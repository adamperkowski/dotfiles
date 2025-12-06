import QtQuick
import QtQuick.Layouts
import Quickshell

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }

  implicitHeight: 30
  color: colBase

  Workspaces {
    anchors {
      verticalCenter: parent.verticalCenter
      left: parent.left
      leftMargin: 10
    }
  }

  Music {
    anchors.centerIn: parent
  }

  RowLayout {
    anchors {
      verticalCenter: parent.verticalCenter
      right: parent.right
      rightMargin: 10
    }

    Txt {
      id: timeTxt
      text: Qt.formatDateTime(new Date(), "hh:mm AP")

      Timer {
        interval: 10000
        running: true
        repeat: true
        onTriggered: timeTxt.text = Qt.formatDateTime(new Date(), "hh:mm AP")
      }
    }
    Spacer {}
    Txt {
      id: dateTxt
      text: Qt.formatDateTime(new Date(), "yyyy-MM-dd")

      Timer {
        interval: 600000
        running: true
        repeat: true
        onTriggered: dateTxt.text = Qt.formatDateTime(new Date(), "yyyy-MM-dd")
      }
    }
  }
}
