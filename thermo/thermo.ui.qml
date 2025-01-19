
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

Item {
    id: appWindow
    width: Theme.screenWidth
    height: Theme.screenHeight

    property int selectedView: 0

    BackgroundImage {
        anchors.fill: parent
    }

    TopBar {
        id: topBar
        width: parent.width
        height: Theme.topBarHeight

        showBackButton: !places.showMain
        title: places.currentRoom.name

        Connections {
            target: topBar
            onBackClicked: {
                places.showMain = true
            }
            onSettingsClicked: {
                languageDialog.triggerAnimation()
            }
        }
    }

    Item {
        id: mainItem
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: topBar.bottom
        height: parent.height - topBar.height - bottomBar.height

        property int currentViewIndex: 0

        PlacesView {
            id: places
            enabled: appWindow.selectedView === 0 && showMain
            visible: opacity > 0.01
            anchors.fill: parent
            showMain: true
            Connections {
                target: places
                onShowMainChanged: {
                    appWindow.selectedView = !places.showMain ? 5 : 0
                }
            }

            selectedView: appWindow.selectedView
            index: 0
        }

        RoomView {
            id: roomView
            anchors.fill: parent
            anchors.bottomMargin: -Theme.bottomBarHeight // No BottomBar in the RoomView
            visible: opacity > 0.01
            currentRoom: places.currentRoom

            selectedView: appWindow.selectedView
            index: 5
        }

        ScheduleView {
            anchors.fill: parent
            enabled: appWindow.selectedView === 1
            visible: opacity > 0.01

            selectedView: appWindow.selectedView
            index: 1
        }

        StatsView {
            anchors.fill: parent
            anchors.topMargin: Theme.statsTopGradientSpacer // The view is opaque, reserve space for the background gradient
            enabled: appWindow.selectedView === 2
            visible: opacity > 0.01

            selectedView: appWindow.selectedView
            index: 2
        }
    }

    BottomBar {
        id: bottomBar
        z: 10 // give precedence to bottom bar touch areas
        width: parent.width
        height: Theme.bottomBarHeight
        selected: appWindow.selectedView
        anchors.bottom: parent.bottom

        anchors.bottomMargin: shift
        showMainOption: places.showMain

        Connections {
            target: bottomBar
            function onViewSwitched(index: int) {
                appWindow.selectedView = index
            }
        }
    }

    LanguageDialog {
        visible: false
        opacity: Configuration.enableFadingAnimations ? 0 : 1
        id: languageDialog
        anchors.fill: parent
        z: 11
    }
}
