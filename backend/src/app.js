const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');
const authRoutes = require('./routes/authRoutes');
const errorHandler = require('./middlewares/errorMiddleware');

const app = express();

app.use(helmet());
app.use(cors({ origin: process.env.CORS_ORIGIN || '*', credentials: true }));

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
