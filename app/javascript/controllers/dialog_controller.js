import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dialog"
export default class extends Controller {
  static targets = ["dialog", "form"]

  open(event) {
    event.preventDefault();
    const deleteUrl = event.currentTarget.dataset.deleteUrl;
    const postTitle = event.currentTarget.dataset.postTitle;
    this.formTarget.action = deleteUrl;
    this.dialogTarget.showModal();

    const postTitleElement = this.dialogTarget.querySelector('.dialog__post-title');
    if (postTitleElement) {
      postTitleElement.textContent = postTitle;
    }
  }

  close() {
    this.dialogTarget.close()
  }
}
