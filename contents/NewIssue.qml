import QtQuick 2.15
import QtQuick.Controls 2.15

import Thermo 1.0
import Redformatter


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
ThermoView {
    id: root

    property bool showMain
    property Room currentRoom: Rooms.livingRoom
    property int cardSizeWithSpacing: Theme.cardRowSpacing + Theme.cardWidth
    property int pageCount: 6

    visible: true
    //Rectangle {
        // width: parent.width
        // height: parent.height
        //color: "#f5f5f5"
        //radius: 10
        ScrollView {
            anchors.centerIn: parent

            Column {
                spacing: 20
                anchors.centerIn: parent

                // 유형 선택
                Row {
                    spacing: 10
                    Text {
                        text: "유형:"
                        anchors.verticalCenter: parent.verticalCenter
                        width: 70
                    }
                    ComboBox {
                        width: 200
                        model: ["버그", "기능 개선", "기타"] // 유형 리스트
                        currentIndex: 0 // 기본 값은 첫 번째 항목으로 설정
                    }
                }

                // 제목 입력
                Row {
                    spacing: 10
                    Text {
                        text: "제목:"
                        width: 70
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    TextField {
                        width: 200
                        placeholderText: "제목을 입력하세요"
                    }
                }

                // 설명 입력
                Row {
                    spacing: 10
                    Text {
                        text: "설명:"
                        width: 70
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    TextArea {
                        width: 200
                        height: 80
                        placeholderText: "이슈에 대한 상세 설명"
                    }
                }

                // 상태 선택
                Row {
                    spacing: 10
                    Text {
                        text: "상태:"
                        width: 70
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    ComboBox {
                        width: 200
                        model: ["열림", "진행 중", "완료"] // 상태 리스트
                        currentIndex: 0 // 기본 값은 첫 번째 항목으로 설정
                    }
                }

                // 담당자 입력
                Row {
                    spacing: 10
                    Text {
                        text: "담당자:"
                        width: 70
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    TextField {
                        width: 200
                        placeholderText: "담당자 이름"
                    }
                }

                // 시작시간 입력
                Row {
                    spacing: 10
                    Text {
                        text: "시작시간:"
                        width: 70
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    // DateTimeEdit {
                    //     width: 200
                    //     placeholderText: "시작 시간을 선택하세요"
                    // }
                }

                // 조치기한 입력
                Row {
                    spacing: 10
                    Text {
                        text: "조치기한:"
                        width: 70
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    // DateTimeEdit {
                    //     width: 200
                    //     placeholderText: "기한을 선택하세요"
                    // }
                }

                // 진척도 입력
                // Row {
                //     spacing: 10
                //     Text {
                //         text: "진척도:"
                //         width: 70
                //         anchors.verticalCenter: parent.verticalCenter
                //     }
                //     // ProgressBar {
                //     //     width: 200
                //     //     // value: 0
                //     //     // from: 0
                //     //     // to: 100
                //     // }
                //     Slider {
                //         id: slider2

                //         width: 90
                //         height: 13
                //         value: 1
                //     }
                // }

                // 제출 버튼
                Button {
                    text: "전송"
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 150
                    Connections {
                        function onClicked() {
                            console.log('Create Issue')
                        }
                    }
                }
            }
        }

        // RangeSlider {
        //     id: rangeSlider
        //     x: 21
        //     y: 459
        //     second.value: 0.75
        //     first.value: 0.25
        // }

        // Slider {
        //     id: slider1
        //     x: 208
        //     y: 465
        //     width: 90
        //     height: 13
        //     value: 1
        // }
   // }
}
