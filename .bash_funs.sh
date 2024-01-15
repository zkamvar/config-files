#! /bin/env bash
# Copy the bibtex entry for a given DOI
#
# example: 
# $ doi 10.7717/peerj.4152
function doi(){ curl -LH "Accept: text/bibliography; style=bibtex" "http://doi.org/$1" \
| sed -r -e 's/([^A-Za-z]), /\1,\n/g'                                                  \
| (xclip -selection clipboard 2> /dev/null || pbcopy); }
export -f doi

# shruggie
# Source: https://twitter.com/climagic/status/672862397015658496
function shrug(){ echo -n "¯\_(ツ)_/¯"    \
| (xclip -selection clipboard 2> /dev/null || pbcopy); echo "¯\_(ツ)_/¯ copied to your clipboard"; }
export -f shrug

# strollie
function stroll(){ echo -n "ᕕ( ᐛ )ᕗ"      \
| (xclip -selection clipboard 2> /dev/null || pbcopy); echo "ᕕ( ᐛ )ᕗ copied to your clipboard"; }
export -f stroll

# flippy
function flip(){ echo -n "(╯°□°）╯︵ ┻━┻" \
| (xclip -selection clipboard 2> /dev/null || pbcopy); echo "(╯°□°）╯︵ ┻━┻ copied to your clipboard"; }
export -f flip

# clone high reference
function jkl { echo -n "(屮ﾟДﾟ)屮"        \
| (xclip -selection clipboard 2> /dev/null || pbcopy); echo "(屮ﾟДﾟ)屮 copied to your clipboard"; }
export -f jkl

# ಠ_ಠ
function concern { echo -n "ಠ_ಠ"          \
| (xclip -selection clipboard 2> /dev/null || pbcopy); echo "ಠ_ಠ copied to your clipboard"; }
export -f concern

