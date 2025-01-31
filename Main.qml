import QtQuick
import Thermo 1.0
import ThermoConfiguration 1.0
import Redformatter
// Window {
//     width: 640
//     height: 480
//     visible: true
//     title: qsTr("Hello World")
// }

// Item {
//     id: appWindow
//     width: Theme.screenWidth
//     height: Theme.screenHeight


// }
Window {
    visible: true
    width: 720
    height: 480

    Loader {
        id: blackBoxLoader
        source: "contents/MainView.ui.qml"
        anchors.fill: parent
    }
}
