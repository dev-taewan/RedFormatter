import QtQuick 2.15
import Thermo 1.0
import ThermoConfiguration 1.0
import Redformatter
import QtQuick.Controls
import QtQuick.Layouts

import Redmine


import QtQuick 2.9
import QtQuick.Controls 1.4
//import QtQuick.Controls.Styles
import QtQml.Models 2.15
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import Qt.labs.platform 1.1
import Redmine
import QtQuick.Layouts
import QtQuick
import QtQuick.Controls
Rectangle{
    id:root
    width: 300
    height: 500
    color: "#d2d2d2"

    TreeView{
        id:tree
        //visible: false
        anchors.fill: parent
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        // TableViewColumn{
        //     title:"name"
        //     role:"name"
        //     width: tree.width
        // }
        model:EquipTreeView
        //style: treeViewStyle
        // selection: sel
        // frameVisible: false//隐藏边框
        // backgroundVisible: false
        // sortIndicatorVisible: true//这句不太清楚什么含义
        // headerVisible: false
        itemDelegate: Item{
            id:treeItem
            Rectangle{
                id:itemRect
                anchors.fill:parent
                //通过设置项圆角矩形相对于项高的上下边距来实现项间间隔效果
                //如果仅设置单边边距会导致圆角矩形向上或向下偏移，与文字不垂直居中，还需再进行定位，很麻烦
                //上下边距设为希望的项间隔的1/2，项高设为原项高+上下边距的高度
                anchors.topMargin: 1.5
                anchors.bottomMargin: 1.5
                width: tree.width
                radius:5
                color:styleData.selected?"#8abcdb":getColor(styleData.index)
            }
            Text{
                id:itemText
                anchors.fill: parent
                anchors.leftMargin: 4
                text:styleData.value
                font.family:"微软雅黑"
                color: "#ffffff"//styleData.selected?"#3742db":"#ffffff"//选中时文字颜色切换
                font.pointSize: 11//styleData.selected?12:11//选中时文字大小切换
                verticalAlignment: Text.AlignVCenter
                MouseArea{
                    id:itemMouse
                    hoverEnabled: true
                    anchors.fill:parent
                    drag.target: itemText
                    onPressed: {

                    }
                    onReleased: {

                    }
                    onClicked: {
                        sel.setCurrentIndex(styleData.index,0x0010)
                    }
                    onDoubleClicked: {
                        if(styleData.isExpanded)
                        {
                            tree.collapse(styleData.index)
                        }
                        else
                        {
                            tree.expand(styleData.index)
                        }
                    }
                }
            }
        }
        ItemSelectionModel//添加自定义选中
        {
            id:sel
            model:EquipTreeView
        }
        Component{
            id:treeViewStyle
            TreeViewStyle//树的自定义样式
            {
                indentation: 20//节点首缩进
                backgroundColor: "transparent"//背景透明
                branchDelegate: Image{//节点展开标记图
                    id:image
                    source: styleData.isExpanded?"./down.png":"./right.png"//项前的三角图标
                    width:15
                    height: 15
                }
                rowDelegate:Rectangle{
                    id:rowRec
                    height:33//项高
                    color:"transparent"//背景透明
                }
            }
        }
        onClicked: {

        }
    }

    // Rectangle{
    //     x: 0
    //     y: 400
    //     width: root.width
    //     height: 100
    //     color:"#6e6e6e"
    //     Rectangle{
    //         x: 33
    //         y: 20
    //         width: 10
    //         height: 10
    //         color:"#4a8fba"
    //     }
    //     Text{
    //         x: 55
    //         y: 14
    //         font.family:"微软雅黑"
    //         color:"#ffffff"
    //         text:"国家"
    //     }
    //     Rectangle{
    //         x: 117
    //         y: 20
    //         width: 10
    //         height: 10
    //         color:"#f0af72"
    //     }
    //     Text{
    //         x: 140
    //         y: 14
    //         font.family:"微软雅黑"
    //         color:"#ffffff"
    //         text:"省份"
    //     }
    //     Rectangle{
    //         x: 200
    //         y: 20
    //         width: 10
    //         height: 10
    //         color:"#d48484"
    //     }
    //     Text{
    //         x: 224
    //         y: 14
    //         font.family:"微软雅黑"
    //         color:"#ffffff"
    //         text:"直辖市"
    //     }
    //     Rectangle{
    //         x: 33
    //         y: 45
    //         width: 10
    //         height: 10
    //         color:"#92d791"
    //     }
    //     Text{
    //         x: 55
    //         y: 40
    //         font.family:"微软雅黑"
    //         color:"#ffffff"
    //         text:"城市"
    //     }
    //     Rectangle{
    //         x: 117
    //         y: 45
    //         width: 10
    //         height: 10
    //         color:"#de8ad5"
    //     }
    //     Text{
    //         x: 148
    //         y: 40
    //         font.family:"微软雅黑"
    //         color:"#ffffff"
    //         text:"区"
    //     }
    //     Rectangle{
    //         x: 200
    //         y: 45
    //         width: 10
    //         height: 10
    //         color:"#bbbbbb"
    //     }
    //     Text{
    //         x: 232
    //         y: 40
    //         font.family:"微软雅黑"
    //         color:"#ffffff"
    //         text:"未知"
    //     }
    //     Rectangle{
    //         x: 33
    //         y: 73
    //         width: 10
    //         height: 10
    //         color:"#8abcdb"
    //     }
    //     Text{
    //         x: 55
    //         y: 66
    //         font.family:"微软雅黑"
    //         color:"#ffffff"
    //         text:"选中"
    //     }
    //}

    //根据每一项的类型返回不同的颜色
    function getColor(index){
        var type = EquipTreeView.getType(index)
        if(type == "Country")
        {
            return "#4a8fba"
        }
        else if(type == "Province")
        {
            return "#f0af72"
        }
        else if(type == "Municipality")
        {
            return "#d48484"
        }
        else if(type == "City")
        {
            return "#92d791"
        }
        else if(type == "District")
        {
            return "#de8ad5"
        }
        else
        {
            return "#bbbbbb"
        }
    }
}
