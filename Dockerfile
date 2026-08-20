FROM nginx:alpine

ARG ENVIRONMENT=DEV

RUN echo "${ENVIRONMENT} DEPLOYMENT" > /usr/share/nginx/html/index.html

EXPOSE 80