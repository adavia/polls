const onJoin = (res, channel) => {
  document.querySelectorAll(".vote-btn").forEach(el => {
    el.addEventListener("click", event => {
      event.preventDefault();
      pushVote(el, channel);
    });
  });
}

// Push votes
const pushVote = (el, channel) => {
  channel
    .push("vote", { option_id: el.getAttribute("data-option-id") })
    .receive("ok", res => console.log("You Voted!"))
    .receive("error", res => console.log("Failed to vote:", res));
}

const connect = socket => {
	// Only connect to the socket if the polls channel actually exists!
	const enablePolls = document.getElementById("poll-channel");

	if (!enablePolls) return;

  const pollId = enablePolls.dataset.poll;
	const remoteIp = document.getElementsByName("remote_ip")[0].getAttribute("content");

	// Create a channel to handle joining/sending/receiving
	const channel = socket.channel(`polls:${pollId}`, { remote_ip: remoteIp });

	// Next, join the topic on the channel!
	channel.join()
	  .receive("ok", res => onJoin(res, channel))
    .receive("error", res => {
    	console.log("Failed to join channel:", res)
    });

  // Vote poll
  channel.on("new_vote", ({ option_id, votes }) => {
		document.getElementById("vote-count-" + option_id).innerHTML = votes;
	});
}

export default { connect };
	
