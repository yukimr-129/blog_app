document.addEventListener("turbolinks:load", function(){
    $(function(){
      var readMore = function(attr){
        $(`#read-${attr}-article`).on("click", function(){
          $(this).remove();
          $(`#${attr}-article`).css("height",`${$(`#${attr}-article`).height()+286}px`);
        });
      };
      attr = ["hot","new"];
      attr.forEach(function(attr){readMore(attr);});
    })
  })