const mongoose = require('mongoose');

const roomSchema = new mongoose.Schema({

    chat_id: { type: String, required: true},
    from: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Employee"
    },
    to: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Employee"
    },
    last_message: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Message"
    },
    messages:[
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: "Message"
        }
    ], // list of messages of the room
});

module.exports = mongoose.model('Room', roomSchema);
