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
    id: root
    property int value: 69
    property int from: 60
    property int to: 100

    property int maxIndex: 48

    property int leftHandleIndex: -1
    property int rightHandleIndex: -1

    signal roomSwitched(int startHour, int startMinute, int endHour, int endMinute)

    Connections {
        target: root

        onRoomSwitched: {
            rightHandleAnimation.enabled = true
            leftHandleAnimation.enabled = true
            var newLeftIndex = (startHour * 2 + startMinute / 30)
            leftHandle.x = newLeftIndex * (root.width - rightHandle.width) / maxIndex
            var newRightIndex = (endHour * 2 + endMinute / 30)
            rightHandle.x = newRightIndex * (root.width-rightHandle.width) / maxIndex
        }
    }

    Image {
        id: background
        anchors.verticalCenter: parent.verticalCenter
        source: "assets/scrollbar-off-track.png"
    }

    Rectangle {
        id: middleBackground
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: leftHandle.horizontalCenter
        anchors.right: rightHandle.horizontalCenter
        height: background.height
        color: ColorStyle.greyMedium3
    }

    function calculateOffset(): int {
        var distance = rightHandle.x - leftHandle.x - (leftHandle.labelWidth + rightHandle.labelWidth + 3)/2
        if (distance >= 0) { return 0 }
        return -distance/2
    }

    TimeIntervalSliderHandle {
        id: leftHandle
        minX: 0
        maxX: rightHandle.x - width
        y: (-height / 2 + parent.height / 2)
        labelOffsetX: root.calculateOffset()

        currentIndex: leftHandle.x / (root.width - rightHandle.width) * root.maxIndex

        Connections {
            target: leftHandle

            onCurrentIndexChanged: root.leftHandleIndex = leftHandle.currentIndex
        }

        Component.onCompleted: {
            leftHandle.x = root.width/4
        }
        Behavior on x {
            id: leftHandleAnimation
            NumberAnimation {
                onRunningChanged: {
                    if (!running) {
                        leftHandleAnimation.enabled = false
                    }
                }
            }
        }
    }

    TimeIntervalSliderHandle {
        id: rightHandle
        minX: leftHandle.x + width
        maxX: root.width - width
        y: (-height / 2 + parent.height / 2)
        labelOffsetX: -root.calculateOffset()

        currentIndex: rightHandle.x / (root.width - rightHandle.width) * root.maxIndex

        Connections {
            target: rightHandle

            onCurrentIndexChanged: root.rightHandleIndex = rightHandle.currentIndex
        }

        Component.onCompleted: {
            rightHandle.x = root.width*3/4
        }

        Behavior on x {
            id: rightHandleAnimation
            NumberAnimation {
                onRunningChanged: {
                    if (!running) {
                        rightHandleAnimation.enabled = false
                    }
                }
            }
        }
    }
}

