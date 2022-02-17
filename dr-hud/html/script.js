$(function(){

    //$(".hudmenu").hide();
    
    window.addEventListener('message', function(event){
        let item = event.data;

        if(item.type == "updatehud"){
            UpdateHud(item.health, item.hunger, item.thirst, item.armor)
        } else if(item.type == "toggleitem") {
            $(`[type="${item.item}"]`).toggle(350);
        }
    });

    /*
    $("#healthtoggle").on('change', function() {
        if ($(this).is(':checked')) {
            console.log("Noget")
        } else {
            console.log("Noget andet")
        }
    });*/

});

function UpdateHud(health, hunger, thirst, armor){
    $("#health").attr('value', health)
    $("#hunger").attr('value', 100-thirst)
    $("#thirst").attr('value', 100-hunger)
    $("#armor").attr('value', armor)
}