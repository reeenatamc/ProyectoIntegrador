class HeaderComponent extends HTMLElement {
    connectedCallback() {
        fetch('header/header.html')
            .then(response => response.text())
            .then(data => {
                this.innerHTML = data;
            })
            .catch(error => console.error('Error loading header:', error));
    }
}

customElements.define('header-component', HeaderComponent);
