FROM phusion/baseimage:latest

# Set correct environment variables.
ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 DEBIAN_FRONTEND=noninteractive JAVA_HOME=/usr/lib/jvm/java-8-oracle

# Install sane locale and updates
RUN locale-gen en_US.UTF-8 && \
    # Java8
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true \
        | debconf-set-selections && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get -qq update && \
    apt-get install -y oracle-java8-installer && \

    # Clean up APT when done.
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ONBUILD ADD ./runit /etc/service/events

# default, run runit and various goodies
CMD ["/sbin/my_init"]

VOLUME ["/var/log"]
VOLUME ["/app"]