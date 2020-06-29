const express                    = require('express'),
      auth                       = require('../middleware/auth'),
      {notificationController}   = require('../utility/modulesInjection');


let router                       = express.Router();


router.get("/", notificationController.getEmployeeNotifications);
router.put("/", notificationController.putAllNotificationsAsSeen);
router.put("/:id", notificationController.putNotificationAsChecked);




module.exports = router;