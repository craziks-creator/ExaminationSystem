FROM richarvey/nginx-php-fpm:latest 
COPY . .


# Image config
ENV SKIP_COMPOSER 1
ENV WEBROOT /var/www/html/public
ENV PHP_ERRORS_STDERR 1
ENV RUN_SCRIPTS 1
ENV REAL_IP_HEADER 1

# Laravel config
ENV APP_ENV staging
ENV APP_DEBUG true
ENV LOG_CHANNEL stderr

# Allow composer to run as root
ENV COMPOSER_ALLOW_SUPERUSER 1
FROM node:alpine as build
WORKDIR /var/www/html/public
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build
CMD ["/start.sh"]
