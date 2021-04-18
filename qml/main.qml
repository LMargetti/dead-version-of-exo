import QtQuick 2.15
import QtQuick.Window 2.12
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "controls"



Window {
    id: window
    title: "ExO"

    // Hard Window Properties
    width: 980
    height: 660
    minimumWidth: 980
    minimumHeight: 660
    visible: true
    color: "#00000000"

    // Remove title bar
    flags: Qt.Window | Qt.FramelessWindowHint

    // Window Properties
    property bool windowMaximised: false
    property int windowMargin: 10
    property int appCornerRadius: 10

    // Menu Properties
    property int leftMenuDefWidth: 60
    property var activeMenuBtn_list: [
        //settingsBtn,
        //infoBtn,
        //profileBtn,
        menuBtn]
    property string mName: ""

    // Font Sizes
    property int menuHeaderFontSize: 30

    // Colour Scheme Properties
    // Backgrounds
    property color darkColour3: "#050505"  // Darkest
    property color darkColour2: "#121212"  //    |
    property color darkColour1: "#1e1e1e"  //    |
    property color middleColour: "#2b2b2b" // Neutral
    property color midLColour1: "#323232"  //    |      Introduced to allow another division of shades
    property color lightColour1: "#383838" //    |
    property color lightColour2: "#454545" //    |
    property color lightColour3: "#515151" // Lightest

    // Text
    property color headingsColour: "#ffffff"
    property color subheadingColour: "#e6e6e6"
    property color bodyTextColour: "#cccccc"

    // Buttons
    property color closeBtnRed: "#b30000"
    property color activeCloseRed: "#800000"
    property color dimmedWhite: "#c2c2c2"
    property color leftMenuClickedColour: "#467dda"
    property color generalHoverTint: "#25000000"

    // Other
    property color highlightColour: "#ffffff"
    property color cTransparent: "#00000000"

    // Internal Functions
    QtObject {
        id: internal

        function activeMenuNameFinder(){
            var i;
            for (i = 0; i < activeMenuBtn_list.length; i++) {
                if(activeMenuBtn_list[i].isActiveMenu){
                    mName = activeMenuBtn_list[i].menuName
                }
            }
            return mName
        }

        function activateMenu(self){
            if(!leftMenuAnimation.running){
                if(self.isActiveMenu){
                       leftMenuAnimation.running = true
                       self.isActiveMenu = false
                   } else if(leftMenu.width > leftMenuDefWidth) {
                        var i;
                        for (i = 0; i < activeMenuBtn_list.length; i++) {
                            activeMenuBtn_list[i].isActiveMenu = false
                        }
                       self.isActiveMenu = true
                   } else {
                       leftMenuAnimation.running = true
                       self.isActiveMenu = true
                   }
               }
        }

        function deactivateMenus(){
            var i;
            for (i = 0; i < activeMenuBtn_list.length; i++) {
                activeMenuBtn_list[i].isActiveMenu = false
            }
        }

        function restoreMargins(){
            windowMaximised = false
            windowMargin = 10
            appCornerRadius = 10
        }

        function winNorm(){
            window.showNormal()
            internal.restoreMargins()
            maximiseBtn.iconSource = "../Resources/svg_images/maximize_icon.svg"
        }

        function maximiseRestore(){
            if(windowMaximised == false){
                windowMaximised = true
                windowMargin = 0
                appCornerRadius = 0
                window.showMaximized()
                maximiseBtn.iconSource = "../Resources/svg_images/restore_icon.svg"
            }
            else{
                internal.winNorm()
                appCornerRadius = 10
            }
        }


    }

    Rectangle {
        id: background
        color: darkColour1
        radius: appCornerRadius
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: windowMargin
        anchors.leftMargin: windowMargin
        anchors.bottomMargin: windowMargin
        anchors.topMargin: windowMargin
        z: 1

        Rectangle {
            id: appContainer
            color: cTransparent
            radius: appCornerRadius
            border.color: "#00000000"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 0





            Rectangle {
                id: content
                color: cTransparent
                border.width: 3
                border.color: middleColour
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.rightMargin: 1
                anchors.leftMargin: 2
                anchors.bottomMargin: 10
                anchors.topMargin: 25

                Rectangle {
                    id: currentPage
                    color: lightColour1
                    anchors.bottomMargin: 1
                    anchors {
                        left: parent.left
                        right: parent.right
                        top: parent.top
                        bottom: parent.bottom
                        topMargin: content.border.width - 1
                    }

//                    CheckBox {
//                        id: checkBox
//                        x: 517
//                        y: 281
//                        text: qsTr("Check Box")
//                        checked: menuActive
//                    }
                }

                Rectangle {
                    id: leftMenu
                    width: leftMenuDefWidth
                    color: middleColour
                    anchors {
                        left: parent.left
                        top: currentPage.top
                        bottom: currentPage.bottom
                    }

                    PropertyAnimation {
                        id: leftMenuAnimation
                        target: leftMenu
                        property: "width"
                        to: if(leftMenu.width == leftMenuDefWidth) return 300; else return leftMenuDefWidth
                        duration: 100
                        easing.type: Easing.InOutQuint
                    }



                    Rectangle {
                        id: expandedMenu
                        color: darkColour1
                        border.color: middleColour
                        border.width: 2
                        anchors.left: menuButtons.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: -1
                        anchors.topMargin: -1
                        anchors.leftMargin: -border.width

                        Text {
                            id: menuTitle
                            height: 56
                            text: qsTr("what up bro")
                            font.capitalization: Font.AllUppercase
                            color: headingsColour
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            font.pixelSize: menuHeaderFontSize
                            verticalAlignment: Text.AlignVCenter
                            font.bold: true
                            clip: true
                            anchors.leftMargin: 8
                            anchors.rightMargin: 3
                            anchors.topMargin: 3
                        }

                        Rectangle {
                            id: rectangle
                            visible: menuBtn.isActiveMenu
                            color: lightColour2
                            anchors.left: menuTitle.right
                            anchors.right: parent.right
                            anchors.top: menuSpacerT.bottom
                            anchors.bottom: menuSpacerB.top
                            anchors.leftMargin: 1
                        }

                        Rectangle {
                            id: menuSpacerB
                            height: 2
                            visible: menuBtn.isActiveMenu
                            color: lightColour2
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: menuTitle.bottom
                            anchors.rightMargin: 0
                            anchors.leftMargin: 0
                        }

                        Rectangle {
                            id: menuSpacerT
                            height: 2
                            visible: menuBtn.isActiveMenu
                            color: lightColour2
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.bottom: menuTitle.top
                            anchors.leftMargin: 0
                            anchors.rightMargin: 0
                        }

                    }

                    Rectangle {
                        id: menuButtons
                        color: "#00000000"
                        anchors.left: parent.left
                        anchors.right: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: -leftMenuDefWidth

                        LeftBarButtons {
                            id: menuBtn
                            menuName: "Menu"
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            iconWidth: 24
                            iconHeight: 24
                            iconSource: "../Resources/svg_images/menu_icon.svg"
                            defCol: middleColour
                            hoverTint: generalHoverTint
                            clickedColour: leftMenuClickedColour
                            iconDefaultColour: highlightColour
                            iconHoverColour: dimmedWhite
                            iconActiveColour: highlightColour
                            menuActiveColour: darkColour1
                            bgBorderColour: lightColour2

                            onClicked: if (!leftMenuAnimation.running){
                                           if(isActiveMenu){
                                               leftMenuAnimation.running = true
                                               isActiveMenu = false
                                           } else {
                                               leftMenuAnimation.running = true
                                               isActiveMenu = true
                                           }
                                       }

                            //onClicked: internal.activateMenu(menuBtn)
                        }



                        LeftBarButtons {
                            id: profileBtn
                            menuName: "Profile"
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.bottom: infoBtn.top
                            anchors.bottomMargin: -2
                            iconWidth: 28
                            iconHeight: 28
                            iconSource: "../Resources/svg_images/profile_icon2.svg"
                            defCol: middleColour
                            hoverTint: generalHoverTint
                            clickedColour: leftMenuClickedColour
                            iconDefaultColour: highlightColour
                            iconHoverColour: dimmedWhite
                            iconActiveColour: highlightColour
                            menuActiveColour: darkColour1
                            bgBorderColour: lightColour2

                            //onClicked: internal.activateMenu(profileBtn)
                        }

                        LeftBarButtons {
                            id: infoBtn
                            menuName: "Info"
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.bottom: settingsBtn.top
                            anchors.bottomMargin: -2
                            iconWidth: 28
                            iconHeight: 28
                            iconSource: "../Resources/svg_images/info_icon.svg"
                            defCol: middleColour
                            hoverTint: generalHoverTint
                            clickedColour: leftMenuClickedColour
                            iconDefaultColour: highlightColour
                            iconHoverColour: dimmedWhite
                            iconActiveColour: highlightColour
                            menuActiveColour: darkColour1
                            bgBorderColour: lightColour2

                            //onClicked: internal.activateMenu(infoBtn)
                        }




                        LeftBarButtons {
                            id: settingsBtn
                            menuName: "Settings"
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            iconWidth: 28
                            iconHeight: 28
                            iconSource: "../Resources/svg_images/settings_icon.svg"
                            defCol: middleColour
                            hoverTint: generalHoverTint
                            clickedColour: leftMenuClickedColour
                            iconDefaultColour: highlightColour
                            iconHoverColour: dimmedWhite
                            iconActiveColour: highlightColour
                            menuActiveColour: darkColour1
                            bgBorderColour: lightColour2

                            //onClicked: internal.activateMenu(settingsBtn)

                        }

                        Rectangle {
                            id: btnSeparator
                            width: 2
                            color: lightColour2
                            anchors.right: parent.right
                            anchors.top: menuBtn.bottom
                            anchors.bottom: profileBtn.top
                        }
                    }










                }

            }


            Rectangle {
                id: topBar
                color: cTransparent
                border.color: "#00000000"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.top
                anchors.bottomMargin: -25


                DragHandler {
                    onActiveChanged: if(active){
                                         internal.restoreMargins()
                                         maximiseBtn.iconSource = "../Resources/svg_images/maximize_icon.svg"
                                         return window.startSystemMove()
                                     }
                }


                Rectangle {
                    id: appBtns
                    width: 150
                    height: 25
                    color: cTransparent
                    radius: 10
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 10

                    WinButtons {
                        id: minimiseBtn
                        width: 50
                        anchors.right: maximiseBtn.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        iconWidth: 18
                        iconHeight: 18
                        iconSource: "../Resources/svg_images/minimise2.svg"
                        anchors.bottomMargin: 1
                        defCol: darkColour1
                        hoverCol:lightColour1
                        actCol: middleColour

                        onClicked: {
                            internal.restoreMargins()
                            window.showMinimized()
                            maximiseBtn.iconSource = "../Resources/svg_images/maximize_icon.svg"
                        }
                    }

                    WinButtons {
                        id: maximiseBtn
                        width: 50
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.right: closeBtn.left
                        iconHeight: 18
                        iconWidth: 18
                        iconSource: "../Resources/svg_images/maximize_icon.svg"
                        defCol: darkColour1
                        hoverCol:lightColour1
                        actCol: middleColour
                        anchors.bottomMargin: 1

                        onClicked: internal.maximiseRestore()

                    }

                    WinButtons {
                        id: closeBtn
                        width: 50
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        iconHeight: 18
                        iconWidth: 18
                        iconSource: "../Resources/svg_images/close_icon.svg"
                        defCol: darkColour1
                        hoverCol: closeBtnRed
                        actCol: activeCloseRed
                        anchors.bottomMargin: 1

                        onClicked: window.close()

                    }


                }
            }
        }

    }

    DropShadow{
        anchors.fill: background
        horizontalOffset: 0
        verticalOffset: 0
        radius: appCornerRadius
        samples: 16
        color: "#80000000"
        source: background
        z: 0
    }

    MouseArea {
        id: bottomResize
        y: 656
        height: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 15
        anchors.leftMargin: 15
        cursorShape: Qt.SizeVerCursor

        DragHandler {
            target: null
            onActiveChanged: if (active) {window.startSystemResize(Qt.BottomEdge)}
        }

    }

    MouseArea {
        id: rightResize
        width: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.topMargin: 10
        cursorShape: Qt.SizeHorCursor

        DragHandler {
            target: null
            onActiveChanged: if (active) {window.startSystemResize(Qt.RightEdge)}
        }

    }

    MouseArea {
        id: leftResize
        width: 10
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.topMargin: 10
        anchors.bottomMargin: 15
        cursorShape: Qt.SizeHorCursor

        DragHandler {
            target: null
            onActiveChanged: if (active) {window.startSystemResize(Qt.LeftEdge)}
        }

    }

    MouseArea {
        id: bottomRightResize
        width: 15
        height: 15
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        cursorShape: Qt.SizeFDiagCursor

        DragHandler {
            target: null
            onActiveChanged: if (active) {window.startSystemResize(Qt.RightEdge | Qt.BottomEdge)}
        }

    }

    MouseArea {
        id: bottomLeftResize
        width: 15
        height: 15
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        cursorShape: Qt.SizeBDiagCursor

        DragHandler {
            target: null
            onActiveChanged: if (active) {window.startSystemResize(Qt.LeftEdge | Qt.BottomEdge)}
        }

    }


}







/*##^##
Designer {
    D{i:0;formeditorZoom:0.9}
}
##^##*/
