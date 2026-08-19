FROM nginx:alpine

RUN echo "Parameterized Jenkins Deployment" > /usr/share/nginx/html/index.html

EXPOSE 80