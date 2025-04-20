// CustomDateInput.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import QtQml
Item {
    width: parent.width
    height: implicitHeight

    property alias contentData: contentData
    property string type: contentData.type

    Loader {
        anchors.fill: parent
        sourceComponent: {
            if (type === "Text") textEditor
            else if (type === "Code") codeEditor
            else if (type === "File") fileBlock
            else null
        }
    }

    Component {
        id: textEditor
        TextArea {
            placeholderText: "일반 텍스트 입력"
            text: contentData.value
            onTextChanged: contentData.value = text
        }
    }

    Component {
        id: codeEditor
        Column {
            spacing: 4
            ComboBox {
                id: langBox
                model: ["cpp", "python", "rust"]
            }
            TextArea {
                placeholderText: "코드 입력"
                text: contentData.value
                onTextChanged: contentData.value = text
            }
        }
    }

    Component {
        id: fileBlock
        Row {
            spacing: 8
            TextField {
                placeholderText: "파일 경로 또는 설명"
                text: contentData.value
                onTextChanged: contentData.value = text
            }
            Button {
                text: "파일 선택"
                // TODO: 파일 다이얼로그 연결
            }
        }
    }
}
