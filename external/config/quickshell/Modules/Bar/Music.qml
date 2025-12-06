import QtQuick
import QtQuick.Layouts
import Quickshell.Io

RowLayout {
  Txt {
    id: musicArtistTxt
  }
  Txt {
    text: if (musicArtistTxt.text !== "" && musicTitleTxt.text !== "") {
      " 󰎇 ";
    } else {
      "";
    }
    color: colOverlay
  }
  Txt {
    id: musicTitleTxt
  }

  Process {
    id: musicProc
    running: true
    command: ["playerctl", "metadata", "--format", "{{ artist }} || {{ title }}"]
    stdout: StdioCollector {
      onStreamFinished: {
        let parts = this.text.trim().split(" || ");
        if (parts.length === 2) {
          musicArtistTxt.text = parts[0];
          musicTitleTxt.text = parts[1];
        } else {
          musicArtistTxt.text = "";
          musicTitleTxt.text = "";
        }
      }
    }
  }

  Timer {
    interval: 5000
    running: true
    repeat: true
    onTriggered: musicProc.running = true
  }
}
