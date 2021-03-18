const goBack = () => {
  const back = document.getElementById("link-back-no-reload");
  if (back) {
    back.addEventListener('click', (event) => {
      event.preventDefault();
    window.history.back();
    });
  }
};

export { goBack }