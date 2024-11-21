import { Controller } from "@hotwired/stimulus"
import { useTransition } from "stimulus-use"

export default class extends Controller {
  static targets = ["menu", "button"]

  connect() {
    useTransition(this, {
      element: this.menuTarget,
      enterActive: 'transition ease-out duration-100',
      enterFrom: 'opacity-0 scale-95 pointer-events-none',
      enterTo: 'opacity-100 scale-100 pointer-events-auto',
      leaveActive: 'transition ease-in duration-75',
      leaveFrom: 'opacity-100 scale-100 pointer-events-auto',
      leaveTo: 'opacity-0 scale-95 pointer-events-none',
      hiddenClass: 'hidden' // Use 'hidden' class to hide the menu
    })
  }

  toggle() {
    this.toggleTransition()
  }

  hide(event) {
    const clickedInside = this.element.contains(event.target)
    if (!clickedInside) {
      this.leave()
    }
  }
}
