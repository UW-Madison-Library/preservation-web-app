import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "content", "icon", "button" ]
  toggle() {
    // toggle content
    let accordionContent = this.contentTarget;
    accordionContent.hidden = !accordionContent.hidden;

    // rotate icon
    let dropDownIcon = this.iconTarget;
    if (dropDownIcon.style.transform === 'rotate(180deg)') {
      dropDownIcon.style.transform = 'rotate(0deg)';
    } else {
      dropDownIcon.style.transform = 'rotate(180deg)';
    }

    // update aria-expanded
    let ariaExpanded = this.buttonTarget.getAttribute('aria-expanded');
    ariaExpanded = (ariaExpanded === 'true') ? 'false' : 'true';
    this.buttonTarget.setAttribute('aria-expanded', ariaExpanded);
  }
}
