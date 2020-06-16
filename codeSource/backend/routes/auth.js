const express                   = require('express');
const AuthController            = require('../controllers/auth');
const AuthService               = require('../services/authService');
const EmployeeRepositoryMongoDb = require('../repositories/Employees/employeeRepositoryMongoDb');


let router         = express.Router();
let employeeRepo   = new EmployeeRepositoryMongoDb();
let authService    = new AuthService(employeeRepo);
let authController = new AuthController(authService);

router.post('/signup',authController.signup);
router.post('/login',authController.login);

module.exports = router;