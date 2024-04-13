# Stage 1: Build the application
FROM node:14 AS builder

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Stage 2: Create a lightweight image to run the application
FROM node:14-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the built application from the previous stage
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./
COPY --from=builder /app/tsconfig.json ./

# Expose the port the app runs on
EXPOSE 3000

# Command to run the application
CMD ["node", "dist/index.js"]
