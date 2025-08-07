# Use the official nginx image as a base
FROM nginx:alpine

# Copy the index.html file to the nginx default directory
COPY index.html /usr/share/nginx/html/

# The EXPOSE instruction indicates the ports on which a container listens for connections
# By default, nginx listens on port 80
EXPOSE 80

# No need to specify CMD or ENTRYPOINT as the nginx:alpine image already has this defined.
# When you run the container, nginx will start automatically and serve your index.html on port 80.
