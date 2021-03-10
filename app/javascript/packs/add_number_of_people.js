import { fetchWithToken } from "../utils/fetch_with_token";

const url = "/preferences";

const fetchNumberOfPerson = (event) => {  
  event.preventDefault();
  console.log(event.currentTarget.value);
  
  const people_number = event.currentTarget.value
  const body = {
      preferences: { number_of_people: people_number }
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
  .then((data) => {
     console.log(data);
   });
};

const addNumberOfPeople = () => {
  const field = document.getElementById('number_people');
  field.addEventListener('input', fetchNumberOfPerson);
};

export { addNumberOfPeople }