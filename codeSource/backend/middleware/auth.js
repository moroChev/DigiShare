const jwt      = require('jsonwebtoken');
const util     = require('util');

module.exports = (req, res, next) => {
  try {
    
    console.log('Authentifcation midel user id sended in req.body.userId: '+req.body.userId);
    console.log(util.inspect(req.headers.authorization));
    const token = req.headers.authorization.split(' ')[1];
    const decodedToken = jwt.verify(token, 'Digi_Share_RONDOM_SECRET');
    const userId = decodedToken.userId;
    console.log('user id sended in req.body.userId: '+util.inspect(req.body.userId)+"userID from jwt : "+userId);
    if (req.body.userId && req.body.userId !== userId) {
        console.log("Invalid user ID");
      throw 'Invalid user ID';
    } else {
      console.log("auth midelware user ID is ok you can pass ...");
      next();
    }
  } catch {
    console.log("Invalid request");
    res.status(401).json({
      error: new Error('Invalid request!')
    });
  }
  
};