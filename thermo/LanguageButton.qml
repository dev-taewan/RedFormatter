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

RadioButton {
    id: control

    implicitWidth: background.implicitWidth
    implicitHeight:  background.implicitHeight
    spacing: 10

    property alias flag: flagIndicator.source

    states: [
        State {
            name: "State1"
            when:  control.checked && control.down

            PropertyChanges {
                target: image
                source: "assets/radiobutton-checked-pressed.png"
            }
        },
        State {
            name: "State2"
            when: control.checked

            PropertyChanges {
                target: image
                source: "assets/radiobutton-checked.png"
            }
        },
        State {
            name: "State3"
            when: control.down

            PropertyChanges {
                target: image
                source: "assets/radiobutton-pressed.png"
            }
        }
    ]

    indicator: Image {
        id: image
        anchors.verticalCenter: parent.verticalCenter
//        y: control.topPadding + (control.availableHeight - height) / 2

        source: "assets/radiobutton.png"
    }

    background: Item {
        implicitWidth: control.contentItem.implicitWidth
        implicitHeight: Theme.dialogButtonHeight
    }

    // Text has no padding properties in older UL (<1.3), so we use Row with an Item for the spacing.
    contentItem: Row {
        anchors.verticalCenter: background.verticalCenter

        Item {
            width: control.indicator.width + control.spacing
            height: 1 //Item is invisible in qml positioners if it doesn't have a real height value
        }

        Image {
            id: flagIndicator
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: control.text
            color: ColorStyle.greyDark4
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: Theme.bottomBarFontSize
            font.family: "Roboto"
            leftPadding: control.spacing
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:16}
}
##^##*/
