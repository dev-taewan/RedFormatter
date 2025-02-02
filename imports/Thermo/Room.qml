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

Item {
    enum Status {
        Heating, Cooling, Off
    }

    enum FanLevel {
        FanOff, FanQuarter, FanHalf, FanThreeQuarters, FanFull
    }

    id: root
    property string name
    property string floor
    property int temperature : 69
    property bool auto_
    property bool power: true
    property bool dryer
    property int fan
    property bool eco
    property bool streamer
    property int status

    property int startHour: 12
    property int startMinute: 30
    property int endHour: 18
    property int endMinute: 30

    property string fanImage: "qrc:/assets/fan-off.png"
    property string smallFanImage: "qrc:/assets/fan-off-small.png"
    readonly property string fanOffImage: "qrc:/assets/fan-off.png"

    Connections {
        target: root
        function onPowerChanged()
        {
            if (!root.power) {
                root.status = Room.Off
            } else {
                root.status = Room.Heating
            }
        }
        // onPowerChanged: {
        //     if (!root.power) {
        //         root.status = Room.Off
        //     } else {
        //         root.status = Room.Heating
        //     }
        // }

        // onStatusChanged: {
        //     root.power = (root.status !== Room.Off)
        // }
        function onStatusChanged()
        {
            root.power = (root.status !== Room.Off)
        }
    }

    property Timer statusChanger: Timer {
        running: true
        repeat: true
        interval: 5000
        onTriggered: {
            if (root.status === Room.Off)
                return;

            if (Math.random() < 0.3)
                root.status = (root.status === Room.Heating ? Room.Cooling : Room.Heating)
        }
    }

    property Timer tempChanger: Timer {
        running: true
        repeat: true
        interval: 3000
        onTriggered: {
            if (Math.random() < 0.3) {
                var min = 50;
                var max = 90;
                root.temperature += Math.random() < 0.5 ? -1 : 1
                if (root.temperature < min) { root.temperature = min }
                else if (root.temperature > max) { root.temperature = max }
            }
        }
    }

    states: [
        State {
            name: "FanOff"
            when: root.fan === Room.FanLevel.FanOff
            PropertyChanges {
                target: root
                fanImage: "qrc:/assets/fan-off.png"
                smallFanImage: "qrc:/assets/fan-off-small.png"
            }
        },
        State {
            name: "FanQuarter"
            when: root.fan === Room.FanLevel.FanQuarter
            PropertyChanges {
                target: root
                fanImage: "qrc:/assets/fan-1-on.png"
                smallFanImage: "qrc:/assets/fan-1-on-small.png"
            }
        },
        State {
            name: "FanHalf"
            when: root.fan === Room.FanLevel.FanHalf
            PropertyChanges {
                target: root
                fanImage: "qrc:/assets/fan-2-on.png"
                smallFanImage: "qrc:/assets/fan-2-on-small.png"
            }
        },
        State {
            name: "FanThreeQuarters"
            when: root.fan === Room.FanLevel.FanThreeQuarters
            PropertyChanges {
                target: root
                fanImage: "qrc:/assets/fan-3-on.png"
                smallFanImage: "qrc:/assets/fan-3-on-small.png"
            }
        },
        State {
            name: "FanFull"
            when: root.fan === Room.FanLevel.FanFull
            PropertyChanges {
                target: root
                fanImage: "qrc:/assets/fan-4-on.png"
                smallFanImage: "qrc:/assets/fan-4-on-small.png"
            }
        }
    ]
}
