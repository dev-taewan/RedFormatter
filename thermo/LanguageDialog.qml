/******************************************************************************
**
** Copyright (C) 2020 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Qt Quick Ultralite module.
**
** $QT_BEGIN_LICENSE:COMM$
**
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see http://www.qt.io/terms-conditions. For further
** information use the contact form at http://www.qt.io/contact-us.
**
** $QT_END_LICENSE$
**
******************************************************************************/

import QtQuick 2.15

import Thermo 1.0
import ThermoConfiguration 1.0

Rectangle {
    id: dialog
    color: "#88000000"
    visible: true

    opacity: Configuration.enableFadingAnimations ? 0 : 1

    signal triggerAnimation
    signal stopAnimation

    SequentialAnimation {
        id: showAnimation
        alwaysRunToEnd: true
        ScriptAction { script: dialog.visible = true }
        PropertyAnimation { target: dialog; property: "opacity"; from: 0.0; to: 1.0 }
    }

    SequentialAnimation {
        id: hideAnimation
        alwaysRunToEnd: true
        PropertyAnimation { target: dialog; property: "opacity"; from: 1.0; to: 0.0 }
        ScriptAction { script: dialog.visible = false }
    }

    Behavior on opacity { NumberAnimation{} }

    Connections {
        target: dialog
        onTriggerAnimation: {
            if (Configuration.enableFadingAnimations) {
                showAnimation.running = true
            } else {
                dialog.visible = true
            }
        }

        onStopAnimation: {
            if (Configuration.enableFadingAnimations) {
                hideAnimation.running = true
            } else {
                dialog.visible = false
            }
        }
    }

    MouseArea {
        anchors.fill: parent
    }

    Image {
        id: background
        source: "assets/popup-bg.png"
        anchors.centerIn: parent

        Item {
            id: titleBar
            height: Theme.dialogBarHeight
            width: background.width

            ColorizedImage {
                id: close
                anchors.verticalCenter: parent.verticalCenter
                anchors.topMargin: 22
                anchors.right: parent.right
                anchors.rightMargin: Theme.dialogRightMargin
                source: "assets/close.png"
                color: ColorStyle.greyDark4
            }

            MouseArea {
                id: closeMA
                anchors.fill: close
                anchors.margins: -15

                Connections {
                    target: closeMA
                    onClicked: dialog.stopAnimation()
                }
            }

            Text {
                id: title
                text: qsTr("Language Settings")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: Theme.dialogLeftMargin
                font.pixelSize: Theme.topBarFontSize
                font.family: "Roboto"
            }
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: titleBar.height / 2
            anchors.left: titleBar.left
            anchors.leftMargin: Theme.dialogLeftMargin

            // No ButtonGroup yet so exclusive checking is implemented manualy
            LanguageButton {
                id: english
                text: "English"
                flag: "assets/UK.png"
                checked: Qt.uiLanguage == "" || Qt.uiLanguage == "en-150"
                enabled: !checked

                Connections {
                    target: english
                    onCheckedChanged: {
                        if (english.checked) {
                            Qt.uiLanguage = ""
                            german.checked = false
                            japanese.checked = false
                        }
                    }
                }
            }

            LanguageButton {
                id: german
                text: "Deutsch"
                checked: Qt.uiLanguage == "de_DE"
                enabled: !checked
                flag: "assets/GERMANY.png"

                Connections {
                    target: german
                    onCheckedChanged: {
                        if (german.checked) {
                            english.checked = false
                            japanese.checked = false
                            Qt.uiLanguage = "de_DE"
                        }
                    }
                }
            }

            LanguageButton {
                id: japanese
                text: "日本語"
                checked: Qt.uiLanguage == "ja_JP"
                enabled: !checked
                flag: "assets/JAPAN.png"

                Connections {
                    target: japanese
                    onCheckedChanged: {
                        if (japanese.checked) {
                            english.checked = false
                            german.checked = false
                            Qt.uiLanguage = "ja_JP"
                        }
                    }
                }
            }
        }
    }
}
