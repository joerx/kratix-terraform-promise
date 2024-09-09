FROM "mikefarah/yq:4"

RUN [ "mkdir", "/tmp/transfer" ]

USER root
RUN apk --no-cache add uuidgen

USER yq
ADD workspace.yaml /tmp/transfer/workspace.yaml
ADD providerconfig.yaml /tmp/transfer/providerconfig.yaml
ADD execute-pipeline execute-pipeline

CMD [ "sh", "-c", "./execute-pipeline"]
ENTRYPOINT []
