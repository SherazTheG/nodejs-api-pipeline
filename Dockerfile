# Use an official Node.js runtime as a parent image
# We use 'alpine' as it's a very small and secure version
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json first
# This takes advantage of Docker's layer caching.
# If these files don't change, Docker won't re-run 'npm install'
COPY package*.json ./

# Install the application's dependencies
RUN npm install

# Copy the rest of your application's source code
COPY . .

# Tell Docker that your app runs on port 3000
EXPOSE 3000

# The command to run your application
CMD [ "npm", "start" ]