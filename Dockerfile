FROM gcr.io/cloud-builders/gcloud
WORKDIR /
RUN gcloud components update --quiet
RUN apt-get update && apt-get install python3 python3-pip -y
RUN curl -s https://api.github.com/repos/kubeflow/kubeflow/releases/latest | \
    grep browser_download | \
    grep linux | \
    cut -d '"' -f 4 | \
    xargs curl -O -L
RUN tar -zvxf kfctl_*_linux.tar.gz
RUN mv kfctl /usr/local/bin
RUN rm kfctl_*_linux.tar.gz
RUN chmod 755 /usr/local/bin/kfctl /usr/local/bin/kubectl
