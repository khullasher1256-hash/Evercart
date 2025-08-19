#!/bin/bash

# =============================================================================
# EverCart E-Commerce Application Startup Script for Linux
# =============================================================================
# This script starts the EverCart application on a Linux server
# Optimized for production deployment with proper environment setup

# Set colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=============================================${NC}"
echo -e "${BLUE}🚀 Starting EverCart E-Commerce Application${NC}"
echo -e "${BLUE}=============================================${NC}"
echo

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo -e "${RED}❌ Node.js is not installed. Please install Node.js first.${NC}"
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo -e "${RED}❌ npm is not installed. Please install npm first.${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Node.js version: $(node --version)${NC}"
echo -e "${GREEN}✅ npm version: $(npm --version)${NC}"
echo

# Check if package.json exists
if [ ! -f "package.json" ]; then
    echo -e "${RED}❌ package.json not found. Please run this script from the project root directory.${NC}"
    exit 1
fi

# Install dependencies if node_modules doesn't exist
if [ ! -d "node_modules" ]; then
    echo -e "${YELLOW}📦 Installing dependencies...${NC}"
    npm install
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Dependencies installed successfully${NC}"
    else
        echo -e "${RED}❌ Failed to install dependencies${NC}"
        exit 1
    fi
    echo
else
    echo -e "${GREEN}✅ Dependencies already installed${NC}"
    echo
fi

# Check if MongoDB is running (optional check)
if command -v mongod &> /dev/null; then
    if pgrep mongod > /dev/null; then
        echo -e "${GREEN}✅ MongoDB is running${NC}"
    else
        echo -e "${YELLOW}⚠️  MongoDB doesn't appear to be running. Make sure it's started.${NC}"
    fi
    echo
fi

# Load production environment
if [ -f ".env.production" ]; then
    echo -e "${GREEN}✅ Loading production environment variables${NC}"
    export $(cat .env.production | grep -v '^#' | xargs)
else
    echo -e "${YELLOW}⚠️  .env.production not found. Using default values.${NC}"
fi

# Set NODE_ENV to production
export NODE_ENV=production

echo -e "${BLUE}🌐 Configuration:${NC}"
echo -e "   📡 Port: ${PORT:-3000}"
echo -e "   🗄️  Database: ${MONGODB_URI:-mongodb://localhost:27017/evercart}"
echo -e "   🔧 Environment: ${NODE_ENV}"
echo -e "   📁 Static files: ./public"
echo

# Start the application
echo -e "${BLUE}🚀 Starting EverCart server...${NC}"
echo -e "${BLUE}=============================================${NC}"
echo

# Use PM2 if available for production, otherwise use node
if command -v pm2 &> /dev/null; then
    echo -e "${GREEN}🔄 Starting with PM2 process manager...${NC}"
    pm2 start server.js --name "evercart" --watch
    pm2 logs evercart
else
    echo -e "${GREEN}🔄 Starting with Node.js...${NC}"
    node server.js
fi
