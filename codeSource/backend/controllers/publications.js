const jwt                = require('jsonwebtoken');
const util               = require('util');

class PublicationController{

    constructor(publicationService){
        this.publicationService = publicationService;
    }

   ///Ok
  getPublicationById    = async (req,res,next)=>{
      try {
          console.log(req.params.id);
          let publication = await this.publicationService.getPublicationById(req.params.id);
          res.status(200).json(publication);
      } catch (error) {
          res.status(500).json(error);
      }
  }  

  ///Ok
  getAllPublications         = async (req, res, next) => {
        console.log("controller pub get All Pub");
        try {
          let publications =  await this.publicationService.getAllPublications();
          res.status(200).json(publications);
        } catch (error) {
            res.status(401).json({ error: error });
        }
    }

   ///OK
    createPublication        = async (req,res,next)=>{
        try {
            let publication = this.returnPublicationFromRequest(req);
            console.log("create Post in controller "+publication);
            let newPublication = await this.publicationService.createPublication(publication);
            res.status(201).json(newPublication);
        } catch (error) {
            console.log('error in creation controller'+error);
            res.status(401).json({ error: error });
        }
    }


   ///Ok
    deletePublication       = async (req,res,next)=>{
        try {
            console.log("delete this one"+req.params.id);
            let response = await this.publicationService.deletePublication(req.params.id);
            res.status(200).json(response);
        } catch (error) {
            res.status(500).json({ error: error });
        }
    }

    ///Ok
    getPublicationLikes     = async (req,res,next)=>{
        try {
            let publication = await this.publicationService.getPublicationLikes(req.params.id);
            res.status(200).json(publication);
        } catch (error) {
            res.status(500).json(error);
        }
     }


    ///Ok
     modifyPublication      = async (req,res,next)=>{ 
         console.log("modify pub ...");
        try {
            let publicationP = this.returnPublicationFromRequest(req);
            console.log(util.inspect(publicationP)+"id pub : "+req.params.id);
            let publication = await this.publicationService.modifyPublication(req.params.id,publicationP);
            res.status(200).json(publication);
        } catch (error) {
            res.status(500).json(error);
        }
    }

    ///Ok
    addlikePublication     = async (req,res,next)=>{ 
        try {
            let publication  = await this.publicationService.addlikePublication(req.params.id, req.body.idEmployee);
            res.status(200).json(publication);
        } catch (error) {
            res.status(500).json(error);
        }
    }

    ///Ok
    removeLikePublication  = async (req,res,next)=>{ 
        try {
            let userId       = this.returnUserIdFromHeader(req); 
            let publication  = await this.publicationService.removeLikePublication(req.params.id, userId);
            res.status(200).json(publication);
        } catch (error) {
            res.status(500).json(error);
        }
    }
    
    ///Ok
    approvePublication    = async (req,res,next)=>{ 
        try {
            let isApproved    = req.body.isApproved;
            let approvedBy    = req.body.approvedBy;
            let publicationId = req.params.id;
            let publication = await this.publicationService.approvePublication(publicationId,approvedBy,isApproved);
            res.status(200).json(publication);
        } catch (error) {
            res.status(500).json(error);
        }
    }

    returnUserIdFromHeader(req){
        try{
            console.log(req.headers.authorization);
            const token = req.headers.authorization.split(' ')[1];
            const decodedToken = jwt.verify(token, 'Digi_Share_RONDOM_SECRET');
            const userId = decodedToken.userId;
            return userId;
        }catch(err){
            console.log(err);
            return 0;
        }
    }

     ///OK
     returnPublicationFromRequest(req){
        
        let pub = req.file ?  {
                    imageUrl: `${req.protocol}://${req.get('host')}/api/publications/postsImages/${req.file.filename}`,
                    ...req.body
                }
            :
                {
                    ...req.body
                };
        return pub
    }

}

module.exports = PublicationController;



