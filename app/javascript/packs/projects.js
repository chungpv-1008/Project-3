$(document).on('turbolinks:load', function() {
  $(".users-projects-select").select2({width: '100%'});
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
  $(".location").each(function(){
    var content = $(this).find('.content').html();
    var coordinates = JSON.parse($(this).find('.coordinate').html()).coordinates;
    $("#container").append(`<div class="coordinate-text text-th-${index + 1}">"${content}"</div>`);
    var maxX = 0;
    var maxY = 0;
    var minY = 1000000;
    
    coordinates.forEach(function(coordinate, i) {
      maxX = (coordinate.x > maxX ? coordinate.x : maxX)
      maxY = (coordinate.y > maxY ? coordinate.y : maxY)
      minY = (coordinate.y < minY ? coordinate.y : minY)
      $("#container").append(`<div class="line" id="line-th-${i + 1}-of-text-th-${index + 1}"></div>`);
      var x2, y2;
      if (i == coordinates.length - 1) {
        x2 = coordinates[0].x;
        y2 = coordinates[0].y;
      } else {
        x2 = coordinates[i + 1].x;
        y2 = coordinates[i + 1].y;
      }
      line(`#line-th-${i + 1}-of-text-th-${index + 1}`, coordinate.x, coordinate.y, x2, y2);
    });
    $(`#container .text-th-${index + 1}`).css("top", (minY + maxY) / 2);
    $(`#container .text-th-${index + 1}`).css("left", maxX);
    var buttonEditLocation = $(this).next();
    buttonEdit(buttonEditLocation, coordinates);
    index += 1;
  });
});

function line($element, x1, y1, x2, y2) {
  var w = Math.sqrt((x1 - x2)**2 + (y1 - y2)**2);
  var deg = Math.acos(1.0 * (x2 - x1)/ w) * 180.0 / Math.PI;
  deg = (y2 > y1 ? deg : (-1 * deg))
  $($element).css("top", y1);
  $($element).css("left", x1);
  $($element).css("width", parseInt(w));
  $($element).css("transform", `rotate(${deg}deg)`);
}

function buttonEdit($button, coordinates) {
  var maxX = 0;
  var maxY = 0;
  var minX = 100000;
  var minY = 100000;
  coordinates.forEach(function(coordinate, i) {
    maxX = (coordinate.x > maxX ? coordinate.x : maxX)
    maxY = (coordinate.y > maxY ? coordinate.y : maxY)
    minX = (coordinate.x < minX ? coordinate.x : minX)
    minY = (coordinate.y < minY ? coordinate.y : minY)
  });
  var avgX = (minX + maxX) / 2 - 16;
  var avgY = (minY + maxY) / 2 - 16;
  $($button).css("top", avgY);
  $($button).css("left", avgX);
}
