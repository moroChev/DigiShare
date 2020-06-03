const Publication  = require('../models/Publication');
const Employee     = require('../models/Employee');

exports.getAllPublications = (req, res, next) => {

    console.log("getALLPublication is called ! ");
    Publication.find()
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
        .then((publications) => {
            console.log(publications);
            res.status(200).json(publications);
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

                 imageUrl: `${req.protocol}://${req.get('host')}/images/${req.file.filename}`,
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

exports.likePublication = (req,res,next)=>{

    Employee.findById(req.body.idEmployee)
            .then((employee)=>{
                    Publication.findByIdAndUpdate(req.params.id,{ $push: { "likes": employee } },{ safe: true, new: true})
                    .then((publication)=>{
                        res.status(201).json(publication);
                    })
                    .catch((err)=>{res.status(500).json(publication);})
            })
            .catch((err)=>{res.status(400).json(err);})

}

exports.dislikePublication = (req,res,next)=>{

    Employee.findById(req.body.idEmployee)
            .then((employee)=>{
                    Publication.findByIdAndUpdate(req.params.id,{ $push: { "dislikes": employee } },{ safe: true, new: true})
                    .then((publication)=>{
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
                        model: 'Employee'
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

    Publication.findByIdAndUpdate(req.params.id, {...returnPublicationFromRequest(req)},{ safe: true, new: true})
               .then((publication) => {
                    console.log(publication);
                    res.status(200).json(publication);
            })
               .catch((err) => {
                        res.status(401).json({ error: err });
                    });
};

// function return a publication object based on whether the received publication contains image or not  
function returnPublicationFromRequest(req)
{
  return req.file ?  {

        imageUrl: `${req.protocol}://${req.get('host')}/images/${req.file.filename}`,
       ...req.body
    }
:
    {
        ...req.body
    };
}



/* exports.approvePublication = (req,res,next) => {
    console.log("to approve a"+req.params.id+" pub : "+req.params.isApproved);

    Publication.findByIdAndUpdate(
                   req.params.id,
                  { isApproved: req.params.isApproved },
                  { safe: true, new: true}
                )
                .then((publication)=>{
                    res.status(200).json({ message: "publication is examined with success", publication: publication });
                })
                .catch((err)=>{
                    res.status(500).json({ error: err });
                });

} */