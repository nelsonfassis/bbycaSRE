FROM node:8

WORKDIR /app
COPY . .
RUN npm install
EXPOSE 8080
CMD [ "node", "bestbuy.ca.js" ]
#CMD [ "/bin/bash"]


#docker run -p 80:80 -e ENV=PROD -e PORT=80 2f22ae2c0f36
