import QtQuick
import QtQuick.Layouts

RowLayout {
  spacing: 20
  Repeater {
    model: wmWSC
    Txt {
      text: ""
      color: if (index + 1 === wmWSA) {
        colAccent;
      } else {
        colOverlay;
      }
    }
  }
}
