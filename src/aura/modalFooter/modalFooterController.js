/**
 * Created by Adelchi on 17/09/2019.
 */

({
    save : function(component, event, helper) {
        console.log("start ...");
        component.find("saveRecord").get("e.force:recordSave").fire();
        console.log("finish ...");
    }
});