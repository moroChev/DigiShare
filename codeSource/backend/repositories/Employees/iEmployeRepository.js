

class IEmployeeRepository{


    


    findById(id){};


    findAllWithAgency(){};


    findByLoginWithAgency(login){};


    create(object){};


    findByIdWithPublications(id){};


    findByIdWithPublications_And_Agency(id){}


    findByIdAndDelete(){};

   /// find by id and add an element to an array 
   /// we must precise the array name and then give it an element
    findById_And_AddToSet(id, object){};


    /// pull an element from an array
    findById_And_Pull(id, object){};


    /// find by id and set some fields or redefine a row
    /// it's dedicated to modify
    findById_And_Set(id, object){};


    /// search by firstname or lastname or position or mail
    search(search){};


}


module.exports  = IEmployeeRepository;