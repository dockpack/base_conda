FROM centos:centos7
MAINTAINER Bas Meijer <bas.meijer@me.com>

RUN mkdir -p /tmp/ansible/roles/conda_envs
RUN yum install -y epel-release && \
    yum install -y ansible && \
    yum clean all
COPY ./files/hosts /etc/ansible/hosts
ADD . /tmp/ansible/roles/base_conda
COPY ./molecule/shared/converge.yml /tmp/ansible/
RUN cd /tmp/ansible && ansible-playbook converge.yml
ENV PATH /opt/conda/envs/env/bin:$PATH
ENV LANG C.UTF-8
