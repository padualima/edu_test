import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-filter"
export default class extends Controller {
  connect() { }

  remoteselect(e) {
    const id = e.target.value
    const url = `groups/${id}/states`

    if (id) {
      fetch(url)
        .then(response => response.json())
        .then(data => this.updateDropdown(data))
    } else {
      this.updateDropdown([])
    }
  }

  updateDropdown(data) {
    var currentTarget = this.targets.find('states')

    currentTarget.innerHTML = "";

    data.unshift(["",""])
    data.forEach((room) => {
      const option = document.createElement("option");
      option.value = room[1];
      option.innerHTML = room[0];
      currentTarget.appendChild(option);
    });
  }
}
