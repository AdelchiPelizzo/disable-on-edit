/**
 * Created by Adelchi on 14/09/2019.
 */

({
    doInit: function(component) {
        console.log("started .... ");
        var device = $A.get("$Browser.formFactor");
        console.log("You are using a " + device);
        // var body = document.getElementsByTagName("body");
        // console.log(body[0]);
        // body[0].classList.add("disabled");
    },

    checkBrowser: function(component) {
        var device = $A.get("$Browser.formFactor");
        alert("You are using a " + device);
    }
});