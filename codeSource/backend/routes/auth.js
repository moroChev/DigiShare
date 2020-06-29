const express            = require('express');
const { authController } = require('../utility/modulesInjection');


let router         = express.Router();

router.post('/signup',authController.signup);
router.post('/login',authController.login);

module.exports = router;