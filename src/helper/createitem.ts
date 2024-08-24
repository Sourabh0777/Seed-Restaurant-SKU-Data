import prisma from '../config/prisma';
import { alreadyExistsIfNotThenCreate } from './PrismaFunctions';

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
          const group = { group_category_id: parseInt(item.group_category_id), g_name: item_extra_data.g_name };
          const groupWhere = { group_category_id: parseInt(item.group_category_id) };
          await alreadyExistsIfNotThenCreate(prisma.restaurant_new_SKU_group, groupWhere, group);

          // Create restaurant_new_SKU_category
          const category = { c_id: parseInt(item_extra_data.c_id), c_name: item_extra_data.c_name };
          const categoryWhere = { c_id: parseInt(item_extra_data.c_id) };
          await alreadyExistsIfNotThenCreate(prisma.restaurant_new_SKU_category, categoryWhere, category);

          // Create restaurant_new_SKU_variants
          if (item_extra_data.v_id !== 0) {
            const variant = { v_id: parseInt(item_extra_data.v_id), v_name: item_extra_data.v_name };
            const variantWhere = { v_id: parseInt(item_extra_data.v_id) };
            await alreadyExistsIfNotThenCreate(prisma.restaurant_new_SKU_variants, variantWhere, variant);
          }

          // Create restaurant_new_SKU_items
          const i_tem = {
            item_id: parseInt(item.item_id),
            price: parseInt(item.price),
            name: item.name,
            old_item_id: item.old_item_id ? parseInt(item.old_item_id) : null,
            i_s_name: item_extra_data.i_s_name ? item_extra_data.i_s_name : null,
            c_id: item_extra_data.c_id ? parseInt(item_extra_data.c_id) : null,
            group_category_id: item.group_category_id ? parseInt(item.group_category_id) : null,
            v_id: item_extra_data.v_id !== 0 ? item_extra_data.v_id : null,
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
