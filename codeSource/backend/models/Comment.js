const mongoose = require('mongoose');
const uniqueValidator = require('mongoose-unique-validator');

const commentSchema = new mongoose.Schema({

    date: { type: Date, default: Date.now },
    text: { type: String, required: true },
    commentator : {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Employee"
    },
    publication: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Publication"
    },

});

module.exports = mongoose.model('Comment', commentSchema);