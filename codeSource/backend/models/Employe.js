const mongoose = require('mongoose');

const employeSchema = new mongoose.Schema({

    firstName : { type:String, required: true },
    lastName : { type: String, required: true },
    email: { type: String, required: true },
    position: { type: String, required: true },   // the position occupied within the society
    canApprove: { type: Boolean, required: true }, // the right to approve a publication 
    userAccount: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User"
    },
    publications: [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: "Publication"  
        }
    ] // list of publications

});

module.exports = mongoose.model('Employe', employeSchema);