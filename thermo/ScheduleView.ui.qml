

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

    property int currentIndex: 0

    property Room currentRoom: Rooms.livingRoom

    ListView {
        id: roomList
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        width: Theme.scheduleViewListWidth + scrollBar.width
        clip: true
        model: 6

        delegate: MouseArea {
            id: delegate
            width: roomList.width
            height: Theme.isBig ? 76 : 46
            required property int index
            property bool selected: index === root.currentIndex

            Connections {
                target: delegate
                onSelectedChanged: {
                    if (selected) {
                        root.currentRoom = Rooms.getByIndex(index)
                    }
                }
                onClicked: {
                    root.currentIndex = index
                }
            }

            Text {
                id: roomNameLabel
                anchors.fill: parent
                font.family: "Roboto"
                font.pixelSize: Theme.scheduleViewListTextSize
                font.weight: Font.Light
                horizontalAlignment: Text.AlignLeft
                anchors.leftMargin: Theme.isBig ? 40 : 16
                verticalAlignment: Text.AlignVCenter
                color: !parent.selected ? ColorStyle.greyDark1 : ColorStyle.blue

                text: Rooms.getByIndex(delegate.index).name
            }

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.isBig ? 24 : 0
                anchors.rightMargin: Theme.isBig ? 24 : 40
                anchors.bottom: parent.bottom
                height: 1
                color: ColorStyle.greyMedium1
            }
        }
    }

    Rectangle {
        id: separator
        width: 1
        height: roomList.height
        anchors.right: roomList.right
        anchors.rightMargin: (scrollBar.width - width) / 2
        color: "#d5dbe0"
    }

    Rectangle {
        id: scrollBar
        y: Math.min(Math.max(0, -(roomList.height - scrollBar.height) * roomList.contentItem.y
            / (roomList.contentItem.height - roomList.height)), roomList.height - scrollBar.height)
        anchors.horizontalCenter: separator.horizontalCenter
        implicitWidth: 4
        implicitHeight: 30
        color: "#90989D"
    }

    RoomSchedule {
        room: root.currentRoom
        anchors.left: roomList.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: Theme.isBig ? 60 : 30
        anchors.rightMargin: Theme.isBig ? 60 : 30
        anchors.bottomMargin: Theme.isBig ? 15 : 5
        anchors.topMargin: Theme.isBig ? 32 : 10
    }
}

