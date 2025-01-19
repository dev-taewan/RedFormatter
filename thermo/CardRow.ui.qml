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

Row {
    id: root;
    signal selected
    spacing: 10
    property Room selectedRoom
    property int pageCount: 6

    Card {
        id: livingCard
        anchors.verticalCenter: parent.verticalCenter
        enabled: root.enabled

        room: Rooms.livingRoom

        Connections {
            target: livingCard
            onSelected: {
                root.selectedRoom = livingCard.room
                root.selected()
            }
        }
    }

    Card {
        id: kids2Card
        anchors.verticalCenter: parent.verticalCenter
        enabled: root.enabled

        room: Rooms.kids2Room

        Connections {
            target: kids2Card
            onSelected: {
                root.selectedRoom = kids2Card.room
                root.selected()
            }
        }
    }
}
