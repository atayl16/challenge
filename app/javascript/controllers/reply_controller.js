import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "form" ]

  //connect() {
    //this.outputTarget.textContent = 'Hello, Stimulus!'
  //}

  toggle(event) {
    event.preventDefault()
    this.formTarget.classList.remove("d-none");
    console.log(this.formTarget.classList);
  }
}
