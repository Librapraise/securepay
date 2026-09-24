const app = require('./src/app');
const prisma = require('./src/config/db');
require('dotenv').config();

const PORT = process.env.PORT || 5000;

async function startServer() {
  try {
    await prisma.$connect();
    console.log('[Neon PostgreSQL] Database connected successfully.');

    app.listen(PORT, () => {
      console.log(`[Server] Running in ${process.env.NODE_ENV || 'development'} mode on port ${PORT}`);
    });
  } catch (error) {
    console.error('[Database Connection Error]', error);
    process.exit(1);
  }
}

startServer();
