import config from './config';
import express from 'express';
import cors from 'cors';

import Routes from './routes/SCP.routes';

const app = express();

//settings
app.set('port', config.port);
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cors());
app.use(Routes);

export default app;
