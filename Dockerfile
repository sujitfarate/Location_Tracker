# Use official Node.js LTS image
FROM node:20-alpine

# Set working directory inside container
WORKDIR /app

# Copy package.json and package-lock.json first (for caching)
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy the rest of your project files
COPY . .

# Expose the port your server listens on (change if different)
EXPOSE 3000

# Start your server
CMD ["node", "server.js"]
