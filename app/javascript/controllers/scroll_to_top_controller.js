import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [];

  connect() {
    window.addEventListener("scroll", this.toggleVisibility.bind(this));
  }

  disconnect() {
    window.removeEventListener("scroll", this.toggleVisibility.bind(this));
  }

  toggleVisibility() {
    if (window.scrollY > 300) {
      this.element.classList.remove("hidden");
    } else {
      this.element.classList.add("hidden");
    }
  }

  scrollToTop() {
    window.scrollTo({ top: 0, behavior: "smooth" });

    const resetButtonAfterScroll = () => {
      if (window.scrollY === 0) {
        this.element.classList.add("hidden");
        window.removeEventListener("scroll", resetButtonAfterScroll);
      }
    };

    window.addEventListener("scroll", resetButtonAfterScroll);
  }
}