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
import ThermoConfiguration 1.0

Item {
    id: root
    property int selectedView: -1
    property int index: -1

    Behavior on opacity {
        enabled: Configuration.enableFadingAnimations
        NumberAnimation {}
    }
    Behavior on x { NumberAnimation {} }

    states: [
        State {
            id: selected
            name: "selected"
            when: root.selectedView == root.index
            PropertyChanges { target: root; opacity: 1 }
            PropertyChanges { target: root; x: 0 }
        },
        State {
            name: "notSelected"
            when: root.selectedView != root.index
            PropertyChanges { target: root; opacity: 0 }
            PropertyChanges { target: root; x: 100 * (root.selectedView > root.index ? -1 : 1) }
        }
    ]
}
