<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.List, com.ajax.model.vo.Member" %>  
    
  
<!-- 페이지에 구성할 부분만 별도로 작성하면 된다, 왜냐하면 ajax로 쏴줄꺼닌깐 -->

<%
	
List<Member> list = (List)request.getAttribute("list");

%>

<table>
	<tr>
		<th>이름</th>
		<th>번호</th>
		<th>프로필</th>
	</tr>
	
	
	<% for(Member m : list) { %>
		<tr>
			<td><%= m.getName() %></td>
			<td><%= m.getPhone() %></td>
			<td>
				<img alt="" src="<%=request.getContextPath()%>/images/<%= m.getProfile()%>">
			</td>
			<td>
				<table>
					<tr>
						<td>ㅋ</td>
						<td>ㅎ</td>
					</tr>
				</table>
			</td>
		</tr>
	<% } %>
</table>