const mongoose = require('mongoose');
const uniqueValidator = require('mongoose-unique-validator');

const userSchema = mongoose.Schema({
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true},
    employer: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Employer"
    }
});

userSchema.plugin(uniqueValidator);

module.exports = mongoose.model('User', userSchema);