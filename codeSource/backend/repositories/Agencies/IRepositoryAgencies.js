class IRepositoryAgency{

    async getAgenciesWithEmployees(){};

    async createAgency(agency){};

    async getAgencyById(id){};

    async addEmployeeToAgency(employeeId, agencyId){};

    async addLocationToAgency(agencyId, location){};
    
}

module.exports = IRepositoryAgency;