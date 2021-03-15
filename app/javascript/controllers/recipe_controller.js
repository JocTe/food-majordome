import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['recipeitem']

  connect() {
    this.showRecipeStep();
  }

  showRecipeStep() {
    this.recipeitemTargets.forEach((el, i) => {
      el.classList.toggle('current-step', this.index == i)
    })
  }

  next() {
    this.index += 1
  }

  get index() {
    return parseInt(this.data.get('index'), 10)
  }

  set index(value) {
    this.data.set('index', value);
    this.showRecipeStep();
  }

}