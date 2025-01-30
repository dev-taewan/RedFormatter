import QtQuick 2.15
import Thermo 1.0
import RedmineTest

Item {
    id: buttonRoot
    property bool isSelected
    property string title

    signal clicked

    MouseArea {
        id: delegateMA
        anchors.fill: parent
        anchors.topMargin: -15

        // Connections {
        //     target: delegateMA
        //     onClicked: buttonRoot.clicked()
        // }
    }

    Text {
        anchors.centerIn: parent
        text: parent.title
        font.pixelSize: 24
        // font.family: "qrc:/fonts/Roboto-Regular.ttf"
        color: buttonRoot.isSelected ? "blue" : "greyDark4"
    }
    Image {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        source: "qrc:/assets/selected.png"
        visible: buttonRoot.isSelected
    }
}
