(function () {
	var timeoutMs = 30 * 60 * 1000;
	var timeoutId = null;
	var events = ["click", "keydown", "mousemove", "scroll", "touchstart"];

	function resetTimer() {
		if (timeoutId) {
			clearTimeout(timeoutId);
		}
		timeoutId = setTimeout(function () {
			window.location.href = "logout";
		}, timeoutMs);
	}

	events.forEach(function (eventName) {
		document.addEventListener(eventName, resetTimer, { passive: true });
	});

	resetTimer();
})();
