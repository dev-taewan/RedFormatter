import QtQuick 2.15
import Redformatter
import QtQuick.Effects

Item {
    id: root
    // width: 48
    // height: 48
    property alias source: sourceImage.source
    property color color: "white"
    // property int width:root.source.width
    // property int height:root.source.height
    implicitWidth: sourceImage.implicitWidth
    implicitHeight: sourceImage.implicitHeight
    //property string source: "image.png"
    //property color color: "red"

    Image {
        id: sourceImage
        source: root.source
        sourceSize: Qt.size(root.width, root.height)
        mipmap: true
        visible: false
    }

    MultiEffect {
        source: sourceImage
        anchors.fill: parent
        colorization: 1
        colorizationColor: root.color
    }
}
