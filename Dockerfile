# Use the official Node.js 14 image
FROM node:14-alpine

# Create a new user with UID 10014
RUN addgroup -g 10014 choreo && \
    adduser  --disabled-password  --no-create-home --uid 10014 --ingroup choreo choreouser

VOLUME /tmp

USER 10014

# Copy package.json and package-lock.json to the working directory
COPY --chown=choreouser:choreo package*.json ./

# Install application dependencies
RUN npm install

# Expose the port on which your application listens
EXPOSE 3000

# Start the application
CMD ["node", "index.js"]
