// CustomDateInput.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import QtQml
Column {
    property var subData
    spacing: 6
    width: parent.width

    TextField {
        placeholderText: "## 서브 섹션 제목"
        text: subData.title
        onTextChanged: subData.title = text
    }

    Repeater {
        model: subData.contents
        delegate: ContentBlock {
            contentData: modelData
        }
    }

    Row {
        spacing: 6
        ComboBox {
            id: typeSelector
            model: ["Text", "Code", "File"]
        }

        Button {
            text: "➕ 내용 추가"
            onClicked: {
                subData.contents.push({
                    type: typeSelector.currentText,
                    value: ""
                })
            }
        }
    }
}
