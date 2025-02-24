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
    width: 1000 // 창 너비 늘림
    height: 600 // 창 높이 늘림
    color: "#f0f0f0" // 전체 배경색을 밝게 변경
    flags: Qt.Dialog | Qt.FramelessWindowHint    // 항상 부모 위에 위치, 이동 불가
    modality: Qt.ApplicationModal    // 부모 창 제어 불가능

    ColumnLayout {
        anchors.fill: parent
        // anchors.top: parent.top // 상단에 anchors.top 설정
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10 // 간격 늘림, 여백 추가
        //margins: 20 // 전체 마진 추가

        // 📌 테이블 헤더 (수동 생성)
        RowLayout {
            Layout.fillWidth: true
            spacing: 5 // 헤더 간 간격 줄임

            Rectangle {
                width: 100; height: 40; // 높이 늘림
                color: "#e0e0e0" // 헤더 배경색 밝게
                border.color: "#c0c0c0" // 테두리 색상 연하게
                radius: 5 // 둥근 모서리 추가
                Text {
                    anchors.centerIn: parent;
                    text: "번호";
                    font.bold: true;
                    color: "#333"; // 텍스트 색상 어둡게
                    font.pixelSize: 14 // 폰트 크기 조정
                }
            }
            Rectangle {
                width: 150; height: 40;
                color: "#e0e0e0"
                border.color: "#c0c0c0"
                radius: 5
                Text {
                    anchors.centerIn: parent;
                    text: "종류";
                    font.bold: true;
                    color: "#333";
                    font.pixelSize: 14
                }
            }
            Rectangle {
                width: 100; height: 40;
                color: "#e0e0e0"
                border.color: "#c0c0c0"
                radius: 5
                Text {
                    anchors.centerIn: parent;
                    text: "업무";
                    font.bold: true;
                    color: "#333";
                    font.pixelSize: 14
                }
            }
            Rectangle {
                width: 100; height: 40;
                color: "#e0e0e0"
                border.color: "#c0c0c0"
                radius: 5
                Text {
                    anchors.centerIn: parent;
                    text: "기한";
                    font.bold: true;
                    color: "#333";
                    font.pixelSize: 14
                }
            }
            Rectangle {
                width: 100; height: 40;
                color: "#e0e0e0"
                border.color: "#c0c0c0"
                radius: 5
                Text {
                    anchors.centerIn: parent;
                    text: "진행률";
                    font.bold: true;
                    color: "#333";
                    font.pixelSize: 14
                }
            }
            Rectangle {
                width: 100; height: 40;
                color: "#e0e0e0"
                border.color: "#c0c0c0"
                radius: 5
                Text {
                    anchors.centerIn: parent;
                    text: "결과물";
                    font.bold: true;
                    color: "#333";
                    font.pixelSize: 14
                }
            }
            Rectangle {
                width: 200; height: 40;
                color: "#e0e0e0"
                border.color: "#c0c0c0"
                radius: 5
                Text {
                    anchors.centerIn: parent;
                    text: "특이사항";
                    font.bold: true;
                    color: "#333";
                    font.pixelSize: 14
                }
            }
            Button {
                text: "행 추가"
                font.pixelSize: 14 // 폰트 크기 조정
                background: Rectangle { // 버튼 배경 스타일 변경
                    color: "#4CAF50" // 녹색 계열
                    radius: 5
                }
                contentItem: Text { // 버튼 텍스트 스타일 변경
                    text: parent.text
                    color: "white"
                    font: parent.font
                    //font.bold: true
                    anchors.centerIn: parent
                }
                onClicked: {
                    issue_work_table.appendRow(["ID" + issue_work_table.rowCount()])
                }
            }

        }

        IssueWorkTable {
            id: issue_work_table
            Component.onCompleted: {
                if (issue_id>0)
                    issue_work_table.GetCurrentWorkTable(issue_id)
            }
            function appendRow(data) {
                var item = {}
                for (var i = 0; i < data.length; i++) {
                    item["column" + i] = data[i]  // 🔥 column0, column1, column2 형태로 저장
                }
                issue_work_table.addItem(item["column" + 0],item["column" + 1],item["column" + 2],item["column" + 3],item["column" + 4],item["column" + 5],item["column" + 6])  // 🔥 UI가 자동 갱신됨
            }
        }

        // 📌 TableView 본체
        TableView {
            id: tableView
            Layout.fillWidth: true
            Layout.fillHeight: true
            columnSpacing: 1
            rowSpacing: 1
            boundsBehavior: Flickable.StopAtBounds
            model: issue_work_table
            delegate: RowLayout
            {
                width: parent.width
                spacing: 1

                //🔥 첫 번째 컬럼 (번호)
                Rectangle {
                    width: 100
                    height: 40 // 높이 늘림
                    color: "white" // 테이블 셀 배경색 변경
                    border.color: "#c0c0c0" // 테이블 셀 테두리 색상 연하게
                    radius: 3 // 테이블 셀 둥근 모서리
                    Text {
                        anchors.centerIn: parent
                        text: model.id
                        color: "#555" // 테이블 텍스트 색상 조금 더 어둡게
                        font.pixelSize: 14
                    }
                }

                // 🔥 두 번째 컬럼 (종류)
                Rectangle {
                    width: 150
                    height: 40
                    color: "white"
                    border.color: "#c0c0c0"
                    radius: 3
                    Text {
                        anchors.centerIn: parent
                        text: model.type
                        color: "#555"
                        font.pixelSize: 14
                    }

                }

                // 🔥 세 번째 컬럼 (업무)
                Rectangle {
                    width: 100
                    height: 40
                    color: "white"
                    border.color: "#c0c0c0"
                    radius: 3
                    Text {
                        anchors.centerIn: parent
                        text: model.title
                        color: "#555"
                        font.pixelSize: 14
                    }
                }

                // 🔥 첫 번째 컬럼 (기한)
                Rectangle {
                    width: 100
                    height: 40
                    color: "white"
                    border.color: "#c0c0c0"
                    radius: 3
                    Text {
                        anchors.centerIn: parent
                        text: model.deadline
                        color: "#555"
                        font.pixelSize: 14
                    }
                }

                // 🔥 두 번째 컬럼 (진행률)
                Rectangle {
                    width: 100
                    height: 40
                    color: "white"
                    border.color: "#c0c0c0"
                    radius: 3
                    Text {
                        anchors.centerIn: parent
                        text: model.achievement
                        color: "#555"
                        font.pixelSize: 14
                    }
                }

                // 🔥 세 번째 컬럼 (결과물)
                Rectangle {
                    width: 100
                    height: 40
                    color: "white"
                    border.color: "#c0c0c0"
                    radius: 3
                    Text {
                        anchors.centerIn: parent
                        text: model.result
                        color: "#555"
                        font.pixelSize: 14
                    }
                }
                // 🔥 세 번째 컬럼 (특이사항)
                Rectangle {
                    width: 200
                    height: 40
                    color: "white"
                    border.color: "#c0c0c0"
                    radius: 3
                    Text {
                        anchors.centerIn: parent
                        text: model.etc
                        color: "#555"
                        font.pixelSize: 14
                    }
                }
            }
        }


    }
    Button {
        id: close_btn
        text: "닫기"
        font.pixelSize: 14 // 폰트 크기 조정
        background: Rectangle { // 버튼 배경 스타일 변경
            color: "#f44336" // 붉은색 계열
            radius: 5
        }
        contentItem: Text { // 버튼 텍스트 스타일 변경
            text: parent.text
            color: "white"
            font: parent.font
            //font.bold: true
            anchors.centerIn: parent
        }
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 20 // margins 늘림
        onClicked: {
            newWindow.visible = false
        }
    }
}
