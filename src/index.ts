import 'dotenv/config';
import express from 'express';
import fs from 'fs';
import path from 'path';
import { env } from './config/envValidate';
import { createItem } from './helper/createitem';
import { getDataFromFile } from './helper/getDataFromFile';

const downloadsDir = path.join(__dirname, 'downloads');

const getAllFilePaths = (dir: string) => {
  const files = fs.readdirSync(dir);
  return files.map(file => path.join(dir, file));
};
const app = express();
app.get('/home', async (req, res) => {
  try {
    const filePaths = getAllFilePaths(downloadsDir);
    const data = await getDataFromFile(filePaths[4]);
    const item = await createItem(data);
    return res.send(item);
  } catch (error) {
    console.log('Error Catch');
    console.log(error);
  }
});

app.listen(env.PORT, () => {
  console.log(`listening to port ${env.PORT}`);
});
