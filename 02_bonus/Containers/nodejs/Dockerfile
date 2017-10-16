FROM alpine:3.5

RUN apk add --no-cache nodejs
RUN echo "license_key: ${NEW_RELIC_KEY}" | sudo tee -a /etc/newrelic-infra.yml
RUN curl https://download.newrelic.com/infrastructure_agent/gpg/newrelic-infra.gpg | sudo apt-key add -
RUN printf "deb [arch=amd64] https://download.newrelic.com/infrastructure_agent/linux/apt buster main" | sudo tee -a /etc/apt/sources.list.d/newrelic-infra.list

COPY package.json package.json

RUN npm install

COPY . .

ENTRYPOINT ["npm", "start"]