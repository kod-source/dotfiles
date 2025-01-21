# git
alias g='git'
alias ga='git add'
alias gap='git add $(git status --short | peco | awk "{print \$2}")'
# alias gcm='git commit -m'
alias gb='git branch'
alias gs='git status'
alias gp='git push'
# alias gpo='git push origin HEAD'
alias gpl='git pull'
alias gl='git log'
alias gc='git checkout'
# alias gst='git stash'
# alias gstf='git stash push -u $(git status --short | peco | awk "{print \$2}")'
alias gstl='git stash list'
alias gsts='git stash save'
alias gsta='git stash apply $(git stash list | peco | sed -e "s/:.*//")'
# alias gstd='git stash drop $(git stash list | peco | sed -e "s/:.*//")'
alias gstp='git stash pop $(git stash list | peco | sed -e "s/:.*//")'
alias gd='git diff'
alias gdp='git diff $(git status --short | peco | awk "{print \$2}")'
alias gds='git diff --staged'
alias gdsp='git diff --staged $(git status --short | peco | awk "{print \$2}")'
alias gbb='git branch | awk "{print \$1}" | peco | xargs git branch -D'
alias gcb='git branch | peco | xargs git checkout'
alias gfp='git ls-files | peco | tr -d "\n" | pbcopy'
alias grm='git rm --cached -r $(git status | peco | sed -e "s/modified://" | sed -e "s/deleted://" | sed -e "s/new file://" | sed s/"\t"//g | sed "s/^[ \t]*//") | tr "\n" " "'
alias gj='git jump'
alias gm='gitmoji'
alias gmc='gitmoji -c'
alias lg='tmux popup -E -h80% -w80% -d "#{pane_current_path}" "lazygit"'
alias grb='git rebase | awk "{print \$1}" | peco | xargs git branch -D'
alias gmg='git merge | awk "{print \$1}" | peco | xargs git branch -D'

# linux
alias cl='clear'
alias al="alias | peco | awk -F '=' '{print $1}' | tr -d '\n' | pbcopy"
alias cdp='cd $(find . -maxdepth 3 -type d -not -path "*/\.git/*" | peco)'
alias rmp='rm $(find . -maxdepth 3 -type f -not -path "*/\.git/*" | peco)'
alias rmrp='rm -r $(find . -maxdepth 3 -type d -not -path "*/\.git/*" | peco)'
alias vip='vi $(find . -maxdepth 3 -type f -not -path "*/\.git/*" | peco)'

# dokcer
alias d='docker'
alias dc='docker compose'
alias d-c='docker-compose'
alias drm="docker system prune"

# Fig
alias f='fig'
alias fr='fig run'

