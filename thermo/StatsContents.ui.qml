/******************************************************************************
**
** Copyright (C) 2021 The Qt Company Ltd.
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
    id: root
    property int selected: 0

    width: background.width
    height: background.height

    Image {
        id: background
        visible: !selected
        source: "assets/stats-month.png"
    }

    Image {
        visible: selected
        source: "assets/stats-year.png"
    }

    Text {
        x: Theme.isBig ? 149 : 87
        y: Theme.isBig ? 278 : 160
        width: 30
        horizontalAlignment: Text.AlignHCenter
        color: ColorStyle.greyDark1
        font.pixelSize: Theme.statsViewChartLabelFontSize
        text: selected ? qsTr("Jan") : qsTr("05/11")
    }

    Text {
        x: Theme.isBig ? 254 : 150
        y: Theme.isBig ? 278 : 160
        width: 30
        horizontalAlignment: Text.AlignHCenter
        color: ColorStyle.greyDark1
        font.pixelSize: Theme.statsViewChartLabelFontSize
        text: selected ? qsTr("Feb") : qsTr("05/12")
    }

    Text {
        x: Theme.isBig ? 361 : 213
        y: Theme.isBig ? 278 : 160
        width: 30
        horizontalAlignment: Text.AlignHCenter
        color: ColorStyle.greyDark1
        font.pixelSize: Theme.statsViewChartLabelFontSize
        text: selected ? qsTr("Mar") : qsTr("05/13")
    }

    Text {
        x: Theme.isBig ? 468 : 276
        y: Theme.isBig ? 278 : 160
        width: 30
        horizontalAlignment: Text.AlignHCenter
        color: ColorStyle.greyDark1
        font.pixelSize: Theme.statsViewChartLabelFontSize
        text: selected ? qsTr("Apr") : qsTr("05/14")
    }

    Text {
        x: Theme.isBig ? 575 : 339
        y: Theme.isBig ? 278 : 160
        width: 30
        horizontalAlignment: Text.AlignHCenter
        color: ColorStyle.greyDark1
        font.pixelSize: Theme.statsViewChartLabelFontSize
        text: selected ? qsTr("May") : qsTr("05/15")
    }

    Text {
        x: Theme.isBig ? 681 : 402
        y: Theme.isBig ? 278 : 160
        width: 30
        horizontalAlignment: Text.AlignHCenter
        color: ColorStyle.greyDark1
        font.pixelSize: Theme.statsViewChartLabelFontSize
        text: selected ? qsTr("Jun") : qsTr("05/16")
    }
}
