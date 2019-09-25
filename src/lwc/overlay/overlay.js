/**
 * Created by Adelchi on 13/09/2019.
 */

import {LightningElement} from 'lwc';


export default class Overlay extends LightningElement {
    initialized = false;
    renderedCallback() {
        console.log("started ...");
        let el = document.getElementsByClassName("oneRecordHomeFlexipage");
        console.log(el[0]+"element ??");
        // if (this.initialized) {
        //     return;
        // }
        // this.initialized = true;
        // el[0].classList.add("disabled").catch(error => {
        //     this.error = error;
        // });
    }
}