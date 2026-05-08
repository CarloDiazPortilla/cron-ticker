FROM --platform=$BUILDPLATFORM node:20-alpine

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

RUN npm run test

RUN rm -rf tests && rm -rf node_modules

RUN npm install --prod

CMD [ "node", "app.js" ]