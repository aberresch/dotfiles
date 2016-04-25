function usereport () {
  host=${1}
  now=$(date +"%Y%m%d-%H%M")
  tempfile=$(mktemp ${host}-${now}-XXXXX)
  ssh ${host} usereport.py > ${tempfile}

  mv ${tempfile} ${tempfile}.md
  echo ${tempfile}.md
  which open > /dev/null 2>&1
  if [[ $?==0 ]]; then
    open ${tempfile}.md
  fi
}

