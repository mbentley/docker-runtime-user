#!/bin/sh

set -e

# if not running as root (e.g. `docker run --user`), we can't modify the user; just run the command
if [ "$(id -u)" != "0" ]
then
  echo "INFO: Not running as root; skipping user setup and running as $(id -u):$(id -g)"
  exec "${@}"
fi

# use the specified UID/GID for the user or default to 1000
PUID="${PUID:-1000}"
PGID="${PGID:-1000}"

# make sure the UID/GID are numeric
for ID in "${PUID}" "${PGID}"
do
  case "${ID}" in
    ''|*[!0-9]*)
      echo "ERROR: PUID and PGID must be numeric (PUID=${PUID}, PGID=${PGID})"
      exit 1
      ;;
  esac
done

# warn if the user would be root-equivalent
if [ "${PUID}" = "0" ] || [ "${PGID}" = "0" ]
then
  echo "WARN: PUID or PGID is set to 0; myapp will run with root privileges"
fi

# update the group's GID if it doesn't match (-o allows a non-unique GID)
if [ "$(id -g app)" != "${PGID}" ]
then
  echo "INFO: Setting GID of group 'app' to ${PGID}"
  groupmod -o -g "${PGID}" app
fi

# update the user's UID if it doesn't match (-o allows a non-unique UID)
if [ "$(id -u app)" != "${PUID}" ]
then
  echo "INFO: Setting UID of user 'app' to ${PUID}"
  usermod -o -u "${PUID}" app
fi

# make sure the home directory matches the UID/GID (groupmod doesn't update file ownership)
if [ "$(stat -c %u:%g /home/app)" != "${PUID}:${PGID}" ]
then
  chown -R app:app /home/app
fi

# make the directories needed to run my app
mkdir -p /opt/myapp

# change ownership of any directories needed to run my app; only when it doesn't already match to avoid a slow recursive chown on every start
if [ "$(stat -c %u:%g /opt/myapp)" != "${PUID}:${PGID}" ]
then
  echo "INFO: Updating ownership of /opt/myapp to ${PUID}:${PGID}"
  chown -R app:app /opt/myapp
fi

# start myapp
echo "INFO: Running myapp as app:app (${PUID}:${PGID})"

# exec and run the actual process specified in the CMD of the Dockerfile (which gets passed as ${*})
exec gosu app "${@}"
