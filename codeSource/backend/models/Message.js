const mongoose = require('mongoose');

const messageSchema = new mongoose.Schema({

    chat_id: { type: String, required: true},
    from: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Employee"
    },
    to: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Employee"
    },
    message: {type: String, required: true},
    sent_at: { type: Date, required: true},
    chatType: {type: String, required: false},
    to_user_online_status: { type: Boolean, required: true},
    status: {type: Number, required: true},
});

module.exports = mongoose.model('Message', messageSchema);
