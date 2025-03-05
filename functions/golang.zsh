function gmi {
if [ -z "$1" ]; then
    go mod init default
    go mod tidy
    return
  fi
    go mod init "$1"
    go mod tidy
}

function newgo {
if [ -z "$1" ]; then
    return 1
  fi

  mkdir "$1"
  cd "$1" || return 1

  mkdir -p cmd/"$1"
  mkdir internal
  echo -e "package main\n\nfunc main() {\n}" > cmd/"$1"/main.go

  go mod init "$1"
  go mod tidy

  git init
  git add .
  git commit -m "initial commit"
  git branch dev
  git checkout -b master
  git checkout dev
  git merge master

  echo "Go project '$1' created successfully."
}

function gbo {
    go build -o "$@" $(find . -iname main.go)
}
