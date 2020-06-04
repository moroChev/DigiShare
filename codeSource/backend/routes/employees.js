const express                = require('express'),
      employeeController     = require('../controllers/employees.js'),
      auth                   = require('../middleware/auth'),
      multer                 = require('../middleware/multer_config'),
      path                	 = require('path');


let router = express.Router();

//route to get profile image
router.use('/profilesImages',auth, express.static(path.join(__dirname, '../images/profilesImages')));

router.get("/rechercher/:fullName",auth, employeeController.getEmployeeByFullName);

router.get("/",auth, employeeController.getAllEmployees);
router.post("/", auth, multer.multerEmployees, employeeController.createEmployee);
router.get("/:id", auth,employeeController.getEmployeeById);
router.get("/:id/Publications", auth, employeeController.getEmployeePublications);
router.put("/:id", auth, multer.multerEmployees, employeeController.modifyEmployee);




module.exports = router;