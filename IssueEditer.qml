import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Basic 2.15

// TableView 지원
import Thermo 1.0
import Redformatter


/*
⭐RF

h2. 날짜: YYYY-MM-DD

h3. ⏳업무 리스트

|_.번호|_.업무| 종류|_.기한|_.진행률|결과물|_.특이사항|
|=.1|레드마인 서포터 설계|⚒️ 설계|01.23 (3)|20% ✅✅☑️☑️☑️☑️☑️☑️☑️☑️| |_.특이사항|
|=.2|레드마인 서포터 기술 조사|❓ 조사|01.27 (3)|20% ✅✅☑️☑️☑️☑️☑️☑️☑️☑️| |_.특이사항|

h2. ⏰ 오늘 진행 내용:

h3. ⚒️ 레드마인 서포터 설계

# class uml 작성
## staruml 통해서 작성
## 작성한 uml 경로 []
# 동료 검토
## 피드백: ~~~
# *%{color:red}❗이슈:%* (%{color:orange}  진행 중%)
## *%{color:blue} 설계 단계에서 고려하지 못한 요구 사항 발생%*
### 추가 요구사항 분석 결과 현재 구조 일부 변경 필요
### 해당 기능 연결 가능하도록 uml 설계 변경 진행중

h3. ⚒️ 레드마인 서포터 기술 조사

# Redmine API 조사
## RestAPI 사용 가능
# 구현할 플랫폼
## c++,qml,conan 사용해서 진행

h2. ⓘ 추가 사항:

# 설계 추가 사항으로 본 일감이 1일 연기 됩니다.

h2. ⏳ 이어서 진행할 업무 리스트:

# ⚒️ 레드마인 서포터 설계
## 변경된 설계내용 동료 검토
# ⚒️ 구현

*/
//Item {

    Window {
        // property bool showMain
        // property Room currentRoom: Rooms.livingRoom
        // property int cardSizeWithSpacing: Theme.cardRowSpacing + Theme.cardWidth
        // property int pageCount: 6
        id: newWindow
        flags: Qt.Dialog | Qt.FramelessWindowHint // 항상 부모 위에 위치, 이동 불가
        modality: Qt.ApplicationModal // 부모 창 제어 불가능

        //onClosing: (event) => { event.accepted = false }
        // 📌 데이터 추가 버튼

        // 창 이동 방지 (사용자가 클릭 & 드래그해도 이동 안됨)
        // MouseArea {
        //     anchors.fill: parent
        //     onPressed: mouse.accepted = true
        //     onPositionChanged: mouse.accepted = true
        // }
        ColumnLayout {
            anchors.fill: parent
            spacing: 5
            // 📌 데이터 추가 버튼

            // 📌 테이블 헤더 (수동 생성)
            RowLayout {
                Layout.fillWidth: true
                spacing: 1
                Rectangle {
                    width: 100
                    height: 30
                    color: "#BBBBBB"
                    border.color: "#888"
                    Text {
                        anchors.centerIn: parent
                        text: "번호"
                        font.bold: true
                    }
                }
                Rectangle {
                    width: 150
                    height: 30
                    color: "#BBBBBB"
                    border.color: "#888"
                    Text {
                        anchors.centerIn: parent
                        text: "종류"
                        font.bold: true
                    }
                }
                Rectangle {
                    width: 100
                    height: 30
                    color: "#BBBBBB"
                    border.color: "#888"
                    Text {
                        anchors.centerIn: parent
                        text: "업무"
                        font.bold: true
                    }
                }
                Rectangle {
                    width: 100
                    height: 30
                    color: "#BBBBBB"
                    border.color: "#888"
                    Text {
                        anchors.centerIn: parent
                        text: "기한"
                        font.bold: true
                    }
                }
                Rectangle {
                    width: 100
                    height: 30
                    color: "#BBBBBB"
                    border.color: "#888"
                    Text {
                        anchors.centerIn: parent
                        text: "진행률"
                        font.bold: true
                    }
                }
                Rectangle {
                    width: 100
                    height: 30
                    color: "#BBBBBB"
                    border.color: "#888"
                    Text {
                        anchors.centerIn: parent
                        text: "결과물"
                        font.bold: true
                    }
                }
                Rectangle {
                    width: 200
                    height: 30
                    color: "#BBBBBB"
                    border.color: "#888"
                    Text {
                        anchors.centerIn: parent
                        text: "특이사항"
                        font.bold: true
                    }
                }
                Button {
                    text: "행 추가"
                    // onClicked: {
                    //     myModel.appendRow(["ID" + myModel.rowCount(
                    //                            ), "User" + myModel.rowCount(
                    //                            ), (20 + myModel.rowCount())])
                    // }
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

                model: myModel

                delegate: Row {
                    spacing: 1

                    // 🔥 첫 번째 컬럼 (번호)
                    Rectangle {
                        width: 100
                        height: 30
                        border.color: "#888"
                        Text {
                            anchors.centerIn: parent
                            text: model.column0
                        }
                    }

                    // 🔥 두 번째 컬럼 (종류)
                    Rectangle {
                        width: 150
                        height: 30
                        border.color: "#888"
                        // Text {
                        //     anchors.centerIn: parent
                        //     text: model.column1
                        // }
                        ComboBox {
                            anchors.fill: parent
                            // anchors.centerIn:parent
                            // anchors.top:parent
                            // anchors.bottom:parent
                            model: ["[조사] ⚲","[분석] ✨","[셋업] ⚙️]","[설계] ✏️","[구현] ⚒️",   "[버그패치] ⚠️", "[서포트] ⚔️"] // 유형 리스트
                            // ✅⭐✨⚙️ ❗❌⚠️⏲ ⏳ ✦ ⚡️⚔️⭕❌⚒️☑️⬜❓⚲✏️ⓘ⌕⏰⩇⩇:⩇⩇업무 리스트
                            currentIndex: 0
                        }
                    }

                    // 🔥 세 번째 컬럼 (업무)
                    Rectangle {
                        width: 100
                        height: 30
                        border.color: "#888"
                        Text {
                            anchors.centerIn: parent
                            text: model.column2
                        }
                    }

                    // 🔥 첫 번째 컬럼 (기한)
                    Rectangle {
                        width: 100
                        height: 30
                        border.color: "#888"
                        Text {
                            anchors.centerIn: parent
                            text: model.column0
                        }
                    }

                    // 🔥 두 번째 컬럼 (진행률)
                    Rectangle {
                        width: 100
                        height: 30
                        border.color: "#888"
                        Text {
                            anchors.centerIn: parent
                            text: model.column1
                        }
                    }

                    // 🔥 세 번째 컬럼 (결과물)
                    Rectangle {
                        width: 100
                        height: 30
                        border.color: "#888"
                        Text {
                            anchors.centerIn: parent
                            text: model.column2
                        }
                    }
                    // 🔥 세 번째 컬럼 (특이사항)
                    Rectangle {
                        width: 200
                        height: 30
                        border.color: "#888"
                        Text {
                            anchors.centerIn: parent
                            text: model.column2
                        }
                    }
                }
            }
        }
        Button {
            id: close_btn
            text: "닫기"
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 10
            // onClicked: {
            //     newWindow.visible = false
            // }
        }
        // 📌 테이블 데이터 모델
        ListModel {
            id: myModel

            function appendRow(data) {
                var item = {}
                for (var i = 0; i < data.length; i++) {
                    item["column" + i] = data[i] // 🔥 column0, column1, column2 형태로 저장
                }
                append(item) // 🔥 UI가 자동 갱신됨
            }

            function rowCount() {
                return count
            }
        }
    }
//}
