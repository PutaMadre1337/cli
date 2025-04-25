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
      event:[
          { edit: Clear }
          { edit: InsertString,
            value: "cd (ls | where type == dir
          | each { |row| $row.name}
          | str join (char nl)
          | fzf --height=30% --preview 'ls --short-names {}'
          | decode utf-8 | str trim)"
          }
          { send: Enter }
        ]
    }
  ]
}

def count_files [] {
  let files = (ls | where type == file);
  let file_count = $files | length;
  return ("Files: " + ($file_count | to text))
}

def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

$env.STARSHIP_SHELL = "nu"
$env.PROMPT_COMMAND = { create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = { count_files }

$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = "󱙧  "
$env.PROMPT_MULTILINE_INDICATOR = "::: "
# $env.PROMPT_INDICATOR_VI_NORMAL = "  "
# $env.PROMPT_INDICATOR_VI_NORMAL = "󰂵  "

$env.EDITOR = "nvim"

$env.FZF_DEFAULT_OPTS = '--bind ctrl-b:preview-up,ctrl-f:preview-down,ctrl-d:half-page-down,ctrl-u:half-page-up --prompt="❯ " --marker="󰣉 "'

$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace

carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
