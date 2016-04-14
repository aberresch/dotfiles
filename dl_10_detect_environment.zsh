PROMPT_PREFIX=""
# Check for Environment
ifconfig | grep 10.102 > /dev/null
[[ $? == 0 ]] && DL_ENV="CLUSTER_B"
ifconfig | grep 10.103 > /dev/null
[[ $? == 0 ]] && DL_ENV="CLUSTER_C"
ifconfig | grep 192.168.205 > /dev/null
[[ $? == 0 ]] && DL_ENV="vCD"

case $DL_ENV in
  CLUSTER_B)
    PROMPT_PREFIX="B|"
    DL_ZSH_GIT_PROMPT=false
    ;;
  CLUSTER_C)
    PROMPT_PREFIX="C|"
    DL_ZSH_GIT_PROMPT=false
    ;;
  vCD)
    PROMPT_PREFIX="vCD|"
    DL_ZSH_GIT_PROMPT=false
    ;;
esac

