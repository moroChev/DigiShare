const mongoose = require('mongoose');

const agencySchema = new mongoose.Schema({

    name: { type: String, required: true},
    adress: { type: String, required: true},
    telephone: { type: String, required: true},
    employees:[
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: "Employe"
        }
    ], // list of employers of teh agence
    
});

module.exports = mongoose.model('Agency', agencySchema);
