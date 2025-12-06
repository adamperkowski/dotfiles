import Quickshell
import Quickshell.Io

import "niri.mjs" as Niri

Process {
  id: niriEventStream
  running: true
  command: ["niri", "msg", "--json", "event-stream"]
  stdout: SplitParser {
    onRead: data => {
      Niri.handleEvent(data, root);
    }
  }
}
