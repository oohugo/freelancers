import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="alert-info"
export default class extends Controller {
  connect() {
    setTimeout(() => this.element.remove(), 30000)
  }
}
