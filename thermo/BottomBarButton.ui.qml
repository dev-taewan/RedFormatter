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
    id: buttonRoot
    property bool isSelected
    property string title

    signal clicked

    MouseArea {
        id: delegateMA
        anchors.fill: parent
        anchors.topMargin: -15

        Connections {
            target: delegateMA
            onClicked: buttonRoot.clicked()
        }
    }

    Text {
        anchors.centerIn: parent
        text: parent.title
        font.pixelSize: Theme.bottomBarFontSize
        font.family: "Roboto"
        color: buttonRoot.isSelected ? ColorStyle.blue : ColorStyle.greyDark4
    }

    Image {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        source: "assets/selected.png"
        visible: buttonRoot.isSelected
    }
}
