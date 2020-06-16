const  jwt       = require('jsonwebtoken'),
       bcrypt    = require('bcrypt'),
       util      = require('util'); 


class AuthService{


    constructor(employeeRepo){
        this._employeeRepo = employeeRepo;
    }

   async login(login,password){
        try {
          let user    = await this._employeeRepo.findByLoginWithAgency(login);
          if(user != undefined){ 
            let isValid = await bcrypt.compare(password, user.userAccount.password);
            if (!isValid) {
              throw("password incorrect");
            }else
              return {
                user: user,    
                token: jwt.sign({ userId : user._id }, 'Digi_Share_RONDOM_SECRET', { expiresIn: '24h'})
              };
           }
           else 
              throw("user unfound");
        }
        catch(error){
              throw(error);
        }
    }

    async signup(employee){
        try {
            let hash        = await bcrypt.hash(employee.userAccount.password, 10);
            employee.userAccount.password = hash;
            console.log(util.inspect(employee));
            let newEmployee = await this._employeeRepo.create(employee);
            return newEmployee;
        } catch (error) {
            throw(error);
        }
    }


}

module.exports = AuthService;