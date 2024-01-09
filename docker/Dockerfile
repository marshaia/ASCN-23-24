FROM ubuntu:22.04

# Set default variable values
ENV DB_HOST=bla \
    DB_CONNECTION=mysql \
    DB_DATABASE=bla \
    DB_PASS=bla \
    DB_USER=bla \
    SEED=true
# Install basic packages and update
RUN apt-get update && \
    apt-get install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update

# Install dependencies
RUN apt-get install -y php8.2 \
    php8.2-common \
    php8.2-mbstring \
    php8.2-mysql \
    php8.2-xml \
    php8.2-curl \
    default-mysql-client \
    composer \
    npm

# Clone laravel.io repository
RUN git clone https://github.com/laravelio/laravel.io.git

# Change working directory
WORKDIR /laravel.io

# Use version X.X.X of laravelio
RUN git reset --hard f4970ad

# Install dependencies from the composer.lock
RUN composer install

# Create .env file with the correct values on the variables:
# DB_PASSWORD;DB_HOST;DB_USERNAME;DB_DATABASE;DB_CONNECTION
RUN sed -i 's/DB_PASSWORD=password/DB_PASSWORD=${DB_PASS}/' .env.example
RUN sed -i '/^DB_PASSWORD=/a DB_HOST=${DB_HOST}' .env.example
RUN sed -i '/^DB_HOST=/a DB_CONNECTION=${DB_CONNECTION}' .env.example
RUN sed -i '/^DB_CONNECTION=/a DB_DATABASE=${DB_DATABASE}' .env.example
RUN sed -i 's/DB_USERNAME=root/DB_USERNAME=${DB_USER}/' .env.example
RUN mv .env.example .env

# Application setup
# Generate app key
RUN php artisan key:generate
# Install node modules and dependencies with node and vite <__LIFE_LESSON__--->__SPECIFIED_VERSIONS__<---__LIFE_LESSON__>
RUN npm install node@18.0.0 vite@4.5.0
# Build app for production
RUN npm run build

# Copy script to migrate and seed (if specified)
COPY run_script.sh run_script.sh

# Grant executing permission
RUN chmod u+x run_script.sh

# Expose port 80 of the container
EXPOSE 80

# Command to execute when running the container
CMD ./run_script.sh
