# oh-my-zsh
export ZSH="$HOME/.sheldon/repos/github.com/ohmyzsh/ohmyzsh"
plugins=(
	alias-finder
	git
	encode64
	colored-man-pages
	command-not-found
	rsync
	gpg-agent
	#ssh-agent
	docker
	kubectl
	helm
	terraform
	doctl
	gcloud
	rust
	golang
	volta
	npm
	yarn
)

# spaceship config file
export SPACESHIP_CONFIG_FILE="$HOME/.config/spaceship.zsh"

# rust
. "$HOME/.cargo/env"

# go
export PATH=$PATH:/usr/local/go/bin

# volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# sheldon
eval "$(sheldon source)"

# alias
alias ls='exa -lahgb --group-directories-first --no-icons'
alias v='nvim'

# default editor
export VISUAL="nvim"
export EDITOR="nvim -e"

# launch pfetch
export PF_INFO="ascii title os host kernel shell editor wm uptime pkgs memory palette"
pfetch
