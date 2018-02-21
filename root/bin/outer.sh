#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        --outer)
            OUTER=true &&
                shift
        ;;
        --docker-semver)
            export DOCKER_SEMVER="${2}" &&
                shift 2
        ;;
        --browser-semver)
            export BROWSER_SEMVER="${2}" &&
                shift 2
        ;;
        --middle-semver)
            export MIDDLE_SEMVER="${2}" &&
                shift 2
        ;;
        --inner-semver)
            export INNER_SEMVER="${2}" &&
                shift 2
        ;;
        *)
            echo Unsupported Option &&
                echo ${0} &&
                echo ${@} &&
                exit 64
        ;;
    esac
done &&
    if [ ${OUTER} == true ]
    then
        sudo \
            /usr/bin/docker \
            container \
            run \
            --interactive \
            --tty \
            --rm \
            --label expiry=$(date --date "now + 1 month" +%s) \
            --volume /var/run/docker.sock:/var/run/docker.sock:ro \
            rebelplutonium/outer:0.0.0 \
                --project-name outer \
                --user-name "${USER_NAME}" \
                --user-email "${USER_EMAIL}" \
                --gpg-secret-key "${GPG_SECRET_KEY}" \
                --gpg2-secret-key "${GPG2_SECRET_KEY}" \
                --gpg-owner-trust "${GPG_OWNER_TRUST}" \
                --gpg2-owner-trust "${GPG2_OWNER_TRUST}" \
                --gpg-key-id "${GPG_KEY_ID}" \
                --secrets-organization "${SECRETS_ORGANIZATION}" \
                --secrets-repository "${SECRETS_REPOSITORY}"
    else
        sudo \
            /usr/bin/docker \
            container \
            run \
            --interactive \
            --tty \
            --rm \
            --label expiry=$(date --date "now + 1 month" +%s) \
            --volume /var/run/docker.sock:/var/run/docker.sock:ro \
            rebelplutonium/outer:0.0.0 \
                --project-name outer \
                --user-name "${USER_NAME}" \
                --user-email "${USER_EMAIL}" \
                --gpg-secret-key "${GPG_SECRET_KEY}" \
                --gpg2-secret-key "${GPG2_SECRET_KEY}" \
                --gpg-owner-trust "${GPG_OWNER_TRUST}" \
                --gpg2-owner-trust "${GPG2_OWNER_TRUST}" \
                --gpg-key-id "${GPG_KEY_ID}" \
                --secrets-organization "${SECRETS_ORGANIZATION}" \
                --secrets-repository "${SECRETS_REPOSITORY}"
    fi