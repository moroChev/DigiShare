class IPublicationRepository{

    constructor(){};

    

    /// find all publications with employees's agencies
    find_And_Employees_Agencies(){};



    /// creation of a publication
    create(object){};



    /// find a publication by id
    findById(id){};



    /// find a publication by id and delete
    findByIdAndDelete(id){};



    ///find by id and add an element to an array
    ///if the element doesn't exist 
    ///else it does nothing
    findById_And_AddToSet(id, object){};



    /// find by id and remove an element from an array
    /// example of usage : 
    /// pull an employee from the list of likes
    /// it takes {"likes": id}
    findById_And_Pull(id, object){};



    /// get publication with all employees who likes the post and their agencies 
    findById_AllLikers_Agencies(id){};



    /// find by id and set some fields or redefine a row
    /// it's dedicated to modify
    findById_And_Set(id, object){};






}

module.exports = IPublicationRepository;