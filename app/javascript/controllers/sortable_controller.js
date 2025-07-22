import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sort", "direction"]

  connect() {
    // Set initial selected state based on URL params
    const urlParams = new URLSearchParams(window.location.search)
    const sortParam = urlParams.get('sort')
    const directionParam = urlParams.get('direction')

    if (sortParam && this.hasSortTarget) {
      const option = this.sortTarget.querySelector(`option[value="${sortParam}"]`)
      if (option) option.selected = true
    }

    if (directionParam && this.hasDirectionTarget) {
      const option = this.directionTarget.querySelector(`option[value="${directionParam}"]`)
      if (option) option.selected = true
    }
  }

  change() {
    // Submit the form when any select changes
    this.element.requestSubmit()
  }
}
