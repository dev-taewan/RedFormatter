import QtQuick 2.15
import Thermo 1.0
import ThermoConfiguration 1.0
import Redformatter
import QtQuick.Controls
import QtQuick.Layouts

Item {
    // ListView {
    //     id: listView
    //     x: 227
    //     y: 99
    //     width: 160
    //     height: 80
    ListModel {
        id: fruitModel

        ListElement {
            kkk: "Apple"
            cost: 2.45
        }
        ListElement {
            kkk: "Orange"
            cost: 3.25
        }
        ListElement {
            kkk: "Banana"
            cost: 1.95
        }
    }
    TableView {
        anchors.fill: parent
        model: fruitModel
        delegate: Column {
            Text {
                text: "Fruit: " + kkk
            }
            Text {
                text: "Cost: $" + cost
            }
        }
    }

    // }
}
