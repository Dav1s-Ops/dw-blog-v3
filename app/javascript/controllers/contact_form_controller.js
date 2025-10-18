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
      this.showMessage("Form configuration error. Please refresh and try again.", "error");
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
          this.showMessage(data.error, "error");
        } else {
          this.showMessage(data.message, "success");
          form.reset();
        }
      })
      .catch((error) => {
        console.error("Fetch error:", error);
        this.showMessage("Failed to send message. Please try again.", "error");
      });
  }

  showMessage(text, type) {
    const messageDiv = this.messageTarget;
    messageDiv.style.display = "block";
    messageDiv.textContent = text;
    messageDiv.className = `contact-form__message contact-form__message--${type}`;
    setTimeout(() => {
      messageDiv.style.display = "none";
      messageDiv.className = "contact-form__message";
    }, 5000);
  }
}