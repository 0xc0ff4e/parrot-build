function tunIP(){
    if [ $(ip a | grep "tun0" | wc -l ) -gt 0 ]; then
      hostname -I | awk '{print $2}'  
    fi
}


### FFUF ### 
function ffvhost(){
  # ffvhost host; ffvhost HOST -fw 123
  HOST=$1; shift 
  
  ffuf -i -c \
  -w /opt/SecLists/Discovery/DNS/subdomains-top1million-5000.txt \
  -u http://$HOST.htb \
  -H "Host: FUZZ.$HOST.htb" \
  $@ 
}
export -f ffvhost

function ffdir(){
  HOST=$1; shift
  ffuf -i -c \
  -w /opt/SecLists/Discovery/Web-Content/raft-small-words-lowercase.txt \
  -u http://$HOST.htb/FUZZ \
  $@
}
export -f ffdir

function ffdirm(){
  HOST=$1; shift
  ffuf -i -c \
  -w /opt/SecLists/Discovery/Web-Content/raft-medium-words-lowercase.txt \
  -u http://$HOST.htb/FUZZ \
  $@
}
export -f ffdirm


### Fuzzy ### 
function fzf-wordlists(){
  find /opt/SecLists/ -type f | grep -vE ".git|.bin" | fzf
}
export -f fzf-wordlists
# example:
# ffuf -i -c -w `fzf-wordlists` -u http://box.htb

function fzls(){
  ls ${1:-.} | fzf 
}
export -f fzls

function fzll(){
  ls -lah ${1:-.} | fzf | awk '{print $NF}'
}
export -f fzll

function fzcat(){
  fzll ${1:-.} | xargs printf -- "${1:-.}/%s" | xargs cat
}
export -f fzcat

function fznano(){
  fzll ${1:-.} | xargs printf -- "${1:-.}/%s" | xargs nano
}
export -f fznano

function fzhist(){
  
  local cmd=$( history | awk '{for (i=2; i<NF; i++) printf $i " ";print $NF}' | fzf )
  echo $cmd
  eval $cmd
}
###


### Simple Helpers ### 
function urlencode(){
  python -c "import urllib.parse; print(urllib.parse.quote_plus(\"$1\"))"
}
export -f urlencode

function docker(){
  podman $*
}
export -f docker

function urldecode(){
  python -c "from urllib.parse import unquote; print(unquote(\"$1\"))"
}
export -f urldecode
###

### HTB ## 
function htb_env(){
  local ip
  local domain
  local dc_ip
  
  read -p "Enter Box IP: " ip
  read -p "Enter Box Domain: (eg box.htb)" domain
  read -p "Enter Box DomainController Hostname: (eg dc01.box.htb)" dc_ip
  
  export IP=$ip
  export DOMAIN=$domain
  export DC_IP=$dc_ip
}

function htb_bloodyAD(){
  if [[ -z $IP ]]; then
    echo "use htb_env first" 
    return 1 
  fi
  
  bloodyAD/.venv/bin/bloodyAD -d "$DOMAIN" --host "$DC_IP" "$@"
  return $?
}

function htb_certipy(){
  if [[ -z $IP ]]; then
    echo "use htb_env first"
    return 1
  fi

  local cmd=$1
  shift 
  certipy "$cmd" -dc-ip "$DC_IP" -ns $IP "$@"
  return $?
}
###
