/**
 * Frontend Configuration for EverCart E-Commerce
 * 
 * This file contains configuration values that are dynamically set by the server
 * based on environment variables. It allows the frontend to adapt to different
 * deployment environments (local, development, production).
 */

// API Configuration
// This will be replaced by the server with actual values from environment variables
window.CONFIG = {
    // Base URL for all API calls
    // Local development: 'http://localhost:3000'
    // AWS deployment: 'http://44.204.20.146:3000' 
    API_BASE_URL: 'http://44.204.20.146:3000',
    
    // Environment information
    NODE_ENV: 'development',
    
    // API endpoints (constructed from base URL)
    API: {
        // Authentication endpoints
        LOGIN: 'http://44.204.20.146:3000/api/login',
        SIGNUP: 'http://44.204.20.146:3000/api/signup',
        ADMIN_LOGIN: 'http://44.204.20.146:3000/api/admin/login',
        ADMIN_CREATE: 'http://44.204.20.146:3000/api/admin/create',
        
        // Product endpoints
        PRODUCTS: 'http://44.204.20.146:3000/api/products',
        CATEGORIES: 'http://44.204.20.146:3000/api/categories',
        BRANDS: 'http://44.204.20.146:3000/api/brands',
        
        // Cart endpoints
        CART_GET: 'http://44.204.20.146:3000/api/cart',
        CART_ADD: 'http://44.204.20.146:3000/api/cart/add',
        CART_UPDATE: 'http://44.204.20.146:3000/api/cart/update',
        CART_REMOVE: 'http://44.204.20.146:3000/api/cart/remove',
        CART_CLEAR: 'http://44.204.20.146:3000/api/cart/clear',
        
        // Admin product management endpoints
        ADMIN_PRODUCTS: 'http://44.204.20.146:3000/api/admin/products'
    }
};

// Helper function to get API URL
window.getApiUrl = function(endpoint) {
    return window.CONFIG.API_BASE_URL + endpoint;
};

console.log('EverCart Config Loaded:', window.CONFIG);
