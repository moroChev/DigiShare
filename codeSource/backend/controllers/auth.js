//const User    = require('../models/User');
const Employe = require('../models/Employe');
const jwt     = require('jsonwebtoken');
const bcrypt  = require('bcrypt'); 

exports.login = (req,res,next) => {

  console.log("login reteched \n"+req.body.login+req.body.password);
    Employe.findOne({ 'userAccount.login' : req.body.login })
           .then((user)=>{
             console.log(user);
            if (!user) {
                return res.status(401).json({ error: 'User unfound !' });
              }
                  bcrypt.compare(req.body.password, user.userAccount.password)
                    .then(valid => {
                      if (!valid) {
                        console.log("comparsing of the the password isn't correct")
                        return res.status(401).json({ error: 'Password incorrect !' });
                      }
                      console.log("yes auth with success !");
                      res.status(200).json({
                        userId: user._id,
                        token: jwt.sign(
                            { userId : user._id },
                            'Digi_Share_RONDOM_SECRET',
                            { expiresIn: '24h'}
                        )
                      });
                    })
                    .catch(error => {console.log("error in comparaison of the password");res.status(500).json({ error })});
           })
           .catch(error => {console.log("error in finding the employe"); res.status(500).json({ error })})
};

exports.signup = (req,res,next) => {
    
        console.log("sign up reteched \n");

        bcrypt.hash(req.body.userAccount.password, 10)
              .then((hash) => {
                        const employe = new Employe({
                          userAccount:{
                            login: req.body.userAccount.login,
                            password: hash
                          },
                          firstName : req.body.firstName,
                          lastName : req.body.lastName,
                          email: req.body.email,
                          position: req.body.position, 
                          canApprove: req.body.canApprove
                        })
                         console.log(employe)
                         employe.save()
                                .then((employeSaved) => {
                                    console.log("user created ! "+employeSaved);
                                    res.status(201).json({ message: 'User created !' });
                        
                                })
                                .catch((error) => {console.log("error in saving the user"); res.status(400).json({ error })});
               })
              .catch((error) => { console.log("error in hashing the password");  res.status(500).json({ error })});
            
};