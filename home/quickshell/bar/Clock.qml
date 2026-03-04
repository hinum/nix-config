import Quickshell
import Quickshell.Wayland
import QtQuick

Rectangle {
  color: Color.blue
  topLeftRadius: 9999
  bottomLeftRadius: 9999

  width: clock.width + 30
  height: parent.height

  SystemClock {
    id: time
    precision: SystemClock.Minutes
  }

  Text {
    id: clock
    color: "black"
    anchors.centerIn: parent
    text: Qt.formatDateTime(time.date, "hh:mm dd/MM")
  }
}
