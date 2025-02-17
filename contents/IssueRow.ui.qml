

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
import QtQuick.Controls 2.15
import Thermo 1.0
import Redformatter
import Redmine

Row {
    id: root
    signal selected
    spacing: 10
    property Room selectedRoom
    property int pageCount: 6
    IssueList {
        id: issue_list

        Component.onCompleted: {
            issue_list.fetch_issues()
        }
    }
    Repeater {
        model: issue_list

        Issue {
            id: issueItem
            anchors.verticalCenter: parent.verticalCenter
            enabled: root.enabled

            issue_id: model.id

            //issue_type:
            //var type = model.title.split("_")[0]
            issue_title: model.title.replace(model.title.split("_")[0] + "_",
                                             "")
            achievment_rate: 60 //model.achievment
            is_overdue: model.isoverdue

            deadline: model.deadline
            issue_type: model.title.split("_")[0]
            // Connections {
            //     target: parent // Connections target을 root로 설정
            //     function onSelected() {
            //         parent.selectedRoom = issueItem.room // room 값을 전달
            //         parent.selected() // 부모의 selected 신호 발생
            //         console.log("Issue ID: " + issueItem.issue_id)
            //         console.log("Issue Title: " + issueItem.issue_title)
            //         console.log("Deadline: " + issueItem.deadline)
            //     }
            // }
        }
    }
}
