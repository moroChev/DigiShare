const EmployeeRepositoryMongoDb       = require('../repositories/Employees/employeeRepositoryMongoDb'),
      EmployeeController              = require('../controllers/employees.js'),
      EmployeeService                 = require('../services/employeeService'),

      PublicationRepo                 = require('../repositories/Publications/publicationRepositoryMongoDb'),
      PublicationService              = require('../services/publicationService'),
      PublicationsController          = require('../controllers/publications'),
     
      AgencyRepositoryMongo           = require('../repositories/Agencies/agencyRepositoryMongoDb'),
      AgencyService                   = require('../services/agencyService'),
      AgencyController                = require('../controllers/agencies'),

      CommentRepositoryMongo          = require('../repositories/Comments/commentRepositoryMongoDb'),
      CommentService                  = require('../services/commentService'),
      CommentController               = require('../controllers/comments'), 

      AuthController                  = require('../controllers/auth'),
      AuthService                     = require('../services/authService'),
      
      NotificationController          = require('../controllers/notifications'),
      NotificationService             = require('../services/notificationService'),
      NotificationRepoMongoDb         = require('../repositories/Notifications/notificationRepositoryMongoDb'),
      
      SocketRepo                      = require('../socketUtils/socket_repo');
      
      
let socketRepo = new SocketRepo();


let employeeRepo             = new EmployeeRepositoryMongoDb();
let notifRepo                = new NotificationRepoMongoDb();
let publicationRepo          = new PublicationRepo();
let agencyRepo               = new AgencyRepositoryMongo();
let commentRepo              = new CommentRepositoryMongo();


let employeeService          = new EmployeeService(employeeRepo,notifRepo);
let employeeController       = new EmployeeController(employeeService); 


let notificationService      = new NotificationService(notifRepo,employeeRepo);
let notificationController   = new NotificationController(notificationService,socketRepo);


let publicationService       = new PublicationService(publicationRepo,employeeRepo,notificationController);
let publicationsController   = new PublicationsController(publicationService);

let commentService           = new CommentService(commentRepo,publicationRepo,notificationController);
let commentController        = new CommentController(commentService);


let agencySvc                = new AgencyService(agencyRepo);
let agencyController         = new AgencyController(agencySvc);


let authService              = new AuthService(employeeRepo);
let authController           = new AuthController(authService);



module.exports = {
    publicationsController: publicationsController,
    employeeController: employeeController,
    agencyController: agencyController,
    authController: authController,
    notificationController: notificationController,
    commentController: commentController,
    socketRepo: socketRepo
}      
