const express                = require('express'),
      authController         = require('../controllers/auth');


let router = express.Router();

router.post('/signup',authController.signup);
router.post('/login',authController.login);

module.exports = router;