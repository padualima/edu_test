import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="portfolios"
export default class extends Controller {
  connect() { }

  linkTo(e) {
    document.location.href = e.params['url']
  }

  disableButton() {
    // this.targets.find('import').disabled=true
    this.targets.find('import').value = "Importando..."
  }
}
