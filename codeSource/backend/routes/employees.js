const express                    = require('express'),
      EmployeeController         = require('../controllers/employees.js'),
      auth                       = require('../middleware/auth'),
      multer                     = require('../middleware/multer_config'),
      path                	     = require('path'),
      EmployeeService            = require('../services/employeeService'),
      EmployeeRepositoryMongoDb  = require('../repositories/Employees/employeeRepositoryMongoDb');


let router                       = express.Router();

let employeeRepo                 = new EmployeeRepositoryMongoDb();
let employeeService              = new EmployeeService(employeeRepo);
let employeeController           = new EmployeeController(employeeService);

//route to get profile image
router.use('/profilesImages', express.static(path.join(__dirname, '../images/profilesImages')));

router.get("/", employeeController.getAllEmployees);
// not tested yet ...
router.post("/",  multer.multerEmployees, employeeController.createEmployee);
router.get("/:id", employeeController.getEmployeeById);
router.get("/:id/Publications", employeeController.getEmployeePublications);
//router.put("/:id", multer.multerEmployees, employeeController.modifyEmployee);
router.post("/search", employeeController.searchEmployee);




module.exports = router;