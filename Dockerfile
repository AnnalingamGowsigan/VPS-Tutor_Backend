# Use the official Node.js 14 image
FROM node:14-alpine

# Create a working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install application dependencies
RUN npm install

# Copy the rest of the application files to the working directory
COPY . .

# Expose the port on which your application listens
EXPOSE 3000

# Start the application
CMD ["node", "index.js"]
