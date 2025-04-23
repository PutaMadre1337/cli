$env.config = {
  buffer_editor: "nvim"
  show_banner: false
  edit_mode: 'vi'

  hooks: {
    env_change: {
      PWD: [{|before, after| print (ls | where type == dir)}]
    }
  }

  keybindings: [
    {
      name: change_dir_with_fzf
      modifier: CONTROL
      keycode: Char_c
      mode: emacs
      event:[
          { edit: Clear }
          { edit: InsertString,
            value: "cd (ls
          | where type == dir
          | each { |row| $row.name}
          | str join (char nl)
          | fzf --preview 'ls --short-names {}'
          | decode utf-8 | str trim)"
          }
          { send: Enter }
        ]
    }

    # {
    #   name: history
    #   modifier: CONTROL
    #   keycode: Char_r
    #   mode: emacs
    #   event:[
    #     { edit: Clear }
    #     { edit: InsertString,
    #       value: "let cmd = history | get command | to text | fzf ; do $cmd"
    #     }
    #     { send: Enter }
    #   ]
    # }
  ]
}

$env.STARSHIP_SHELL = "nu"
def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}
$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = {
  let files = (ls | where type == file);
  let file_count = $files | length;
  return ("Files: " + ($file_count | to text))
}
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ""
# $env.PROMPT_INDICATOR_VI_NORMAL = "  "
$env.PROMPT_INDICATOR_VI_NORMAL = "󱙧  "
# $env.PROMPT_INDICATOR_VI_NORMAL = "󰂵  "
$env.PROMPT_MULTILINE_INDICATOR = "::: "

$env.EDITOR = "nvim"

$env.FZF_DEFAULT_OPTS = '--bind ctrl-b:preview-up,ctrl-f:preview-down,ctrl-d:half-page-down,ctrl-u:half-page-up --prompt="❯ " --marker="󰣉 "'

$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
