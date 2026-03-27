# ==========================================
# CORE ENV
# ==========================================
export EDITOR="nvim"
export LANG=en_US.UTF-8
export LANGUAGE="en"

# ==========================================
# PATH 
# ==========================================

#Local
export PATH="${PATH}:${HOME}/.local/bin"
export PATH="$HOME/.local/bin:$PATH"
export PATH=$HOME/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:$PATH

#Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Java
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home/"
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-23.jdk/Contents/Home/"
# export JAVA_HOME="${HOME}/Library/Java/JavaVirtualMachines/openjdk-22.0.1/Contents/Home"

# Android
export GRADLE_USER_HOME=/Users/Shared/gradle

# Golang
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Opencode
export PATH="/Users/nanaumov/.opencode/bin:$PATH"

# Fast Node Manager
export RCFILE="$HOME/.zshrc"
eval "$(fnm env --use-on-cd --version-file-strategy recursive)"


# ==========================================
# ALIASES 
# ==========================================
alias g='git'
alias nvm="fnm"
alias oc='opencode'

# Ai
alias c='opencode run "Write a concise commit message"'

# NAVIGATION
eval "$(zoxide init zsh)"
alias cd="z"
alias cdi="zi"

# CLI MODERN
alias ls="eza --icons"
alias ll="eza -lah --git"
alias cat="bat"
alias grep="rg"
alias find="fd"

# Avito
alias acl='avito ai claude --'
alias bd='avito llm budget --model gpt-5.3-codex --unit "Jobs Employer&TnS&MNZ"'
alias a72='avito service k-branch-deploy --ttl 72h'
alias ae2e='avito service system-tests run'

# ==========================================
# DEV HELPERS
# ==========================================
mkcd() {
  mkdir -p "$1" && cd "$1"
}

#compdef opencode
###-begin-opencode-completions-###
#
# yargs command completion script
#
# Installation: opencode completion >> ~/.zshrc
#    or opencode completion >> ~/.zprofile on OSX.
#
_opencode_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" opencode --get-yargs-completions "${words[@]}"))
  IFS=$si
  if [[ ${#reply} -gt 0 ]]; then
    _describe 'values' reply
  else
    _default
  fi
}
if [[ "'${zsh_eval_context[-1]}" == "loadautofunc" ]]; then
  _opencode_yargs_completions "$@"
else
  compdef _opencode_yargs_completions opencode
fi
###-end-opencode-completions-###


op() {
  local base="$HOME/.config/opencode-profiles"
  local profile="$1"
  local dir="$base/$profile"

  if [[ -z "$profile" ]]; then
    opencode
    return
  fi

  if [[ -d "$dir" ]]; then
    OPENCODE_CONFIG_DIR="$dir" opencode
  else
    echo "Profile not found: $profile ($dir)"
    return 1
  fi
}

_op_complete() {
  local base="$HOME/.config/opencode-profiles"
  local d

  for d in "$base"/*(/N:t); do
    compadd -- "$d"
  done
}

compdef _op_complete op

# ==========================================
# ZINIT
# ==========================================
if [[ ! -f ~/.zinit/bin/zinit.zsh ]]; then
  mkdir -p ~/.zinit && git clone https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin
fi
source ~/.zinit/bin/zinit.zsh

# ==========================================
# COMPLETION
# ==========================================
autoload -Uz compinit
compinit -d ~/.cache/zcompdump

# ==========================================
# HISTORY
# ==========================================
HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups

export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"

setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
setopt HIST_REDUCE_BLANKS

# ==========================================
# PLUGINS 
# ==========================================
zinit ice wait lucid atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit light ajeetdsouza/zoxide

zinit ice wait lucid
zinit light junegunn/fzf

# highlighting всегда последним
zinit ice wait lucid atload"ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)"
zinit light zsh-users/zsh-syntax-highlighting

# ==========================================
# STARSHIP
# ==========================================
if command -v starship >/dev/null; then
  eval "$(starship init zsh)"
fi

# ==========================================
# FZF
# ==========================================
export FZF_DEFAULT_OPTS="
  --height 40%
  --layout=reverse
  --border
  --preview 'bat --style=numbers --color=always {}'
"