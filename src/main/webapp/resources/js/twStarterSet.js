

(function (dom) {
  // Toggle accordion content
  dom("body").on("click", "[data-tw-toggle='collapse']", function () {
    toggle(this);
  });

  function toggle(el, event = "toggle") {
    dom(el)
      .closest(".accordion")
      .find("[data-tw-toggle='collapse']")
      .each(function () {
        // Trigger "hide.tw.accordion" callback function
        if (
          !dom(this).hasClass("collapsed") &&
          this !== el &&
          (event == "toggle" || event == "hide")
        ) {
          const event = new Event("hide.tw.accordion");
          dom(this).closest(".accordion-header")[0].dispatchEvent(event);
        }

        // Trigger "show.tw.accordion" callback function
        if (
          dom(this).hasClass("collapsed") &&
          this === el &&
          (event == "toggle" || event == "show")
        ) {
          const event = new Event("show.tw.accordion");
          dom(this).closest(".accordion-header")[0].dispatchEvent(event);
        }
      });

    const collapsed = dom(el).hasClass("collapsed");

    // Close active accordion
    dom(el)
      .closest(".accordion")
      .find(".accordion-collapse")
      .slideUp(300, (el) => {
        dom(el).removeClass("show");
        dom(el)
          .closest(".accordion-item")
          .find("[data-tw-toggle='collapse']")
          .addClass("collapsed")
          .attr("aria-expanded", false);
      });

    // Set active accordion
    setTimeout(() => {
      const accordionCollapse = dom(el)
        .closest(".accordion-item")
        .find(".accordion-collapse");

      const hide = () => {
        dom(accordionCollapse).removeClass("show");
        dom(el).addClass("collapsed").attr("aria-expanded", false);
        dom(el)
          .closest(".accordion-item")
          .find(".accordion-collapse")
          .slideUp();
      };

      const show = () => {
        dom(accordionCollapse).addClass("show");
        dom(el).removeClass("collapsed").attr("aria-expanded", true);
        dom(el)
          .closest(".accordion-item")
          .find(".accordion-collapse")
          .slideDown();
      };

      if (event === "toggle") {
        !collapsed ? hide() : show();
      } else if (event === "show") {
        show();
      } else {
        hide();
      }
    }, 300);
  }

  // Create instance
  function createInstance(el) {
    return {
      show() {
        toggle(el, "show");
      },
      hide() {
        toggle(el, "hide");
      },
      toggle() {
        toggle(el);
      },
    };
  }

  // Register instance
  (function init() {
    dom("[data-tw-toggle='collapse']").each(function () {
      dom(this).closest(".accordion-header")[0]["__accordion"] =
        createInstance(this);
    });

    if (window.tailwind === undefined) window.tailwind = {};
    window.tailwind.Accordion = {
      getInstance(el) {
        return el.__accordion;
      },
      getOrCreateInstance(el) {
        return el.__accordion === undefined
          ? createInstance(el)
          : el.__accordion;
      },
    };
  })();
});


(function (dom) {
  "use strict";

  // Close active alert
  dom("body").on("click", "[data-tw-dismiss='alert']", function () {
    hide(dom(this).closest(".alert"));
  });

  function show(el) {
    dom(el).fadeIn(300, function () {
      dom(this).addClass("show");

      // Trigger "shown.tw.alert" callback function
      const event = new Event("shown.tw.alert");
      dom(el)[0].dispatchEvent(event);
    });

    // Trigger "show.tw.alert" callback function
    const event = new Event("show.tw.alert");
    dom(el)[0].dispatchEvent(event);
  }

  function hide(el) {
    dom(el).fadeOut(300, function () {
      dom(this).removeClass("show");

      // Trigger "hidden.tw.alert" callback function
      const event = new Event("hidden.tw.alert");
      dom(el)[0].dispatchEvent(event);
    });

    // Trigger "hide.tw.alert" callback function
    const event = new Event("hide.tw.alert");
    dom(el)[0].dispatchEvent(event);
  }

  function toggle(el) {
    dom(el).hasClass("show") ? hide(el) : show(el);
  }

  // Create instance
  function createInstance(el) {
    return {
      show() {
        show(el);
      },
      hide() {
        hide(el);
      },
      toggle() {
        toggle(el);
      },
    };
  }

  // Register instance
  (function init() {
    dom(".alert").each(function () {
      this["__alert"] = createInstance(this);
    });

    if (window.tailwind === undefined) window.tailwind = {};
    window.tailwind.Alert = {
      getInstance(el) {
        return el.__alert;
      },
      getOrCreateInstance(el) {
        return el.__alert === undefined ? createInstance(el) : el.__alert;
      },
    };
  })();
});

