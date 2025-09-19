# -------- Stage 1: Build React app --------
FROM node:18 AS build

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies (including react-scripts explicitly if missing)
RUN npm install && \
    npm install react-scripts --save-dev --legacy-peer-deps

# Copy the rest of the code
COPY . .

# Build React app (creates /build folder)
RUN npm run build


# -------- Stage 2: Serve with Nginx --------
FROM nginx:latest

# Clean default nginx files
RUN rm -rf /usr/share/nginx/html/*

# Copy build output from stage 1
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
