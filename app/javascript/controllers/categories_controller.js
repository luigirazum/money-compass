import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "menu", "close", "nav" ]

  toggleMenu() {
    this.menuTarget.classList.toggle('icon--hidden');
    this.closeTarget.classList.toggle('icon--hidden');
    this.navTarget.classList.toggle('nav--visible');
  }
}
