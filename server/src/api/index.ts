import { Router, Request, Response } from 'express';
import db from '../loaders/database';
import path from 'path';
import multer from 'multer';
import { config } from 'dotenv';
import S3 from 'aws-sdk/clients/s3';
import fs from 'fs';
import { nanoid } from 'nanoid';
import util from 'util';

config();

export const upload = multer({
  dest: 'uploads',
});

const region = 'ap-south-1';
const accessKeyId = process.env.key;
const secretAccessKey = process.env.secret;

const s3 = new S3({
  region,
  accessKeyId,
  secretAccessKey,
});

const unlinkFile = util.promisify(fs.unlink);

export default (): Router => {
  const app = Router();
  app.get('/animals/:name', async (req: Request, res: Response) => {
    try {
      if (!req.params.name) return res.sendStatus(404);
      if (req.params.name === 'all') {
        const data = await (await db()).collection('animals').find({}).toArray();
        res.send(data);
        return;
      }
      const data = await (await db()).collection('animals').find({ typeInEng: req.params.name }).toArray();
      res.send(data);
    } catch (err) {
      console.log(err);
      res.sendStatus(err.status || 500);
    }
  });

  app.post('/add/animal', upload.single('file'), async (req: Request, res: Response) => {
    try {
      const file = req.file;
      if (!file) {
        res.send('Add image');
        return;
      }
      console.log(file);
      const fileStream = fs.createReadStream(file.path);
      const uid = nanoid();
      const uploadParams = {
        Bucket: 'mechenzie',
        Body: fileStream,
        Key: `acm/${uid}`,
        ContentType: file.mimetype,
        ACL: 'public-read',
      };
      const url = `https://mechenzie.s3.ap-south-1.amazonaws.com/acm/${uid}`;
      console.log(url);
      if (
        !req.body.type ||
        !req.body.typeInEng ||
        !req.body.name ||
        !req.body.price ||
        !req.body.description ||
        !req.body.age
      ) {
        res.send('Please enteer name,type, typeInEng, price, and description');
        unlinkFile(file.path);

        return;
      }
      await (await db()).collection('animals').insertOne({
        image: url,
        name: req.body.name,
        type: req.body.type,
        typeInEng: req.body.typeInEng,
        price: req.body.price,
        description: req.body.description,
        age: req.body.age,
      });
      await (await s3).upload(uploadParams).promise();
      res.sendStatus(200);
      unlinkFile(file.path);
    } catch (err) {
      console.log(err);
      res.sendStatus(err.status || 500);
    }
  });

  return app;
};
