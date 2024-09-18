import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

async function main() {
  const deleteMealType = await prisma.meal_type.deleteMany();
  const deletBuffetType = await prisma.buffet_type.deleteMany();
  const deleteCustomerType = await prisma.customer_type.deleteMany();
  const deletevegetarianMark = await prisma.vegetarian_mark.deleteMany();

  //
  const lunch = await prisma.meal_type.create({ data: { mealTypeName: 'Lunch' } });
  const dinner = await prisma.meal_type.create({ data: { mealTypeName: 'Dinner' } });
  const not_applicatble = await prisma.meal_type.create({ data: { mealTypeName: 'Not_applicable' } });

  //
  const isBuffetFalse = await prisma.buffet_type.create({ data: { id: 0, buffetTypeName: 'False' } });
  const isBuffettrue = await prisma.buffet_type.create({ data: { id: 1, buffetTypeName: 'true' } });
  await prisma.customer_type.create({ data: { customerTypeName: 'Adult' } });
  await prisma.customer_type.create({ data: { customerTypeName: 'Child' } });
  await prisma.vegetarian_mark.create({ data: { vegetarianMarkType: 'Veg' } });
  await prisma.vegetarian_mark.create({ data: { vegetarianMarkType: 'Non-Veg' } });
  await prisma.vegetarian_mark.create({ data: { vegetarianMarkType: 'Not_applicable' } });
}
main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async error => {
    console.log(error);
    await prisma.$disconnect();
  });
