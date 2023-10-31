import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "textBox", "fileUpload" ]

  reset_form() {
    this.textBoxTarget.value = ""
    this.fileUploadTarget.value = ""
  }
}
