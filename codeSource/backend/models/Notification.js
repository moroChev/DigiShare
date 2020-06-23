const mongoose = require('mongoose');

/*           
 *             NOTIFICATION LOGIC
 * In order the customize the notification feature
 * every employee of the App must have his list of notifications
 * that are already checked and some others aren't checked yet
 * In these case we have O(n*m) space complexity !
 * 

 * 
 * in case of Digi Share App we have four notifications types:
 * 1) An employee gonna publish a publication : newPubication,
 * 2) An employee gonna change his position : newPosition,
 * 3) An employee gonna change his work location ( agency changing ) : newLocation,
 * 4) A publication gonna be approved
 * 
 * Every Notification must have four informations
 * 1) The employee who made the action
 * 2) The notification type (newPublication, newPosition, newLocation, approval)
 * 3) The timesTamp of the notification
 * 4) is The notification checked or not yet
 * 
 * adding to the must have informations we have :
 * In case of newPublication or approval we must store the publication id in order to get it after
 * In Case of newPosition the position is already stored in the employee object and we can get the new position from the object
 * In Case of newLocation is the same thing as the newPosition logic
 * 
 */


const notificationSchema = new mongoose.Schema({
 
    notificationType: { type:String, required:true },
    date: { type: Date, default: Date.now },
    isChecked: { type:Boolean, default:false },
    employee: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Employee"
    },
    publication: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Publication"  
    }
});


module.exports = mongoose.model('Notification',notificationSchema);



/*
 *   Thought stupid!
 * 
 *  ( 
 *   there is another approach for the O(n*m) space complexity problem which is:
 *   for every notification we gonna have instead of isChecked field a checkedBy field
 *   which gonna be a list and gonna store the id of the employees who checked the notif 
 *   and also for delete notif feature we gonna have instead of notifications field in the employee model
 *   deletedNotifications list .... 
 *   the complexity of this approach is worst since we gonna do the comparaison n*m times 
 *   and the complexity of the comparaison algorithme must also be taking into account
 *   and in my point of view is less elegant 
 * )
 *  
 */