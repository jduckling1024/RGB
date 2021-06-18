<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../main/header.jsp"%>

<!DOCTYPE HTML>
<html>

<head>
<title>RoomGuideBook_JOIN</title>
<link href="/resources/css/style.css" rel='stylesheet' type='text/css' />
<link href="/resources/css/boardRegister.css" rel='stylesheet'
	type='text/css' />
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
</script>
<!----webfonts---->
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800'
	rel='stylesheet' type='text/css'>
<!----//webfonts---->
<!----start-alert-scroller---->
<script src="/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery.easy-ticker.js"></script>
<script type="text/javascript">
        $(document).ready(function () {
            $('#demo').hide();
            $('.vticker').easyTicker();
        });
    </script>
<!----start-alert-scroller---->
<!-- start menu -->
<link href="/resources/css/megamenu.css" rel="stylesheet"
	type="text/css" media="all" />
<script type="text/javascript" src="/resources/js/megamenu.js"></script>
<script>$(document).ready(function () { $(".megamenu").megamenu(); });</script>
<script src="/resources/js/menu_jquery.js"></script>
<!-- //End menu -->
<!---slider---->
<link rel="stylesheet" href="/resources/css/slippry.css">
<script src="/resources/js/jquery-ui.js" type="text/javascript"></script>
<script src="/resources/js/scripts-f0e4e0c2.js" type="text/javascript"></script>
<script>
        jQuery('#jquery-demo').slippry({
            // general elements & wrapper
            slippryWrapper: '<div class="sy-box jquery-demo" />', // wrapper to wrap everything, including pager
            // options
            adaptiveHeight: false, // height of the sliders adapts to current slide
            useCSS: false, // true, false -> fallback to js if no browser support
            autoHover: false,
            transition: 'fade'
        });
    </script>
<!---move-top-top---->
<script type="text/javascript" src="js/move-top.js"></script>
<script type="text/javascript" src="js/easing.js"></script>
<script type="text/javascript">
        jQuery(document).ready(function ($) {
            $(".scroll").click(function (event) {
                event.preventDefault();
                $('html,body').animate({ scrollTop: $(this.hash).offset().top }, 1200);
            });
        });
    </script>
<!---//move-top-top---->
</head>


<body>
	<div class="login-main">
		<div class="wrap">
			<Br>

			<div class="boardInfo-grids">
				<form action="/registerBoard" method="post"
					enctype="multipart/form-data">
					<div class="board">
						<div class="imageSection">
							<div class="upload-btn-wrapper">
								<button class="btn">UPLOAD A FILE</button>
								<input type="file" name="myfile" accept="image/*"
									onchange="setThumbnail1(event);" />


								<div id="image_container1"></div>

								<script>
                                function setThumbnail1(event) {
                                    for (var image of event.target.files) {
                                        var reader = new FileReader();
                                        reader.onload = function (event) {
                                            var img = document.createElement("img");
                                            img.onclick = function () { document.getElementById('image_container1').removeChild(this) }; // 이미지를 다시 한번 더 클릭하면 삭제
                                            img.setAttribute("src", event.target.result);
                                            img.style.margin = "3% 10% 3% 10%";
                                            img.style.padding="3%";
                                            img.style.border = "solid 2.3px #E45D5D";
                                            img.style.width='80%';
                                            document.querySelector("div#image_container1").appendChild(img);
                                        };
                                        console.log(image);
                                        reader.readAsDataURL(image);
                                    }
                                }
                            </script>

							</div>
						</div>
						<div class="contentSection">
							<input type="text" id="title" placeholder="제목" name="title">
							<textarea cols="45" rows="13" id="content" placeholder="내용" name="content"></textarea>

							<h1>
								<Span>
									<button type="submit" id="addBtn">UPLOAD</button>
								</Span>
							</h1>
						</div>

					</div>
				</form>
			</div>
		</div>
		<div class="clear"></div>
	</div>


	<!---- start-bottom-grids---->
	<div class="bottom-grids">
		<div class="bottom-bottom-grids"></div>
	</div>
	<!---- //End-bottom-grids---->
	<!--- //End-content---->
	<!---start-footer---->
	<div class="footer">
		<div class="wrap">
			<div class="footer-left">
				<ul>
					<li><a href="#">RoomGuideBook</a> <span> </span></li>
				</ul>
			</div>

			<div class="clear"></div>
		</div>
	</div>
	<!---//End-footer---->
	<!---//End-wrap---->
</body>

</html>