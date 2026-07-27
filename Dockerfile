FROM node:22.22-alpine3.24 AS build
WORKDIR /opt/server
COPY package.json .
COPY *.js .

# this may add extra cache memory we can use multi satge build 
RUN npm install 

FROM node:22.22-alpine3.24
# make to normol user not root user
RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
WORKDIR /opt/server
EXPOSE 8080
LABEL project="roboshop"\
      components="catalogue"\
      created_by="chinna"
ENV MONGO=true\
    MONGO_URL="mongodb://mongodb:27017/catalogue" 
COPY --from=build /opt/server /opt/server  
RUN chown -R roboshop:roboshop /opt/server  
USER roboshop   
CMD ["server.js"]    
ENTRYPOINT ["node"]
