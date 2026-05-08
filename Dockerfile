FROM --platform=$BUILDPLATFORM node:20-alpine AS deps
# FROM --platform=$BUILDPLATFORM node:20-alpine

WORKDIR /app

COPY package*.json ./

RUN npm ci



FROM --platform=$BUILDPLATFORM node:20-alpine AS builder

WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules

COPY . .

RUN npm run test

# RUN npm run build

FROM --platform=$BUILDPLATFORM node:20-alpine AS prod-deps

WORKDIR /app

COPY --from=builder /app/package*.json ./

RUN npm ci --omit=dev


FROM node:20-alpine AS runner

WORKDIR /app

COPY --from=builder /app/app.js ./

COPY --from=builder /app/tasks ./tasks

COPY --from=prod-deps /app/node_modules ./node_modules


CMD [ "node", "app.js" ]