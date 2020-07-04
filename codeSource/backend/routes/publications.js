const express                  = require('express'),    
      auth                     = require('../middleware/auth'),
      multer                   = require('../middleware/multer_config'),
      publicationMiddelware    = require('../middleware/publicationMiddleware'),
      path                     = require('path'),  
      {publicationsController, commentController} = require('../utility/modulesInjection');
    
let router                     = express.Router();

//route to get posts images (one by one)
router.use('/postsImages', express.static(path.join(__dirname, '../images/postsImages')));
//router.use(auth);

///get all publications with employee who posted and his campagny
router.get("/", publicationsController.getAllPublications);
/// create a publication
router.post("/",  multer.multerPosts, publicationsController.createPublication);
/// delete a publication has a middelware to verify the rights
router.delete("/:id", publicationsController.deletePublication);
/// get a single publication
router.get("/:id", publicationsController.getPublicationById);
/// get all publications's likes
router.get("/:id/likes",  publicationsController.getPublicationLikes);
/// add like to publications
router.post("/:id/likes",  publicationsController.addlikePublication);
//remove a like to a given publication of a given employee
router.delete("/:id/likes",  publicationsController.removeLikePublication);
// to approuve a publication by the employee who has the right (canApprove field)
// we have to implement a middleware to examine the right
router.post("/:id/approve", publicationsController.approvePublication);
//modify a given publication, this action must be verified by a middelware called canModifyPublication
/// isn't tested yet ...
router.put("/:id", multer.multerPosts, publicationsController.modifyPublication);

/****************  Comments Section  ***************/
router.get('/:id/comments', commentController.getAllComments);
router.post('/:id/comments', commentController.addComment);
router.put('/:id/comments/:commentId', commentController.editComment);
router.delete('/:id/comments/:commentId', commentController.deleteComment);



module.exports = router;