const express                = require('express'),
      publicationsController = require('../controllers/publications'),
      auth                   = require('../middleware/auth'),
      multer                 = require('../middleware/multer_config');
      path                	 = require('path');



let router = express.Router();

//route to get posts images (one by one)
router.use('/image', auth, express.static(path.join(__dirname, '../images/postsImages')));

router.get("/", publicationsController.getAllPublications);
router.post("/", auth, multer,publicationsController.createPublication);
router.get("/:id", auth, publicationsController.getPublicationById);

// to approuve a publication by the employee who has the right (canApprove field)
// we have to implement a middleware to examine the right
// router.post("/:id/toApprove", publicationsController.approvePublication);

module.exports = router;