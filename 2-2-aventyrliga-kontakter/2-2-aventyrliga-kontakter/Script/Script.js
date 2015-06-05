"use strict";

var DeleteLinkButton = document.getElementById("DeleteLinkButton");


var succBox = document.getElementById("BorderSuccesBox");


document.getElementById("Esc").addEventListener("click", function (e) {
    e.preventDefault();
    succBox.parentNode.removeChild(succBox);
    //alert("hej")
});