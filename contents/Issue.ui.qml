import QtQuick 2.15
import Thermo 1.0
import ThermoConfiguration 1.0
import Redformatter

Item {
    id: root

    property Room room

    width: 324
    height: 132

    signal selected

    Item {
        width: Theme.cardWidth
        height: Theme.cardHeight

        Image {
            source: "images/card-back-topleft.png"
        }

        Rectangle {
            x: Theme.cardCornerRadius
            width: Theme.cardWidth - 2 * Theme.cardCornerRadius
            height: Theme.cardCornerRadius
            color: ColorStyle.greyLight1
        }

        Image {
            x: Theme.cardWidth - Theme.cardCornerRadius
            source: "images/card-back-topright.png"
        }

        Rectangle {
            y: Theme.cardCornerRadius
            width: Theme.cardWidth
            height: Theme.cardHeight - 2 * Theme.cardCornerRadius
            color: ColorStyle.greyLight1
        }

        Image {
            y: Theme.cardHeight - Theme.cardCornerRadius
            source: "images/card-back-bottomleft.png"
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
            source: "images/card-back-bottomright.png"
        }

        Row {
            id: temperatureText
            anchors.top: parent.top
            anchors.topMargin: Theme.cardTemperatureTopMargin
            anchors.left: parent.left
            anchors.leftMargin: Theme.cardTemperatureLeftMargin
            anchors.right: parent.right

            height: 48
            width: temp.text.length != 0 ? 92 : 0
            visible: temp.text.length !== 0

            Text {
                id: temp
                text: "Type"
                font.pixelSize: 60
                font.family: "Roboto"
                font.weight: Font.Medium
                color: ColorStyle.greyDark4
                visible: text.length !== 0
                height: parent.height
                anchors.topMargin: -8
                anchors.top: parent.top
            }

            // Text {
            //     anchors.top: parent.top
            //     font.family: "Roboto"
            //     font.pixelSize: 20
            //     color: ColorStyle.greyDark4
            //     text: Units.temperatureSymbol
            // }
        }

        Column {
            id: roomColumn
            anchors.top: parent.top
            anchors.topMargin: Theme.cardRoomColumnTopMargin
            anchors.left: parent.left
            anchors.leftMargin: Theme.cardRoomColumnLeftMargin

            spacing: Theme.cardRoomColumnSpacing

            Text {
                font.pixelSize: Theme.cardRoomFontSize
                font.weight: Font.Light
                text: "issue title"
                font.family: "Roboto"
                color: ColorStyle.greyDark4
            }
            Text {
                font.pixelSize: Theme.cardFloorFontSize
                font.family: "Roboto"
                text: "일감번호"
                color: ColorStyle.greyDark1
            }
        }

        Image {
            x: Theme.cardSeparatorLeftMargin
            y: Theme.cardSeparatorTopMargin
            source: "assets/separator-line.png"
        }

        Row {
            //진행률 표시
            visible: root.room.status !== Room.Off && !root.room.auto_
            spacing: Theme.cardIndicatorSpacing
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 25
            anchors.left: parent.left
            anchors.leftMargin: 22

            ColorizedImage {
                source: "assets/dryer-on-small.png"
                color: root.room.dryer ? ColorStyle.blue : ColorStyle.greyMedium3
            }

            Image {
                source: root.room.smallFanImage
            }

            ColorizedImage {
                source: "assets/eco-on-small.png"
                color: root.room.eco ? ColorStyle.blue : ColorStyle.greyMedium3
            }

            ColorizedImage {
                source: "assets/streamer-on-small.png"
                color: root.room.streamer ? ColorStyle.blue : ColorStyle.greyMedium3
            }
        }

        Image {
            id: autoIndicator
            visible: root.room.status !== Room.Off && root.room.auto_
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 25
            anchors.left: parent.left
            anchors.leftMargin: 22
            source: "assets/auto-card.png"
        }

        Row {
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 23
            anchors.left: parent.left
            anchors.leftMargin: Theme.isBig ? 305 - width : (root.room.status
                                                             === Room.Off ? 22 : 122)

            spacing: 3

            Text {
                text: ((root.room.status === Room.Heating) ? qsTr("Overdue") : (root.room.status === Room.Cooling) ? qsTr("On Time") : qsTr("Off"))
                color: ColorStyle.greyDark1
                font.pixelSize: Theme.cardStateFontSize
                font.family: "Roboto"
            }

            ColorizedImage {
                y: Theme.isBig ? 3 : 2
                source: "assets/status-small.png"
                color: ((root.room.status === Room.Heating) ? ColorStyle.pinkyRed : (root.room.status === Room.Cooling) ? ColorStyle.blue : ColorStyle.greyMedium3)
            }
            Text {
                font.pixelSize: Theme.cardFloorFontSize
                font.family: "Roboto"
                text: "기타등등"
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
                onClicked: root.selected()
            }
        }
    }

    // PowerSwitch {
    //     id: enabledSwitch
    //     enabled: root.enabled

    //     y: Theme.powerSwitchTopMargin

    //     anchors.right: parent.right
    //     anchors.rightMargin: Theme.powerSwitchRightMargin
    //     checked: root.room.status !== Room.Off

    //     Connections {
    //         target: enabledSwitch

    //         onEnabledChanged: {
    //             enabledSwitch.checked = (root.room.status !== Room.Off)
    //         }

    //         onCheckedChanged: {
    //             root.room.power = enabledSwitch.checked
    //         }
    //     }
    // }
}
