function getItemsWindow(windowSize, itemCount, onClick) {
  if (isNaN(windowSize) || windowSize < 0) {
    throw new Error("Window size must be non-negtive integer");
  }

  if (isNaN(itemCount) || itemCount < 0) {
    throw new Error("Window size must be non-negtive integer");
  }

  if (windowSize > itemCount) {
    windowSize = itemCount;
  }

  var itemsWindow = $(document.createElement('div'))
    .addClass("btn-group bg-light");
  var left = $(document.createElement('button')).prop("disabled", true)
    .text("<")
    .addClass("btn btn-primary")
    .prop("type", "button")
  var right = $(document.createElement('button'))
    .text(">")
    .addClass("btn btn-primary")
    .prop("type", "button")

  let btns = [];
  for (let i = 0; i < itemCount; i++) {
    btns[i] = $(document.createElement('button'))
      .text(i + 1)
      .addClass("btn btn-light")
      .css("width", "48px")
      .prop("type", "button")
      .click(() => {
        $(itemsWindow).find(".active").removeClass("active btn-secondary");

        btns[i].removeClass('btn-light');
        btns[i].addClass('btn-secondary active');

        if (onClick)
          onClick(btns[i], i, btns[i - 1], btns[i + 1]);
      });

    if (i >= windowSize) {
      btns[i].hide();
    }
  }

  if (btns[0]) {
    btns[0].click();
  }

  var currentRange = {
    least: 0,
    last: windowSize - 1
  };

  left.click(() => {
    if (currentRange.least <= 0) {
      return;
    }

    btns[currentRange.last--].hide();
    btns[--currentRange.least].fadeIn();

    if (currentRange.least <= 0) {
      left.prop("disabled", true);
    }

    right.prop("disabled", false);
  });

  right.click(() => {
    if (currentRange.last >= itemCount - 1) {
      return;
    }

    btns[currentRange.least++].hide();
    btns[++currentRange.last].fadeIn();

    if (currentRange.last >= itemCount - 1) {
      right.prop("disabled", true);
    }

    left.prop("disabled", false);
  });

  return itemsWindow.append(left, btns, right);
}