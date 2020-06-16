const mongoose = require('mongoose');

const agencySchema = new mongoose.Schema({

    name: { type: String, required: true},
    address: { type: String, required: true},
    telephone: { type: String, required: true},
    logo: {type: String, required: true},
    email: {type: String, required: true},
    location: {
    	lat: {type: Number, required: true},
    	lng: {type: Number, required: true}
    },
    subsidiaries: [
    	{
    		type: mongoose.Schema.Types.ObjectId,
    		ref: "Agency"
    	}
    ],
    employees:[
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: "Employee"
        }
    ], // list of employers of teh agence
    
});


module.exports = mongoose.model('Agency', agencySchema);
