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

//Get information about event for modal windows

function getEventInfo(eventId, support, appendSelector, modalSelector) {
	$.ajax({
		type: "POST",
		url: "/events/get_info",
		data: {
			event_id: eventId,
			support: support
		},
		success: function(data) {
			data.pacs.forEach(function(pac) {
				$(appendSelector).html("").append("<option value='" + pac.id + "'>" + pac.committee_name + "</option>");
			});

			$(modalSelector).modal("show");
		}
	});
}

//Logic to support or oppose a politician

function supportOppose(support, optionSelector, done) {
	$.ajax({
		type: "POST",
		url: "/transactions",
		data: {
			event_id: localStorage.getItem("event_id"),
			support: support,
			amount: $("#contribute-amount").val() * 100,
			pac_id: $(optionSelector).val()
		},
		success: function() {
			done();
		},
		error: function() {
			alert("There was a problem processing your request.");
		}
	});
}

//Support a politician

$(document).on("click", "a.support", function(event) {
	event.preventDefault();

	var that = this;

	checkPaymentMethod(function() {
		localStorage.setItem("event_id", $(that).attr("id"));

		getEventInfo($(that).attr("id"), true, "#support-pac", "#support-modal");
	});
});

$(document).on("click", "#support-confirm-button", function() {
	supportOppose(true, "#support-pac", function() {
		$("#support-modal").modal("hide");

		$("#event" + localStorage.getItem("event_id")).css("background-color", "#F0FFED");
	});
});

//Oppose a politician

$(document).on("click", "a.oppose", function(event) {
	event.preventDefault();

	var that = this;

	checkPaymentMethod(function() {
		localStorage.setItem("event_id", $(that).attr("id"));

		getEventInfo($(that).attr("id"), false, "#oppose-pac", "#oppose-modal");
	});
});

$(document).on("click", "#oppose-confirm-button", function() {
	supportOppose(false, "#oppose-pac", function() {
		$("#oppose-modal").modal("hide");

		$("#event" + localStorage.getItem("event_id")).css("background-color", "#FFEDED");
	});
});