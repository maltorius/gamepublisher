FROM node:8
RUN npm install express typescript tslint @types/node @types/express
COPY . .
RUN npm run build
CMD npm run start
