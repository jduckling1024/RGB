<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.springframework.web.context.request.SessionScope"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../main/header.jsp"%>
<%@ page session="true"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />

<title>가구 배치하기</title>
<link rel="stylesheet" href="/resources/css/arrange.css">
</head>
<body>
<div class="wrap">
        <div class="top">
            <div class="header">
                <p class="Title"><strong>RGB : Room Guide Book</p></strong>
                <div class="menu">
                    <ul>
                        <li class="menu1"><a href="">Store</a>
                        <li class="menu2"><a href="">Community</a>
                        <li class="menu4"><a href="">Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
        
        <div class="fullSection">
          <ul>
            <li>
              <div class="leftSection">
                 <div id="mydiv"></div>
                 <% String filepath = (String)request.getAttribute("filepath");  %>
                 <img class="room" src="<%= filepath %>" alt="">
                 
                <form name = "posform" id = "posform" method="post">
				<input type="hidden" id="x" name="x">
				<input type="hidden" id="y" name="y">
				<input type="hidden" name="rFilepath" value="<%= filepath %>">
				<input type="hidden" id = "fFilepath" name="fFilepath" >
				</form>
				
               </div>
             <li>
				<div class="rightSection">
                   <ul>
                     <li class=buttonBack><button type="button" class="btn_back"
							onclick="history.back(-1)">돌아가기</button>
					 <br> 
					 <br>
					 <li><a>모델명 : </a>
                     <li><a>방 정보 : </a></li>
                    </ul>
                    <br>
                    <hr width="90%">
                    <br>
                    <br>
                  <div class="arrangeImage" style="overflow:auto">
                   <img class="image" src="\resources\image_arrange_ap\fabricsopaFront.png" width="100%" onclick="make()">
				   <img class="image" src="\resources\image_arrange_ap\fabricsopaFSide.png" width="100%" onclick="make()">
				   <img class="image" src="\resources\image_arrange_ap\fabricsopaHide.png" width="100%" onclick="make()">
					<img class="image" src="\resources\image_arrange_ap\fabricsopaHSide.png" width="100%" onclick="make()">
				   </div>
                        <br>
                        <br>
                        <hr width="90%">
                        <br>
                    </div>
                </li>
            </ul>
        </div>
    </div>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript">

