const IPublicationRepository = require("./IPublicationRepository");
const Publication            = require("../../models/Publication");

class PublicationRepositoryMongoDb extends IPublicationRepository{

    constructor(){
        super();
    }

    async findById(id){
        try{
            console.log("in repo .... "+id);
            let pub = await Publication.findById(id);
            return pub;
        } catch (error) {
            throw(error);
        }
    }

    /// getting all the publications with employees agencies
    async find_And_Employees_Agencies(){
        console.log("repository pub");
        try {
            let publications;
                publications = await Publication.find() 
                                                .populate(
                                                [
                                                    { path: 'approvedBy', populate : { path : 'agency' } },
                                                    { path: 'postedBy', populate : { path : 'agency' } }
                                                ]
                                                );
            return publications;
        } catch (error) {
            console.log('error in repo');
            throw(error);
        }
    }

    async create(publication){
        console.log("repo create ... Post"+publication);
        try {
            let newPublication;
            newPublication = await Publication.create(publication);
            return newPublication;
        } catch (error) {
            console.log("error in repo post "+error);
            throw(error);
        }
    }


    async findByIdAndDelete(id){
        try {
            console.log("delete in repo "+id);
            let deletedOne = await Publication.findByIdAndDelete(id);
            return deletedOne; 
        } catch (error) {
            console.log("error in suppression pub repos");
            throw(error)
        }
    }


    async findById_And_AddToSet(id, object){
        try{
            let publication = await Publication.findByIdAndUpdate(id, {$addToSet : object },{ safe: true, new: true});
            return publication;
        } catch (error) {
            console.log('error in addToSet publication');
            throw(error);   
        }
    };

    async findById_And_Pull(id, object){
        try {
            let publication = await Publication.findByIdAndUpdate(id, {$pull: object },{ safe: true, new: true});
            console.log(publication);
            return publication;
        } catch (error) {
            console.log('error in pull publication');
            throw(error);
        }
    };

    async findById_And_Set(id, object){
        try{
            let publication = await Publication.findByIdAndUpdate(id, {$set : object },{ safe: true, new: true});
            return publication;
        } catch (error) {
            console.log('error in set publication');
            throw(error);   
        }
    };

    async findById_AllLikers_Agencies(id){
        try {
            let publication = await Publication.findById(id).populate({ path: 'likes', populate : { path : 'agency' } });
            return publication;
        } catch (error) {
            throw(error);
        }

    };


}


module.exports = PublicationRepositoryMongoDb;