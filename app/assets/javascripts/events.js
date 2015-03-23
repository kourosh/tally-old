$(document).on("click", "a.support", function(event) {
	event.preventDefault();

	$("#contribute-modal").modal("show");
});