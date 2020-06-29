const jwt      = require('jsonwebtoken');
const util     = require('util');


exports.employeeObjectFromRequest = (req)=>{
    return req.file ?  {
        imageUrl: `${req.protocol}://${req.get('host')}/api/employees/profilesImages/${req.file.filename}`,
       ...req.body
    }
: 
    {
        ...req.body
    };
}

exports.returnUserIdFromHeader = (req)=>{
    try{
        console.log(req.headers.authorization);
        const token = req.headers.authorization.split(' ')[1];
        const decodedToken = jwt.verify(token, 'Digi_Share_RONDOM_SECRET');
        const userId = decodedToken.userId;
        console.log("the userId is : "+userId);
        return userId;
    }catch(err){
        console.log(err);
        return 0;
    }
}