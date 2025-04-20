// CustomDateInput.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import QtQml
// Item {
//     property var sectionData

//     width: parent ? parent.width : 400
//     height: 50

//     Rectangle {
//         width: parent.width
//         height: 50
//         color: "#eee"

//         Text {
//             anchors.centerIn: parent
//             text: sectionData.title
//         }
//     }
// }

Column {
    property var sectionData

    spacing: 8
    width: parent.width

    Rectangle {
        width: parent.width
        height: 40
        color: "#f0f0f0"
        radius: 4

        TextField {
            anchors.fill: parent
            placeholderText: "# 섹션 제목"
            text: sectionData.title
            onTextChanged: sectionData.title = text
        }
    }

    Repeater {
        model: sectionData.subsections
        delegate: SubSectionComponent {
            subData: modelData
        }
    }

    Button {
        text: "➕ 서브 섹션 추가"
        onClicked: {
            sectionData.subsections.push({
                title: "",
                contents: []
            })
        }
    }
}
