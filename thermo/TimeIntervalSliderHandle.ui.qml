

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
    width: Theme.sliderHandleSize
    height: Theme.sliderHandleSize
    property alias rootX: root.x

    Image {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 6 // account for shadow
        source: "assets/slider-handle.png"
    }

    property alias mouseX: ta.mouseX

    property int labelOffsetX: 0
    property int minX: -1
    property int maxX: -1
    property int currentIndex: -1

    property string hour: Math.floor(currentIndex / 2)
    property string minute: ((currentIndex % 2 == 1) ? "30" : "00")

    property alias labelWidth: label.width

    Row {
        id: label
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -root.labelOffsetX
        anchors.bottom: parent.top
        anchors.bottomMargin: 4
        spacing: 4

        Row {
            id: time

            Text {
                text: root.hour
                color: "#3d464d"
                font.pixelSize: Theme.sliderHandleLabelFontSize
                font.family: "Roboto"
            }

            Text {
                text: ":"
                color: "#3d464d"
                font.pixelSize: Theme.sliderHandleLabelFontSize
                font.family: "Roboto"
                horizontalAlignment: Text.AlignLeft
            }

            Text {
                id: txt
                text: root.minute
                color: "#3d464d"
                font.pixelSize: Theme.sliderHandleLabelFontSize
                font.family: "Roboto"
            }
        }

        Text {
            text: (((root.currentIndex / 2 < 24)
                    && (root.currentIndex / 2 >= 12)) ? "pm" : "am")
            color: "#3d464d"
            font.pixelSize: 9
            font.family: "Roboto"
            anchors.bottom: time.bottom
            anchors.bottomMargin: 1
        }
    }

    MouseArea {
        id: ta
        anchors.fill: parent
        anchors.margins: -10
        property real pressedX: 0
        property real pressedY: 0

        Connections {
            target: ta

            onPressed: {
                ta.pressedX = mouse.x
                ta.pressedY = mouse.y
            }

            onMouseXChanged: {
                var newX = root.x - (ta.pressedX - ta.mouseX)
                rootX = Math.max(root.minX, Math.min(root.maxX, newX))
            }
        }
    }
}
