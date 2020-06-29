const mongoose = require('mongoose');
const uniqueValidator = require('mongoose-unique-validator');

const employeeSchema = new mongoose.Schema({
     
    firstName : { type:String, required: true },
    lastName : { type: String, required: true },
    imageUrl : { type: String, required: false},
    email: { type: String, required: true },
    position: { type: String, required: true },   // the position occupied within the society
    canApprove: { type: Boolean, required: true }, // the right to approve a publication 
    userAccount: {
                login: { type: String, required: true, unique: true },
                password: { type: String, required: true }
    },
    agency: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Agency"
    }, // the agency where he works
    publications: [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: "Publication"  
        }
    ], 
});

// add indexs for search feature
employeeSchema.index({firstName: 'text', lastName:'text', position: 'text', email:'text'});

module.exports = mongoose.model('Employee', employeeSchema);