// 드래그 함수
		let fFilepath = '';
	    function make() {

            var img = document.createElement('img'); // 이미지 객체 생성

            fFilepath = img.src = $(event.target).attr("src");
            $("#fFilepath").attr("value", fFilepath);
            
            img.id = "mydivheader";
            img.style.cursor = 'pointer'; // 커서 지정
            img.style.position = 'absolute';    // absolute해야지 이미지위에 이미지 올라간다고했음!
            img.style.width = '300px'; // 배치할 이미지크기 여기서 지정
            img.style.height = '150px';
            document.getElementById('mydiv').appendChild(img); // 드래그할이미지동적생성
            
	    }

        //Make the DIV element draggagle:
        dragElement(document.getElementById("mydiv"));

        var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
        
        function dragElement(elmnt) {

            const pos = $(".room").position()
            const y = pos.top
            const x = pos.left

            if (document.getElementById(elmnt.id + "header")) {
                /* if present, the header is where you move the DIV from:*/
                document.getElementById(elmnt.id + "header").onmousedown = dragMouseDown;
            } else {
                /* otherwise, move the DIV from anywhere inside the DIV:*/
                elmnt.onmousedown = dragMouseDown;
            }

            function dragMouseDown(e) {
                e = e || window.event;
                e.preventDefault();
                // get the mouse cursor position at startup:
                pos3 = e.clientX;
                pos4 = e.clientY;
                document.onmouseup = closeDragElement;
                // call a function whenever the cursor moves:
                document.onmousemove = elementDrag;
            }

            function elementDrag(e) {

                e = e || window.event;
                e.preventDefault();
                // calculate the new cursor position:
                pos1 = pos3 - e.clientX;
                pos2 = pos4 - e.clientY;
                pos3 = e.clientX;
                pos4 = e.clientY;
                // set the element's new position:
                elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
                elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";

                const proWidth = parseInt($("#mydivheader").css("width"));
                const proHeight = parseInt($("#mydivheader").css("height"));

                console.log("기준 offset: ("+proWidth/2+", "+proHeight/2+")");
                console.log('x: '+ parseInt(elmnt.offsetLeft - pos1 - x + proWidth/2));
                console.log('y: '+parseInt(elmnt.offsetTop - pos2 - y + proHeight/2)) ;
                
                $("#x").attr("value", parseInt(elmnt.offsetLeft - pos1 - x + proWidth/2));
                $("#y").attr("value", parseInt(elmnt.offsetTop - pos2 - y + proHeight/2));
                
            }

            function closeDragElement() {
                /* stop moving when mouse button is released:*/
                document.onmouseup = null;
                document.onmousemove = null;
                
                checkValid();
            }
        }
    	


        // 사용자가 방 이미지를 업로드하면 폴더에 저장해두고
       	// 새로 부를 때 jsp에 경로를 전송해서 새로고침하는 효과
       	<% String detectedObject =""; int size = 0;
       	
       	   Cookie[] cookies = request.getCookies();
       	   
       	   Boolean makeCookie = (Boolean)request.getAttribute("cookie"); 
       	   
       	   if(makeCookie){ // 새로운 이미지 업로드 시
       		   size = (Integer)request.getAttribute("size");
       		   detectedObject = (String)request.getAttribute("objects"); // 쿠키에 값이 없다면, attr를 통해 받음
       		   
       		   Cookie cookie1 = new Cookie("size", Integer.toString(size)); 
       		   Cookie cookie2 = new Cookie("objects", detectedObject); 
       		   cookie1.setMaxAge(1*24*60*60); cookie2.setMaxAge(1*24*60*60);
       		  
       		   response.addCookie(cookie1);
       		   response.addCookie(cookie2); // client에 응답으로 쿠키를 전송
       		}
       	   
       	   else{
       		   // 쿠키로부터 크기, 객체인식 결과를 얻음
       		  detectedObject = (String)cookies[2].getValue();
       		  size = Integer.parseInt(cookies[1].getValue());
       	   }
       	%>
       	
       	const size = <%= size %>
       	const objects = new Array(size)
       	<% int i = 0; %>

       	<% StringTokenizer st = new StringTokenizer(detectedObject, "#");
       		while(st.hasMoreTokens()){
       			String x = st.nextToken();
       			String y = st.nextToken();
       			String w = st.nextToken();
       			String h = st.nextToken(); %>
       			objects[<%= i %>] = new Array(4)
       			objects[<%= i %>][0] = <%= x %>
       			objects[<%= i %>][1] = <%= y %>
       			objects[<%= i %>][2] = <%= w %>
       			objects[<%= i %>][3] = <%= h %>
       			<% i++; %>
       		<%}%>
       		
       	
       	let result = true
           
           
       	const checkValid = function () {

       		alert('검사 …')
       		let ax = $("#x").val()
       		let ay = $("#y").val()
       		console.log('checkValid'+size)
       		i = 0
       		
       		for(i=0; i < size; i++){
       			let x = objects[i][0]
       			let y = objects[i][1]
       			let w = objects[i][2]
       			let h = objects[i][3]
       			
       			console.log("x: "+x+" y: "+y+" w"+w+" h"+h)
       			console.log("ax: "+ax+" ay: "+ay)
       			
       			if(x<= ax && ax<=x+w && y<=ay && ay <= y+h){
       				result = false
       				break
       			}
       		}
       		
       		const form = document.posform
       		
       		if(!result){
       			let act = confirm('현재 위치에 물체가 있습니다. 그래도 놓으시겠습니까?')
       			if(!act){
       				document.location.reload(true);
       				return;
       			}
       		}
       		
       		transferColor();
       		//return true;
       		// tfColor 컨트롤러 호출
       	};
       	
       	const transferColor = function(){
				alert('컬러 매칭 진행 중..');
       			$.ajax({
       				type: 'post',
       				url: '/transferColor',
       				data: $("#posform").serialize(),
       				error : function(){
       					alert('실패!');
       	            },
       	            complete: function(){
       	            	arrangeImage();
       	            }
       			})
       			
       	};
       	
       	function arrangeImage(){
       		let temp = fFilepath.split('\\');
	       	const resultPath = temp[temp.length-1];
	       	$("#mydivheader").attr("src", "\\resources\\image_result\\"+resultPath + '?' + new Date().getTime());
       		console.log($("#mydivheader").attr("src"));
       	};
       
        
    	
</script>
</body>
</html>