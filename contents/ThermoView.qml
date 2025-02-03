import QtQuick 2.15
import ThermoConfiguration 1.0

Item {
    id: root
    property int selectedView: -1
    property int index: -1
    Rectangle {
            anchors.fill: parent
            color: "#5ae0aa"
            z: -1 // 다른 컴포넌트들보다 뒤에 오도록
        }
    Behavior on opacity {
        enabled: Configuration.enableFadingAnimations
        NumberAnimation {}
    }
    Behavior on x { NumberAnimation {} }

    states: [
        State {
            id: selected
            name: "selected"
            when: root.selectedView == root.index
            PropertyChanges { target: root; opacity: 1 }
            PropertyChanges { target: root; x: 0 }
        },
        State {
            name: "notSelected"
            when: root.selectedView != root.index
            PropertyChanges { target: root; opacity: 0 }
            PropertyChanges { target: root; x: 100 * (root.selectedView > root.index ? -1 : 1) }
        }
    ]
}
