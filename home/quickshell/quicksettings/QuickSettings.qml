import QtQuick
import Quickshell
pragma ComponentBehavior: Bound

LazyLoader {
  id: root
  active: true

  PanelWindow {
    visible: root.active

    anchors {
      right: true
      left: true
      top: true
      bottom: true
    }
    exclusionMode: ExclusionMode.Ignore
    color: "transparent"

    MouseArea {
      anchors.fill: parent
      onClicked: root.active = false;
    }
    Rectangle {
      anchors.right: parent.right
      anchors.verticalCenter: parent.verticalCenter
      width: 100
      height: 100
    }
  }
  function display() {
    root.active = true;
  }
}
