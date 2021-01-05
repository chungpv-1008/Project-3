$(document).on('turbolinks:load', function() {
  $(".users-projects-select").select2({width: '100%'});
  var width = $(".detail-image")[0].naturalWidth;
  var height = $(".detail-image")[0].naturalHeight;
  $(".detail-image").css("width", width);
  $(".detail-image").css("height", height);
  // $('body').on('mousemove', '.detail-image', function(e) {
  //   var x_min = e.pageX - $(this).offset().left
  //   var y_min = e.pageY - $(this).offset().top;
  // })
  $( ".detail-image" ).mouseup(function() {
    console.log("ABC");
  }).mousedown(function() {
    console.log("MNP");
  });
});

$(document).on('turbolinks:load', function() {
  var modal = $('#modalImage');
  var modalImg = $('#img01')
  var captionText = $('#caption')
  $('body').on('click', '.myImg', function() {
    modal.css("display", "block");
    modalImg.attr("src", $(this).attr("src"))
    captionText.innerHTML = $(this).attr("alt")
  })
  $('body').on('click', '.close', function() {
    modal.css("display", "none");
  })
})

$(document).on('turbolinks:load', function() {
  var index = 0;
  $(".location").each(function() {
    var content = $(this).find('.content').html();
    var boxes = $(this).find('.coordinate').html().split(',').map(function(e) {
      return parseInt(e);
    });
    $(this).append(`<div class="box" id="box-th-${index + 1}"></div>`);
    $(`#box-th-${index + 1}`).css("top", boxes[1]);
    $(`#box-th-${index + 1}`).css("left", boxes[0]);
    $(`#box-th-${index + 1}`).css("width", boxes[2] - boxes[0]);
    $(`#box-th-${index + 1}`).css("height", boxes[3] - boxes[1]);
    buttonEdit($(`#button-edit-${index + 1}`), boxes);
    index = index + 1;
  });
});

function buttonEdit($button, boxes) {
  $($button).css("top", boxes[1]);
  $($button).css("left", boxes[0]);
}

// $(document).ready(function(){
//   $('body').on('click', '.box', function() {
//     console.log('123')
//     // var id = $(this).attr('id');
//     // $(`button-edit-${id}`).css('display', 'inline-block');
//     // $(`button-edit-${id}`).css('opacity', '.6');
//   });
// });

$(document).on('mouseenter','.box', function() {
  var id = $(this).attr('id').split('-')[2];
  $(this).parent().find(".button-edit-location").css('display', 'inline-block');
  $(this).parent().find(".button-edit-location").css('opacity', '.6');
  $(this).parent().find(".button-edit-location").css('z-index', '1000');
}).on('mouseleave','.box',  function(){
  var id = $(this).attr('id').split('-')[2];
  $(this).parent().find(".button-edit-location").css('display', 'none');
  $(this).parent().find(".button-edit-location").css('z-index', '1000');
});

$(document).on('mouseenter','.button-edit-location', function() {
  $(this).css('display', 'inline-block');
  $(this).css('opacity', '.6');
  $(this).css('z-index', '1000');
}).on('mouseleave','.button-edit-location',  function(){
  var id = $(this).attr('id').split('-')[2];
  $(this).css('display', 'none');
  $(this).css('z-index', '1000');
});
