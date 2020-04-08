FROM gcr.io/cloud-builders/gcloud
WORKDIR /
RUN gcloud components update --quiet
RUN curl -s https://api.github.com/repos/kubeflow/kubeflow/releases/latest | \
    grep browser_download | \
    grep linux | \
    cut -d '"' -f 4 | \
    xargs curl -O -L
RUN tar -zvxf kfctl_*_linux.tar.gz
RUN mv kfctl /usr/local/bin
RUN rm kfctl_*_linux.tar.gz
RUN echo $(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt) > stable.txt
RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(cat stable.txt)/bin/linux/amd64/kubectl"
RUN mv kubectl /usr/local/bin
RUN chmod 755 /usr/local/bin/kfctl /usr/local/bin/kubectl
RUN pip3 install kfp kfp-server-api --upgrade
