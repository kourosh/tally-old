//Check for payment method before allowing users to support or oppose

function checkPaymentMethod(done) {
	$.ajax({
		type: "GET",
		url: "/payment_methods/check",
		success: function(data) {
			if (data.result === "ok") {
				done();
			} else {
				window.location.href="/payment_methods/new?error=no_method";
			}
		}
	});
}

//Support a politician

$(document).on("click", "a.support", function(event) {
	event.preventDefault();

	checkPaymentMethod(function() {
		localStorage.setItem("event_id", $(this).attr("id"));

		$("#support-modal").modal("show");
	});
});

$(document).on("click", "#support-confirm-button", function() {
	$("#support-modal").modal("hide");

	$("#event" + localStorage.getItem("event_id")).css("background-color", "#F0FFED");
});

//Oppose a politician

$(document).on("click", "a.oppose", function(event) {
	event.preventDefault();

	checkPaymentMethod(function() {
		localStorage.setItem("event_id", $(this).attr("id"));

		$("#oppose-modal").modal("show");
	});
});

$(document).on("click", "#oppose-confirm-button", function() {
	$("#oppose-modal").modal("hide");

	$("#event" + localStorage.getItem("event_id")).css("background-color", "#FFEDED");
});