import { PrismaClient } from '@prisma/client';
import { env } from './envValidate';

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: env.DATABASE_URL, // Ensure you have the DATABASE_URL in your .env file
    },
  },
});

export default prisma;
