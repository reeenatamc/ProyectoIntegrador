class ModComponent extends HTMLElement {
    connectedCallback() {
        fetch('paginas/modelado-bd.html')
            .then(response => response.text())
            .then(data => {
                this.innerHTML = data;
            })
            .catch(error => console.error('Error loading header:', error));
    }
}

customElements.define('mod-bd-component', ModComponent);