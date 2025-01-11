import QtQuick
import RedFormatter
import QtQuick.Controls
Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("ListView with Custom Model")

    IssueList{
        id:issueList

    }
    ListView{
        id:listView
        anchors.fill: parent
        model:issueList
        ScrollBar.vertical: ScrollBar{
                               id:verticalScrollBar
                               width:14
                               policy:ScrollBar.AlwaysOn
                           }

        delegate:Item{
            height: column.height+10
            Row{
                id:column
                spacing:10
                Text{
                    text:model.name
                    font.bold:true

                }
                Text{
                    text:model.description
                    color:"lightgrey"
                }
            }
        }

        Component.onCompleted:{
            issueList.addItem("item1","This is the first item.")
            //javascript 문법 사용
            for(var i=1;i<20;i++){
                issueList.addItem("item"+i,"This is "+i+"Item.")
            }
        }
    }
}