# quick way to view csv files
function csv { column -s, -t < "$1" | less -#2 -N -S; }
export -f csv

# template for a notes repository
function getnotes { curl -L https://api.github.com/repos/zkamvar/notes-template/tarball \
| tar --strip-components=1 -xzv \
--exclude=README.md \
--exclude=LICENSE \
--exclude=flow.png \
--exclude=.gitignore; }
export -f getnotes

# set theme
function theme() { 
  kitty +kitten themes
  if [[ $(black_cat) -eq 0 ]]; then
    export BAT_THEME="Zenburn"
  else
    export BAT_THEME="Monokai Extended Light"
  fi
}
export -f theme

function black_cat () {
  local bg
  bg=$( kitty @ --to="${KITTY_LISTEN_ON}" get-colors | grep '^background' | awk '{print $2}' )
  echo "$( luminance "${bg}" ) > 0.228" | bc -l
}
export -f black_cat

# https://stackoverflow.com/a/56678483/2752888
function luminance () {
  local hex="${1/\#/}" # remove leading hash
  local r g b
  r=$( sRGBtoLIN "${hex:0:2}" )
  g=$( sRGBtoLIN "${hex:2:2}" )
  b=$( sRGBtoLIN "${hex:4:2}" )
  echo "${r} * 0.2126 + ${g} * 0.7152 + ${b} * 0.0722" | bc -l
}
export -f luminance


function sRGBtoLIN () {
  # convert hex to decimal
  local in=$((16#${1}))
  # convert to fraction
  local v
  v=$( echo "${in}/255" | bc -l )
  # linearize based on perception threshold.
  local thresh
  thresh=$( echo "${v} < 0.04045" | bc -l )
  if [ "${thresh}" -eq 1 ]; then
     v=$(echo "${v}/12.92" | bc -l)
  else
     # bc gives a weird warning of "non-zero scale in exponent" when trying to
     # parse a decimal or negative exponent. The solution is:
     #
     # e(l(2) * 2.5) == 2^2.5
     #
     # I would link the page I got it from but yeesh, there was a banner that
     # was espousing conspiracy theories
     v=$( echo "e(l((${v} + 0.055)/1.055) * 2.4)" | bc -l )
  fi
  echo "$v"
}
export -f sRGBtoLIN

# Provide an interface to toggle VPN on and off.
function vpn () {

  local switch="${1:-none}"
  local con="${2:-none}"
  local active
  active=$( vpn_active )

  # cli switching on of VPN: https://askubuntu.com/a/57409/853075
  # disabling ipv6 on linux: https://support.vyprvpn.com/hc/en-us/articles/360038553552-How-do-I-disable-IPv6-on-Linux-
  case "${switch}" in 
    "none"|"list"|"help")
      echo "Connect to a VPN network and disable IPv6 defaults"
      echo "=================================================="
      echo
      echo "A lot of VPN managers do not support IPv6, which causes your IPv6"
      echo "address to be exposed to entities like Google, so it's necessary"
      echo "to disable the IPv6 defaults before turning on a VPN."
      echo
      echo "Use <https://test-ipv6.com/simple_test.html> to test that IPv6 is"
      echo "disabled after turning on the VPN."
      echo
      echo "Usage:"
      echo 
      echo "vpn [on|off|list|help] [NAME]"
      echo
      echo "Arguments:"
      echo 
      echo "  on|off|list|help  turn the vpn on, off, or print help with"
      echo "                    a list of available networks and exit"
      echo "  NAME              name of the VPN to use"
      echo 
      echo "Examples:"
      echo
      echo '  vpn                  # Show a list of available VPN networks'
      echo '  vpn on               # Select a VPN network to activate'
      echo '  vpn off              # Close the current VPN connection'
      echo '  vpn on Seattle       # Turn on the Seattle VPN'
      echo '  vpn on "South Korea" # Turn on the South Korea VPN'
      echo
      vpn_status "${active}"
      echo "----------- Available VPN networks -----------"
      echo 
      vpn_list | awk -F '  ' '{print NR") "$1}'
      echo 
      echo "-----------------------------------------------"
      return 0
      ;;
    # Turning on the VPN we have to check that a connection is available
    # choose_vpn will search the available connections and 
    "on")
      con=$( vpn_choose "${con}" )
      echo "Connecting to ${con} vpn..."
      sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1 \
      && sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1 \
      && sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1
      nmcli con up id "${con}"
      return 0
      ;;

    "off")
      sudo sysctl -w net.ipv6.conf.all.disable_ipv6=0 \
      && sudo sysctl -w net.ipv6.conf.default.disable_ipv6=0 \
      && sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=0
      if [ -z "${active}" ]
      then
        echo "not connected to vpn"
        return 0
      else
        echo "switching off ${active} ..."
        nmcli con down id "${active}"
        return 0
      fi
      ;;

    *)
      echo "VPN command not found: ${switch}"
      ;;
  esac
}
export -f vpn

# choose a specific VPN 
function vpn_choose () {

  local connections
  local declared="${1:-none}"
  # https://www.baeldung.com/linux/reading-output-into-array
  readarray -t connections < <(vpn_list)

  if containsElement "${declared}" "${connections[@]}"
  then
    echo "${declared}"
    return 0
  fi

  # https://linuxize.com/post/bash-select/
  select con in "${connections[@]}":
  do
    echo "${con}"
    return 0
  done

}

# List all the VPN connections
vpn_list () {
  nmcli -f NAME,TYPE con show \
  | grep 'vpn\s*$' \
  | awk -F '  ' '{print $1}'
}

# show the active connection name or fail 
vpn_active () {
  local active
  active=$(nmcli -f NAME,TYPE con show --active \
    | grep 'vpn\s*$' \
    | awk -F'  ' '{print $1}'
  )
  if [[ $active != "" ]] 
  then
    echo "${active}"
    return 0
  fi
  return 1
}

vpn_status () {
  local active="${1}"
  local __END="\033[00m"
  local RED__="\033[0;31m"
  local LBLUE__="\033[0;34m"
  local LPURPLE__="\033[0;35m"
  echo
  if [[ -z "${active}" ]]
    then
      echo -e "VPN status: ${RED__}OFF${__END}"
  else
    echo -e "VPN status:   ${LBLUE__}ON${__END}"
    echo -e "Connected to: ${LPURPLE__}${active}${__END}"
  fi
  echo

}

# https://stackoverflow.com/a/8574392
# 
# Returns success if the element exists in an array, a failure otherwise
#
# containsElement <element> <array>
containsElement () {
  set +e
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}


