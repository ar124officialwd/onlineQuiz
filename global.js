function preventDefault(event) {
  event.preventDefault();
}

function linkButtonClick() {
  const href = $(event.target).data("href");
  if (href && href != "") {
    window.location = href;
  }
}
