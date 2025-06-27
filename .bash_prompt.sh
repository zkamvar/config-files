function color_my_prompt { 
    local __user_and_host="\[\033[01;32m\]\u@\h"
    local __cur_location="\[\033[01m\]\t \w"
    local __prompt_tail="$"
    local __last_color="\[\033[00m\]"

    local RED="\[\033[0;31m\]"
    local YELLOW="\[\033[0;33m\]"
    local LPURPLE="\[\033[0;35m\]"
    local GREEN="\[\033[0;32m\]"
    local LBLUE="\[\033[0;34m\]"

    local git_status
    local git_stash
    local git_branch
    git_branch=$(git symbolic-ref HEAD --short 2> /dev/null)
    if [[ -n "${git_branch}" ]]
    then
      git_branch="(${git_branch})"
    fi
    # Capture the output of the "git status" command.
    git_status="$(git status 2> /dev/null)"
    # Counting how many stashes exist
    git_stash="$(git stash list 2> /dev/null | wc -l | xargs)"

    # Set color based on clean/staged/dirty.
    local state
    if [[ ${git_status} =~ "othing to commit" ]]; then
	      state="${LBLUE}"
    elif [[ ${git_status} =~ "Changes to be committed" ]]; then
	      state="${LPURPLE}"
    else
        state="${RED}"
    fi

    # collect the number of commits ahead or behind origin
    local sym
    sym=$(echo "${git_status}" \
      | tr -d '\n' \
      | sed -E 's/^.*by[[:blank:]]([0-9]*)[[:blank:]]commit.*$/\1/' \
      | grep '[0-9]' 2> /dev/null
    )

    # add marker for origin status with number of commits ahead (+) or behind (-)
    if [[ ${git_status} =~ "branch is ahead of" ]]; then
        sym="[+${sym}]"
    elif [[ ${git_status} =~ "branch is behind" ]]; then
        sym="[-${sym}]"
    elif [[ ${git_status} =~ "HEAD detached at" ]]; then
        git_branch=$(echo "${git_status}" \
          | tr -d '\n' \
          | sed -E 's/HEAD detached at ([^ ]+).*$/(🙃HEAD @ \1)/' 2> /dev/null
        )
        sym=""
    else
        sym=""
    fi
    # add marker for the state of the git stash
    local stash=""
    if [[ ! ${git_stash} -eq 0 ]]; then
        stash="{📦${git_stash}}"
    fi

    export PS1="${__cur_location}\n${state}${git_branch}${sym}${stash}${__last_color}${__prompt_tail} "
}
# Tell bash to execute this function just before displaying its prompt.
PROMPT_COMMAND=color_my_prompt
