FROM ubuntu

RUN groupadd -r moro && useradd -r -g moro moro

RUN apt-get update && apt-get install -y \
    faketime \
    sqlite3 \
    nodejs \
    npm

ARG NODE_ENV=development
ENV NODE_ENV $NODE_ENV

RUN npm i npm@latest -g

WORKDIR /opt/app
COPY package.json package-lock.json* ./
RUN npm install

COPY . /opt/app

RUN npm link

CMD npm test