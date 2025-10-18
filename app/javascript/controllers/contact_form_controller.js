import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["message"];

  connect() {
    console.log("ContactFormController connected");
  }

  submitForm(event) {
    event.preventDefault();
    console.log("Form submission triggered");
    const form = this.element;
    const formData = new FormData(form);
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;

    if (!csrfToken) {
      console.error("CSRF token not found");
      this.showFlashMessage("Form configuration error. Please refresh and try again.", "alert");
      return;
    }

    fetch(form.action, {
      method: "POST",
      body: formData,
      headers: {
        Accept: "application/json",
        "X-CSRF-Token": csrfToken,
      },
    })
      .then((response) => {
        console.log("Fetch response:", response.status);
        if (!response.ok) {
          throw new Error(`HTTP error: ${response.status}`);
        }
        return response.json();
      })
      .then((data) => {
        console.log("Response data:", data);
        if (data.error) {
          this.showFlashMessage(data.flash.alert, "alert");
        } else {
          this.showFlashMessage(data.flash.notice, "notice");
          form.reset();
          document.getElementById('contact-dialog').close();
        }
      })
      .catch((error) => {
        console.error("Fetch error:", error);
        this.showFlashMessage("Failed to send message. Please try again.", "alert");
      });
  }

  showFlashMessage(text, type) {
    const flashContainer = document.createElement('div');
    flashContainer.className = `app-flash-notification ${type}`;
    flashContainer.setAttribute('data-controller', 'flash');
    flashContainer.innerHTML = `<p>${text}</p>`;
    document.body.appendChild(flashContainer);
  }
}