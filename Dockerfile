# # Use official Node.js image
# FROM node:18

# # Create app directory
# WORKDIR /usr/src/app

# # Copy package.json and package-lock.json
# COPY package*.json ./

# # Install dependencies
# RUN npm install

# # Copy rest of the application code
# COPY . .

# # Expose port your server runs on
# EXPOSE 3000

# # Start the server
# # CMD ["node", "server.js"]
# # Use official Nginx image
# FROM nginx:latest

# # Remove default Nginx static files
# RUN rm -rf /usr/share/nginx/html/*

# # Copy your app files into Nginx folder
# # Change ./public to your static folder (React: build/, Node.js: public/)
# COPY ./public /usr/share/nginx/html



# -------- Stage 1: Build the app --------
FROM node:18 AS build
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy rest of the code and build
COPY . .
RUN npm run build   # make sure your build output goes to 'build/' folder

# -------- Stage 2: Serve with Nginx --------
FROM nginx:latest

# Remove default Nginx files
RUN rm -rf /usr/share/nginx/html/*

# Copy built app from previous stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
