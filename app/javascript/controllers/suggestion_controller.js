import { Controller } from "stimulus";

export default class extends Controller {
    static targets = ['screen']

    connect() {
        this.showScreen();
    }

    showScreen() {
        this.screenTargets.forEach((el, i) => {
            el.classList.toggle('show', this.index == i);
        })
    }

    next() {
        this.index += 1
        const button = document.getElementById("button-save-to-hide");
        button.classList.toggle("hide");
    }

    get index() {
        return parseInt(this.data.get('index'), 10);
    }

    set index(value) {
        this.data.set('index', value);
        this.showScreen();
    }
}