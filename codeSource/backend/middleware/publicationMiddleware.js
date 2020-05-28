const jwt     = require('jsonwebtoken');
const Employe = require('../models/Employe');

exports.canApprovePublication = (req, res, next) => {

    try {
      console.log(req.headers.authorization);
      const token = req.headers.authorization.split(' ')[1];
      const decodedToken = jwt.verify(token, 'Digi_Share_RONDOM_SECRET');
      const userId = decodedToken.userId;
      Employe.findById(userId)
             .populate('employe')
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