$env.config = {
  buffer_editor: "nvim"
  show_banner: false
  edit_mode: 'emacs'

  hooks: {
    env_change: {
      PWD: [{print (ls | where type == dir)}]
    }
  }

  keybindings: [
    {
      name: change_dir_with_fzf
      modifier: CONTROL
      keycode: Char_c
      mode: [ emacs vi_insert vi_normal ]
      event: {
        send: executehostcommand,
        cmd: "cd (ls **/** | where type == dir | each { |row| $row.name} | str join (char nl) | rg -v target | fzf --preview 'ls --short-names {}' | decode utf-8 | str trim)"
      }
    }

    {
      name: search_files_with_fzf
      modifier: CONTROL
      keycode: Char_x
      mode: [ emacs vi_insert vi_normal ]
      event: {
        send: executehostcommand,
        cmd: "cd (ls **/* | where type == file | each { |row| $row.name} | str join (char nl) | rg -v -i 'target|\\.png$|\\.gif$|\\.jpg$|\\.zip$|\\.tar|\\.mp4$' | fzf --preview 'bat --style=numbers --color always {}' | decode utf-8 | str trim)"
      }
    }

    {
      name: serch_notes
      modifier: CONTROL
      keycode: Char_g
      mode: [ emacs vi_insert vi_normal ]
      event: {
        send: executehostcommand,
        cmd: "fdnote"
      }
    }
  ]
}

def count_objects [] {
  let files = (ls | where type == file);
  let file_count = $files | length;

  let dirs = (ls | where type == dir);
  let dir_count = $dirs | length;

  return (" Files: " + ($file_count | to text) + "   " + " Directories: " + ($dir_count | to text));
}

def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

$env.STARSHIP_SHELL = "nu"
$env.PROMPT_COMMAND = { create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = { count_objects }

$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = "󱙧  "
$env.PROMPT_MULTILINE_INDICATOR = "::: "
# $env.PROMPT_INDICATOR_VI_NORMAL = "  "
# $env.PROMPT_INDICATOR_VI_NORMAL = "󰂵  "

$env.EDITOR = "nvim"

$env.PATH = ($env.PATH | append /home/username/.local/share/go/bin)

$env.FZF_DEFAULT_OPTS = '--bind ctrl-b:preview-up,ctrl-f:preview-down,ctrl-d:half-page-down,ctrl-u:half-page-up --prompt="❯ " --marker="󰣉 "'

$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace

carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
