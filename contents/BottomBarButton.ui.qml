import QtQuick 2.15
import Thermo 1.0
import Redformatter

Item {
    id: buttonRoot
    property bool isSelected
    property string title

    signal clicked

    MouseArea {
        id: delegateMA
        anchors.fill: parent
        anchors.topMargin: -15

        Connections {
            target: delegateMA
            function onClicked() {
                buttonRoot.clicked()
            }
        }
    }
    FontLoader {
        id: button_text_fam
        source: "qrc:/fonts/Roboto-Regular.ttf"
    }

    Text {
        anchors.centerIn: parent
        text: parent.title
        font.pixelSize: Theme.bottomBarFontSize
        font.family: button_text_fam.name
        color: buttonRoot.isSelected ? ColorStyle.blue : ColorStyle.greyDark4
    }
    Image {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        source: "qrc:/assets/selected.png"
        visible: buttonRoot.isSelected
    }
}
