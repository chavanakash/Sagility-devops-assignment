# ---------- Stage 1: Dependencies ----------
FROM node:20-alpine AS deps

WORKDIR /app

# Copy package files and install only production deps
COPY package*.json ./
RUN npm install --only=production

# ---------- Stage 2: Runtime ----------
FROM node:20-alpine AS runtime

WORKDIR /app

# Copy node_modules from deps
COPY --from=deps /app/node_modules ./node_modules

# Copy application files
COPY . .

# Expose application port
EXPOSE 3005

# Start the app
CMD ['node', 'app.js']
