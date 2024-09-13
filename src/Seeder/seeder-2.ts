import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

async function main() {
  const mealType = await prisma.mealType.findFirst({ where: { mealTypeName: 'not_applicable' } });
  if (mealType) {
    await prisma.restaurant_new_SKU_category.updateMany({ data: { mealTypeId: mealType.id } });
  }
  const isBuffetFalse = await prisma.buffetType.findFirst({ where: { buffetTypeName: 'false' } });
  if (isBuffetFalse) {
    await prisma.restaurant_new_SKU_category.updateMany({ data: { buffetTypeId: isBuffetFalse.id } });
  }
}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async error => {
    console.log(error);
    await prisma.$disconnect();
  });
