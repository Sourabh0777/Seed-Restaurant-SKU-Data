import prisma from '../config/prisma';

export const createItem = async (data: any) => {
  console.log('started');

  try {
    for (const orderData of data) {
      const responses = await Promise.all(
        orderData.OrderItem.map(async (item: any) => {
          const item_extra_data = JSON.parse(item.item_extra_data);
          if (!item_extra_data) {
            return;
          }
          // Create Restaurant
          let findRestaurant = await prisma.newRestaurant.findUnique({ where: { restaurant_id: parseInt(item.restaurant_id) } });
          let createRestaurant;
          if (!findRestaurant) {
            createRestaurant = await prisma.newRestaurant.create({ data: { restaurant_id: parseInt(item.restaurant_id) } });
          }
          const restaurantId = findRestaurant?.restaurant_id || createRestaurant?.restaurant_id;
          if (!restaurantId) {
            throw new Error('Restaurant ID is undefined');
          }

          // Create Group
          const findGroupById = await prisma.restaurant_new_SKU_group.findFirst({ where: { restaurant_id: restaurantId, group_category_id: parseInt(item.group_category_id) } });
          const findGroupByName = await prisma.restaurant_new_SKU_group.findFirst({ where: { restaurant_id: restaurantId, g_name: item_extra_data.g_name } });
          let createGroup;
          if (!findGroupById && !findGroupByName) {
            createGroup = await prisma.restaurant_new_SKU_group.create({
              data: { group_category_id: parseInt(item.group_category_id), g_name: item_extra_data.g_name, restaurant_id: restaurantId },
            });
            console.log('🚀 ~ orderData.OrderItem.map ~ createGroup:', createGroup);
          }

          // Create restaurant_new_SKU_category
          const findCategoryById = await prisma.restaurant_new_SKU_category.findFirst({ where: { restaurant_id: restaurantId, c_id: parseInt(item_extra_data.c_id) } });
          const findCategoryByName = await prisma.restaurant_new_SKU_category.findFirst({ where: { restaurant_id: restaurantId, c_name: item_extra_data.c_name } });
          let createCategory;
          if (!findCategoryById && !findCategoryByName) {
            createCategory = await prisma.restaurant_new_SKU_category.create({
              data: { c_id: parseInt(item_extra_data.c_id), c_name: item_extra_data.c_name, restaurant_id: restaurantId },
            });
            console.log('🚀 ~ orderData.OrderItem.map ~ createCategory:', createCategory);
          }

          // Create restaurant_new_SKU_variants
          let checkVarientExists;
          let createVarient;
          if (item_extra_data.v_id !== 0) {
            checkVarientExists = await prisma.restaurant_new_SKU_variants.findFirst({ where: { v_id: parseInt(item_extra_data.v_id) } });
            if (!checkVarientExists) {
              const variant = { v_id: parseInt(item_extra_data.v_id), v_name: item_extra_data.v_name };
              createVarient = await prisma.restaurant_new_SKU_variants.create({ data: variant });
              console.log('🚀 ~ orderData.OrderItem.map ~ createVarient:', createVarient);
            }
          }
          const itemExistsById = await prisma.restaurant_new_SKU_items.findFirst({
            where: { restaurant_id: restaurantId, item_id: parseInt(item.item_id) },
          });

          const itemExistsByName = await prisma.restaurant_new_SKU_items.findFirst({
            where: { restaurant_id: restaurantId, name: item.name },
          });

          if (!itemExistsById && !itemExistsByName) {
            const createdItem = await prisma.restaurant_new_SKU_items.create({
              data: {
                item_id: parseInt(item.item_id),
                price: parseInt(item.price),
                name: item.name,
                restaurant_id: restaurantId,
                old_item_id: parseInt(item.old_item_id),
                i_s_name: item_extra_data.i_s_name,
                c_id: findCategoryById?.id || findCategoryByName?.id || createCategory?.id,
                group_category_id: findGroupById?.id || findGroupByName?.id || createGroup?.id,
                v_id: checkVarientExists?.id || createVarient?.id,
              },
            });
            console.log('🚀 ~ createdItem:', createdItem);
          } else {
            return 'W';
          }
          return 'W';
        })
      );
    }
    return;
  } catch (error: any) {
    throw error;
  }
};
