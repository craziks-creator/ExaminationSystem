
FROM node:alpine as build
WORKDIR /var/www/html/public
COPY package.json package-lock.json ./
RUN npm install
COPY . .


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
# Copy application code to the container
COPY . /var/www/html/public

# Copy pre-built frontend assets from local "assets" directory to the container
COPY manifest.json/ /var/www/html/public/

# Copy Node.js dependencies from the build container
COPY --from=build /var/www/html/public/node_modules/ /var/www/html/public/node_modules/
CMD ["/start.sh"]

