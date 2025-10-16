# Build stage
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./

RUN npm install --only=production


COPY . .

# Expose port
EXPOSE 3005

# Start application
CMD ["node", "app.js"]