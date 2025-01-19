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

ThermoView {
    id: root

    property int currentTemp: 69
    property int prevTemp: 69
    property alias thermoOn: powerBtn.checked

    property int maxTemp: Units.fahrenheitToTemperatureUnit(90)
    property int minTemp: Units.fahrenheitToTemperatureUnit(50)
    property int smallestAngle : 25;

    property Room currentRoom

    // This can't be done with a binding because we set it from several places
    onVisibleChanged: {
        setTemperatureWithoutAnimation(currentRoom.temperature)
        powerBtn.checked = currentRoom.power
        autoBtn.checked = currentRoom.auto_
        dryerBtn.checked = currentRoom.dryer
        ecoBtn.checked = currentRoom.eco
        streamerBtn.checked = currentRoom.streamer
    }
    onCurrentTempChanged: {
        currentRoom.temperature = currentTemp
    }

    function setTemperature(t : real) {
        _setTemperatureImpl(t, false)
    }
    function setTemperatureWithoutAnimation(t : real) {
        _setTemperatureImpl(t, true)
    }
    function _setTemperatureImpl(t : real, stopAnimation : bool) {
        currentTemp = Math.min(Math.max(Math.round(t), minTemp), maxTemp);
        tens.stopAnimation = stopAnimation
        ones.stopAnimation = stopAnimation
        tens.reversed = currentTemp < prevTemp
        ones.reversed = currentTemp < prevTemp
        prevTemp = currentTemp
    }

    Item {
        width: wheelImg.width
        height: width
        anchors.horizontalCenter: parent.horizontalCenter

        y: Theme.thermoY

        Image {
            id: wheelImg
            source: root.thermoOn ? "assets/jog.png" : "assets/jog-off.png"
        }

        Row {
            clip: true
            id: thermoText
            anchors.centerIn: parent
            width: Theme.roomViewTempWidth
            height: Theme.roomViewTempHeight

            AnimatedDigit {
                id: tens
                visible: root.thermoOn;
                value: root.currentTemp / 10
            }

            AnimatedDigit {
                id: ones
                visible: root.thermoOn;
                value: root.currentTemp % 10
            }
        }

        Image {
            id: digitMaskTop
            anchors.top: thermoText.top
            anchors.horizontalCenter: parent.horizontalCenter
            source: "assets/digitMaskTop.png"
        }

        Image {
            id: digitMaskBottom
            anchors.bottom: thermoText.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            source: "assets/digitMaskBottom.png"
        }

        Text {
            visible: root.thermoOn
            color: "#3d464d"
            anchors.top: thermoText.top
            anchors.left: thermoText.right
            anchors.topMargin: Theme.isBig ? 13 : 11
            text: Units.temperatureSymbol
            font.pixelSize: Theme.wheelTempUnitSize
            font.family: "Roboto"
        }

        MouseArea {
            visible: root.thermoOn

            width: parent.width
            height: parent.height / 2

            Image {
                visible: parent.pressed
                source: "assets/pressed-bg-up.png"
                anchors.centerIn: parent
            }

            ColorizedImage {
                source: "assets/temp-up-pressed.png"
                anchors.centerIn: parent
                anchors.verticalCenterOffset: Theme.tempControlOffset
                color: parent.pressed ? ColorStyle.blue : ColorStyle.greyMedium3
            }

            onClicked: {
                root.setTemperature(root.currentTemp+1);
            }
        }

        MouseArea {
            visible: root.thermoOn

            width: parent.width
            height: parent.height / 2
            anchors.bottom: parent.bottom

            Image {
                visible: parent.pressed
                source: "assets/pressed-bg-down.png"
                anchors.centerIn: parent
            }

            ColorizedImage {
                source: "assets/temp-down-pressed.png"
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -Theme.tempControlOffset
                color: parent.pressed ? ColorStyle.blue : ColorStyle.greyMedium3
            }

            onClicked: {
                root.setTemperature(root.currentTemp-1);
            }
        }

        Image {
            id: thermoHandle
            visible: root.thermoOn
            z: 10
            source: "images/inner-circle.png"
            property real angle: (90 + root.smallestAngle + (root.currentTemp - root.minTemp)/(root.maxTemp-root.minTemp)  * (360-2*root.smallestAngle) )
                * 2 * Math.PI / 360
            x : parent.width/2 - width/2 + Theme.wheelSize * Math.cos(angle)
            y : parent.height/2 - height/2 + Theme.wheelSize * Math.sin(angle)

            MouseArea {
                anchors.centerIn: parent
                width: Theme.thermoHandleSize
                height: Theme.thermoHandleSize

                property real pressedX: 0
                property real pressedY: 0

                onPressed: {
                    pressedX = mouse.x
                    pressedY = mouse.y
                }

                onPositionChanged: {
                    var px = mouse.x - pressedX + x + width/2 + parent.x - parent.parent.width / 2
                    var py = mouse.y - pressedY + y + height/2 + parent.y - parent.parent.height / 2
                    var d = Math.sqrt(px*px + py*py);
                    if (d < Theme.wheelSize * 0.6)
                        return; // too far from the position
                    var angle = Math.atan2(px / d, py / d) * 360 / (Math.PI*2);
                    angle = (360 - angle);
                    while (angle > 360)
                        angle-=360;
                    var temperature = root.minTemp + (angle-root.smallestAngle) * (root.maxTemp-root.minTemp) / (360-2*root.smallestAngle);

                    root.setTemperatureWithoutAnimation(temperature);
                }

                Image {
                    source: "assets/thermo-handle.png"
                    visible: parent.pressed
                    anchors.centerIn: parent;
                }
            }
        }
    }

    Text {
        visible: root.thermoOn || Theme.isBig
        text: {
            switch (root.currentRoom.status) {
                case Room.Heating: return qsTr("Heating")
                case Room.Cooling: return qsTr("Cooling")
                default: return qsTr("OFF")
            }
        }
        color: root.currentRoom.status == Room.Off ? ColorStyle.greyDark1 : ColorStyle.greyDark4
        font.pixelSize: Theme.wheelStatusTextSize
        font.family: "Roboto"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Theme.isBig ? 36 : 12
    }

    ColorizedImage {
        visible: root.thermoOn
        source: "assets/status-small.png"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Theme.isBig ? 15 : 0
        color: root.currentRoom.status == Room.Heating ? ColorStyle.pinkyRed : ColorStyle.blue
    }

    Column {
        anchors.leftMargin: Theme.roomButtonMargin
        anchors.left: parent.left
        y: Theme.roomButtonsY
        spacing: Theme.roomButtonSpacing

        RoomControlButton {
            id: autoBtn
            icon.source: "assets/auto-on.png"
            enabled: root.thermoOn
            onCheckedChanged: {
                if (checked) {
                    dryerBtn.checked = fanBtn.checked = ecoBtn.checked = streamerBtn.checked = false;
                }
                root.currentRoom.auto_ = checked
            }
        }
        RoomControlButton {
            id: dryerBtn
            icon.source: "assets/dryer-on.png"
            enabled: root.thermoOn
            onCheckedChanged: {
                if (checked) {
                    autoBtn.checked = false
                }
                root.currentRoom.dryer = checked
            }
        }

        FanControlButton {
            id: fanBtn
            enabled: root.thermoOn
            currentRoom: root.currentRoom
        }
    }
    Column {
        anchors.rightMargin: Theme.roomButtonMargin
        anchors.right: parent.right
        y: Theme.roomButtonsY
        spacing: Theme.roomButtonSpacing

        RoomControlButton {
            id: powerBtn
            icon.source: "assets/power-on.png"
            checked: false
            pulsing: !checked
            onCheckedChanged: {
                root.currentRoom.power = checked
            }
        }

        RoomControlButton {
            id: ecoBtn
            icon.source: "assets/eco-on.png"
            enabled: root.thermoOn
            onCheckedChanged: {
                if (checked) {
                    autoBtn.checked = false
                }
                root.currentRoom.eco = checked
            }
        }

        RoomControlButton {
            id: streamerBtn
            icon.source: "assets/streamer-on.png"
            enabled: root.thermoOn
            onCheckedChanged: {
                if (checked) {
                    autoBtn.checked = false
                }
                root.currentRoom.streamer = checked
            }
        }
    }
}

