import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.tooltipElement = document.createElement("div");
    this.tooltipElement.className = "tooltip";

    const tooltipText = document.createElement("span");
    tooltipText.innerText = this.element.dataset.tooltipText;

    const carrot = document.createElement("div");
    carrot.className = "tooltip-carrot";

    this.tooltipElement.appendChild(tooltipText);
    this.tooltipElement.appendChild(carrot);

    document.body.appendChild(this.tooltipElement);
  }

  show(event) {
    this.tooltipElement.classList.add("visible");

    const rect = this.element.getBoundingClientRect();
    const tooltipWidth = this.tooltipElement.offsetWidth;
    const leftPosition = rect.left + window.scrollX + (rect.width / 2) - (tooltipWidth / 2);

    this.tooltipElement.style.left = `${leftPosition}px`;
    this.tooltipElement.style.top = `${rect.top + window.scrollY - this.tooltipElement.offsetHeight - 8}px`;
  }

  hide() {
    this.tooltipElement.classList.remove("visible");
  }

  disconnect() {
    this.tooltipElement.remove();
  }
}
