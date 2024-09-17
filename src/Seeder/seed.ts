import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

async function main() {
  // const lunch = await prisma.mealType.create({ data: { mealTypeName: 'Lunch' } });
  // const dinner = await prisma.mealType.create({ data: {  mealTypeName: 'Dinner' } });
  // const not_applicatble = await prisma.mealType.create({ data: { mealTypeName: 'Not_applicable' } });
  //   const isBuffetFalse = await prisma.buffetType.create({ data: { id: 0, buffetTypeName: 'False' } });
  //   const isBuffettrue = await prisma.buffetType.create({ data: { id: 1, buffetTypeName: 'true' } });
  //   await prisma.customerType.create({ data: { customerTypeName: 'Adult' } });
  //   await prisma.customerType.create({ data: { customerTypeName: 'Child' } });
  //   await prisma.vegetarianMark.create({ data: { vegetarianMarkType: 'Veg' } });
  //   await prisma.vegetarianMark.create({ data: { vegetarianMarkType: 'Non-Veg' } });
  //   await prisma.vegetarianMark.create({ data: { vegetarianMarkType: 'Not_applicable' } });
}
main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async error => {
    console.log(error);
    await prisma.$disconnect();
  });
