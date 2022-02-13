wsl2_ssh_pageant_bin="$HOME/.ssh/wsl2-ssh-pageant.exe"
if [[ ! -f "${wsl2_ssh_pageant_bin}" ]]; then
  windows_destination="/mnt/c/Users/Public/Downloads/wsl2-ssh-pageant.exe"
  if [[ ! -f "${windows_destination}" ]]; then
    wget -O "$windows_destination" "https://github.com/BlackReloaded/wsl2-ssh-pageant/releases/latest/download/wsl2-ssh-pageant.exe"
    # Set the executable bit.
    chmod +x "$windows_destination"
  fi
  # Symlink to linux for ease of use later
  ln -s $windows_destination $wsl2_ssh_pageant_bin
fi

export SSH_AUTH_SOCK="$HOME/.ssh/agent.sock"
if ! ss -a | grep -q "$SSH_AUTH_SOCK"; then
  rm -f "$SSH_AUTH_SOCK"
  if test -x "$wsl2_ssh_pageant_bin"; then
    (setsid nohup socat UNIX-LISTEN:"$SSH_AUTH_SOCK,fork" EXEC:"$wsl2_ssh_pageant_bin" >/dev/null 2>&1 &)
  else
    echo >&2 "WARNING: $wsl2_ssh_pageant_bin is not executable."
  fi
fi

export GPG_AGENT_SOCK="$HOME/.gnupg/S.gpg-agent"
if ! ss -a | grep -q "$GPG_AGENT_SOCK"; then
  rm -rf "$GPG_AGENT_SOCK"
  windows_username=$(cmd.exe /c echo %USERNAME% 2>/dev/null | tr -d '\r')
  # When gpg4win is installed with scoop, the pipe is in the local directory
  echo $windows_username
  if [ -d "/mnt/c/Users/$windows_username/AppData/Local/gnupg" ]; then
    config_path="C\:/Users/$windows_username/AppData/Local/gnupg"
  else
    config_path="C\:/Users/$windows_username/AppData/Roaming/gnupg"
  fi
  
  if test -x "$wsl2_ssh_pageant_bin"; then
    (setsid nohup socat UNIX-LISTEN:"$GPG_AGENT_SOCK,fork" EXEC:"$wsl2_ssh_pageant_bin --gpgConfigBasepath ${config_path} --gpg S.gpg-agent" >/dev/null 2>&1 &)
  else
    echo >&2 "WARNING: $wsl2_ssh_pageant_bin is not executable."
  fi
  unset windows_username config_path
fi

unset wsl2_ssh_pageant_bin
