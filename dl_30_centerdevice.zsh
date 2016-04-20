if [[ "${DL_ENV}" == "vCD" ]]; then

  function cd_userInfo() {
          [[ -x /usr/bin/mongo ]] || return 2;
          local projection="{ _id: 0,
                              id: 1,
                              email: 1,
                              first_name: 1,
                              last_name: 1,
                              distributor: 1,
                              role: 1,
                              status: 1,
                              tenant: 1,
                              last_login: 1,
                              'upload_settings.email_upload_alias': 1
                            }"
          if [[ "${1}" = "-v" ]]; then
                  projection="{}"
                  shift;
          fi
          local userId="${1}"
          if [[ -z "$userId" ]]; then
                  echo "Usage: userInfo [-v] <userId|uploadId>"
                  return 1
          fi
          echo "db.user.findOne({ \$or:[ {\"id\":\"$userId\"}, {\"upload_settings.email_upload_alias\":\"$userId\"}]}, $projection )" | mongo --quiet --host node01 centerdevice-security
  }

  function cd_docInfo() {
    [[ -x /usr/bin/mongo ]] || return 2;
          local projection="{ _id: 0,
                              filename: 1,
                              mimetype: 1,
                              size: 1,
                              version: 1,
                              version_date: 1,
                              uploader: 1,
                              owner: 1
                            }"
          if [[ "${1}" = "-v" ]]; then
                  projection="{}"
                  shift;
          fi
          local docId="${1}"
          if [[ -z "$docId" ]]; then
                  echo "Usage: docInfo [-v] <documentId>"
                  return 1
          fi
          echo "db.metadata.findOne({\"id\":\"$docId\"}, $projection )" | mongo --quiet --host node01 centerdevice-metadata
  }

fi

