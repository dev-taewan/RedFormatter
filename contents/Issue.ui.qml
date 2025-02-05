import QtQuick 2.15
import Thermo 1.0
import ThermoConfiguration 1.0
import Redformatter
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    property string issue_type
    property int issue_id
    property string issue_title
    property int achievment_rate
    property bool is_overdue: false
    property date deadline
    //property Room room
    width: Theme.cardWidth
    height: Theme.cardHeight

    signal selected
    FontLoader {
        id: button_text_fam
        source: "qrc:/fonts/Roboto-Regular.ttf"
    }
    Item {
        width: Theme.cardWidth
        height: Theme.cardHeight

        Image {
            source: "qrc:/images/card-back-topleft.png"
        }

        Rectangle {
            x: Theme.cardCornerRadius
            width: Theme.cardWidth - 2 * Theme.cardCornerRadius
            height: Theme.cardCornerRadius
            color: ColorStyle.greyLight1
        }

        Image {
            x: Theme.cardWidth - Theme.cardCornerRadius
            source: "qrc:/images/card-back-topright.png"
        }

        Rectangle {
            y: Theme.cardCornerRadius
            width: Theme.cardWidth
            height: Theme.cardHeight - 2 * Theme.cardCornerRadius
            color: ColorStyle.greyLight1
        }

        Image {
            y: Theme.cardHeight - Theme.cardCornerRadius
            source: "qrc:/images/card-back-bottomleft.png"
        }

        Rectangle {
            x: Theme.cardCornerRadius
            y: Theme.cardHeight - Theme.cardCornerRadius
            width: Theme.cardWidth - 2 * Theme.cardCornerRadius
            height: Theme.cardCornerRadius
            color: ColorStyle.greyLight1
        }

        Image {
            x: Theme.cardWidth - Theme.cardCornerRadius
            y: Theme.cardHeight - Theme.cardCornerRadius
            source: "qrc:/images/card-back-bottomright.png"
        }

        // Row {
        //     id: issue_head_info
        //     anchors.top: parent.top
        //     anchors.leftMargin: Theme.cardRoomColumnLeftMargin
        //     anchors.rightMargin: Theme.cardRoomColumnLeftMargin
        //     anchors.left: parent.left
        //     anchors.right: parent.right
        //     anchors.topMargin: Theme.cardTemperatureTopMargin
        //     Text {
        //         id: temp
        //         text: "AIEngine"
        //         font.pixelSize: 20
        //         font.family: button_text_fam.name
        //         font.weight: Font.Medium
        //         color: ColorStyle.greyDark4
        //     }
        //     Text {
        //         anchors.right: parent.right
        //         font.pixelSize: Theme.cardFloorFontSize
        //         font.family: button_text_fam.name
        //         text: "일감번호"
        //         color: ColorStyle.greyDark1
        //     }
        // }
        Item {
            id: issue_head_info

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: Theme.cardTemperatureTopMargin
            anchors.leftMargin: Theme.cardRoomColumnLeftMargin
            anchors.rightMargin: Theme.cardRoomColumnLeftMargin

            Text {
                text: issue_type
                font.pixelSize: 20
                font.family: button_text_fam.name
                font.weight: Font.Medium
                color: ColorStyle.greyDark4
            }

            Text {
                anchors.right: parent.right
                font.pixelSize: Theme.cardFloorFontSize
                font.family: button_text_fam.name
                text: issue_id //"일감번호"
                color: ColorStyle.greyDark1
            }
        }
        Column {
            id: roomColumn
            anchors.top: parent.top
            anchors.topMargin: 50 + Theme.cardRoomColumnSpacing + 5
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: Theme.cardRoomColumnLeftMargin
            anchors.rightMargin: Theme.cardRoomColumnLeftMargin
            spacing: Theme.cardRoomColumnSpacing + 5

            Image {
                anchors.right: parent.right
                anchors.left: parent.left
                source: "qrc:/assets/separator-line.png"
            }
            Text {
                anchors.right: parent.right
                anchors.left: parent.left
                width: root.width
                wrapMode: Text.WrapAnywhere
                font.pixelSize: Theme.cardRoomFontSize
                font.weight: Font.Light
                text: issue_title
                font.family: button_text_fam.name
                color: ColorStyle.greyDark4
            }
        }

        ProgressBar {
            //진행률 표시
            id: progressbar
            rangeValue: achievment_rate
            anchors.bottom: parent.bottom
            anchors.bottomMargin: progressbar.r
            anchors.left: parent.left
            anchors.leftMargin: progressbar.r
        }
        Column {

            anchors.bottom: parent.bottom
            anchors.bottomMargin: Theme.cardRoomColumnLeftMargin
            anchors.right: parent.right
            anchors.rightMargin: Theme.cardRoomColumnLeftMargin

            spacing: 3
            Row {
                spacing: 3
                ColorizedImage {
                    id: status_led

                    property bool isCurrent

                    source: "qrc:/assets/status-small.png"
                    //status_led.sourceImage.source
                    width: 30
                    height: 30
                    color: ColorStyle.greenLight
                }
                Text {
                    id: status_msg

                    text: is_overdue ? "Overdue" : "On Time" // on time
                    color: ColorStyle.greyDark1
                    font.pixelSize: Theme.cardStateFontSize
                    font.family: button_text_fam.name
                }
            }

            //property date currentDate: new Date()
            Text {
                //anchors.bottom: parent.bottom
                anchors.right: parent.right
                font.pixelSize: Theme.cardFloorFontSize
                font.family: button_text_fam.name
                // "yyyy년 MM월 dd일" 포맷으로 표시
                text: Qt.formatDate(parent.deadline, "yy년 MM월 dd일")
                color: ColorStyle.greyDark1
            }
        }

        MouseArea {
            id: ta
            enabled: root.enabled
            anchors.fill: parent
            z: 1

            Connections {
                target: ta
                function onClicked() {
                    root.selected()
                }
            }
        }
    }
    // states: [
    //     State {
    //         name: "over"
    //         when: isCurrent
    //         PropertyChanges {
    //             target: status_led
    //             color: ColorStyle.blue
    //         }
    //     },
    //     State {
    //         name: "running"
    //         when: isCurrent
    //         PropertyChanges {
    //             target: status_led
    //             color: ColorStyle.blue
    //         }
    //     }
    // ]
}
