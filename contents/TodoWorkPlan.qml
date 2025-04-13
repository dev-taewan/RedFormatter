// TaskDetailPanel.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import Qt.labs.platform 1.1
import Redmine
import QtQuick.Layouts
import QtQuick
import QtQuick 2.15
import QtQuick.Controls 2.15

import Thermo 1.0
import Redformatter
import QtQuick.Window

ThermoView {
    property bool showMain
    // property Room currentRoom: Rooms.livingRoom
    // property int cardSizeWithSpacing: Theme.cardRowSpacing + Theme.cardWidth
    // property int pageCount: 6
    signal selected
    //signal getTreeitems
    // property alias workDetailInfo: subTaskManager
    // property ListModel taskDataListModel: ListModel {}

    property TreeModel treeModel
    property ListModel fileModel
    property ListModel issueModel
    function getTreeItems() {
        console.log("gettree")
        //treeModel.getAllData()
        return treeModel.getAllData()
    }
    function fileModelTest() {
        console.log(fileModel.count)
        for(var i=0;i<fileModel.count;i++)
        {
            console.log(fileModel.get(i).path)
        }
        //console.log("gettree")
        //treeModel.getAllData()
        return fileModel
    }
    //visible: false
    id: detailPanel
    // width:1280
    // height:720
    property var taskData: ({
            "title": "",
            "type": "",
            "deadline": "",
            "achievement": "0"
        })
    property ListModel taskDataListModel: ListModel {}
    function loadTaskData(data) {
            console.log("loadTaskData 호출됨");
            //taskDataListModel.clear() // 모델 초기화: 기존 데이터 제거 <--- 수정됨
            if (Array.isArray(data)) { //data가 배열인지 확인 <--- 수정됨
                data.forEach(item => { // 배열 순회 <--- 수정됨
                    taskDataListModel.append({
                        "title": item.title || "N/A",
                        "type": item.type || "N/A",
                        "deadline": item.deadline || "N/A",
                        "achievement": Number(item.achievement) || 0
                    });
                })
            } else if (data) { //data가 객체이고 유효한 경우 <--- 수정됨
                taskDataListModel.append({
                    "title": data.title || "N/A",
                    "type": data.type || "N/A",
                    "deadline": data.deadline || "N/A",
                    "achievement": Number(data.achievement) || 0
                });
            }


            //visible=true
            console.log("Visibility state:", visible)
        }
    Rectangle {
            anchors.fill: parent
            color: Material.backgroundColor
            border.color: Material.primaryColor
            radius: 5

            Component.onCompleted:{
               console.log("rect size: ".width,height)
            }
        }
    // Rectangle { // 배경 확인용 Rectangle (색상 변경)
    //         anchors.fill: parent
    //         color: "lightgray" // Material.backgroundColor 대신 기본 색상 사용!! <--- 여기 수정
    //     }
    ScrollView {
            id: scrollView
            anchors.fill: parent // ScrollView가 부모 크기를 채우도록 설정
            clip: true // 내용이 ScrollView 영역을 벗어나지 않도록 클리핑

            // 스크롤바 정책 설정 (필요에 따라 조정 가능)
            ScrollBar.horizontal.policy: ScrollBar.AsNeeded
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn // 항상 스크롤바 표시
    ColumnLayout {
            id: mainColumnLayout // ColumnLayout ID 추가 <--- 추가됨
            Layout.fillWidth:true
            Layout.fillHeight:true
            spacing:10


            Repeater {
                id: repeater
                model: taskDataListModel
                delegate: ColumnLayout { // delegate을 ColumnLayout으로 변경 <--- 수정됨
                    Layout.fillWidth: true
                    //Layout.fillHeight: true // delegate ColumnLayout에서 fillHeight 제거 <--- 수정됨
                    spacing: 10 // delegate ColumnLayout spacing 수정 <--- 수정됨

                    GroupBox {
                        width: parent.width
                        title: " 기본 정보 - "
                        leftPadding: 15
                        rightPadding: 15
                        background: Rectangle {
                            id: bgRect
                            color: Material.backgroundColor
                            border.color: Material.dividerColor
                            radius: 4
                        }
                        contentItem: ColumnLayout {
                            Layout.fillWidth: true
                            //Layout.fillHeight: true // contentItem ColumnLayout에서 fillHeight 제거 <--- 수정됨
                            spacing: 10
                            Grid {
                                id:content_info
                                columns: 2
                                spacing: 15
                                width: parent.width
                                LabeledField { label: "업무 제목"; text: model.title ? model.title : "N/A"; onTextChanged: console.log("Title updated:", text) }
                                LabeledField { label: "종류"; text: model.type ? model.type : "N/A" ; onTextChanged: console.log("Type updated:", text) }
                                LabeledField { label: "기한"; text: model.deadline ? model.deadline : "N/A" ; onTextChanged: console.log("Deadline updated:", text)}
                                LabeledProgressBar { label: "진행률"; value: { if(typeof model.achievement === "string") { return parseFloat(model.achievement) / 100 } return model.achievement / 100 }}
                            }

                            CollapsibleSection {
                                                        id: collapsibleSection
                                                        width: detailPanel.width
                                                        height:detailPanel.height
                                                        // anchors.left:detailPanel.left
                                                        // anchors.right:detailPanel.right
                                                        title: " 하위 업무"
                                                        ex_contentItem: WorkDetailInfo {
                                                            id: subTaskManager
                                                            title:model.title
                                                            anchors.fill:detailPanel
                                                            width:1280
                                                            //height:50
                                                            //visible: contentArea.visible // 오류 발생 원인: contentArea가 뒤에 정의됨
                                                            Binding { // Binding을 사용하여 contentArea가 생성된 후 visible 바인딩 평가
                                                                target: subTaskManager
                                                                property: "visible"
                                                                //value: contentArea.visible
                                                            }
                                                            //model: ListModel { id: subTaskModel}
                                                            // onTaskAdded: function(text) {
                                                            //     console.log("add")
                                                            //     subTaskModel.append({description: text, completed: false})
                                                            // }
                                                            Component.onCompleted:{

                                                                detailPanel.treeModel=subTaskManager.treeModel
                                                            }
                                                            // onGetTreeitems:function(){
                                                            //     subTaskManager.treeModel.getAllData()
                                                            // }

                                                        }
                                                    }


                        }
                    }
                }
            }
        }
    }
     // 데이터 저장 함수
    function saveTaskData() {
            let data = {
                subTasks: subTaskModel,
                files: fileModel,
                issues: issueModel
            }
            taskUpdated(data)
        }
        // 컴포넌트 정의
        component LabeledField: Row {
            property string label
            property string text

            spacing: 10
            Label {
                text: parent.label + ":"
                font.bold: true
                width: 80
                horizontalAlignment: Text.AlignRight
            }
            Label { text: parent.text }
        }

        component LabeledProgressBar: Row {
            property string label
            property real value

            spacing: 10
            Label {
                text: parent.label + ":"
                font.bold: true
                width: 80
                horizontalAlignment: Text.AlignRight
            }
            ProgressBar {
                value: parent.value
                width: 200
                Material.accent: value >= 0.7 ? Material.Green : value >= 0.4 ? Material.Orange : Material.Red
            }
        }

        component CollapsibleSection: Column {
            property alias title: header.text
            property alias ex_contentItem: contentArea.data


            spacing: 0
            // 헤더 영역
            Button {
                id: header // ID 확인 (header 로 되어 있는지)
                width: parent.width
                background:  Rectangle { // 배경 확인용 Rectangle (색상 변경)
                    anchors.fill: parent
                    color: "lightgray" // Material.backgroundColor 대신 기본 색상 사용!! <--- 여기 수정
                }
                flat: true      // flat 속성 (외형 관련, 클릭 동작에 영향 X)


                contentItem: Row { // contentItem 정의 확인
                    Label {
                        text: header.text // 텍스트 바인딩 확인
                        font.bold: true
                        color: Material.primaryColor
                        //horizontalAlignment: Text.AlignLeft
                    }
                    Text {
                        text: contentArea.visible ? "▲" : "▼" // 텍스트 변경 로직 확인
                        font.pixelSize: 14
                        color: Material.primaryColor
                    }

                    Item {
                        id: contentArea
                        width: parent.width
                        visible: true // CollapsibleSection contentArea visible 초기값 수정: 접혀진 상태로 시작 <--- 수정됨
                        height: visible ? childrenRect.height : 0 // 높이 자동 조정 및 visible 속성에 따라 높이 변경 <--- 수정됨
                        clip: true // clip 속성 추가: contentArea 내용이 Item 영역을 벗어나지 않도록 <--- 추가됨
                        Behavior on height { // height 속성에 animation behavior 추가 <--- 추가됨
                            NumberAnimation { duration: 200 }
                        }
                        //contentItem

                        ColumnLayout { // contentArea 내부를 ColumnLayout으로 변경 <--- 수정됨
                            id: contentColumnLayout // contentArea ColumnLayout id 추가 <--- 추가됨
                            Layout.fillWidth: true
                            spacing: 0 // contentArea ColumnLayout spacing 수정 <--- 수정됨
                            Repeater { // Repeater 추가하여 contentItem을 여러 개 배치 가능하도록 (필요한 경우) <--- 추가됨
                                model: 1 // 일단 1개만 배치
                                delegate: ex_contentItem // delegate으로 contentItem 사용
                            }
                        }

                        onVisibleChanged: {
                            console.log("visible: ", visible, parent.height)
                            if (visible) {
                                height = childrenRect.height
                            } else {
                                height = 0
                            }
                        }
                    }
                }

                onClicked: { // onClicked 시그널 핸들러 정의 확인
                    console.log("click")
                    contentArea.visible = !contentArea.visible // contentArea visible 토글 로직 확인
                }
            }
        }

 component FileAttachmentManager: Column {
            property alias model: fileListView.model
                    signal filesSelected(var files)  // 시그널 추

        width: parent.width
        spacing: 10

        ListView {
            id: fileListView
            width: parent.width
            height: Math.min(contentHeight, 100)
            delegate: Row {
                spacing: 10
                Image {
                    source: "qrc:/icons/file-icon.svg"
                    width: 20
                    height: 20
                }
                Label { text: path }
                Button {
                    text: "삭제"
                    Material.foreground: Material.Red
                    onClicked: model.remove(index)
                }
            }
        }

        Button {
            text: "파일 첨부"
            Material.background: Material.Blue
            onClicked: fileDialog.open()
            FileDialog {
                id:fileDialog
                 onAccepted: filesSelected(files)
            }
        }
    }
}
