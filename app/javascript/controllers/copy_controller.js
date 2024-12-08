import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { code: String }

  connect() {
    this.originalButtonHTML = this.element.querySelector('.copy-button').innerHTML
  }

  copy(event) {
    const button = event.currentTarget
    const code = this.codeValue

    navigator.clipboard.writeText(code).then(() => {
      button.textContent = 'Copied!'
      setTimeout(() => {
        button.innerHTML = this.originalButtonHTML
      }, 2000);
    });
  }
}