import QtQuick 2.15
import Thermo 1.0
import Redformatter
Rectangle {
    id: root
    color: "blue"

    property int selected

    signal viewSwitched(int index)
    property bool showMainOption: false

    property int shift: !root.showMainOption ? -height : 0
    visible: shift > -height
    Behavior on shift {
        NumberAnimation {}
    }

    // Connections {
    //     target: root
    //     onSelectedChanged: viewSwitched(selected)
    // }

    Row {
        id: row
        anchors.fill: parent

        BottomBarButton {
            id: placesButton
            width: root.width/3
            height: root.height

            isSelected: root.selected === 0
            title: qsTr("Places")

            // Connections {
            //     target: placesButton
            //     onClicked: root.selected = 0
            // }
        }

        BottomBarButton {
            id: scheduleButton
            width: root.width/3
            height: root.height

            isSelected: root.selected === 1
            title: qsTr("Schedule")

            // Connections {
            //     target: scheduleButton
            //     onClicked: root.selected = 1
            // }
        }

        BottomBarButton {
            id: statsButton
            width: root.width/3
            height: root.height

            isSelected: root.selected === 2
            title: qsTr("Stats")

            // Connections {
            //     target: statsButton
            //     onClicked: root.selected = 2
            // }
        }
    }
}
