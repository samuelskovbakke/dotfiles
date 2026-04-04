import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Widgets

Item {
    id: root

    property var pluginApi: null

    readonly property var geometryPlaceholder: panelContainer
    readonly property bool allowAttach: true

    property real contentPreferredWidth:  420 * Style.uiScaleRatio
    property real contentPreferredHeight: 520 * Style.uiScaleRatio

    anchors.fill: parent

    // ── State ────────────────────────────────────────────────────────────

    property string currentExpr: ""
    property bool   isRunning:   false
    property var    history:     []

    // ── qalc process ─────────────────────────────────────────────────────

    Process {
        id: qalcProc
        command: []
        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                root.isRunning = false
                var raw    = this.text.trim()
                var lines  = raw.split("\n").map(function(l) { return l.trim() }).filter(function(l) { return l.length > 0 })
                var result = lines.length > 0 ? lines[lines.length - 1] : "(no output)"
                var isErr  = result.toLowerCase().indexOf("error") === 0 || result === ""
                root.history = root.history.concat([{ expr: root.currentExpr, result: result, isError: isErr }])
            }
        }

        stderr: StdioCollector {
            onStreamFinished: {
                var err = this.text.trim()
                if (err.length === 0) return
                root.isRunning = false
                root.history = root.history.concat([{ expr: root.currentExpr, result: err, isError: true }])
            }
        }
    }

    function doEval(expr) {
        var t = expr.trim()
        if (t.length === 0 || root.isRunning) return
        root.currentExpr = t
        root.isRunning   = true
        qalcProc.command = ["qalc", "-t", t]
        qalcProc.running = true
    }

    function doSubmit() {
        var expr = inputField.text.trim()
        if (expr.length === 0 || root.isRunning) return
        doEval(expr)
        inputField.text = ""
        inputField.forceActiveFocus()
    }

    // ── UI ───────────────────────────────────────────────────────────────

    Rectangle {
        id: panelContainer
        anchors.fill: parent
        color: Color.mSurface
        radius: Style.radiusXL

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 10

            // Header
            RowLayout {
                Layout.fillWidth: true

                Text {
                    text: "Calculator"
                    font.pixelSize: 18
                    font.bold: true
                    color: Color.mOnSurface
                    Layout.fillWidth: true
                }

                Rectangle {
                    width: 28; height: 28
                    radius: 14
                    color: closeHover.containsMouse ? Color.mSurfaceVariant : "transparent"
                    Text { anchors.centerIn: parent; text: "✕"; color: Color.mOnSurface; font.pixelSize: 14 }
                    MouseArea {
                        id: closeHover
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: { if (pluginApi) pluginApi.closePanel(pluginApi.panelOpenScreen) }
                    }
                }
            }

            // History
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: Color.mSurfaceVariant
                radius: 12

                Text {
                    anchors.centerIn: parent
                    visible: root.history.length === 0
                    text: "Enter an expression and press Enter"
                    color: Color.mOnSurfaceVariant
                    font.pixelSize: 13
                    opacity: 0.7
                }

                ListView {
                    id: histView
                    anchors { fill: parent; margins: 8 }
                    model: root.history
                    spacing: 6
                    clip: true
                    ScrollBar.vertical: ScrollBar { policy: ScrollBar.AsNeeded }

                    delegate: Rectangle {
                        width: histView.width
                        height: col.implicitHeight + 16
                        color: modelData.isError ? "#33882222" : Color.mSurface
                        radius: 8

                        MouseArea {
                            anchors.fill: parent
                            onClicked: { if (!modelData.isError) { inputField.text = modelData.result; inputField.forceActiveFocus() } }
                        }

                        Column {
                            id: col
                            anchors { left: parent.left; right: parent.right; top: parent.top; margins: 8 }
                            spacing: 2
                            Text { width: parent.width; text: modelData.expr;   font.pixelSize: 11; color: Color.mOnSurfaceVariant; elide: Text.ElideRight }
                            Text { width: parent.width; text: modelData.result; font.pixelSize: 15; font.bold: true; color: modelData.isError ? "#e05555" : Color.mPrimary; wrapMode: Text.WordWrap }
                        }
                    }
                }
            }

            // "Calculating..." row
            Text {
                visible: root.isRunning
                Layout.fillWidth: true
                text: "Calculating…"
                font.pixelSize: 11
                color: Color.mOnSurfaceVariant
                horizontalAlignment: Text.AlignRight
            }

            // Input row
            RowLayout {
                Layout.fillWidth: true
                spacing: 8

                Rectangle {
                    Layout.fillWidth: true
                    height: 40
                    radius: 8
                    color: Color.mSurface
                    border.color: inputField.activeFocus ? Color.mPrimary : Color.mOutline
                    border.width: 1

                    TextField {
                        id: inputField
                        anchors { fill: parent; leftMargin: 10; rightMargin: 10 }
                        background: null
                        color: Color.mOnSurface
                        placeholderText: "e.g. 2^10, sqrt(2), 100 km to miles"
                        placeholderTextColor: Color.mOnSurfaceVariant
                        font.pixelSize: 13
                        enabled: !root.isRunning
                        verticalAlignment: TextInput.AlignVCenter
                        selectByMouse: true

                        Keys.onReturnPressed: root.doSubmit()
                        Keys.onEnterPressed:  root.doSubmit()
                    }
                }

                Rectangle {
                    width: 40; height: 40
                    radius: 8
                    color: submitHover.containsMouse && inputField.text.trim().length > 0 ? Color.mPrimary : Color.mSurfaceVariant
                    opacity: (inputField.text.trim().length > 0 && !root.isRunning) ? 1.0 : 0.4

                    Behavior on color { ColorAnimation { duration: 120 } }

                    Text { anchors.centerIn: parent; text: "="; font.pixelSize: 18; font.bold: true; color: Color.mOnSurface }

                    MouseArea {
                        id: submitHover
                        anchors.fill: parent
                        hoverEnabled: true
                        enabled: inputField.text.trim().length > 0 && !root.isRunning
                        onClicked: root.doSubmit()
                    }
                }
            }

            Text {
                Layout.fillWidth: true
                text: "↑↓ browse history  ·  click result to reuse"
                font.pixelSize: 11
                color: Color.mOnSurfaceVariant
                opacity: 0.5
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    Component.onCompleted: inputField.forceActiveFocus()
}
