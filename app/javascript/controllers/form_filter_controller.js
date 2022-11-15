import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-filter"
export default class extends Controller {
  connect() {
    console.log("Hello, Stimulus!", this.element)
  }

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

    if (data == 0) {
      const option = document.createElement("option");
      option.innerHTML = "Entire place";
      this.targets.find("states").appendChild(option);
    } else {
      data.forEach((room) => {
        const option = document.createElement("option");
        option.value = room[1];
        option.innerHTML = room[0];
        this.targets.find("states").appendChild(option);
      });
    }
  }
}
