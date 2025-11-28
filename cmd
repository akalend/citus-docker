cat .git/`cat .git/HEAD | awk '{print $2}'`  # хеш текущего коммита
export commit=$(cat .git/`cat .git/HEAD | awk '{print $2}'` | cut -c 1-7)