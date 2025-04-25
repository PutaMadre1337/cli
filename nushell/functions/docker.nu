def "docker pruneall" [] {
  ^docker stop (^docker ps -q)
  ^docker container prune -f
  ^docker system prune -f -a --volumes
}
