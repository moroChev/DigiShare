const Publication = require('../models/Publication');
const Employe     = require('../models/Employe');

exports.getAllPublications = (req, res, next) => {

    console.log("getALLPublication is called ! ");
    Publication.find()
        .populate([
            {
                path: 'approvedBy',
                model: 'Employe'
            },
            {
                path: 'postedBy',
                model: 'Employe'
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
    console.log("create Publication is called ! ");
    delete req.body.id;
    let publication = new Publication(
        {
            ...req.body
        }
    );
    console.log(publication);
    publication.save()
        //   Publication.create({ ...req.body })
        .then(
            (publicationSaved) => {
                console.log("just after saving pub, posted by : " + publicationSaved.postedBy);
                // looking for the employee who posted the publication to add it to his publications list
                Employe.findById({ _id: publicationSaved.postedBy })
                    .then(
                        (employeWhoPosted) => {
                            console.log("la publication : " + publicationSaved + " l'employe : " + employeWhoPosted);
                            employeWhoPosted.publications.push(publicationSaved);
                            console.log("pub added to the list");
                            employeWhoPosted.save()
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
                      model: 'Employe'
                    },
                    {
                      path: 'postedBy',
                      model: 'Employe'
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