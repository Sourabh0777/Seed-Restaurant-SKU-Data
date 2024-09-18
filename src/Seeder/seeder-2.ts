import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

async function main() {
  const meal_type = await prisma.meal_type.findFirst({ where: { mealTypeName: 'Not_applicable' } });
  if (meal_type) {
    await prisma.restaurant_new_SKU_category.updateMany({ data: { mealTypeId: meal_type.id } });
  }
  const isBuffetFalse = await prisma.buffet_type.findFirst({ where: { buffetTypeName: 'False' } });
  if (isBuffetFalse) {
    await prisma.restaurant_new_SKU_category.updateMany({ data: { buffetTypeId: isBuffetFalse.id } });
  }
  const isAdult = await prisma.customer_type.findFirst({ where: { customerTypeName: 'Adult' } });
  if (isAdult) {
    await prisma.restaurant_new_SKU_items.updateMany({ data: { isAdult: isAdult.id } });
  }
  const veg = await prisma.vegetarian_mark.findFirst({ where: { vegetarianMarkType: 'Veg' } });
  if (veg) {
    await prisma.restaurant_new_SKU_items.updateMany({ data: { isVeg: veg.id } });
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
