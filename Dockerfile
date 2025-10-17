                                                               #multi-stage build dockerfile
# ---------- Stage 1: Dependencies ----------
FROM node:20-alpine AS deps

WORKDIR /app

COPY package*.json ./
RUN npm install --only=production

# ---------- Stage 2: Runtime ----------
FROM node:20-alpine AS runtime

WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules

COPY . .

# Expose application port
EXPOSE 3005

# Start the app
CMD ["node", "app.js"]
