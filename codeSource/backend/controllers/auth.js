<<<<<<< HEAD
const Employee  = require('../models/Employee'),
      jwt       = require('jsonwebtoken'),
      bcrypt    = require('bcrypt'),
      Agency    = require('../models/Agency'); 
=======
//const User    = require('../models/User');
const Employee = require('../models/Employee');
const jwt     = require('jsonwebtoken');
const bcrypt  = require('bcrypt'); 
>>>>>>> c49bb10ed707052ac9aed3e19b2d7cd9e93dfe46

exports.login = (req,res,next) => {

  console.log("login reteched \n"+req.body.login+req.body.password);
    Employee.findOne({ 'userAccount.login' : req.body.login })
<<<<<<< HEAD
            .populate(
              {
                path: 'agency',
                model: 'Agency'
              }
            )
            .exec((error,user)=>{
=======
           .then((user)=>{
>>>>>>> c49bb10ed707052ac9aed3e19b2d7cd9e93dfe46
             console.log(user);
            if (!user) {
                return res.status(401).json({ error: 'User unfound !' });
              }else if(user)
                {  bcrypt.compare(req.body.password, user.userAccount.password)
                    .then(valid => {
                      if (!valid) {
                        console.log("comparsing of the the password isn't correct")
                        return res.status(401).json({ error: 'Password incorrect !' });
                      }
                      console.log("yes auth with success !");
                      res.status(200).json({
                        user: user,         // I want to get since the login the most important informations e.g userId, firstName and lastName and AgencyName  
                        token: jwt.sign(
                            { userId : user._id },
                            'Digi_Share_RONDOM_SECRET',
                            { expiresIn: '24h'}
                        )
                      });
                    })
                    .catch(error => {console.log("error in comparaison of the password");res.status(500).json({ error })});
<<<<<<< HEAD
           }else
           {console.log("error in finding the employee"); res.status(500).json({ error })};
          });
=======
           })
           .catch(error => {console.log("error in finding the employee"); res.status(500).json({ error })})
>>>>>>> c49bb10ed707052ac9aed3e19b2d7cd9e93dfe46
};
exports.signup = (req,res,next) => {
    
        console.log("sign up reteched \n");
        console.log(req.body.firstName);

        bcrypt.hash(req.body.userAccount.password, 10)
              .then((hash) => {
                        const employee = new Employee({
                          userAccount:{
                            login: req.body.userAccount.login,
                            password: hash
                          },
                          firstName : req.body.firstName,
                          lastName : req.body.lastName,
                          email: req.body.email,
                          position: req.body.position, 
                          canApprove: req.body.canApprove,
<<<<<<< HEAD
                          imageUrl: req.body.imageUrl,
                          agency: req.body.agency
=======
                          imageEmployee: req.body.imageEmployee
>>>>>>> c49bb10ed707052ac9aed3e19b2d7cd9e93dfe46
                        })
                         console.log(employee)
                         employee.save()
                                .then((employeeSaved) => {
                                    console.log("user created ! "+employeeSaved);
<<<<<<< HEAD
                                    res.status(201).json({ message: 'User created !', employee: employeeSaved });
=======
                                    res.status(201).json({ message: 'User created !' });
>>>>>>> c49bb10ed707052ac9aed3e19b2d7cd9e93dfe46
                        
                                })
                                .catch((error) => {console.log("error in saving the user"); res.status(400).json({ error })});
               })
              .catch((error) => { console.log("error in hashing the password");  res.status(500).json({ error })});
            
};