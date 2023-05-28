//*********************************************************************

import QtQuick 2.0
import SddmComponents 2.0

Rectangle {
    width: 640
    height: 480

    TextConstants {
        id: textConstants
    }

    Connections {
        function onLoginSucceeded() {
            errorMessage.color = "#a1b0d6";
            errorMessage.text = textConstants.loginSucceeded;
        }

        function onLoginFailed() {
            errorMessage.color = "#f7768e";
            errorMessage.text = textConstants.loginFailed;
        }

        target: sddm
    }

    Repeater {
        model: screenModel

        Background {
            x: geometry.x
            y: geometry.y
            width: geometry.width
            height: geometry.height
            source: config.background
            fillMode: Image.Tile
            onStatusChanged: {
                if (status == Image.Error && source != config.defaultBackground)
                    source = config.defaultBackground;

            }
        }

    }

    Rectangle {
        property variant geometry: screenModel.geometry(screenModel.primary)

        x: geometry.x
        y: geometry.y
        width: geometry.width
        height: geometry.height
        color: "transparent"
        transformOrigin: Item.Top
        Component.onCompleted: {
            if (name.text == "")
                name.focus = true;
            else
                password.focus = true;
        }

        Image {
            id: archlogo

            width: height * 3
            height: parent.height / 6
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -1 * height / 2
            anchors.horizontalCenterOffset: 0
            fillMode: Image.PreserveAspectFit
            transformOrigin: Item.Center
            source: "archlinux.png"
        }

        Column {
            id: archlinux

            anchors.centerIn: parent
            height: parent.height / 10 * 3
            width: height * 1.8
            anchors.verticalCenterOffset: height * 2 / 3
            spacing: height / 30

            Row {
                width: parent.width
                spacing: Math.round(archlinux.height / 70)

                Text {
                    id: lblName

                    width: parent.width * 0.2
                    height: archlinux.height / 9
                    color: "#a1b9d6"
                    text: textConstants.userName
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    font.pixelSize: archlinux.height / 22.5
                }

                TextBox {
                    id: name

                    width: parent.width * 0.8
                    height: archlinux.height / 9
                    text: userModel.lastUser
                    font.pixelSize: archlinux.height / 20
                    color: "#a1b9d6"
                    radius: 10
                    KeyNavigation.backtab: rebootButton
                    KeyNavigation.tab: password
                    Keys.onPressed: {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            sddm.login(name.text, password.text, sessionModel.lastIndex);
                            event.accepted = true;
                        }
                    }
                }

            }

            Row {
                width: parent.width
                spacing: Math.round(archlinux.height / 70)

                Text {
                    id: lblPassword

                    width: parent.width * 0.2
                    height: archlinux.height / 9
                    color: "#a1b9d6"
                    text: textConstants.password
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    font.pixelSize: archlinux.height / 22.5
                }

                PasswordBox {
                    id: password

                    width: parent.width * 0.8
                    height: archlinux.height / 9
                    font.pixelSize: archlinux.height / 20
                    color: "#a1b9d6"
                    focus: true
                    radius: 10
                    KeyNavigation.backtab: name
                    KeyNavigation.tab: shutdownButton
                    Keys.onPressed: {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            sddm.login(name.text, password.text, sessionModel.lastIndex);
                            event.accepted = true;
                        }
                    }

                    Timer {
                        interval: 200
                        running: true
                        onTriggered: password.forceActiveFocus()
                    }

                }

            }

            Column {
                width: parent.width

                Text {
                    id: errorMessage

                    anchors.horizontalCenter: parent.horizontalCenter
                    text: ""
                    color: "#a1b9d6"
                    font.pixelSize: archlinux.height / 22.5
                }

            }

        }

    }

    Row {
        property variant geometry: screenModel.geometry(screenModel.primary)
        property int btnWidth: 60
        property int btnHeight: 60
        property int fontSize: 30

        x: geometry.width - 120
        y: geometry.height - 80

        Button {
            id: shutdownButton

            text: "⏻"
            width: parent.btnWidth
            height: parent.btnHeight
            font.pixelSize: parent.fontSize
            radius: 10
            color: "#1A0B25"
            onClicked: sddm.powerOff()
            KeyNavigation.backtab: password
            KeyNavigation.tab: rebootButton
        }

        Button {
            id: rebootButton

            text: "󰜉"
            width: parent.btnWidth
            height: parent.btnHeight
            font.pixelSize: parent.fontSize
            radius: 10
            color: "#1A0B25"
            onClicked: sddm.reboot()
            KeyNavigation.backtab: shutdownButton
            KeyNavigation.tab: name
        }

    }

}
