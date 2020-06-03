const express                = require('express'),
      employeeController     = require('../controllers/employees.js'),
      auth                   = require('../middleware/auth');
      path                	 = require('path');


let router = express.Router();

//route to get profile image
router.use('/profileImage', auth, express.static(path.join(__dirname, '../images/profilesImages')));

router.get("/rechercher/:fullName",auth, employeeController.getEmployeeByFullName);
router.get("/", auth,employeeController.getAllEmployees);
router.post("/", auth, employeeController.createEmployee);
router.get("/:id",  auth,employeeController.getEmployeeById);
router.get("/:id/Publications", auth,employeeController.getEmployeePublications);



module.exports = router;