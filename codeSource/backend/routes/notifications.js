const express                    = require('express'),
      auth                       = require('../middleware/auth'),
      {notificationController}   = require('../utility/modulesInjection');


let router                       = express.Router();
//router.use(auth);

router.get("/", notificationController.getEmployeeNotifications);
router.put("/", notificationController.putAllNotificationsAsSeen);
router.put("/:id", notificationController.putNotificationAsChecked);
router.delete("/", notificationController.deleteAllNotifications);
router.delete("/:id",notificationController.deleteNotification);




module.exports = router;