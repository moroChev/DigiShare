// Reserved Events
exports.ON_CONNECTION = 'connection';
exports.ON_DISCONNECT = 'disconnect';

// Main Events
exports.EVENT_IS_USER_ONLINE = 'check_online';
exports.EVENT_SINGLE_CHAT_MESSAGE = 'single_chat_message';
exports.EVENT_MESSAGE_SEEN = 'message_seen';

// Sub Events
exports.SUB_EVENT_RECEIVE_MESSAGE = 'receive_message';
exports.SUB_EVENT_IS_USER_CONNECTED = 'is_user_connected';
exports.SUB_EVENT_MESSAGE_STATUS_CHANGED = 'message_status_changed';

//Status
exports.STATUS_MASSAGE_SENDING = 10000;
exports.STATUS_MASSAGE_NOT_SENT = 10001;
exports.STATUS_MASSAGE_SENT = 10002;
exports.STATUS_MASSAGE_DELIVERED = 10003;
exports.STATUS_MASSAGE_SEEN = 10004;