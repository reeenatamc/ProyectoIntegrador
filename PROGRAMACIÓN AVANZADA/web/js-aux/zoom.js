var imgContainer = document.getElementById('img-contenedor');
var img = document.getElementById('img');

var scale = 1.0;
var maxScale = 2.0;
var minScale = 0.5;
var step = 0.1;

function zoomIn() {
    if (scale < maxScale) {
        scale += step;
        img.style.transform = 'scale(' + scale + ')';
        img.style.cursor = 'move'; 
    }
}

function zoomOut() {
    if (scale > minScale) {
        scale -= step;
        img.style.transform = 'scale(' + scale + ')';
        img.style.cursor = 'move'; 
    }
}

var posX = 0, posY = 0;
var startDrag = false;

imgContainer.addEventListener('mousedown', function(e) {
    startDrag = true;
    posX = e.clientX - img.offsetLeft;
    posY = e.clientY - img.offsetTop;
});

imgContainer.addEventListener('mousemove', function(e) {
    if (startDrag) {
        var mouseX = e.clientX - posX;
        var mouseY = e.clientY - posY;
        img.style.left = mouseX + 'px';
        img.style.top = mouseY + 'px';
    }
});

imgContainer.addEventListener('mouseup', function() {
    startDrag = false;
});
