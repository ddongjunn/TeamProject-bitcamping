<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.noticeDetail{
		width: 85%;
		background-color: LavenderBlush;
	}
	.noticeDetail td{
		padding: 10px 0px;
		border-bottom: 1px solid gray;
		border-right: 1px solid gray;
	}
	.commentbox{
		background-color: LightCyan;
		width: 85%;
		margin-top: 15px;
		padding: 15px;
	}
	.inputComment{
		width: 80%;
		height: 80px;
	}
</style>
</head>
<body>

<table class="noticeDetail">
	<tbody>
		<tr>
			<td>
				<span>${notice.title}</span>
			</td>
		</tr>
		<tr>
			<td>
				<span>${notice.nickname}</span>
			</td>
		</tr>
		<tr>
			<td>
				<span>조회수 ${notice.readcount}</span>
			</td>
		</tr>
		<tr>
			<td>
				<span>${notice.filename} (${notice.downcount}회 다운)</span>
			</td>
		</tr>	
		<tr>
			<td>
				<span>${notice.content}</span>
			</td>
		</tr>
	</tbody>
</table>

<div class="commentbox">
	<div>
	</div>
	<div>
		<textarea class="inputComment" placeholder="댓글 입력"></textarea>
	</div>
	<div class="writeCommentBtnBox">
		
	</div>
</div>

</body>
</html>