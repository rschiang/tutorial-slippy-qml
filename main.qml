import QtQuick 2.3
import QtQuick.Window 2.2

Window {
    id: window
    visible: true
    width: 360
    height: 360
    title: "良辰吉日"
    color: "#33b5e5"
    // flags: Qt.FramelessWindowHint

    AnimatedImage {
        id: slippy
        anchors.fill: parent
           source: "slippy.gif"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            slippy.paused = !slippy.paused
            timer.running = !slippy.paused
            if (clickEffect.running)
                clickEffect.stop()
            clickEffect.start()
        }
    }

    Text {
            id: hello
            font.pointSize: 32
            font.bold: true
            font.family: "Roboto"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: '26°'
            color: "#fff"
        }

        Text {
            anchors.left: hello.right
            anchors.baseline: hello.baseline
            text: "C"
            color: "#ffffff"
            font.pointSize: 16
            font.bold: true
            font.family: "Roboto"
        }

        Text {
            id: messageText
            color: "#fff"
            opacity: .65
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: hello.bottom
                margins: 8
            }
            text: "颱風"
        }

        Text {
            id: clock
            color: "#fff"
            font.pointSize: 24
            font.family: "Roboto"
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: messageText.bottom
                margins: 16
            }
        }

        Timer {
            id: timer
            running: true
            repeat: true
            interval: 1000
            onTriggered: {
                var date = new Date()
                var months = ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二"]
                window.title = months[date.getMonth()] + "月十日"
                clock.text = date.getHours() + ":" +
                             date.getMinutes() + ":" +
                             date.getSeconds()
            }
        }

        ParallelAnimation {
            id: clickEffect

            NumberAnimation {
                target: slippy
                property: "opacity"
                from: 0.5
                to: 1
                duration: 2000
                easing.type: Easing.OutBack
            }

            ColorAnimation {
                target: window
                property: "color"
                from: "black"
                to: "#33b5e5"
                duration: 200
            }


            NumberAnimation {
                target: slippy
                property: "scale"
                duration: 200
                from: 1.1; to: 1
                easing.type: Easing.OutExpo
            }
        }
}
