class AuthController{

  constructor(authService){
    this._authService = authService;
  }

  login = async (req,res,next) => {
    try {
      let response = await this._authService.login(req.body.login, req.body.password);
      res.status(200).json(response);
    } catch (error) {
      res.status(500).json(error);
    }
  }

  signup = async (req,res,next) => {
    try {
      let employee = {
        ...req.body
      } 
      
      let newEmployee = await this._authService.signup(employee);
      res.status(201).json(newEmployee);
    } catch (error) {
      res.status(500).json(error);
    }
  }

}

module.exports = AuthController;

