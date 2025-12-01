{
  programs.bash.shellInit = ''
    if [ -n "$SSH_TTY" ]; then
      export TERM='xterm-256color'
    fi
  '';
}
