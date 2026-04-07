import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.Commons
import qs.Widgets

Rectangle {
    id: root

    // Injected by PluginService
    property var pluginApi: null

    // Required bar widget properties
    property ShellScreen screen
    property string widgetId: ""
    property string section: ""
    property int sectionWidgetIndex: -1
    property int sectionWidgetsCount: 0

    implicitWidth: row.implicitWidth + Style.marginM * 2
    implicitHeight: Style.barHeight

    color: hovered ? Style.capsuleColorHover : Style.capsuleColor
    radius: Style.radiusM

    property bool hovered: false

    Behavior on color {
        ColorAnimation { duration: 120 }
    }

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: Style.marginXS

        NIcon {
            icon: "calculator"
            color: Color.mPrimary
            pointSize: Style.fontSizeM
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: root.hovered = true
        onExited:  root.hovered = false

        onClicked: {
            if (pluginApi) {
                pluginApi.togglePanel(root.screen, root)
            }
        }
    }
}
