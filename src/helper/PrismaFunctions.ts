export const createRow = async (tableName: any, data: any) => {
  try {
    const result = await tableName.create({ data });
    return result;
  } catch (error: any) {
    if (error.code === 'P2002') {
      console.error('A record with this unique field already exists.');
    } else {
      throw error;
    }
  }
};

export const findMany = async (tableName: any) => {
  const result = await tableName.findMany();
  return result;
};
export const findUniqueRow = async (tableName: any, where: any) => {
  try {
    const result = await tableName.findUnique({ where: where });
    if (!result) {
      return;
    } else if (result) {
      return result;
    }
  } catch (error: any) {
    console.log('Error is caused by :', error.message);
    return error;
  }
};

export const updateRow = async (tableName: any, where: any, data: any) => {
  try {
    const result = await tableName.update({
      data: data,
      where: where,
    });
    return result;
  } catch (error) {
    return error;
  }
};
//Check if the  already exists then update
export const alreadyExistsThenUpdate = async (tableName: any, where: any, data: any) => {
  try {
    const alreadyExists = await findUniqueRow(tableName, where);
    if (alreadyExists) {
      return alreadyExists;
    }
    if (!alreadyExists) {
      const update = await updateRow(tableName, where, data);
      return update;
    }
  } catch (error) {
    return error;
  }
};
//Check if already exist if not then create
export const alreadyExistsIfNotThenCreate = async (tableName: any, where: any, data: any) => {
  try {
    const alreadyExists = await findUniqueRow(tableName, where);
    if (!alreadyExists) {
      const create = await createRow(tableName, data);
      console.log('🚀 ~ alreadyExistsIfNotThenCreate ~ create:', create);
      return create;
    } else {
      return;
    }
  } catch (error) {
    return error;
  }
};
