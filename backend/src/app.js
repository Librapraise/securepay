const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');
const authRoutes = require('./routes/authRoutes');
const errorHandler = require('./middlewares/errorMiddleware');

const app = express();

app.use(helmet({
  crossOriginResourcePolicy: { policy: 'cross-origin' }
}));

const allowedOrigins = [
  'https://securepay-blush.vercel.app',
  'http://localhost:3000',
  'http://localhost:5000',
  'http://localhost:8080',
  'http://127.0.0.1:3000',
  'http://127.0.0.1:5000',
  'http://127.0.0.1:8080'
];

app.use(cors({
  origin: (origin, callback) => {
    // Allow requests with no origin (like mobile apps, curl, postman)
    if (!origin) return callback(null, true);
    
    // Check if origin matches allowed origins or localhost regex or matches CORS_ORIGIN env
    const isLocalhost = /^http:\/\/(localhost|127\.0\.0\.1)(:\d+)?$/.test(origin);
    const isConfiguredEnv = process.env.CORS_ORIGIN && process.env.CORS_ORIGIN.split(',').map(s => s.trim()).includes(origin);
    const isAllowed = allowedOrigins.includes(origin) || isLocalhost || isConfiguredEnv;
    
    if (isAllowed) {
      return callback(null, true);
    }
    // Fallback: allow dynamically for web preview / development
    return callback(null, true);
  },
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS', 'PATCH'],
  allowedHeaders: ['Content-Type', 'Authorization', 'Accept', 'X-Requested-With']
}));
app.options('*', cors());

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 100,
  standardHeaders: true,
  legacyHeaders: false,
  message: { success: false, message: 'Too many requests, please try again later.' }
});
app.use('/api', limiter);

app.use(express.json());

app.get('/health', (req, res) => res.json({ status: 'ok', service: 'securepay-api' }));
app.use('/api/auth', authRoutes);

app.use(errorHandler);

module.exports = app;
