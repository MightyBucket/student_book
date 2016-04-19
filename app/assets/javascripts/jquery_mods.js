$(document).ready(function(){
	$("#from_here").append($("#to_here"));
});
$(document).ready(function(){
    //Check to see if the window is top if not then display button
    $(window).scroll(function(){
        if ($(this).scrollTop() > 100) {
            $('.scrollToTop ').fadeIn();
        } else {
            $('.scrollToTop ').fadeOut();
        }
    });
    //Click event to scroll to top
    $('.scrollToTop ').click(function(){
        $('html, body').animate({scrollTop : 0},800);
        return false;
    });
});


$(document).ready(function(){
    $("#toggleDiv").toggle(10);
    $("#buttoon").toggle(10);
    $("#button").click(function(){
        $("#toggleDiv").toggle(300);
        $("#button").toggle(10);
        $("#buttoon").toggle(10);
        $('html, body').animate({
            scrollTop: $("#toggleDiv").offset().top
        }, 500);


    });
});

$(document).ready(function(){
    $("#buttoon").click(function(){
        $("#toggleDiv").toggle(300);
        $("#buttoon").toggle(10);
        $("#button").toggle(10);
        $('html, body').animate({
            scrollTop: $("#toggleDiv").offset().top
        }, 500);


    });
});
