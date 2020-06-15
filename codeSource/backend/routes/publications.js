const express                = require('express'),
      PublicationsController = require('../controllers/publications'),
      auth                   = require('../middleware/auth'),
      multer                 = require('../middleware/multer_config'),
      publicationMiddelware  = require('../middleware/publicationMiddleware'),
      path                   = require('path');



let router = express.Router();
let publicationsController = new PublicationsController();

//route to get posts images (one by one)
router.use('/postsImages', express.static(path.join(__dirname, '../images/postsImages')));


router.get("/", publicationsController.getAllPublications);


/* router.post("/", auth, multer.multerPosts,publicationsController.createPublication);
router.get("/:id",  publicationsController.getPublicationById);
router.delete("/:id",auth, publicationMiddelware.canRemovePublication ,publicationsController.deletePublication);


//modify a given publication, this action must be verified by a middelware called canModifyPublication
router.put("/:id", auth, multer.multerPosts, publicationsController.modifyPublication);
// add likes to a given publication
router.post("/:id/likes",auth, publicationsController.addlikePublication);
//remove a like to a given publication of a given employee
router.delete("/:id/likes",auth, publicationsController.removeLikePublication);
//get all likes of a given publictaion
router.get("/:id/likes",   publicationsController.getPublicationLikes); */





// to approuve a publication by the employee who has the right (canApprove field)
// we have to implement a middleware to examine the right
//router.post("/:id/approve", auth, publicationsController.approvePublication);

module.exports = router;