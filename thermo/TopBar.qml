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

Item {
    id: topBar

    property bool showBackButton: false
    property alias title: titleText.text

    signal backClicked
    signal settingsClicked

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
            source: "assets/baseline-arrow-back.png"
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
            font.family: "Roboto"
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
        source: "assets/change-language.png"
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
                onClicked: topBar.settingsClicked()
            }
        }
    }

    ColorizedImage {
        id: qtLogo
        width: 300
        height: 104
        color: "#344ca1"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        source: "assets/main_logo.png"
        anchors.verticalCenterOffset: 12
        anchors.horizontalCenterOffset: 0
    }

    Row {
        height: parent.height
        anchors.right: parent.right
        anchors.rightMargin: Theme.isBig ? 20 : 15
        spacing: Theme.isBig ? 28 : 4

        Row {
            height: parent.height
        }
    }


    ColorizedImage {
        id: buttonImage1
        width:buttonImage.width+5
        height:buttonImage.height+5
        x: parent.width-buttonImage1.width-14

        visible: opacity > 0
        color: "#344ca1"
        anchors.verticalCenter: parent.verticalCenter
        //source: "assets/add_button_red.png"
        opacity: topBar.showBackButton ? 0 : 1

        Behavior on opacity {
            NumberAnimation{}
        }
        MouseArea {
            width: parent.width
            height: parent.height / 2
            anchors.bottom: parent.bottom
            visible: root.thermoOn


            Image {
                width: 100
                height: 100
                visible: false
                source: "assets/pressed-bg-down.png"
                anchors.centerIn: parent
            }

            ColorizedImage {
                width:35
                height:35
                color: "#344ca1"
                source: "assets/add_button_red.png"
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -Theme.tempControlOffset
            }

            onClicked: {
                root.setTemperature(root.currentTemp-1);
            }
        }
        // MouseArea {
        //     visible: root.thermoOn

        //     width: parent.width
        //     height: parent.height
        //     anchors.bottom: parent.bottom

        //     Image {
        //         width:35
        //         height:35
        //         visible: parent.pressed
        //         source: "assets/add_button_press.png"
        //         anchors.centerIn: parent
        //     }

        //     ColorizedImage {
        //         width:35
        //         height:35
        //         source: "assets/add_button_red"
        //         anchors.centerIn: parent
        //         //anchors.verticalCenterOffset: -Theme.tempControlOffset
        //     }

        //     // onClicked: {
        //     //     root.setTemperature(root.currentTemp-1);
        //     // }
        // }
    }
}

