$(document).on("submit", "#payment-method-form", function(event) {
	event.preventDefault();

	var that = this;

	Stripe.card.createToken({
		name: $("#card-name").val(),
		number: $("#card-number").val(),
		cvc: $("#card-cvv").val(),
		exp_month: $("#card-month").val(),
		exp_year: $("#card-year").val()
	}, function(status, response) {
		if (response.error) {
			$("#stripe-error").html(response.error.message).slideDown();
		} else {
			$("#stripe-error").slideUp();
			$("#submit-card").attr("disabled", "disabled").html("Loading...");
			$("#payment-token").val(response.id);

			that.submit();
		}
	});
});