// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "chartkick"
import "Chart.bundle"

document.addEventListener('DOMContentLoaded', function() {
  document.querySelectorAll('.copy-button').forEach(function(button) {
    button.addEventListener('click', function() {
      const code = this.getAttribute('data-code');
      if (navigator.clipboard) {
        navigator.clipboard.writeText(code).then(() => {
          this.textContent = 'Copied!';
          setTimeout(() => {
            this.textContent = 'Copy';
          }, 2000);
        });
      } else {
        // Fallback for older browsers
        const textarea = document.createElement('textarea');
        textarea.value = code;
        document.body.appendChild(textarea);
        textarea.select();
        try {
          document.execCommand('copy');
          this.textContent = 'Copied!';
          setTimeout(() => {
            this.textContent = 'Copy';
          }, 2000);
        } catch (err) {
          console.error('Unable to copy', err);
        }
        document.body.removeChild(textarea);
      }
    });
  });
});
