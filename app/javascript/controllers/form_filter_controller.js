import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-filter"
export default class extends Controller {
  connect() { }

  remoteselect(e) {
    const id = e.target.value
    const url = `groups/${id}/states`
    // const select = document.querySelector("#states_select")
    fetch(url)
      .then(response => response.json())
      .then(data => this.updateDropdown(data))
  }

  updateDropdown(data) {
    this.targets.find("states").innerHTML = "";

    data.unshift(["",""])
    data.forEach((room) => {
      const option = document.createElement("option");
      option.value = room[1];
      option.innerHTML = room[0];
      this.targets.find("states").appendChild(option);
    });
  }
}
