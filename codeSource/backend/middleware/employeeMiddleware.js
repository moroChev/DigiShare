const globalUtils = require('../utility/globalUtil');


exports.canNotifsAccess = (req,res,next)=>{

    if(req.params.id == globalUtils.returnUserIdFromHeader)
      next();
    else
      res.status(401).json({message:'you can not access to those notifications'});
  
} 