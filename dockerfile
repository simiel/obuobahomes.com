FROM nginx:alpine

# Copy the website files to the Nginx HTML directory
COPY . /usr/share/nginx/html/

# Nginx runs on port 80 by default
EXPOSE 80