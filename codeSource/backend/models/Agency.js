const mongoose = require('mongoose');

const agencySchema = new mongoose.Schema({

    name: { type: String, required: true},
    adress: { type: String, required: true},
    telephone: { type: String, required: true},
    employers:[
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: "Employer"
        }
    ] // list of employers of teh agence

});

module.exports = mongoose.model('Agency', agencySchema);
