import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  connect() {
    const fadeOutDelay = 3000;
    const fadeOutDuration = 500;

    setTimeout(() => {
      this.element.classList.add('fade-out');

      setTimeout(() => {
        this.element.remove();
      }, fadeOutDuration);
    }, fadeOutDelay);
  }
}
