import Quickshell
import Quickshell.Wayland
import QtQuick

PanelWindow {
  id: root

  anchors {
    top: true
    right: true;
  }
  exclusionMode: ExclusionMode.Ignore
  WlrLayershell.layer: WlrLayer.Overlay

  property int padding: 2
  property int height: 50
  property int itemsize: height - padding * 2
  signal clicked()

  implicitWidth: row.width
  implicitHeight: height
  color: "transparent"

  Row {
    id: row
    anchors.centerIn: parent
    spacing: 10

    Workspace {
      itemsize: root.itemsize
      strokesize: 5
    }
    Clock {
      MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
      }
    }
  }
}
