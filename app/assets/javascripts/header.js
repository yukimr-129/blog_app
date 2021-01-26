document.addEventListener("turbolinks:load", function(){
    $(function(){
      modal = $(".header-modal");
      button = "#header-modal-button";
      modal.css("display","none");
      $(button).on("click", function(){
        modal.css("display","flex");
      });
      $(document).on("click", function(e){
        if (!$(e.target).closest(".header-modal").length && !$(e.target).closest(button).length) {
          modal.css("display","none");
        }
      });
    })
  })