// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function remove_fields(link) {
  if ($('.check_answers:visible').length > 2) {
    $(link).closest('#answer_fields').hide()
    $(link).prev('input[type=hidden]').val('1');
  }
  else {
    alert($('#at-least-two-answers-msg').val())
  }
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp('new_' + association, 'g')
  $(link).before(content.replace(regexp, new_id));
}

var time = 600;
function countdown() {
  window.onbeforeunload = function (e) {
    e = e || window.event;
    if (e) {
      e.returnValue = 'Sure?';
    }
    return 'Sure?';
    };
  document.getElementById("clock").innerHTML = time;
  time--;
  if (time == -1) {
    document.getElementById("clock").innerHTML = "0";
    $("#btnFinish").click()
    return 0;
  }
  timerID = setTimeout(function () {
    countdown();
  }, 1000);
  return 1;
}
$(function(){
$("#btnStart").click(function () {
  document.getElementById("btnStart").disabled = true;
  $("#time").click();
  $("#div-btn-finish").show();
  $("#div-btn-start").hide();
  $(".lesson_question").hide();
  $(".lesson_question:first").show();
  $("#prev").show();
  $("#next").show();
  countdown();
});



$("#btnFinish").click(function () {
  window.onbeforeunload = null;
  document.getElementById("btnFinish").disabled = true;
  $("#save").click()
  $("#time-set").hide()
  $("#time-out").show();
});

$("#btnPrev").click(function () {
  if($(".lesson_question:visible")
    .prevAll(".lesson_question").first().length) {
    $(".lesson_question").index($(".lesson_question:visible"));
    $(".lesson_question:visible").prevAll(".lesson_question").first()
      .show().nextAll(".lesson_question").first().hide();
  } else {
    return false;
  }
});

$("#btnNext").click(function () {
  if($(".lesson_question:visible")
    .nextAll(".lesson_question").first().length) {
    $(".lesson_question").index($(".lesson_question:visible"));
    $(".lesson_question:visible").nextAll(".lesson_question").first()
      .show().prevAll(".lesson_question").first().hide();
  } else {
    return false;
  }
});
});
