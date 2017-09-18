# Select Ubuntu as the base image
FROM ubuntu:14.04
ARG ruby_version=2.3.5

MAINTAINER Zesty

# Update Apt
RUN apt-get -y update
RUN apt-get -y install curl git-core python-software-properties

# Install essentials
RUN apt-get -y install build-essential
RUN apt-get install -y -q git
RUN apt-get install -y libssl-dev
RUN apt-get install -y libreadline-dev
RUN apt-get install -y libpq-dev
RUN apt-get install -y postgresql-client
RUN apt-get install -y libfontconfig
RUN apt-get install -y libxrender1

# Install phantomjs
RUN curl --output /tmp/phantomjs https://s3.amazonaws.com/circle-downloads/phantomjs-2.1.1
RUN chmod ugo+x /tmp/phantomjs
RUN ln -sf /tmp/phantomjs /usr/local/bin/phantomjs

# Install rbenv
RUN git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv
RUN echo '# rbenv setup' > /etc/profile.d/rbenv.sh
RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh
RUN echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN chmod +x /etc/profile.d/rbenv.sh

# install ruby-build
RUN mkdir /usr/local/rbenv/plugins
RUN git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build

ENV RBENV_ROOT /usr/local/rbenv
ENV PATH $RBENV_ROOT/bin:$RBENV_ROOT/shims:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN rbenv install $ruby_version
RUN rbenv global $ruby_version
RUN gem install bundler

# De-escalate privileges
RUN useradd -m zesty && echo "zesty:zesty" | chpasswd && adduser zesty sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER zesty
