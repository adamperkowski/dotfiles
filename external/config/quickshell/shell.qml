import QtQuick
import Quickshell

import "Modules/Bar"
import "Services/Niri"

ShellRoot {
  id: root

  property color colBase: "#1e1e2e"
  property color colText: "#cdd6f4"
  property color colOverlay: "#6c7086"
  property color colAccent: "#b4befe"
  property color colSecond: "#cba6f7"

  property string fontFamily: "FiraCode Nerd Font"
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
