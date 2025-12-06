export const handleEvent = (evRaw, ns) => {
  const ev = JSON.parse(evRaw);

  if (ev.WorkspaceActivated) ns.wmWSA = ev.WorkspaceActivated.id;
  else if (ev.WorkspacesChanged) ns.wmWSC = ev.WorkspacesChanged.workspaces.filter(w => w.name)
    .length;
};
