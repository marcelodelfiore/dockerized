from ruby:3.2.2

RUN apt update
RUN apt upgrade -y
RUN apt install lsb-base lsb-release

RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

RUN apt update \
    && apt install -y libpq-dev \
                      vim \
                      htop \
                      postgresql-14

RUN gem install pg

ADD . /home/app/web
WORKDIR /home/app/web

RUN bundle install --jobs 5 --retry 5
