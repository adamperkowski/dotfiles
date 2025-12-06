export const handleEvent = (evRaw, ns) => {
  const ev = JSON.parse(evRaw);

  if (ev.WorkspacesChanged) ns.wmWSC = ev.WorkspacesChanged.workspaces.filter(w => w.name).length;
  else if (ev.WorkspaceActivated) ns.wmWSA = ev.WorkspaceActivated.id;
};
