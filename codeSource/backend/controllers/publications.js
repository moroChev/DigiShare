const Publication  = require('../models/Publication');
const Employee     = require('../models/Employee');
const util         = require('util');
const jwt          = require('jsonwebtoken');

exports.getAllPublications = (req, res, next) => {

    console.log("getALLPublication is called ! ");
    Publication.find()
        .populate([
            {
                path: 'approvedBy',
                populate : {
                    path : 'agency'
                  }
            },
            {
                path: 'postedBy',
                populate : {
                    path : 'agency'
                  }
            }]
        )
        .then((publications) => {
            let publicationsSortedByDate = publications.sort((pubA,pubB)=>  pubB.date - pubA.date )
            console.log(publicationsSortedByDate); 
            res.status(200).json(publicationsSortedByDate);
        })
        .catch((err) => {
            res.status(401).json({ error: err });
        });

}

exports.createPublication = (req, res, next) => {

    console.log(`create Publication is called ! ${ req.file ==null } or ` );
    console.log(`the host is : +${req.get('host')}`);
    
    delete req.body._id;
    let pub = req.file ?  {

                 imageUrl: `${req.protocol}://${req.get('host')}/api/publications/postsImages/${req.file.filename}`,
                ...req.body
             }
        :
             {
                 ...req.body
             };
    let publication = new Publication(
        {  
            ...pub
        }
    );
    console.log(publication);
    publication.save()
        //   Publication.create({ ...req.body })
        .then(
            (publicationSaved) => {
                console.log("just after saving pub, posted by : " + publicationSaved.postedBy);
                // looking for the employee who posted the publication to add it to his publications list
                Employee.findById({ _id: publicationSaved.postedBy })
                    .then(
                        (employeeWhoPosted) => {
                            console.log("la publication : " + publicationSaved + " l'employee : " + employeeWhoPosted);
                            employeeWhoPosted.publications.push(publicationSaved);
                            console.log("pub added to the list");
                            employeeWhoPosted.save()
                                .then((employeeSavedAfterAddingPub) => { console.log("pub added to the list into DATABASE"); res.status(200).json(employeeSavedAfterAddingPub); })
                                .catch((err) => { console.log("error in saving the employee"); res.status(400).json({ error: err }) });

                        }
                    )
                    .catch((err) => { console.log("error in finding the employee"); res.status(400).json({ error: err }) });
            })
        .catch((err) => { console.log("error in saving the pub" + err); res.status(400).json({ error: err }) });
        
}


exports.getPublicationById = (req, res, next) => {

    console.log("get pub By id");
    Publication.findById(req.params.id)
               .populate([
                    {
                      path: 'approvedBy',
                      model: 'Employee'
                    },
                    {
                      path: 'postedBy',
                      model: 'Employee'
                    }]
               )
               .then((publication) => {
                            console.log(publication);
                            res.status(200).json(publication);
                })
                .catch((err) => {
                           res.status(401).json({ error: err });
                });

}

exports.addlikePublication = (req,res,next)=>{
    console.log("like is retched with employee id : "+req.body.idEmployee);
    Employee.findById(req.body.idEmployee)
            .then((employee)=>{
                    Publication.findByIdAndUpdate(req.params.id,{ $addToSet: { "likes": employee } },{ safe: true, new: true})
                    .then((publication)=>{
                        console.log("like is retched "+publication+"and the person who liked is "+employee.firstName+" his id is : "+employee._id);
                        res.status(201).json(publication);
                    })
                    .catch((err)=>{res.status(500).json(publication);})
            })
            .catch((err)=>{res.status(400).json(err);})

}

exports.removeLikePublication = (req,res,next) =>{

    let userId = returnUserIdFromHeader(req);

    console.log("luser id who attemp to dislike is"+util.inspect(userId));
    Employee.findById(userId)
    .then((employee)=>{
        console.log("the empooyee found is : "+employee+" pub id : "+req.params.id);
            Publication.findByIdAndUpdate(req.params.id,{ $pull: { "likes": employee._id } },{ safe: true, new: true})
            .then((publication)=>{
                console.log("this dislike is goooooood ")
                res.status(201).json(publication);
            })
            .catch((err)=>{res.status(500).json(publication);})
    })
    .catch((err)=>{res.status(400).json(err);})



}

exports.getPublicationLikes = (req,res,next)=>{

    Publication.findById(req.params.id)
               .populate(
                    {
                        path: 'likes',
                        populate : {
                            path : 'agency'
                          }
                    }
                   )
                .then((publication) => {
                            console.log(publication);
                            res.status(200).json(publication);
                    })
                .catch((err) => {
                           res.status(401).json({ error: err });
                    });

}

exports.modifyPublication = (req,res,next)=>{
    
    
    let publicationF = {...returnPublicationFromRequest(req)};
    console.log("yes it's modification method ...."+util.inspect(publicationF)+" for the pub id :"+req.params.id);
    
    Publication.findByIdAndUpdate(req.params.id,{ $set: publicationF } ,{ safe: true, new: true})
               .then((publication) => {
                    console.log(publication);
                    res.status(200).json(publication);
               })
               .catch((err) => {
                        console.log("error in saving the update ... ");
                        res.status(401).json({ error: err });
                    });
};


exports.deletePublication = (req,res,next)=>{
    console.log("delete publication .... "+req.params.id);
    Publication.findByIdAndDelete(req.params.id)
               .then(()=>{ console.log("everything is good ..."); res.status(200).json({message : "suppression ok !"}); })
               .catch((err)=>{res.status(400).json(err);})
}


// function return a publication object based on whether the received publication contains image or not  
function returnPublicationFromRequest(req)
{
  return req.file ?  {

        imageUrl: `${req.protocol}://${req.get('host')}/api/publications/postsImages/${req.file.filename}`,
       ...req.body
    }
:
    {
        ...req.body
    };
}




//method used to get the userId from the header in order to remove his like to a given publication
function returnUserIdFromHeader(req){

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



exports.approvePublication = (req,res,next) => {

    console.log("---------------------------------------ApprovePublication------------------------------------------------");
    console.log("to approve a"+req.params.id+" pub : "+util.inspect(req.body.isApproved)+" and user id who approved : "+util.inspect(returnUserIdFromHeader(req)));

    let isApproved = req.body.isApproved;
    let approvedBy = returnUserIdFromHeader(req);

    Publication.findByIdAndUpdate(
                   req.params.id,
                  {
                    $set:
                    { 
                        isApproved: isApproved,
                        approvedBy: approvedBy 
                    }
                  },
                  { safe: true, new: true}
                )
                .then((publication)=>{
                    res.status(200).json({ message: "publication is examined with success", publication: publication });
                })
                .catch((err)=>{
                    res.status(500).json({ error: err });
                });

}