import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["box"]

  connect() {
    // Animate in
    requestAnimationFrame(() => {
      this.boxTarget.classList.remove("opacity-0", "-translate-y-5")
      this.boxTarget.classList.add("opacity-100", "translate-y-0")
    })

    // Animate out after 3 seconds
    setTimeout(() => {
      this.boxTarget.classList.add("opacity-0", "-translate-y-5")
      this.boxTarget.classList.remove("opacity-100", "translate-y-0")
    }, 3000)

    // Remove from DOM after transition
    setTimeout(() => {
      this.boxTarget.remove()
    }, 3500)
  }
}