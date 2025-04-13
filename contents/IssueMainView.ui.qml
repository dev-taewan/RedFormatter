import QtQuick 2.15
import QtQuick.Controls
//import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Basic 2.15
// TableView 지원
import QtQuick.Controls.Material 2.15
import Thermo 1.0
import Redformatter
import Redmine
import QtQuick.Dialogs

import Qt.labs.platform 1.1
import Redmine
import QtQuick.Layouts
import QtQuick

Window {
    id: appWindow
    width: Theme.screenWidth
    height: Theme.screenHeight
    property int issue_id: 0
    property int selectedView: 0
    //property IssueManager issue_manager
    // BackgroundImage {
    //     anchors.fill: parent
    // }
    IssueManager {
        id: issue_manager
    }
    Button {
        text: "전송"
        x: 500
        width: 100
        height: 50
        font.pixelSize: 25 // 폰트 크기 조정
        background: Rectangle {
            // 버튼 배경 스타일 변경
            color: "#4CAF50" // 녹색 계열
            radius: 5
        }
        contentItem: Text {
            // 버튼 텍스트 스타일 변경
            text: parent.text
            color: "white"
            //font: parent.font
            font.bold: true
            //anchors.centerIn: parent
        }
        onClicked: {
            if (issue_manager == null) {
                issue_manager = new IssueManager()
            }

            issue_manager.GetWorkTable(
                        todoworkplan.issueWorkTable.getWorkTableList())
            console.log("get tree items: ",
                        todoworkplan.todayplan.getTreeItems())
            //TreeItem item=todoworkplan.todayplan.getTreeItems()
            //var item = todoworkplan.todayplan.getTreeItems()
            issue_manager.GetTodayWorkPlan(
                        todoworkplan.todayplan.getTreeItems(), 0)
            //todoworkplan.todayplan.fileModelTest()
        }
    }
    WriteIssue {
        id: todoworkplan
        issue_id: appWindow.issue_id
        //width: 300
        height: parent.height / 2
        todayplan: todaywork
        nextplan: nextwork
        mode: 0
    }
    // TodoWorkPlan {
    //     id: todaywork
    //     width: parent.width

    //     //height: parent.height - topBar.height - bottomBar.height
    //     //anchors.bottom: bottomBar.top
    //     //anchors.bottomMargin: -Theme.bottomBarHeight
    //     anchors.top: todoworkplan.bottom
    //     enabled: appWindow.selectedView === 0
    //     visible: opacity > 0.01

    //     selectedView: appWindow.selectedView
    //     index: 0
    // }
    Item {
        id: testitem
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: todoworkplan.bottom
        height: parent.height - topBar.height - bottomBar.height
        //anchors.bottom: bottomBar.top
        anchors.bottomMargin: -Theme.bottomBarHeight
        //property int currentViewIndex: 0
        TodoWorkPlan {
            id: todaywork
            anchors.fill: parent
            //width: 1280
            enabled: appWindow.selectedView === 0
            visible: opacity > 0.01

            selectedView: appWindow.selectedView
            index: 0
        }
    }

    Item {
        id: testitem2
        // anchors.left: parent.left
        // anchors.right: parent.right
        width: parent.width
        anchors.top: todoworkplan.bottom
        height: parent.height - topBar.height - bottomBar.height
        //anchors.bottom: bottomBar.top
        anchors.bottomMargin: -Theme.bottomBarHeight
        //property int currentViewIndex: 0
        TodoWorkPlan {
            id: nextwork
            anchors.fill: parent
            enabled: appWindow.selectedView === 1
            visible: opacity > 0.01

            selectedView: appWindow.selectedView
            index: 1
        }
    }
    IssueWriterBottomBar {
        id: bottomBar
        z: 10 // give precedence to bottom bar touch areas
        width: parent.width

        height: Theme.bottomBarHeight
        selected: appWindow.selectedView
        anchors.bottom: parent.bottom

        anchors.bottomMargin: 1

        showMainOption: places.showMain
        Connections {
            target: bottomBar
            function onViewSwitched(index: int) {
                console.log("click index: ", index)
                appWindow.selectedView = index
                todoworkplan.mode = index
            }
        }
    }
}
