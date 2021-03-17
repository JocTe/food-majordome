import { Controller } from "stimulus";

export default class extends Controller {
    static targets = ['card']


    toggleState(event) {
        event.preventDefault();
        const card = event.currentTarget;
        // toggle between true and false
        card.querySelector('input').checked ^= 1;

        card.classList.toggle('task-done');
    }

}