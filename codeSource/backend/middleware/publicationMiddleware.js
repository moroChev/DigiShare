const jwt         = require('jsonwebtoken'),
      Employee    = require('../models/Employee'),
      Publication = require('../models/Publication'),
      util        = require('util');

exports.canApprovePublication = (req, res, next) => {

    try {
      console.log(req.headers.authorization);
      const token = req.headers.authorization.split(' ')[1];
      const decodedToken = jwt.verify(token, 'Digi_Share_RONDOM_SECRET');
      const userId = decodedToken.userId;
      Employee.findById(userId)
              .then((user)=>{
                if(user.canApprove)
                {
                    next();
                }else{
                    throw 'Invalid user right';
                }
               })
              .catch((err)=>{res.status(401).json({
                error: new Error('Invalid request!')
                  });
             })
    } catch {
      console.log("Invalid request");
      res.status(401).json({
        error: new Error('Invalid request!')
      });
    }

};

exports.canModifyPublication = (req,res,next) => {

};


exports.canRemovePublication = (req,res,next) => {
  
  console.log("canRemove Publication midelware");
  try {
    console.log(req.headers.authorization);
    const token = req.headers.authorization.split(' ')[1];
    const decodedToken = jwt.verify(token, 'Digi_Share_RONDOM_SECRET');
    const userId = decodedToken.userId;
    Employee.findById(userId)
            .then((user)=>{
              console.log(user._id+"  -- or -- "+user);
              console.log("---------------------------------------------------------------")
              Publication.findById(req.params.id)
                         .populate(
                            {
                            path: 'postedBy',
                            model: 'Employee'
                            }
                         )
                         .exec((err,publication)=>{
                           console.log( "the postedBy id is:"+publication.postedBy._id+" the user id is : ");
                          if(user._id.equals(publication.postedBy._id)){
                            console.log("the user can remove the publication go ahead");
                            next();
                          }
                           else if(err){
                             console.log("erreur en findById Publication ...");
                            res.status(401).json({error: new Error('Invalid request!') });
                           }else{
                             console.log("the same error of before");
                            res.status(401).json({error: new Error('The User doesnt have the right to remove this publication') });
                           }
                        })
             })
            .catch((err)=>{
              console.log("error in finding the user By id "); 
              res.status(401).json({error: new Error('Invalid request!')});
           })
  } catch {
    console.log("Invalid to the user Id id from the token ");
    res.status(401).json({
      error: new Error('Invalid request!')
    });


  }














}