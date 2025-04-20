// CustomDateInput.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window
import QtQml

Item {
    id: root
    width: 150
    height: 40

    property date selectedDate: new Date()
    signal dateChanged(date newDate)

    Button {
        id: dateButton
        anchors.fill: parent
        text: Qt.formatDate(root.selectedDate, "yyyy-MM-dd")
        onClicked: popup.open()
    }

    Popup {
        id: popup
        modal: true
        focus: true
        parent: root.Window
        x: dateButton.mapToItem(null, 0, dateButton.height).x
        y: dateButton.mapToItem(null, 0, dateButton.height).y

        Rectangle {
            width: 220
            height: 240
            color: "white"
            border.color: "#aaa"
            radius: 4
           // padding: 10

            ColumnLayout {
                spacing: 6

                RowLayout {
                    spacing: 6
                    Label { text: "Year:" }
                    SpinBox {
                        id: yearSpin
                        from: 2000
                        to: 2100
                        value: root.selectedDate.getFullYear()
                    }

                    Label { text: "Month:" }
                    SpinBox {
                        id: monthSpin
                        from: 1
                        to: 12
                        value: root.selectedDate.getMonth() + 1
                    }
                }

                GridLayout {
                    id: dayGrid
                    columns: 7
                    //spacing: 4
                    Layout.alignment: Qt.AlignHCenter

                    Repeater {
                        model: 31
                        delegate: Button {
                            text: (index + 1).toString()
                            visible: index + 1 <= daysInMonth(yearSpin.value, monthSpin.value)
                            onClicked: {
                                const newDate = new Date(yearSpin.value, monthSpin.value - 1, index + 1)
                                root.selectedDate = newDate
                                root.dateChanged(newDate)
                                popup.close()
                            }
                        }
                    }
                }
            }
        }
    }

    // 유틸 함수
    function daysInMonth(year, month) {
        return new Date(year, month, 0).getDate();
    }
}
