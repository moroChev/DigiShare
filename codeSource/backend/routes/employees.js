const express                    = require('express'),
      auth                       = require('../middleware/auth'),
      multer                     = require('../middleware/multer_config'),
      path                	     = require('path'),
      {employeeController}       = require('../utility/modulesInjection');


let router                       = express.Router();

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