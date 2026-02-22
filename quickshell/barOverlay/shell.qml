import Quickshell
import Quickshell.Io // for Process
import QtQuick

PanelWindow {
  anchors {
    top: true
    right: true
  }

  implicitHeight: 40
  width: clock.width + 40
  color: "transparent"
  focusable: false
  exclusionMode: ExclusionMode.Ignore
  

  Rectangle {
    anchors.fill: parent
    topLeftRadius: 60
    bottomLeftRadius: 60
    color: "white"
    Text {
      // give the text an ID we can refer to elsewhere in the file
      id: clock

      anchors.right: parent.right
      anchors.verticalCenter: parent.verticalCenter
      anchors.rightMargin: 20
      anchors.leftMargin: 20

      // create a process management object
      Process {
        // the command it will run, every argument is its own string
        command: ["date"]

        // run the command immediately
        running: true

        // process the stdout stream using a StdioCollector
        // Use StdioCollector to retrieve the text the process sends
        // to stdout.
        stdout: StdioCollector {
          // Listen for the streamFinished signal, which is sent
          // when the process closes stdout or exits.
          onStreamFinished: clock.text = this.text // `this` can be omitted
        }
      }
    }
  }
}
