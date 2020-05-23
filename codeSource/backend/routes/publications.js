const express                = require('express'),
      publicationsController = require('../controllers/publications');


let router = express.Router();


router.get("/", publicationsController.getAllPublications);
router.post("/", publicationsController.createPublication);
router.get("/:id", publicationsController.getPublicationById);

module.exports = router;