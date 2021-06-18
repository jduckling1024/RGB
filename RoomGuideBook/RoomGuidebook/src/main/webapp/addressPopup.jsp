<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head> 
	<style>
	/* 바탕 배경 이미지 */
.pop-address-search .pop-address-search-inner { background-image: url(http://www.0000.com/img/backImg.png);}
/* 회사 로고 이미지 */
.pop-address-search .pop-address-search-inner .logo { background: url(http://www.0000.com/img/logo.png) no-repeat; background-position:center; }

/* 바탕 배경색상 */
.pop-address-search .pop-address-search-inner { background-color:#ECECEC; }
/* 검색창 색상 */
.pop-address-search .pop-address-search-inner .wrap input { background-color:#FFFFFF; }
/* 검색버튼 색상 */
.pop-address-search .pop-address-search-inner .wrap { background-color:#FFFFFF; }
/* 본문 배경색(홀수) */
.pop-address-search .pop-address-search-inner .result table.data-col tbody tr:nth-child(odd) td {background:#FFFFFF}
/* 본문 배경색(짝수) */
.pop-address-search .pop-address-search-inner .result table.data-col tbody tr:nth-child(even) td {background:#FFFFFF}

	</style>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
		<%
		request.setCharacterEncoding("UTF-8"); //해당시스템의 인코딩타입이 UTF-8일 경우
		//한글이 깨지는 경우 주석 제거
		String inputYn = request.getParameter("inputYn");
		String roadFullAddr = request.getParameter("roadFullAddr");
		String zipNo = request.getParameter("zipNo");
		%>
		
	</head>
<script language="javascript">
// opener관련 오류가 발생하는 경우 아래 주석을 해지하고, 사용자의 도메인정보를 입력합니다.
// ("주소입력화면 소스"도 동일하게 적용시켜야 합니다.)
  document.domain = "roomguidebook.cf";
  
	function init(){
		var url = location.href;
		var confmKey = "devU01TX0FVVEgyMDIwMTEyMTE3MjgzMjExMDQ0OTE="; // 연계싞청시 부여받은 승인키 입력(테스트용 승인키 : TESTJUSOGOKR)
		var resultType = "4"; // 도로명주소 검색결과 화면 출력유형,
		 // 1 : 도로명, 2 : 도로명+지번, 3 : 도로명+상세건물명, 4 : 도로명+지번+상세건물명
		var inputYn= "<%=inputYn%>";
		
		if(inputYn != "Y"){
			 document.form.confmKey.value = confmKey;
			 document.form.returnUrl.value = url;
			 document.form.resultType.value = resultType;
			 document.form.action="https://www.juso.go.kr/addrlink/addrLinkUrl.do"; //인터넷망(행정망의 경우 별도 문의)
			 
			 //** 2017년 5월 모바일용 팝업 API 기능 추가제공 **/
			 //document.form.action="https://www.juso.go.kr/addrlink/addrMobileLinkUrl.do"; //모바일 웹인 경우, 인터넷망
			 document.form.submit();
	  	}

		else{
	  		opener.jusoCallBack("<%=roadFullAddr%>", "<%=zipNo%>");
	  		// opener가 정상적으로 생성되지 않아,
	  		// 부모창에서 할당한 윈도우 이름으로 매핑한 opener를 직접 생성
	  		window.close();
	  		
		  }
	}
</script>
	<body onload="init();">
	<form id="form" name="form" method="post">
		<input type="hidden" id="confmKey" name="confmKey" value=""/>
		<input type="hidden" id="returnUrl" name="returnUrl" value=""/>
		<input type="hidden" id="resultType" name="resultType" value=""/>
	<!-- <input type="hidden" id="encodingType" name="encodingType" value="EUC-KR"/> -->
	</form>
	</body>
</html>