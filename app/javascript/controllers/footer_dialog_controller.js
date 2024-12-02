import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.closeAllDialogs()

  }

  disconnect() {
  }

  closeAllDialogs = () => {
    this.element.querySelectorAll('dialog[open]').forEach((dialog) => {
      dialog.close()
    })
  }

  open(event) {
    event.preventDefault()
    const dialogId = event.currentTarget.dataset.dialogId
    this.dialog = document.getElementById(dialogId)

    if (this.dialog) {
      this.handleDialogClick = this.dialogClick.bind(this)
      this.dialog.addEventListener('click', this.handleDialogClick)

      this.dialog.showModal()
    } else {
      console.error(`Dialog with ID "${dialogId}" not found.`)
    }
  }

  close(event) {
    event.preventDefault()
    const dialogElement = event.currentTarget.closest('dialog')

    if (dialogElement) {
      dialogElement.close()
      dialogElement.removeEventListener('click', this.handleDialogClick)
    } else {
      console.error('No dialog found to close.')
    }
  }

  dialogClick(event) {
    if (event.target === this.dialog) {
      this.dialog.close()
      this.dialog.removeEventListener('click', this.handleDialogClick)
    }
  }
}
