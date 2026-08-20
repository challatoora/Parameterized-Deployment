FROM nginx:alpine

ARG ENVIRONMENT=UNKNOWN

RUN echo "================================" > /usr/share/nginx/html/index.html && \
    echo "   PARAMETERIZED DEPLOYMENT" >> /usr/share/nginx/html/index.html && \
    echo "================================" >> /usr/share/nginx/html/index.html && \
    echo "" >> /usr/share/nginx/html/index.html && \
    echo "Environment: ${ENVIRONMENT}" >> /usr/share/nginx/html/index.html && \
    echo "Deployment: SUCCESS" >> /usr/share/nginx/html/index.html

EXPOSE 80