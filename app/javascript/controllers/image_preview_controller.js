import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview"]

  connect() {
    if (this.hasInputTarget && this.hasPreviewTarget) {
      this.inputTarget.addEventListener('change', this.previewImage.bind(this))
    }
  }

  previewImage() {
    const input = this.inputTarget
    const preview = this.previewTarget

    // Clear preview area
    preview.innerHTML = ''

    if (input.files && input.files[0]) {
      const reader = new FileReader()

      reader.onload = (e) => {
        const img = document.createElement('img')
        img.src = e.target.result
        img.classList.add('w-full', 'h-64', 'object-cover', 'rounded-lg')
        preview.appendChild(img)
      }

      reader.readAsDataURL(input.files[0])
    }
  }
}
