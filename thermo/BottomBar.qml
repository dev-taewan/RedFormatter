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

Rectangle {
    id: root
    color: "white"

    property int selected

    signal viewSwitched(int index)
    property bool showMainOption: false

    property int shift: !root.showMainOption ? -height : 0
    visible: shift > -height
    Behavior on shift {
        NumberAnimation {}
    }

    Connections {
        target: root
        onSelectedChanged: viewSwitched(selected)
    }

    Row {
        id: row
        anchors.fill: parent

        BottomBarButton {
            id: placesButton
            width: root.width/3
            height: root.height

            isSelected: root.selected === 0
            title: qsTr("Places")

            Connections {
                target: placesButton
                onClicked: root.selected = 0
            }
        }

        BottomBarButton {
            id: scheduleButton
            width: root.width/3
            height: root.height

            isSelected: root.selected === 1
            title: qsTr("Schedule")

            Connections {
                target: scheduleButton
                onClicked: root.selected = 1
            }
        }

        BottomBarButton {
            id: statsButton
            width: root.width/3
            height: root.height

            isSelected: root.selected === 2
            title: qsTr("Stats")

            Connections {
                target: statsButton
                onClicked: root.selected = 2
            }
        }
    }
}
