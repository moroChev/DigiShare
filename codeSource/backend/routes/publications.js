const express                = require('express'),
      publicationsController = require('../controllers/publications'),
      auth                   = require('../middleware/auth'),
      multer                 = require('../middleware/multer_config')
      publicationMiddelware  = require('../middleware/publicationMiddleware');


let router = express.Router();


router.get("/", publicationsController.getAllPublications);
router.post("/", auth, multer,publicationsController.createPublication);
router.get("/:id", auth, publicationsController.getPublicationById);

//modify a given publication, this action must be verified by a middelware called canModifyPublication
router.put("/:id",auth,publicationMiddelware.canModifyPublication, publicationsController.modifyPublication);
// add likes to a given publication
router.post("/:id/likes",auth, publicationsController.likePublication);
//add dislike to a given publication
router.post("/:id/dislikes",auth, publicationsController.dislikePublication);
//get all likes of a given publictaion
router.get("/:id/likes", auth,  publicationsController.getPublicationLikes);
//get all dislikes of a given publication
router.get("/:id/dislikes"); 



// to approuve a publication by the employee who has the right (canApprove field)
// we have to implement a middleware to examine the right
// router.post("/:id/toApprove", publicationsController.approvePublication);

module.exports = router;