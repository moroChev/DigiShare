const mongoose = require('mongoose');

const publicationSchema = new mongoose.Schema({

    date: { type: Date, default: Date.now },
    content: { type: String, required: true },
    imageUrl: { type: String, required: false },
    approvedBy : {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Employer"
    },   // the employed who approved the publication
    postedBy: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Employer"
    }  // the employed who posted the publication

  //  title: { type: String, },

});


module.exports = mongoose.model('Publication', publicationSchema);