const String _serverIP = 'http://localhost';
//Platform.isIOS ? 'http://localhost' : 'http://10.0.0.2';
const int SERVER_PORT = 3000;
const String connectUrl = '$_serverIP:$SERVER_PORT';

// Events
const String ON_USER_ONLINE = 'is_user_connected';
const ON_MESSAGE_STATUS_CHANGED = 'message_status_changed';
const String ON_MESSAGE_RECEIVED = 'receive_message';
const String IS_USER_ONLINE_EVENT = 'check_online';
const String EVENT_SINGLE_CHAT_MESSAGE = 'single_chat_message';
const String EVENT_MESSAGE_SEEN = 'message_seen';
const String ON_NOTIFICATION = 'notification';

// Status
const int STATUS_MASSAGE_SENDING = 10000;
const int STATUS_MASSAGE_NOT_SENT = 10001;
const int STATUS_MASSAGE_SENT = 10002;
const int STATUS_MASSAGE_DELIVERED = 10003;
const int STATUS_MASSAGE_SEEN = 10004;

// Type of Chat
const String SINGLE_CHAT = 'single_chat';