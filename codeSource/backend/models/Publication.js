const mongoose = require('mongoose');

const publicationSchema = new mongoose.Schema({

    date: { type: Date, default: Date.now },
    content: { type: String, required: true },
    imageUrl: { type: String, required: false },
    isApproved : { type: Boolean, default: false },
    approvedBy : {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Employee"
    },   // the employee who approved the publication
    postedBy: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Employee",
    },  // the employee who posted the publication
    likes: [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: "Employee",
        }
    ]
});


module.exports = mongoose.model('Publication', publicationSchema);