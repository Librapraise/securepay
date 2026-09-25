require('dotenv').config();
const { PrismaClient } = require('@prisma/client');

let prisma;

const prismaOptions = {
  datasources: {
    db: {
      url: process.env.DATABASE_URL,
    },
  },
};

if (process.env.NODE_ENV === 'production') {
  prisma = new PrismaClient(prismaOptions);
} else {
  if (!global.prisma) {
    global.prisma = new PrismaClient({
      ...prismaOptions,
      log: ['warn', 'error'],
    });
  }
  prisma = global.prisma;
}

module.exports = prisma;
