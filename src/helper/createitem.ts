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

          // Create Group
          const findGroupById = await prisma.restaurant_new_SKU_group.findUnique({ where: { group_category_id: parseInt(item.group_category_id) } });
          const findGroupByName = await prisma.restaurant_new_SKU_group.findUnique({ where: { g_name: item_extra_data.g_name } });
          let createGroup;
          if (!findGroupById && !findGroupByName) {
            createGroup = await prisma.restaurant_new_SKU_group.create({ data: { group_category_id: parseInt(item_extra_data.group_category_id), g_name: item_extra_data.g_name } });
          }

          // Create restaurant_new_SKU_category
          const findCategoryById = await prisma.restaurant_new_SKU_category.findUnique({ where: { c_id: parseInt(item_extra_data.c_id) } });
          const findCategoryByName = await prisma.restaurant_new_SKU_category.findUnique({ where: { c_name: item_extra_data.c_name } });
          let createCategory;
          if (!findCategoryById && !findCategoryByName) {
            createCategory = await prisma.restaurant_new_SKU_category.create({ data: { c_id: parseInt(item_extra_data.c_id), c_name: item_extra_data.c_name } });
          }

          // Create restaurant_new_SKU_variants
          let checkVarientExists;
          let createVarient;
          if (item_extra_data.v_id !== 0) {
            const variant = { v_id: parseInt(item_extra_data.v_id), v_name: item_extra_data.v_name };
            const variantWhere = { v_id: parseInt(item_extra_data.v_id) };
            checkVarientExists = await prisma.restaurant_new_SKU_variants.findUnique({ where: variantWhere });
            if (!checkVarientExists) {
              createVarient = await prisma.restaurant_new_SKU_variants.create({ data: variant });
              console.log('🚀 ~ orderData.OrderItem.map ~ createVarient:', createVarient);
            }
          }

          // Create restaurant_new_SKU_items
          let i_tem = {
            item_id: parseInt(item.item_id),
            price: parseInt(item.price),
            name: item.name,
            old_item_id: item.old_item_id ? parseInt(item.old_item_id) : null,
            i_s_name: item_extra_data.i_s_name ? item_extra_data.i_s_name : null,
            c_id: findCategoryById?.c_id || findCategoryByName?.c_id || createCategory?.c_id,
            group_category_id: findGroupById?.group_category_id || findGroupByName?.group_category_id || createGroup?.group_category_id,
            v_id: checkVarientExists?.v_id || createVarient?.v_id,
          };

          const itemExistsById = await prisma.restaurant_new_SKU_items.findUnique({
            where: { item_id: parseInt(item.item_id) },
          });

          const itemExistsByName = await prisma.restaurant_new_SKU_items.findUnique({
            where: { name: item.name },
          });

          if (!itemExistsById && !itemExistsByName) {
            const createdItem = await prisma.restaurant_new_SKU_items.create({ data: i_tem });
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
    console.error('Error:', error);
  }
};
