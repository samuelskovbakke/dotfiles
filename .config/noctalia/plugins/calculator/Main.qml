import QtQuick
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Services.UI

Item {
    id: root

    property var pluginApi: null

    IpcHandler {
        target: "calculator"

        // Toggle the calculator panel open/closed.
        // Invoke from the command line:
        //   noctalia-shell ipc call calculator toggle
        function toggle() {
            if (!pluginApi) {
                Logger.w("Calculator", "IPC toggle called but pluginApi is not available")
                return
            }

            pluginApi.withCurrentScreen(function(screen) {
                pluginApi.togglePanel(screen)
            })

            Logger.d("Calculator", "IPC toggle invoked")
        }
    }
}
