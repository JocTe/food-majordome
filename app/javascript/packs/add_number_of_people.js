import { fetchWithToken } from "../utils/fetch_with_token";

  const fetchNumberOfPerson = (event) => {    
    const url = "/preferences";
    event.preventDefault();    

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
    // .then((data) => {
    //    console.log(data);
    // });
  };
  

  const addNumberOfPeople = () => {
    const selectElement = document.getElementById('nb_people');    
    if (selectElement) {      
      selectElement.addEventListener('change', fetchNumberOfPerson);
    }
  };

export { addNumberOfPeople }

