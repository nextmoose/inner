ARG BASE_IMAGE=docker:18.03.1-ce-dind
FROM ${BASE_IMAGE}
COPY scripts /opt/scripts/
ENTRYPOINT ["sh", "/opt/scripts/entrypoint.sh"]
CMD ["up"]