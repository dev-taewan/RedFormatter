import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
//import Qt.labs.platform 1.1
import Redmine
import QtQuick.Layouts
import QtQuick
//import QtQuick.Controls
//import QtQuick.Dialogs

//import QtQuick.Dialogs 6.0
//simport QtQuick 6.0
//import QtQuick.Controls 6.0
//import QtQuick.Controls.Material 6.0
//import QtQuick.Dialogs 6.0
//import QtQuick.Layouts 6.0
import QtQuick.Dialogs

Item {
    id: root
    signal taskAdded(string text)
    property string title
    property var selectedFiles: []
    property int count:0
    implicitHeight: workdetail_view.contentHeight + 30 // TreeView 높이 + 버튼 영역 + 여백
    property TreeModel treeModel: TreeModel {
        id: treemodel
        onRowsInserted: {
            let parentIndex = workdetail_view.selectionModel.currentIndex
            for (var i = parentIndex.row; i < parentIndex.row + count; i++) {
                var index = treemodel.index(i, 0, parentIndex)
                workdetail_view.expand(index)
            }
        }

    }

    Rectangle {
        anchors.fill: parent
        color: "#f5f5f5"
        radius: 8
        border.color: "#e0e0e0"
        border.width: 1
    }


    TreeView {
        id: workdetail_view
        anchors.fill: parent
        anchors.margins: 10
        clip: true
        model: root.treeModel
        selectionModel: ItemSelectionModel {}
        //focus: true // 키 입력을 받기 위해 포커스 활성화
        delegate: Item {
            implicitWidth: label.implicitWidth + 40 + arrow.width
            implicitHeight: label.implicitHeight * 1.5

            required property TreeView treeView
            required property bool isTreeNode
            required property bool hasChildren
            required property bool expanded
            required property int depth
            required property int row
            required property int column
            required property var index

            Rectangle {
                anchors.fill: parent
                // 선택된 항목 색상 강조 (selectionModel.isSelected 사용)
                //color: treeView.selectionModel.isSelected(index) ? "#aaddff" : "#ffffff"
                color: row === workdetail_view.currentRow ? "#aaddff" : "#ffffff"
                border.color: "#e0e0e0"
                radius: 4
            }

            Text {
                id: arrow
                x: depth * 20
                width: 16
                height: 16
                text: hasChildren ? (expanded ? "▼" : "▶") : " "
                font.pixelSize: 14
                color: "#212121"
                anchors.verticalCenter: parent.verticalCenter

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (hasChildren) {
                            if (expanded) {
                                treeView.collapse(index)
                            } else {
                                treeView.expand(index)
                            }
                        }
                    }
                }
                // Component.onCompleted: {
                //     if (hasChildren) {
                //         //if (!expanded) {
                //             treeView.expand(index)
                //        // }
                //     }
                //     }

            }

            TextEdit {
                id: label
                x: depth * 20 + 40
                anchors.verticalCenter: parent.verticalCenter
                text: model.text[1]
                font.pixelSize: 14
                color: "#212121"
                //onTextChanged: model.text = label.text

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton
                    onDoubleClicked: {
                        editDialog.currentText = model.text[1]
                        editDialog.currentIndex = index
                        editDialog.open()
                    }
                }

            }
            CheckBox{
            id:is_success
            x: depth * 20
            anchors.verticalCenter: parent.verticalCenter
            }
        }

        Behavior on contentY {
            NumberAnimation { duration: 200 }
        }

        // Delete 키 이벤트 처리
        Keys.onPressed: (event) => {
            if (event.key ===Qt.Key_Delete) {
                let selectedIndex = selectionModel.currentIndex
                if (selectedIndex.valid) {

                                        model.removeNode(selectedIndex)
                                    event.accepted = true

                }
            }
            // }
                            else if (event.key === Qt.Key_A) {
                                console.log("current_index: ",selectionModel.currentIndex)
                                let parentIndex = selectionModel.currentIndex
                                if (!parentIndex.valid) {
                                    parentIndex = workdetail_view.model.index(0, 0) // 선택된 항목이 없으면 첫 번째 항목 사용
                                }
                                let newIndex = workdetail_view.model.insertChild(parentIndex, ["f","새 하위 항목"])
                                // if (newIndex.valid) {
                                //     workdetail_view.expand(newIndex) // 부모 항목을 펼침
                                // }
                                workdetail_view.expand(parentIndex) // 부모 항목을 펼침



                                event.accepted = true
                            }
        }
    }

    Component.onCompleted: {
            let initialIndex = workdetail_view.model.insertNode(workdetail_view.model.rowCount(),["root",title] )
            if (initialIndex.valid) {
                workdetail_view.selectionModel.select(initialIndex, ItemSelectionModel.ClearAndSelect)
                workdetail_view.currentIndex = initialIndex
            }
        }


    Dialog {
        id: editDialog
        title: "항목 편집"
        width: 720
        height: 400 // 높이 조정
        modal: true
        standardButtons: Dialog.Ok | Dialog.Cancel

        property string currentText: ""
        property var currentIndex: null
        //property var selectedFiles: [] // 선택된 파일 경로 저장

        // Redmine에서 가져온 이미지 목록 (예시 데이터, 실제로는 API 호출 필요)
        property var issueImages: [
            { "filename": "image1.png", "id": 1 },
            { "filename": "image2.jpg", "id": 2 }
        ]

        contentItem: ColumnLayout {
            spacing: 10

            // 1. 콤보박스 추가
            RowLayout {
                Label { text: "서식: " }
                ComboBox {
                    id: formatCombo
                    model: ["타이틀", "세부내용"]
                    onActivated: {
                        if (currentIndex === 0) { // 타이틀
                            editField.font.pixelSize = 18
                            editField.font.bold = true
                            editField.color = "black"
                        } else if (currentIndex === 1) { // 세부내용
                            editField.font.pixelSize = 14
                            editField.font.bold = false
                            editField.color = "gray"
                        }
                    }
                }

                // 2. 파일 추가 버튼
                Button {
                    text: "파일 추가"
                    onClicked: fileDialog.open()
                }

                // 3. 이미지 목록 표시 버튼
                Button {
                    text: "이미지 목록"
                    onClicked: imageListPopup.open()
                }
            }

            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true

                TextArea {
                    id: editField
                    width: 400
                    height: 300
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    wrapMode: TextArea.Wrap
                    font.pixelSize: 14
                    selectByMouse: true
                    cursorVisible: true
                    text: editDialog.currentText
                    verticalAlignment: TextArea.AlignTop
                    focus: true

                    // 엔터 키로 개행
                    // Keys.onReturnPressed: {
                    //     editField.insert(cursorPosition, "\n")
                    //     event.accepted = true
                    // }

                    // background: Rectangle {
                    //     color: "white"
                    //     border.color: "gray"
                    //     border.width: 1
                    // }
                }
            }
        }

        // 2. 파일 선택 다이얼로그
        FileDialog {
            id: fileDialog
            title: "파일 선택"
            //folder: shortcuts.home

            nameFilters: ["Image files (*.png *.jpg *.jpeg *.gif)"]
            onAccepted: {
                var filePath = fileDialog.selectedFile.toString()
                var fileName = filePath.substring(filePath.lastIndexOf("/") + 1)
                root.selectedFiles.push(filePath) // 파일 경로 저장
                editField.insert(editField.cursorPosition, "!" + fileName + "!") // Redmine 형식 삽입
            }
        }

        // 3. 이미지 목록 팝업
        Popup {
            id: imageListPopup
            width: 300
            height: 200
            modal: true
            anchors.centerIn: parent

            ColumnLayout {
                anchors.fill: parent
                Text { text: "이슈에 있는 이미지:" }

                ListView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    model: editDialog.issueImages
                    delegate: Button {
                        width: parent.width
                        text: modelData.filename
                        onClicked: {

                            editField.insert(editField.cursorPosition, "!" + modelData.filename + "!")
                            imageListPopup.close()
                        }
                    }
                }
            }
        }

        // 4. 확인 버튼으로 업데이트
        onAccepted: {
            if (editDialog.currentIndex && editField.text) {
                workdetail_view.model.setData(editDialog.currentIndex, editField.text, Qt.DisplayRole)
                // TODO: selectedFiles를 Redmine에 업로드하는 로직 추가 (예: REST API 호출)
                console.log("Updated text: " + editField.text)
                console.log("Files to upload: " + editDialog.selectedFiles)
            }
        }

        onRejected: {
            editDialog.selectedFiles = [] // 취소 시 파일 목록 초기화
        }
    }
    // Dialog {
    //         id: editDialog
    //         title: "항목 편집"
    //         width: 720
    //         height: 300
    //         modal: true
    //         standardButtons: Dialog.Ok | Dialog.Cancel

    //         property string currentText: ""
    //         property var currentIndex: null

    //         contentItem: ColumnLayout {
    //             spacing: 10
    //             TextArea {
    //                 id: editField
    //                 width:400
    //                 height:300
    //                 Layout.fillWidth: true
    //                 Layout.fillHeight: true
    //                 wrapMode: TextEdit.Wrap // 줄 바꿈 활성화
    //                                 font.pixelSize: 14
    //                                 selectByMouse: true // 마우스로 텍스트 선택 가능
    //                                 cursorVisible: true // 커서 표시
    //                 text: editDialog.currentText
    //                 verticalAlignment: TextEdit.AlignTop // 텍스트를 최상단부터 시작
    //             }
    //         }

    //         onAccepted: {
    //             if (editDialog.currentIndex && editField.text) {
    //                 workdetail_view.model.setData(editDialog.currentIndex, editField.text, Qt.DisplayRole)
    //             }
    //         }
    //     }
}
