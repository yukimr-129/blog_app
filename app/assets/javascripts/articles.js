document.addEventListener("turbolinks:load", function(){
    if($("#header").attr("action") == "articles#edit"){
        $(".thumbnail").empty().css({"background-size":"cover",
                                     "background-image":`url(${$("#header").attr("thumbnail")})`});
    }
})