document.addEventListener("turbolinks:load", function(){
    if($("#header").attr("action") == "articles#edit" || "drafts#edit"){
        $(".thumbnail").empty().css({"background-size":"cover",
                                     "background-image":`url(${$("#header").attr("thumbnail")})`});
    }

    $("draft").on("click", function(e){
        e.preventDefault();
        $.ajax({
            url: "/articles/set_draft"
        }).done(function(){
            $("#article_form").submit();
        })
    })
})