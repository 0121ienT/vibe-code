FROM node:20-alpine

# Cài đặt git và bash vì vibe-kanban cần tương tác với git repo và tạo worktrees
RUN apk add --no-cache git bash

# Cài đặt OmniRoute vào trong image (tuỳ chọn sử dụng qua CLI)
RUN npm install -g omniroute

WORKDIR /app

# Expose các port mặc định của vibe-kanban
# Frontend thường chạy port 3000, Backend thường là 3001
EXPOSE 3000 3001

# Sử dụng npx để khởi chạy vibe-kanban
CMD ["npx", "-y", "vibe-kanban"]
