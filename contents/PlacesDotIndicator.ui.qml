import QtQuick 2.15
import Thermo 1.0
import Redformatter

ColorizedImage {
    id: dotRoot

    property bool isCurrent

    source: "assets/page-indicator.png"
    color: ColorStyle.greyDark1

    states: [
        State {
            name: "current"
            when: isCurrent
            PropertyChanges {
                target: dotRoot
                color: ColorStyle.greyMedium2
            }
        }
    ]
}
