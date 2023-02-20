const express = require('express');
const router = require('./routes/routes');
const bodyParser = require('body-parser');

const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));
app.get('/', (request, response) => { response.json({ info: 'Node.js, Express, and Postgres API' }) });

app.use(router, (request, response) => { response.json({ data }) });
//app.use(router);
app.use('/uploads', express.static('uploads'));

app.listen(3000,() => { console.log('Server is running in PORT 3000'); });