import Quickshell
import Quickshell.Wayland
import QtQuick

Variants {
  model: Quickshell.screens
  delegate: PanelWindow {
    anchors {
      top: true
      right: true
    }
    required property var modelData
    screen: modelData
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Overlay

    implicitWidth: clock.width + 40
    implicitHeight: 40
    color: "transparent"

    Rectangle {
      color: Color.red
      anchors.centerIn: parent
      width: parent.width
      height: parent.height

      topLeftRadius: 9999
      bottomLeftRadius: 9999

      SystemClock {
        id: time
        precision: SystemClock.Minutes
      }

      Text {
        id: clock
        color: "black"
        anchors.centerIn: parent
        text: Qt.formatDateTime(time.date, "hh:mm dddd dd-MM-yy")
      }
    }
  }
}
