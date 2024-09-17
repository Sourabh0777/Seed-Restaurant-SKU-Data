import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

async function main() {
  // const meal_type = await prisma.meal_type.findFirst({ where: { meal_typeName: 'Not_applicable' } });
  // if (meal_type) {
  //   await prisma.restaurant_new_SKU_category.updateMany({ data: { meal_typeId: meal_type.id } });
  // }
  // const isBuffetFalse = await prisma.buffetType.findFirst({ where: { buffetTypeName: 'Single Item' } });
  // if (isBuffetFalse) {
  //   await prisma.restaurant_new_SKU_category.updateMany({ data: { buffetTypeId: isBuffetFalse.id } });
  // }
  // const isAdult = await prisma.customerType.findFirst({ where: { customerTypeName: 'Adult' } });
  // if (isAdult) {
  //   await prisma.restaurant_new_SKU_items.updateMany({ data: { isAdult: isAdult.id } });
  // }
  // const veg = await prisma.vegetarianMark.findFirst({ where: { vegetarianMarkType: 'Veg' } });
  // if (veg) {
  //   await prisma.restaurant_new_SKU_items.updateMany({ data: { isVeg: veg.id } });
  // }
}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async error => {
    console.log(error);
    await prisma.$disconnect();
  });
