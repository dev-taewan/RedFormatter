import QtQuick 2.15
import QtQuick.Controls
//import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Basic 2.15  // TableView 지원
import QtQuick.Controls.Material 2.15
import Thermo 1.0
import Redformatter
import Redmine
import QtQuick.Dialogs
Item {
    property TodoWorkPlantest todayplan
    property TodoWorkPlantest nextplan
    property int issue_id: 0
property int mode: 0
    id: newWindow
    property alias issueWorkTable: issue_work_table

    IssueWorkTable {
        id: issue_work_table
        Component.onCompleted: {
            if (issue_id>0)
            {
                issue_work_table.addItem("번호","종류","업무","기한","진행률","결과물","특이사항")
                issue_work_table.GetCurrentWorkTable(issue_id)
            }

        }
        function appendRow(data) {
            var item = {}
            for (var i = 0; i < data.length; i++) {
                item["column" + i] = data[i]  // 🔥 column0, column1, column2 형태로 저장
            }
            console.log("append Row")
            issue_work_table.addItem(item["column" + 0],item["column" + 1],item["column" + 2],item["column" + 3],item["column" + 4],item["column" + 5],item["column" + 6])
        }
    }


    ColumnLayout {
        id: main_table_column
                anchors.fill: parent // 부모 전체를 채우도록 수정
                spacing: 10
        RowLayout {
            id:check_btn
                       Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter// anchors 대신 사용
                        //anchors.margins: 20

        Button {
            text: "추가"
            font.pixelSize: 25 // 폰트 크기 조정
            background: Rectangle { // 버튼 배경 스타일 변경
                color: "#4CAF50" // 녹색 계열
                radius: 5
            }
            contentItem: Text { // 버튼 텍스트 스타일 변경
                text: parent.text
                color: "white"
                //font: parent.font
                font.bold: true
                //anchors.centerIn: parent
            }
            onClicked: {
                console.log("click")
                //console.log(todayplan.)
                //issue_work_table.appendRow([issue_work_table.rowCount(),issue_work_table.rowCount()+1,"❓ 조사",issue_work_table.rowCount()+2,issue_work_table.rowCount()+3,issue_work_table.rowCount()+4])
            }
        }
        Button {
            id: close_btn
            text: "닫기"
            font.pixelSize: 25 // 폰트 크기 조정
            background: Rectangle { // 버튼 배경 스타일 변경
                color: "#f44336" // 붉은색 계열
                radius: 5
            }
            contentItem: Text { // 버튼 텍스트 스타일 변경
                text: parent.text
                color: "white"
                //font: parent.font
                font.bold: true
                //anchors.centerIn: parent
            }

            onClicked: {
                newWindow.visible = false
            }
        }

        }
        // 📌 TableView 본체
        TableView {
            Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.alignment: Qt.AlignHCenter
                        Layout.topMargin: 10
                        model: issue_work_table
                        columnWidthProvider: function(column) {
                            return tableView.width / 7
                        }
            delegate: RowLayout
            {
                id:rows
                //anchors.horizontalCenter:main_table_column.horizontalCenter
                // anchors.top:parent.top
                // anchors.horizontalCenter:parent.horizontalCenter
                //Layout.fillWidth: true
                spacing: 5 // 헤더 간 간격 줄임
                width: parent.width
                //width: tableView.columnWidthProvider(styleData.column)
                //spacing: 1
                property bool isFirstRow: index === 0
                property int row_index: index
                //🔥 첫 번째 컬럼 (번호)
                Rectangle {
                    id:row_num
                    width: 50
                    height: 40 // 높이 늘림
                    color: isFirstRow? "#5ae0aa":"white" // 테이블 셀 배경색 변경
                    border.color: "#c0c0c0" // 테이블 셀 테두리 색상 연하게
                    radius: 3 // 테이블 셀 둥근 모서리

                    Text {
                        visible:isFirstRow
                        anchors.centerIn: parent
                        text: model.id
                        color:   isFirstRow?"white":"#555" // 테이블 텍스트 색상 조금 더 어둡게
                        font.pixelSize: 14

                    }
                    Button {
                        visible:!isFirstRow
                        anchors.fill: parent
                        Material.elevation: 2 // ✅ 버튼에 약간의 그림자 효과 추가
                        Material.roundedScale : Material.NotRounded
                       // Material.containerStyle.:0
                        Material.background: "transparent" // ✅ 클릭 시 자연스럽게 눌리는 효과 적용

                            contentItem: Text { // 버튼 텍스트 스타일 변경
                                text: "추가"
                                font.pixelSize: 14 // 폰트 크기 조정
                                color: "#4CAF50"
                                //font: parent.font
                                font.bold: true
                                anchors.fill: parent // ✅ 부모(Button) 크기에 맞춤
                                        horizontalAlignment: Text.AlignHCenter // ✅ 가로 중앙 정렬
                                        verticalAlignment: Text.AlignVCenter   // ✅ 세로 중앙 정렬
                            }
                            onPressed: {opacity = 0.3}
                            onReleased: {opacity = 1.0}
                            onClicked: {
                                console.log(model.title)
                                if(mode==0)
                                {
                                    console.log("today model title: ",model.title)
                                    todayplan.loadTaskData(model)
                                    todayplan.visible = true
                                    //nextplan.visible = false
                                }
                                else
                                {
                                    nextplan.loadTaskData(model)
                                    nextplan.visible = true
                                    //todayplan.visible = false
                                }

                                // detailPanel.taskData = model.get(index)

                            }
                        }
                }


                // 🔥 두 번째 컬럼 (종류)
                Rectangle {
                    width: 350
                    height: 40
                    color: isFirstRow? "#5ae0aa":"white"
                    border.color: "#c0c0c0"
                    radius: 3

                    TextEdit {
                        id:title_edit
                        anchors.centerIn: parent
                        text: model.title
                        color: isFirstRow?"white":"#555"
                        font.pixelSize: 14
                        readOnly:isFirstRow

                        onTextChanged:{
                            //issue_work_table.updateItem(row_index, title_edit.text);
                            console.log("title changed")
                            //model.title=title_edit.text
                        }
                    }

                }

                // 🔥 세 번째 컬럼 (업무)
                Rectangle {
                    width: 140
                    height: 40
                    color: isFirstRow? "#5ae0aa":"white"
                    border.color: "#c0c0c0"
                    radius: 3
                    ComboBox {

                                    id: work_type_list
                                    //visible: !rows.isFirstRow
                                    anchors.centerIn: parent

                                    background: Rectangle {
                                            color: "white"
                                            border.color: "#c0c0c0"
                                            radius: 3
                                        }

                                        contentItem: Text {
                                            text: work_type_list.displayText
                                            font.pixelSize: 14
                                            color: "#555"  // 글씨 색상 맞추기
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                        visible:!isFirstRow
                                        model:["❓ 조사","❗ 분석", "⚒️ 설계", "⚡️ 구현", "⚠️ 이슈", "✨ 서포트", "⚙️ 셋업", "✏️ 리뷰"]
                                        Binding {
                                                target: work_type_list
                                                property: "currentIndex"
                                                when: model.type !== undefined
                                                value: work_type_list.model.indexOf(model.type) !== -1 ? work_type_list.model.indexOf(model.type) : 0
                                            }

                                        onActivated: function(index) {
                                            console.log("index: ",row_index)
                                            issue_work_table.updateItem(row_index, work_type_list.model[index],IssueWorkTable.WorkTypeRole);
                                        }

                                }

                                // isFirstRow가 true일 때만 Text 표시
                                Text {
                                    visible: isFirstRow
                                    anchors.centerIn: parent
                                    text: model.type
                                    color: isFirstRow ? "white" : "#555"
                                    font.pixelSize: 14

                                }

                }

                // 🔥 첫 번째 컬럼 (기한)
                Rectangle {
                    width: 100
                    height: 40
                    color: isFirstRow? "#5ae0aa":"white"
                    border.color: "#c0c0c0"
                    radius: 3
                    TextEdit {
                        anchors.centerIn: parent
                        text: model.deadline
                        color: isFirstRow?"white":"#555"
                        font.pixelSize: 14
                        readOnly:isFirstRow
                    }
                    MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        console.log("deadline")
                                        calendarPopup.open()
                                        currentRow = index
                                    }
                                }
                }

                // 🔥 두 번째 컬럼 (진행률)
                Rectangle {
                    width: 300
                    height: 40
                    color: isFirstRow? "#5ae0aa":"white"
                    border.color: "#c0c0c0"
                    radius: 3
                    TextEdit {
                        id:achievement_column
                        anchors.centerIn: parent
                        text: model.achievement
                        color: isFirstRow?"white":"#555"
                        font.pixelSize: 14
                        readOnly:isFirstRow
                    }
                }

                // 🔥 세 번째 컬럼 (결과물)
                Rectangle {
                    width: 150
                    height: 40
                    color: isFirstRow? "#5ae0aa":"white"
                    border.color: "#c0c0c0"
                    radius: 3
                    TextEdit {
                        id:result_column
                        anchors.centerIn: parent
                        text: model.result
                        color: isFirstRow?"white":"#555"
                        font.pixelSize: 14
                        readOnly:isFirstRow
                    }
                }
                // 🔥 세 번째 컬럼 (특이사항)
                Rectangle {
                    width: 150
                    height: 40
                    color: isFirstRow? "#5ae0aa":"white"
                    border.color: "#c0c0c0"
                    radius: 3
                    TextEdit {
                        id:etc_column
                        anchors.centerIn: parent
                        text: model.etc
                        color: isFirstRow?"white":"#555"
                        font.pixelSize: 14
                        readOnly:isFirstRow
                    }
                }
            }
        }


    }


}
