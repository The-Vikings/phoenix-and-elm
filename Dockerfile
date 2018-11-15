# ./Dockerfile

# Use an official Elixir runtime as a parent image
FROM elixir:1.7.4

RUN apt-get update && \
  apt-get install -y postgresql-client inotify-tools apt-transport-https

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
      && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
      && curl -sL https://deb.nodesource.com/setup_8.x | bash \
      && apt-get install -y nodejs yarn


# Create app directory and copy the Elixir projects into it
RUN mkdir /app
COPY . /app

WORKDIR /app

# Install hex package manager
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phx_new.ez

# Compile the project
RUN mix deps.get
RUN mix do compile

WORKDIR /app/assets
RUN npm install

WORKDIR /app/assets/leia-elm
RUN yarn global add elm@0.18

WORKDIR /app
CMD ["./entrypoint.sh"]
