# Stage 1: Build the application
FROM node:lts as builder

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy the rest of the application code
COPY . .

# Stage 2: Create a lightweight image to run the application
FROM node:14-alpine

# Set the working directory in the container
WORKDIR /app

# Expose the port the app runs on
EXPOSE 3000

# Command to run the application
CMD ["node", "dist/index.js"]
