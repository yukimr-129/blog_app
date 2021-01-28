// document.addEventListener("turbolinks:load", function(){
//     if($("#header").attr("action") == "articles#edit" || "drafts#edit"){
//         $(".thumbnail").empty().css({"background-size":"cover",
//                                      "background-image":`url(${$("#header").attr("thumbnail")})`});
//     }

//     $("draft").on("click", function(e){
//         e.preventDefault();
//         $.ajax({
//             url: "/articles/set_draft"
//         }).done(function(){
//             $("#article_form").submit();
//         })
//     })
// })

document.addEventListener("turbolinks:load", function(){
    $(function(){
      var actionName = $("#header").attr("action");
      if(actionName == "articles#new" || actionName == "articles#edit"){
        var targetModel = "article";
      }else if(actionName == "drafts#edit"){
        var targetModel = "draft";
      }
      if(actionName == "articles#edit" || actionName == "drafts#edit"){
        $(".thumbnail").empty().css({"background-size":"cover",
                                     "background-image":`url(${$("#header").attr("thumbnail")})`});
        // $(".bottom-wrapper").prepend(`
        //   <label class="image_fields">
        //     <div class="image-button">画像を挿入</div>
        //     <input type="file" name="${targetModel}[images_attributes][0][image]" id="${targetModel}_images_attributes_0_image">
        //   </label>
        // `);
      }
      $(".input-thumb").on("change", function(e){
        $(".thumbnail").empty().css("background-image",`url(${window.URL.createObjectURL(e.target.files[0])})`);
      })
    //   var targetIndex = 0;
    //   $(`.image_fields`).on("change", function(e){
    //     var blob = window.URL.createObjectURL(e.target.files[0]);
    //     targetIndex ++;
    //     $(this).attr("for", `${targetModel}_images_attributes_${targetIndex}_image`);
    //     $(this).append(`<input type="file" name="${targetModel}[images_attributes][${targetIndex}][image]" id="${targetModel}_images_attributes_${targetIndex}_image">`);
    //     $(".body").focus();
    //     document.execCommand('insertText', false, `<img src="${blob}" alt="${e.target.files[0].name}" class="body_image">`);
    //     $.ajax({
    //       url: "/articles/set_blob",
    //       type: "post",
    //       data: {blob: blob},
    //       dataType: "json"
    //     })
    //     buildPreview();
    //   });
      $("#draft").on("click", function(e){
        e.preventDefault();
        $.ajax({
          url: "/articles/set_draft"
        }).done(function(){
          $("#article_form").submit();
        })
      })
    })
  })