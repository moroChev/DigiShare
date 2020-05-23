const express             = require('express'),
      bodyParser          = require('body-parser'),
      mongoose            = require('mongoose'),
      routerPublications  = require('./routes/publications'),
      routerEmployees     = require('./routes/employees') ;

let app = express();

mongoose.connect('mongodb://localhost/digi_share',{ useNewUrlParser: true });

app.use(bodyParser.json());

app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content, Accept, Content-Type, Authorization');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH, OPTIONS');
    next();
  });


app.use('/api/publications', routerPublications);  
app.use('/api/employees', routerEmployees);





module.exports = app;