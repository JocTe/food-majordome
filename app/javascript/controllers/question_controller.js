import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['questionitem']    
  
  connect() {
    console.log(this.questionitemTargets);
    this.showQuestion();
  }

  showQuestion() {
    this.questionitemTargets.forEach((el, i) => {
      el.classList.toggle('current', this.index == i)
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
    this.showQuestion();
  }

}