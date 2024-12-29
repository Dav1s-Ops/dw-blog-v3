import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["image", "lightbox", "lightboxImage"];

  connect() {
    this.lightbox = document.getElementById("lightbox");
    this.lightboxImage = this.lightbox.querySelector(".lightbox-image");
  }

  open(event) {
    this.lightboxImage.src = event.target.src;
    this.lightbox.classList.remove("hidden");
  }

  close(event) {
    if (event.target === this.lightbox) {
      this.lightbox.classList.add("hidden");
    }
  }
}
