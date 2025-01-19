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

Image {
    id: weatherIcon
    Behavior on opacity { NumberAnimation { duration: 200 } }
    source: "assets/weather/w_01.png";
    Timer {
        running: true
        repeat: true
        interval: 5000
        onTriggered: {
            if (Math.random() < 0.3) {
                switch (Math.floor(Math.random() * 7)) {
                    case 0: weatherIcon.source = "assets/weather/w_01.png"; break;
                    case 1: weatherIcon.source = "assets/weather/w_02.png"; break;
                    case 2: weatherIcon.source = "assets/weather/w_03.png"; break;
                    case 3: weatherIcon.source = "assets/weather/w_04.png"; break;
                    case 4: weatherIcon.source = "assets/weather/w_05.png"; break;
                    case 5: weatherIcon.source = "assets/weather/w_06.png"; break;
                    case 6: weatherIcon.source = "assets/weather/w_07.png"; break;
                }
            }
        }
    }
}
