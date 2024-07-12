function runCell() {
    fetch('/run_cell', {
        method: 'POST'
    })
    .then(response => response.json())
    .then(data => {
        document.getElementById('output').innerHTML = '<img src="data:image/png;base64,' + data.plot_url + '">';
    })
    .catch(error => console.error('Error:', error));
}