const express                = require('express'),
      publicationsController = require('../controllers/publications'),
      auth                   = require('../middleware/auth');


let router = express.Router();


router.get("/", auth, publicationsController.getAllPublications);
router.post("/", auth, publicationsController.createPublication);
router.get("/:id", auth, publicationsController.getPublicationById);

// to approuve a publication by the employe who has the right (canApprove field)
// we have to implement a middleware to examine the right
// router.post("/:id/toApprove", publicationsController.approvePublication);

module.exports = router;