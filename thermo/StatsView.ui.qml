

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
import ThermoConfiguration 1.0

ThermoView {
    id: thermoView
    width: stats.width
    height: stats.height

    StatsContents {
        id: stats
        anchors.fill: parent

        Image {
            id: image
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: Theme.statsViewToggleTopMargin
            source: stats.selected === 0 ? "assets/toggle-month.png" : "assets/toggle-year.png"

            Text {
                id: monthLabel
                text: qsTr("Month")
                x: Theme.statsViewButtonMonthHCenter - width / 2
                y: Theme.statsViewButtonVCenter - baselineOffset / 2
                font.pixelSize: Theme.statsViewButtonFontSize
                font.family: "Roboto"
                color: stats.selected === 0 ? ColorStyle.blue : ColorStyle.greyDark4
            }

            Text {
                id: yearLabel
                text: qsTr("Year")
                x: Theme.statsViewButtonYearHCenter - width / 2
                y: Theme.statsViewButtonVCenter - baselineOffset / 2
                font.pixelSize: Theme.statsViewButtonFontSize
                font.family: "Roboto"
                color: stats.selected !== 0 ? ColorStyle.blue : ColorStyle.greyDark4
            }

            MouseArea {
                id: month
                width: parent.width / 2
                height: parent.height

                Connections {
                    target: month
                    onClicked: {
                        if (stats.selected != 0) {
                            stats.selected = 0
                        }
                    }
                }
            }

            MouseArea {
                id: year
                x: parent.width / 2
                width: parent.width / 2
                height: parent.height

                Connections {
                    target: year
                    onClicked: {
                        if (stats.selected != 1) {
                            stats.selected = 1
                        }
                    }
                }
            }
        }
    }
}
