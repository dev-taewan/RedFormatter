/******************************************************************************
**
** Copyright (C) 2020 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Qt Quick Ultralite module.
**
** $QT_BEGIN_LICENSE:COMM$
**
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see http://www.qt.io/terms-conditions. For further
** information use the contact form at http://www.qt.io/contact-us.
**
** $QT_END_LICENSE$
**
******************************************************************************/

import QtQuick 2.15
import Thermo 1.0
import Redformatter
Item {
    id: topBar

    property bool showBackButton: false
    property alias title: titleText.text

    signal backClicked
    signal settingsClicked
    FontLoader {
        id: font_fam
        source: "qrc:/fonts/Roboto-Regular.ttf"
    }
    Item {
        width: backImage.width + backImage.x * 2
        height: parent.height
        opacity: topBar.showBackButton ? 1 : 0

        Behavior on opacity {
            NumberAnimation{}
        }


        ColorizedImage {
            x: 14
            id: backImage
            color: "#c4c9cc"
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:/assets/baseline-arrow-back.png"
        }
    }

    MouseArea {
        enabled: topBar.showBackButton
        height: parent.height
        width: label.x + titleText.width
        onClicked: topBar.backClicked()
    }

    Item {
        id: label
        x: topBar.showBackButton ? (Theme.isBig ? 60 : 45) : (Theme.isBig ? 24 : 15)
        height: parent.height

        Behavior on x {
            NumberAnimation{}
        }

        Text {
            id: titleText
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: Theme.topBarFontSize
            font.family: font_fam.name
            color: "#3d464d"
            opacity: topBar.showBackButton ? 1 : 0

            Behavior on opacity {
                NumberAnimation{}
            }
        }
    }

    ColorizedImage {
        id: buttonImage
        x: 14
        visible: opacity > 0
        color: ColorStyle.greyDark4
        anchors.verticalCenter: parent.verticalCenter
        source: "qrc:/assets/change-language.png"
        opacity: topBar.showBackButton ? 0 : 1

        Behavior on opacity {
            NumberAnimation{}
        }

        MouseArea {
            id: ma
            anchors.fill: parent
            anchors.margins: -15;

            Connections {
                target: ma
                function onClicked()
                {
                    topBar.settingsClicked()
                }
            }
            // Connections {
            //     target: ma
            //     onClicked: topBar.settingsClicked()
            // }
        }
    }

    ColorizedImage {
        id: qtLogo
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        source: "qrc:/assets/qt-logo.png"
        color: ColorStyle.greyDark4
    }

    // Row {
    //     height: parent.height
    //     anchors.right: parent.right
    //     anchors.rightMargin: Theme.isBig ? 20 : 15
    //     spacing: Theme.isBig ? 28 : 4

    //     // WeatherStatus {
    //     //     anchors.verticalCenter: parent.verticalCenter
    //     // }

    //     Row {
    //         height: parent.height

    //         Text {
    //             id: outTemp
    //             anchors.verticalCenter: parent.verticalCenter
    //             width: 20
    //             horizontalAlignment: Text.AlignRight
    //             font.family: font_fam.name
    //             font.pixelSize: Theme.topBarFontSize
    //             color: ColorStyle.greyDark4
    //             Timer {
    //                 running: true
    //                 repeat: true
    //                 interval: 5000
    //                 onTriggered: {
    //                     if (Math.random() < 0.3) {
    //                         outTemp.text = Math.random() * 99
    //                     }
    //                 }
    //             }
    //             Component.onCompleted: outTemp.text = Math.random() * 99
    //         }

    //         Text {
    //             anchors.verticalCenter: parent.verticalCenter
    //             text: "123"
    //             font.family:font_fam.name
    //             font.pixelSize: Theme.topBarFontSize
    //             color: ColorStyle.greyDark4
    //         }
    //     }
    // }
}

