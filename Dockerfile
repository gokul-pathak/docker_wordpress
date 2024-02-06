# Use the official Nginx image
FROM nginx:latest

# Copy custom Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Expose ports
EXPOSE 80 443
