import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Basic 2.15  // TableView 지원
import Thermo 1.0
import Redformatter
import Redmine

Window {

    property int issue_id: 0
    id: newWindow
    width: 2000 // 창 너비 늘림
    height: 600 // 창 높이 늘림
    color: "#f0f0f0" // 전체 배경색을 밝게 변경
    flags: Qt.Dialog | Qt.FramelessWindowHint    // 항상 부모 위에 위치, 이동 불가
    modality: Qt.ApplicationModal    // 부모 창 제어 불가능
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
            issue_work_table.addItem(item["column" + 0],item["column" + 1],item["column" + 2],item["column" + 3],item["column" + 4],item["column" + 5],item["column" + 6])
        }
    }
    // ListModel {
    //         id: issue_work_type_list
    //         ListElement { type: "❓ 조사" }
    //         ListElement { type: "🛠️ 설계" }
    //         ListElement { type: "⚡️ 구현" }
    //         ListElement { type: "⚠️ 이슈" }
    //         ListElement { type: "✨ 서포트" }
    //          ListElement { type: "⚙️ 셋업" }
    //           ListElement { type: "✏️ 리뷰" }
    //     }
    ColumnLayout {
        id:main_table_column
        anchors.fill:parent
        // anchors.top: newWindow.top // 상단에 anchors.top 설정
        // anchors.horizontalCenter: newWindow.horizontalCenter
        //anchors.bottomMargin:30
        spacing: 10 // 간격 늘림, 여백 추가
        width: parent.width // 부모의 너비를 고정
        //margins: 20 // 전체 마진 추가

        // 📌 테이블 헤더 (수동 생성)
        // RowLayout {
        //     topMargin:10
        //     leftMargin:(parent.width-1200)/2
        //     Layout.fillWidth: true
        //     spacing: 5 // 헤더 간 간격 줄임

        //     Rectangle {
        //         width: 50; height: 40; // 높이 늘림
        //         color: "#e0e0e0" // 헤더 배경색 밝게
        //         border.color: "#c0c0c0" // 테두리 색상 연하게
        //         radius: 5 // 둥근 모서리 추가
        //         Text {
        //             anchors.centerIn: parent;
        //             text: "번호";
        //             font.bold: true;
        //             color: "#333"; // 텍스트 색상 어둡게
        //             font.pixelSize: 14 // 폰트 크기 조정
        //         }
        //     }
        //     Rectangle {
        //         width: 70; height: 40;
        //         color: "#e0e0e0"
        //         border.color: "#c0c0c0"
        //         radius: 5
        //         Text {
        //             anchors.centerIn: parent;
        //             text: "종류";
        //             font.bold: true;
        //             color: "#333";
        //             font.pixelSize: 14
        //         }
        //     }
        //     Rectangle {
        //         width: 350; height: 40;
        //         color: "#e0e0e0"
        //         border.color: "#c0c0c0"
        //         radius: 5
        //         Text {
        //             anchors.centerIn: parent;
        //             text: "업무";
        //             font.bold: true;
        //             color: "#333";
        //             font.pixelSize: 14
        //         }
        //     }
        //     Rectangle {
        //         width: 100; height: 40;
        //         color: "#e0e0e0"
        //         border.color: "#c0c0c0"
        //         radius: 5
        //         Text {
        //             anchors.centerIn: parent;
        //             text: "기한";
        //             font.bold: true;
        //             color: "#333";
        //             font.pixelSize: 14
        //         }
        //     }
        //     Rectangle {
        //         width: 300; height: 40;
        //         color: "#e0e0e0"
        //         border.color: "#c0c0c0"
        //         radius: 5
        //         Text {
        //             anchors.centerIn: parent;
        //             text: "진행률";
        //             font.bold: true;
        //             color: "#333";
        //             font.pixelSize: 14
        //         }
        //     }
        //     Rectangle {
        //         width: 150; height: 40;
        //         color: "#e0e0e0"
        //         border.color: "#c0c0c0"
        //         radius: 5
        //         Text {
        //             anchors.centerIn: parent;
        //             text: "결과물";
        //             font.bold: true;
        //             color: "#333";
        //             font.pixelSize: 14
        //         }
        //     }
        //     Rectangle {
        //         width: 150; height: 40;
        //         color: "#e0e0e0"
        //         border.color: "#c0c0c0"
        //         radius: 5
        //         Text {
        //             anchors.centerIn: parent;
        //             text: "특이사항";
        //             font.bold: true;
        //             color: "#333";
        //             font.pixelSize: 14
        //         }
        //     }
        //     // Button {
        //     //     text: "행 추가"
        //     //     font.pixelSize: 14 // 폰트 크기 조정
        //     //     background: Rectangle { // 버튼 배경 스타일 변경
        //     //         color: "#4CAF50" // 녹색 계열
        //     //         radius: 5
        //     //     }
        //     //     contentItem: Text { // 버튼 텍스트 스타일 변경
        //     //         text: parent.text
        //     //         color: "white"
        //     //         font: parent.font
        //     //         //font.bold: true
        //     //         anchors.centerIn: parent
        //     //     }
        //     //     onClicked: {
        //     //         issue_work_table.appendRow(["ID" + issue_work_table.rowCount()])
        //     //     }
        //     // }

        // }



        // 📌 TableView 본체
        TableView {
            id: tableView
            topMargin:10
            leftMargin:(parent.width-1200)/2
            //anchors.horizontalCenter:parent.horizontalCenter
            Layout.fillWidth: true
            Layout.fillHeight: true
            // Layout.fillWidth: true
            // Layout.fillHeight: true
            // columnSpacing: 1
            // rowSpacing: 1
            // boundsBehavior: Flickable.StopAtBounds
            model: issue_work_table

            columnWidthProvider: function(column) {
                        return tableView.width / 7;
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
                //🔥 첫 번째 컬럼 (번호)
                Rectangle {
                    width: 50
                    height: 40 // 높이 늘림
                    color: isFirstRow? "#5ae0aa":"white" // 테이블 셀 배경색 변경
                    border.color: "#c0c0c0" // 테이블 셀 테두리 색상 연하게
                    radius: 3 // 테이블 셀 둥근 모서리
                    Text {
                        anchors.centerIn: parent
                        text: model.id
                        color:   isFirstRow?"white":"#555" // 테이블 텍스트 색상 조금 더 어둡게
                        font.pixelSize: 14

                    }
                }

                // 🔥 두 번째 컬럼 (종류)
                Rectangle {
                    width: 350
                    height: 40
                    color: isFirstRow? "#5ae0aa":"white"
                    border.color: "#c0c0c0"
                    radius: 3

                    Text {
                        anchors.centerIn: parent
                        text: model.title
                        color: isFirstRow?"white":"#555"
                        font.pixelSize: 14
                    }

                }

                // 🔥 세 번째 컬럼 (업무)
                Rectangle {
                    width: 140
                    height: 40
                    color: isFirstRow? "#5ae0aa":"white"
                    border.color: "#c0c0c0"
                    radius: 3
                    //property string work_type_str:model.type
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
                                        currentIndex: work_type_list.model.indexOf(model.type)!=-1?work_type_list.model.indexOf(model.type):0

                                }

                                // isFirstRow가 true일 때만 Text 표시
                                Text {
                                    visible: isFirstRow
                                    anchors.centerIn: parent
                                    text: model.type
                                    color: isFirstRow ? "white" : "#555"
                                    font.pixelSize: 14

                                }
                                // Component.onCompleted: {
                                //      console.log(index)
                                //      work_type_list.currentIndex= work_type_list.model.indexOf(model.type)!=-1?work_type_list.model.indexOf(model.type):0
                                // }
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
                        //readOnly:isFirstRow?true:false
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
                        // Component.onCompleted: {
                        //     achievement_column.readOnly=isFirstRow
                        // }
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
                        // Component.onCompleted: {
                        //     result_column.readOnly=isFirstRow
                        // }
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
                        // Component.onCompleted: {
                        //     etc_column.readOnly=isFirstRow
                        // }
                    }
                }
            }
        }


    }
    RowLayout {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 20 // margins 늘림

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
            issue_work_table.appendRow([issue_work_table.rowCount(),issue_work_table.rowCount()+1,"❓ 조사",issue_work_table.rowCount()+2,issue_work_table.rowCount()+3,issue_work_table.rowCount()+4])
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

}
