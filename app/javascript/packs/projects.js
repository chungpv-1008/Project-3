var location_th = 0;
$(document).on('turbolinks:load', function() {
  $(".users-projects-select").select2({width: '100%'});
  var width = $(".detail-image")[0].naturalWidth;
  var height = $(".detail-image")[0].naturalHeight;
  $(".detail-image").css("width", width);
  $(".detail-image").css("height", height);
  $("#container").css("width", width);
  $("#container").css("height", height);
  $('#container').append(`<div class="background"></div>`);
  $(".background").css("width", width);
  $(".background").css("height", height);

  $("body").on("click", "#stick_by_hands", function() {
    var mess_conf = confirm("Are you sure?");
    if (mess_conf == false){
      return
    } else{
      image_id = $(this).attr("data-uid");
      $.ajax({
        url: '/en/images/' + image_id,
        data: {image_id: image_id},
        method: 'PUT'
      });
      $(".location").each(function() {
        $(this).remove();
      });
    }
  });

  var allPoints = [];
  $(".background").mousedown(function (e) {
      allPoints = [];
      $(this).unbind("mousemove", trackPoints(e, $(this)));
  }).mouseup(function (e) {
      $(this).bind("mousemove", trackPoints(e, $(this)));
      hanlde_mouse(allPoints);
  });

  function trackPoints(e, $this) {
    allPoints.push({ x: e.pageX - Math.round($this.offset().left), y: e.pageY - Math.round($this.offset().top) });
  }
});

function hanlde_mouse(allPoints) {
  location_th += 1;
  $("#container").append(`<div class="location"><a class="button-edit-location btn btn-sm btn-primary" id="button-edit-${location_th}" data-remote="true" href="/en/admin/locations/3490/edit"><i class="mdi mdi-brush mdi-9px"></i></a><div class="box" id="box-th-${location_th}"></div></div>`);
  x_min = allPoints[0].x > allPoints[1].x ? allPoints[1].x : allPoints[0].x
  y_min = allPoints[0].y > allPoints[1].y ? allPoints[1].y : allPoints[0].y
  x_max = allPoints[0].x > allPoints[1].x ? allPoints[0].x : allPoints[1].x
  y_max = allPoints[0].y > allPoints[1].y ? allPoints[0].y : allPoints[1].y
  width = Math.abs(allPoints[1].x - allPoints[0].x);
  height = Math.abs(allPoints[1].y - allPoints[0].y);
  $(`#box-th-${location_th}`).css("top", y_min);
  $(`#box-th-${location_th}`).css("left", x_min);
  $(`#box-th-${location_th}`).css("width", width);
  $(`#box-th-${location_th}`).css("height", height);
  var image_id = $("#stick_by_hands").attr("data-uid");
  $.ajax({
    url: '/en/locations/new',
    data: {image_id: image_id, coordinate: `${x_min},${y_min},${x_max},${y_max}`},
    method: 'GET'
  });
  buttonEdit($(`#button-edit-${location_th}`), [x_min, y_min]);
}

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
  var width = $(".detail-image")[0].naturalWidth;
  var height = $(".detail-image")[0].naturalHeight;
  $(".location").each(function() {
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
    var content = $(this).find('.content').html();
    $(this).find('.content').parent().css("list-style-type", "none");
    $(this).find('.content').css("color", "#1212dc");
    $(this).find('.content').css("border", "1px solid");
    $(this).find('.content').css("position", "absolute");
    $(this).find('.content').css("bottom", height - boxes[1]);
    $(this).find('.content').css("left", (boxes[2] + boxes[0]) / 2);
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
  $(this).parent().find(".content").css("border", "1px solid red");
  $(this).parent().find(".content").css("color", "red");
}).on('mouseleave','.box',  function(){
  var id = $(this).attr('id').split('-')[2];
  $(this).parent().find(".button-edit-location").css('display', 'none');
  $(this).parent().find(".button-edit-location").css('z-index', '1000');
  $(this).parent().find(".content").css("border", "1px solid #1212dc");
  $(this).parent().find(".content").css("color", "#1212dc");
});

$(document).on('mouseenter','.button-edit-location', function() {
  $(this).css('display', 'inline-block');
  $(this).css('opacity', '.6');
  $(this).css('z-index', '1000');
  $(this).parent().find(".content").css("border", "1px solid red");
  $(this).parent().find(".content").css("color", "red");
}).on('mouseleave','.button-edit-location',  function(){
  var id = $(this).attr('id').split('-')[2];
  $(this).css('display', 'none');
  $(this).css('z-index', '1000');
  $(this).parent().find(".content").css("border", "1px solid #1212dc");
  $(this).parent().find(".content").css("color", "#1212dc");
});
