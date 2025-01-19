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

Button {
    id: root
    width: Theme.roomButtonSize
    height: Theme.roomButtonSize

    checkable: false

    property Room currentRoom

    signal fanLevelChanged

    icon.source: enabled ? currentRoom.fanImage : currentRoom.fanOffImage

    contentItem: Item {
        Image {
            source: root.pressed ? "assets/btn-bg-down.png" : (root.enabled && root.checked)  ? "assets/btn-bg-big-on.png" : "assets/btn-bg-big-off.png";
            anchors.horizontalCenter: parent.horizontalCenter
            y: root.pressed ? 0 : -6 // Because of the 6 pixel shadow in the on and off image
        }

        Image {
            source: root.icon.source
            anchors.centerIn: parent
        }
    }

    onClicked: {
        if (!enabled)
            return

        if (currentRoom.fan === Room.FanOff) {
            currentRoom.fan = Room.FanQuarter
        } else if (currentRoom.fan === Room.FanQuarter) {
            currentRoom.fan = Room.FanHalf
        } else if (currentRoom.fan === Room.FanHalf) {
            currentRoom.fan = Room.FanThreeQuarters
        } else if (currentRoom.fan === Room.FanThreeQuarters) {
            currentRoom.fan = Room.FanFull
        } else if (currentRoom.fan === Room.FanFull) {
            currentRoom.fan = Room.FanOff
        }
    }
}
