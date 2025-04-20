import QtQuick
import QtQuick.Controls 6
import QtQuick.Layouts


Rectangle {
    id: root
    width: parent ? parent.width : implicitWidth
    color: "transparent"

    default property alias content: contentArea.data
    property alias title: header.text
    property bool expanded: false
    signal toggled(bool expanded)

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // 헤더 영역
        Rectangle {
            color: "#f0f0f0"
            Layout.fillWidth: true
            height: 40
            border.color: "#ccc"

            RowLayout {
                anchors.fill: parent
                anchors.margins: 8

                Button {
                    id: header
                    text: "제목"
                    checkable: true
                    checked: root.expanded
                    Layout.fillWidth: true
                    onClicked: {
                        root.expanded = checked
                        root.toggled(checked)
                    }
                }

                Label {
                    text: root.expanded ? "\u25BC" : "\u25B6" // ▼ or ▶
                    font.pixelSize: 18
                    verticalAlignment: Label.AlignVCenter
                }
            }
        }

        // 콘텐츠 영역 (패딩 처리)
        Item {
            id: contentWrapper
            visible: root.expanded
            implicitHeight: contentArea.implicitHeight + 16
            Layout.fillWidth: true

            ColumnLayout {
                id: contentArea
                spacing: 12
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 8
            }

            Behavior on visible { NumberAnimation { duration: 150 } }
        }
    }
}
