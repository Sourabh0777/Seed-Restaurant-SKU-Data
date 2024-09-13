import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

async function main() {
  //   const lunch = await prisma.mealType.create({ data: { id: 'l', mealTypeName: mealTypes[0] } });
  //   const dinner = await prisma.mealType.create({ data: { id: 'd', mealTypeName: mealTypes[1] } });
  //   const not_applicatble = await prisma.mealType.create({ data: { id: 'n', mealTypeName: mealTypes[2] } });

//   const isBuffetFalse = await prisma.buffetType.create({ data: { id: 0, buffetTypeName: 'False' } });
//   const isBuffettrue = await prisma.buffetType.create({ data: { id: 1, buffetTypeName: 'true' } });
}
main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async error => {
    console.log(error);
    await prisma.$disconnect();
  });
