const express                = require('express'),    
      auth                   = require('../middleware/auth'),
      multer                 = require('../middleware/multer_config'),
      publicationMiddelware  = require('../middleware/publicationMiddleware'),
      path                   = require('path'),
      EmployeeRepo           = require('../repositories/Employees/employeeRepositoryMongoDb'),
      PublicationRepo        = require('../repositories/Publications/publicationRepositoryMongoDb'),
      PublicationService     = require('../services/publicationService'),
      PublicationsController = require('../controllers/publications');

let router                   = express.Router();


let employeeRepo             = new EmployeeRepo();
let publicationRepo          = new PublicationRepo();
let publicationService       = new PublicationService(publicationRepo,employeeRepo);
let publicationsController   = new PublicationsController(publicationService);

//route to get posts images (one by one)
router.use('/postsImages', express.static(path.join(__dirname, '../images/postsImages')));

///get all publications with employee who posted and his campagny
router.get("/", publicationsController.getAllPublications);

/// create a publication
router.post("/", auth, multer.multerPosts, publicationsController.createPublication);

/// delete a publication has a middelware to verify the rights
router.delete("/:id", publicationsController.deletePublication);

/// get a single publication
router.get("/:id", auth, publicationsController.getPublicationById);

/// get all publications's likes
router.get("/:id/likes", auth, publicationsController.getPublicationLikes);

/// add like to publications
router.post("/:id/likes", auth, publicationsController.addlikePublication);

//remove a like to a given publication of a given employee
router.delete("/:id/likes", auth, publicationsController.removeLikePublication);

// to approuve a publication by the employee who has the right (canApprove field)
// we have to implement a middleware to examine the right
router.post("/:id/approve", auth,publicationsController.approvePublication);

//modify a given publication, this action must be verified by a middelware called canModifyPublication
/// isn't tested yet ...
router.put("/:id",auth, multer.multerPosts, publicationsController.modifyPublication);


/* 
// add likes to a given publication
router.post("/:id/likes",auth, publicationsController.addlikePublication);
//get all likes of a given publictaion
 */


module.exports = router;