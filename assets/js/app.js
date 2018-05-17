import "phoenix_html"
import socket from "./socket"

import Polls from "./poll";
import Chat from "./chat";

Polls.connect(socket);
Chat.loadChat(socket);
