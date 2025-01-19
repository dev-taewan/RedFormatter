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
import QtQuick.Templates 2.15

import Thermo 1.0

Item {
    id: root
    property Room room: Rooms.livingRoom
    width: 480
    height: 187

    Connections {
        target: root
        onRoomChanged: {
            tempSliderAnimations.enabled = true
            timeSlider.roomSwitched(room.startHour, room.startMinute, room.endHour, room.endMinute)
            tempSlider.value = room.temperature
        }
    }

    Column {
        id: columnItem
        anchors.fill: parent

        y: Theme.roomScheduleTopMargin

        spacing: Theme.sliderSpacing

        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            width: Theme.sliderWidth
            spacing: Theme.sliderLabelSpacing
            //! [StaticText snippet]
            StaticText {
                text: qsTr("Set interval time")
                anchors.left: parent.left
                color: "#3c94eb"
                font.family: "Roboto"
                font.pixelSize: Theme.sliderLabelFontSize
            }
            //! [StaticText snippet]
            TimeIntervalSlider {
                id: timeSlider
                width: Theme.sliderWidth
                height: sliderContainer.height
                onLeftHandleIndexChanged: {
                    root.room.startHour = leftHandleIndex/2
                    root.room.startMinute = leftHandleIndex%2 * 30
                }
                onRightHandleIndexChanged: {
                    root.room.endHour = rightHandleIndex/2
                    root.room.endMinute = rightHandleIndex%2 * 30
                }
            }
        }

        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            width: Theme.sliderWidth
            spacing: Theme.sliderLabelSpacing

            StaticText {
                id: tempText
                text: qsTr("Set temperature")
                font.family: "Roboto"
                anchors.left: parent.left
                color: "#3c94eb"
                font.pixelSize: Theme.sliderLabelFontSize
            }

            Item {
                id: sliderContainer
                height: tempSlider.handle.height + tempSlider.topPadding + tempSlider.bottomPadding

                Slider {
                    id: tempSlider
                    value: root.room.temperature
                    onMoved: root.room.temperature = value
                    from: Units.fahrenheitToTemperatureUnit(50)
                    to: Units.fahrenheitToTemperatureUnit(90)
                    stepSize: 1

                    implicitWidth: Theme.sliderWidth
                    height: sliderContainer.height + 20 // to improve touchability

                    anchors.verticalCenter: parent.verticalCenter

                    handle: Item {
                        width: Theme.sliderHandleSize
                        height: Theme.sliderHandleSize

                        Image {
                            anchors.centerIn: parent
                            anchors.verticalCenterOffset: 6 // account for shadow
                            source: "assets/slider-handle.png"
                        }

                        x: tempSlider.leftPadding + tempSlider.visualPosition * (tempSlider.availableWidth - width)
                        Behavior on x {
                            id: tempSliderAnimations
                            NumberAnimation {
                                onRunningChanged: {
                                    if (!running) {
                                        tempSliderAnimations.enabled = false
                                    }
                                }
                            }
                        }
                        y: (tempSlider.height - height) / 2

                        Row {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.top
                            anchors.bottomMargin: 4
                            spacing: 2

                            Text {
                                text: tempSlider.value.toString()
                                color: "#3d464d"
                                font.pixelSize: Theme.sliderHandleLabelFontSize
                                font.family: "Roboto"
                            }

                            StaticText {
                                text: Units.temperatureSymbol
                                color: "#3d464d"
                                font.pixelSize: Theme.sliderHandleLabelFontSize
                                font.family: "Roboto"
                            }
                        }
                    }

                    background: Image {
                        anchors.verticalCenter: parent.verticalCenter
                        source: "assets/scrollbar-temperature-track.png"
                    }
                }
            }
        }
    }
}
