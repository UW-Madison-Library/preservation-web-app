import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "button", "options" ]

  hide(event) {
    // check that the dropdown is open and the user clicked outside of the dropdown before closing
    if (!this.optionsTarget.hidden && !this.element.contains(event.target)) {
      this.close();
    }
  }

  toggle() {
    // toggle menu
    const menuOptions = this.optionsTarget;
    menuOptions.hidden = !menuOptions.hidden;

    // update aria-expanded
    let ariaExpanded = this.buttonTarget.getAttribute('aria-expanded');
    ariaExpanded = (ariaExpanded === 'true') ? 'false' : 'true';
    this.buttonTarget.setAttribute('aria-expanded', ariaExpanded);
  }

  selectOption(event) {
    // update the url with the batch object id
    const url = new URL(`${location}`);
    const params = new URLSearchParams(url.search);
    params.set("batch_object_id", event.target.innerText);
    window.history.replaceState({}, '', `${location.pathname}?${params}`);

    // close the menu
    this.close();
  }

  close() {
    this.buttonTarget.setAttribute('aria-expanded', 'false');
    this.optionsTarget.hidden = true;
  }
}
