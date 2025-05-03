def gmi [name?: string] {
    go mod init ($name | default 'default')
    go mod tidy
}

# def newgo [name: string] {
#   mkdir ($name)
#
#   mkdir ($name)/cmd/($name | str)
#   mkdir internal
#   "package main\n\nfunc main() {\n}" | save ($name)/cmd/($name)/main.go
#
#   cd ($name)
#   go mod init ($name)
#   go mod tidy
#
#   git init
#   git add .
#   git commit -m "initial commit"
#   git branch dev
#   git checkout -b master
#   git checkout dev
#   git merge master
#
#   print "Go project '$1' created successfully."
# }

def gbo [target_name: string] {
    go build -o ($target_name) (ls **/main.go | get name | to text | str trim)
}
