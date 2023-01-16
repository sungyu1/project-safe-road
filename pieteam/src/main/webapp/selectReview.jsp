<%@page import="com.smhrd.model.Police"%>
<%@page import="java.util.List"%>
<%@page import="com.smhrd.model.PoliceDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<title>안.길</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
</head>
<body>
<nav>
<h2 class="major" style="text-align:center">리뷰 관리</h2>
<a href="selectMate.jsp" class="button next scrolly">등교메이트 관리</a>
<table class="table">
  <tr>
      <th>글 제목</th>
      <th>글 내용</th>
      <th>게시날짜</th>
      <th>올린사람</th>
  </tr>
  <c:forEach begin="0" end="10" step="1" varStatus="status">  
	  <tr>
		  <td id="name${status.index}"></td>
	      <td id="content${status.index }"></td>
	      <td id="date${status.index }"></td>					
	      <td id="writer${status.index }"></td>					
	  </tr>
  </c:forEach>
  <tr>
	  <td colspan="3" id="controller"></td>
  </tr>
</table>
</nav>

		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/browser.min.js"></script>
			<script src="assets/js/breakpoints.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>

<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script type="text/javascript">

// 게시물 요청
next_list(1,1);

var arr=null;
var pageSize = 3;
var maxRow=10;


function button_create(data_list,startPage){
	
	var pageNum=null;
	
	if(data_list.length%maxRow == 0){
		pageNum = data_list.length/maxRow;
	}
	
	else{
		pageNum =Math.floor(data_list.length/maxRow)+1;  
	}
	
	var currentPage=startPage;
	
	for(var i =0;i<pageNum;i++){
		arr=data_list;
		$('#controller').append('<button onclick="page('+currentPage+')" id="'+currentPage+'" class="button">'+currentPage+'</button>');
		currentPage= currentPage+1;
	}
}


//다음 버튼이 눌린다면 그에 맞는 버튼들이 생성, 삭제 와 해당 리스트가 출력되기 위한 메소드 
function next_list(startRow,startPage){
	$.ajax({
		/* jsp 시작하면서 바로 border서블릿과 비동기 통신으로 DB 에있는 내용을 가져온다 */
		url:'ReviewListCon',
		method:'post',
		dataType :'json', // 응답데이터 형식 지정
		data :{"num":startRow},/* 한 페이지 에서 가져와야하는 양이 정해저 있으므로 어디 페이지에서 요청했는지 알기위해 가져올DB의 시작 num을 같이 넘겨 준다 */
		success:function(data_list){
			console.log(data_list)
			if(data_list.length<10){/* DB를 통해 가져왔는데 가져온 양이 테이블 행의 갯수인 10 보다 적으면 html의 테이블은 이전값을 가지고 있으므로 안보이게 .hide()를 사용해주어야 한다 */
				list_write(data_list);
				button_create(data_list,startPage);
			}
			
			else{				
				print_list(data_list);
				button_create(data_list ,startPage);
			}
			
		},
		error:function(e){
			alert(e);
		}
		
	});
	
}

//jsonArray타입의 객체의 갯수가 10개보다 적을경우 객체를 매개변수로 받아 출력하는 함수이다.
function list_write(data_list){
	
	for(var i =0 ; i<data_list.length;i++){//jquery 문을통해 태그안의 내용을 바꾸어준다 --> .text()사용
		
		$('#name'+i).text(data_list[i].name);
		$('#content'+i).text(data_list[i].content);
		$('#date'+i).text(data_list[i].date);
		$('#writer'+i).text(data_list[i].writer);
	}
	
	for(var i =data_list.length;i<10;i++){//jsonArray타입의 객체의 갯수가 10개보다 적을경우 데이터가 들어가지 않는 행은 안보임 처리를 해준다
		$('#name'+i).hide(); 
		$('#content'+i).hide();
		$('#date'+i).hide();
		$('#writer'+i).hide();
	}
	
}

//클로저 함수 --> 클릭된 버튼의 값에 맞게 불러온 데이터 를 슬라이싱 해서 보여줌
//클릭된 버튼의 값을 사용해서 슬라이싱 범위인 startNum,endNum을 지정해 준다.
//한 페이지 에는 페이지안에 속해있는 페이지 블럭에 맞는 게시물(레코드) 수가 있기 때문이다.
//--->한 페이지 가 가지고 있는 배열안에서 그때그때 해당페이지 블럭을 클릭 한다면 거기 범위에 맞는 데이터를 가져오기 위해 슬라이싱 해줄 필요가 있다
function page(currentPage){
	
	var startNum = (currentPage-1)*10+1;
	var endNum = currentPage*10;
	
	var start_index=0;
	var end_index=0;
	
	 //endNum 이 해당 배열의 마지막 숫자보다 크다면 다시 슬라이싱이 제대로 되지 않으므로 범위를 다시 지정해 주어야 한다
	 //구분 하기 위해 check라는 변수를 사용해서 check 값이 변하지 않는다면 endNum의 범위를 다시 지정해준다
	var check=null;
	
	for(var i = 0; i<arr.length;i++){
		if(arr[i].num==startNum){
			start_index=i;
		}
		if(arr[i].num==endNum){
			end_index=i;
			check=1;
		}
		
	}
	
	var new_arr = new Array();
	
	if(check != 1){
		end_index=arr.length-1; // endNum의 는 배열의 마지막 인덱스 번호이다. 
	}
		
	new_arr = arr.slice(start_index, end_index+1);	
	
	
	if(new_arr.length<maxRow){//데이터가 maxRow보다 작다면 데이터를 출력하는 데에 있어서 다르게 처리해주어야 함
		list_write(new_arr);
	}
	else{
		print_list(new_arr);
	} 
	

}

//10개 보다 큰 게시물이 출력 될때 이전의 데이터는 10개보다 작을수 있으므로
//.hide()메소드가 사용되어 가려져 있을 확률 이 있다
//그래서 전부 .show() 로 보여준다음

//해당 게시물을 출력한다
function print_list(data_list){
	for(var i=0;i<10;i++){
		$('#name'+i).show();
		$('#content'+i).show();
		$('#date'+i).show();
		$('#writer'+i).show();
		
		$('#name'+i).text(data_list[i].name);
		$('#content'+i).text(data_list[i].content);
		$('#date'+i).text(data_list[i].date);
		$('#writer'+i).text(data_list[i].writer);
	}
}

</script>
</body>
</html>