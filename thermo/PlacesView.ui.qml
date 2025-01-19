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

    property bool showMain
    property Room currentRoom: Rooms.livingRoom
    property int cardSizeWithSpacing: Theme.cardRowSpacing + Theme.cardWidth
    property int pageCount: 6

    Flickable {
        id: swipeView
        interactive: root.showMain
        anchors.fill: parent

        contentWidth: root.pageCount * root.cardSizeWithSpacing + 2 * Theme.cardRowOffset
        contentHeight: swipeView.height

        CardRow {
            id: cardRow
            enabled: root.enabled
            x: Theme.cardRowOffset
            y: 30
            spacing: Theme.cardRowSpacing

            Connections {
                target: cardRow
                onSelected: {
                    root.currentRoom = cardRow.selectedRoom
                    root.showMain = false
                }
            }
        }
    }

    property real delta: swipeView.contentX / (swipeView.contentWidth - swipeView.width + 0.001) // ensure range is [0..1)

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Theme.cardRowIndicatorBottomMargin
        spacing: Theme.cardRowIndicatorSpacing

        PlacesDotIndicator {
            isCurrent: Math.floor(4 * root.delta) <= 0
        }

        PlacesDotIndicator {
            isCurrent: Math.floor(4 * root.delta) == 1
        }

        PlacesDotIndicator {
            isCurrent: Math.floor(4 * root.delta) == 2
        }

        PlacesDotIndicator {
            isCurrent: Math.floor(4 * root.delta) >= 3
        }
    }
}
