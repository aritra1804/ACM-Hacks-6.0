import { Router, Request, Response } from 'express';
import db from '../loaders/database';
export default (): Router => {
  const app = Router();
  app.get('/animals/:name', async (req: Request, res: Response) => {
    if (!req.params.name) res.sendStatus(404);
    const data = await (await db()).collection('animals').find({ typeInEng: req.params.name }).toArray();
    res.send(data);
  });
  return app;
};
