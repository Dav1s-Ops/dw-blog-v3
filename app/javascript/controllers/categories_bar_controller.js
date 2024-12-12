import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["category"];

  connect() {
    this.categoriesBar = this.element.querySelector(".categories-bar-container");

    this.categoryTargets.forEach((category) => {
      category.addEventListener("mouseenter", this.handleMouseEnter.bind(this));
      category.addEventListener("mouseleave", this.handleMouseLeave.bind(this));
    });
  }

  handleMouseEnter(event) {
    const category = event.currentTarget;
    const categoryColor = getComputedStyle(category).getPropertyValue("--category-color");
    this.categoriesBar.style.borderColor = `rgba(${categoryColor}, 1)`;
  }

  handleMouseLeave() {
    this.categoriesBar.style.borderColor = "var(--Gray, #363636)"; // Default border color
  }
}
