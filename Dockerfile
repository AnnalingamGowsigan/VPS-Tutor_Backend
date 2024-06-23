# Use the official Node.js 14 image
FROM node:14-alpine

# Create a new user with UID 10001 (within the specified range)
RUN addgroup -g 10001 choreo && \
    adduser --disabled-password --no-create-home --uid 10001 --ingroup choreo choreouser

# Create a working directory and set permissions
WORKDIR /usr/src/app
RUN chown choreouser:choreo /usr/src/app

# Switch to the non-root user
USER choreouser

# Copy package.json and package-lock.json to the working directory
COPY --chown=choreouser:choreo package*.json ./

# Install application dependencies
RUN npm install

# Copy the rest of the application files to the working directory
COPY --chown=choreouser:choreo . .

# Expose the port on which your application listens
EXPOSE 3000

# Start the application
CMD ["node", "index.js"]
