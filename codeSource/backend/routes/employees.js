const express                = require('express'),
      employeeController     = require('../controllers/employees.js'),
      auth                   = require('../middleware/auth'),
      multer                 = require('../middleware/multer_config');

let router = express.Router();


router.get("/rechercher/:fullName",auth, employeeController.getEmployeeByFullName);
router.get("/", auth, employeeController.getAllEmployees);
router.post("/", auth, multer, employeeController.createEmployee);
router.get("/:id", auth, employeeController.getEmployeeById);
router.get("/:id/Publications", auth, employeeController.getEmployeePublications);
router.put("/:id", auth, multer, employeeController.modifyEmployee);



module.exports = router;