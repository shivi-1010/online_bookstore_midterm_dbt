# Use the official Node.js image.
FROM node:lts-alpine

# Create and set the working directory.
WORKDIR /app

# Copy package.json and package-lock.json (if available) and install dependencies.
COPY package*.json ./
RUN npm install

# Copy the rest of the application code.
COPY . .

# Compile TypeScript code.
RUN npm run build

# Expose the port your app runs on.
EXPOSE 3000

# Start the application.
CMD ["npm", "start"]
