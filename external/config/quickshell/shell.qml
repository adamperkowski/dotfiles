import QtQuick
import Quickshell

import "Modules/Bar"
import "Services/Niri"

ShellRoot {
  id: root

  property color colBase: "#232a2e"
  property color colText: "#f8f9e8"
  property color colOverlay: "#58686d"
  property color colAccent: "#cbe3b3"
  property color colSecond: "#f5d098"

  property string fontFamily: "Maple Mono NF"
  property int fontSize: 14

  property int wmWSC
  property int wmWSA

  LazyLoader {
    active: true
    component: Niri {}
  }

  LazyLoader {
    active: true
    component: Bar {}
  }
}
