#!/usr/bin/env bash
### @File   : git-build.sh
### @Author : Luke Penrod - support@deepinthought.io
### @Company : DeepInThought
### @Link   : https://deepinthought.io
### @Created   : Saturday,September 29 2018 11:26:22
### @Modified : Saturday,September 29 2018 15:21:16
###-

echo -e "\\033[0;32mDeploying updates to GitHub...\\033[0m"
export ROOT_PATH="${HOME}/Documents"
export GIT_LOCAL_PATH="${ROOT_PATH}/vscode-shell-snippets"
export GIT_REPOSITORY="https://github.com/DeepInThought/vscode-shell-snippets.git"
export GIT_RAW_TEST="https://raw.githubusercontent.com/DeepInThought/vscode-shell-snippets/master/README.md"
export ERROR_CODE=

__username="$(whoami)"
__dir="$(cd "$(dirname "${HOME}"/"${__username}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename "${__file}" .sh)"
__with_extension="${__base}.sh"

# todo: create a functions file.
handle_exit_code() {
	ERROR_CODE="$?"
	if [ "${ERROR_CODE}" = "0" ]; then
		printf -- '\033[32m [SUCCESS]: %s \033[0m\n' "${deepMsg:-${__with_extension}}"
		printf -- '\033[32m [FINISHED] without errors. \033[0m\n'
		printf -- '\033[32m [EXIT] with status code %s.\033[0m\n' "${ERROR_CODE}"
		exit ${ERROR_CODE}
	fi
	if [ "${ERROR_CODE}" = "1" ]; then
		printf -- '\033[31m [ERROR CODE %s]: ERROR_CODE %s is related to Git repositories.\033[0m\n' ${ERROR_CODE} ${ERROR_CODE}
		printf -- '\033[31m [EXIT] with status code %s.\033[0m\n' "${ERROR_CODE}"
		exit ${ERROR_CODE}
	fi
	if [ "${ERROR_CODE}" = "2" ]; then
		printf -- '\033[31m [ERROR CODE %s]: ERROR_CODE %s primary to echo call failed.\033[0m\n' ${ERROR_CODE} ${ERROR_CODE}
		printf -- '\033[31m [EXIT] with status code %s.\033[0m\n' "${ERROR_CODE}"
		exit ${ERROR_CODE}
	fi
	# ...
	if [ "${ERROR_CODE}" != "0" ]; then
		printf -- '\033[31m [ERROR CODE %s]: ERROR_CODE %s is not defined yet.\033[0m\n' ${ERROR_CODE} ${ERROR_CODE}
		printf -- '\033[31m [EXIT] with status code %s.\033[0m\n' "${ERROR_CODE}"
		exit ${ERROR_CODE}
	fi
	printf -- '\033[31m [ERROR] occurred.  Cleaning up now...\033[0m\n'
	### Cleanup
	printf -- '\033[33m [CLEAN]: Cleaning exit properly.\n\033[31m [EXIT] with error code %s.\n' "${ERROR_CODE}"
	exit "${ERROR_CODE}"
}
trap "handle_exit_code" EXIT

# todo: Setup git credential fill
### $(git credential fill \
###    protocol=https \
###    host="$GIT_REPOSITORY" \
###    username=deepinthought \
###    password="$GITHUB_PASSWORD" \
###    )

if [ ! "${GIT_RAW_TEST}" ]; then
	echo "[Testing]: ${GIT_RAW_TEST} exists."
	curl "${GIT_RAW_TEST}" || echo || exit 2
	printf -- '\033[32m [SUCCESS]: %s \033[0m\n' ${GIT_RAW_TEST}
	sleep 1
fi
if [ ! -d "${GIT_LOCAL_PATH}" ]; then
	echo "[GIT_RAW_TEST]: Not Setup! ${GIT_RAW_TEST}"
	git clone "${GIT_REPOSITORY}" || echo || exit 2
	printf -- '\033[32m [SUCCESS]: %s \033[0m\n' "${GIT_LOCAL_PATH}"
	sleep 1
fi
if [ $# -eq 1 ]; then
	GIT_COMMIT_MSG=$1
	${GIT_REPOSITORY:-'https://github.com/DeepInThought/vscode-shell-snippets.git'}
	echo "[Git Comment]: ${GIT-GIT_COMMIT_MSG}"
	echo "[Git Repository]: ${GIT_REPOSITORY}"
	git commit -m "${GIT_COMMIT_MSG}" || printf -- '\033[31m [EXIT] with status code %s.\033[0m\n' ${ERROR_CODE:-1} || exit 1
	printf -- '\033[32m [Git Commit]: [FINISHED] without errors. \033[0m\n'
fi
if [ $# -eq 2 ]; then
	GIT_COMMIT_MSG="[Git Commit]: at $(date --rfc-3339=seconds)"
	echo "[Git Comment]: ${GIT_COMMIT_MSG}"
	echo "[Git Commit]: at $(date --rfc-3339=seconds)"
	git commit -m "${GIT_COMMIT_MSG}" || printf -- '\033[31m [EXIT] with status code %s.\033[0m\n' ${ERROR_CODE:-2} || exit 1
	printf -- '\033[32m [Git Commit]: [FINISHED] without errors. \033[0m\n'
else
	GIT_COMMIT_MSG="[Git Commit]: at $(date --rfc-3339=seconds)"
	echo "[Auto]: Setting GIT_COMMIT_MSG to ${GIT_COMMIT_MSG}"
	printf -- '\033[32m [Git Commit]: [FINISHED] without errors. \033[0m\n'
fi


if [ -d "${GIT_LOCAL_PATH}" ]; then
	cd "${GIT_LOCAL_PATH}" || echo "Current Dir: $PWD" || exit 2
	printf -- '\033[32m [SUCCESS]: %s \033[0m\n' "${GIT_LOCAL_PATH}"

	### Setup for commit.
	git add . || echo || exit 1
	printf -- '\033[32m [SUCCESS]: git add . \033[0m\n'

	### Commit changes.
	git commit -m "${GIT_COMMIT_MSG}" || printf -- '\033[31m [EXIT] with status code %s.\033[0m\n' ${ERROR_CODE:-1} || exit 1
	printf -- '\033[32m [SUCCESS]: git commit -m \033[0m\n'

	### Push code to Repository
	git push origin master || printf -- '\033[31m [EXIT] with status code %s.\033[0m\n' ${ERROR_CODE:-1} || exit 1
	printf -- '\033[32m [SUCCESS]: git push origin master \033[0m\n'

fi
