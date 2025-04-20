// MainUI.qml
import QtQuick
import QtQuick.Controls 6
import QtQuick.Layouts

Item {
    id: root
    width: 1000
    height: 700

    property var sectionModel: [
            {
                title: "레드마인 서포터 설계",
                subsections: [
                    {
                        title: "Class Diagram 작성",
                        contents: [
                            { type: "File", value: "Redmine supporter class uml.png" },
                            { type: "Text", value: "클래스 다이어그램 작성에 대한 설명" }
                        ]
                    },
                    {
                        title: "동료 검토 진행",
                        contents: [
                            { type: "Text", value: "피드백 내용 1" },
                            { type: "Text", value: "피드백 내용 2" },
                            { type: "File", value: "Redmine supporter class uml.png" }
                        ]
                    }
                ]
            }
        ]

        ColumnLayout {
            anchors.fill: parent
            spacing: 10
            //padding: 16

            RowLayout {
                spacing: 10
                Layout.alignment: Qt.AlignLeft

                CustomDateInput {
                    id: dateInput
                    Layout.preferredWidth: 160
                }

                Button {
                    text: "미리보기"
                    onClicked: {
                        // 미리보기 로직
                    }
                }

                Button {
                    text: "전송"
                    onClicked: {
                        // 전송 로직
                    }
                }
            }

            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true

                Column {
                    id: sectionList
                    width: parent.width
                    spacing: 12

                    ListView {
                        width: parent.width
                        height: parent.height
                        model: sectionModel

                        delegate: SectionComponent {
                            sectionData: modelData
                        }
                    }


                    Button {
                        text: "➕ 섹션 추가"
                        onClicked: sectionModel.push({
                            title: "",
                            subsections: []
                        })
                    }
                }
            }
        }
}
