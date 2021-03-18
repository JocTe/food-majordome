import { fetchWithToken } from "../utils/fetch_with_token";

const addDiet = () => {

  const diets = document.querySelectorAll(".diet");
  const url = "/preferences";

  if (diets) {
    diets.forEach((diet) => {

      diet.addEventListener('click', (event) => {

        if (event.currentTarget.dataset.state == "false") {
          event.currentTarget.dataset.state = "true";
        } else {
          event.currentTarget.dataset.state = "false";
        };

        event.currentTarget.classList.toggle('selected');

        const diet = event.currentTarget.dataset.diet;
        const state = event.currentTarget.dataset.state
        const body = {
          preferences: { [diet]: state }
        }
        fetchWithToken(url, {
          method: "POST",
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: JSON.stringify(body),
        })
          .then(response => response.json())
      });

    });
  }
};

export { addDiet }