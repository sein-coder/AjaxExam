package com.ajax.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ajax.model.vo.Member;

/**
 * Servlet implementation class JqueryCsvServlet
 */
@WebServlet("/js/csvData")
public class JqueryCsvServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JqueryCsvServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Member> list = new ArrayList();
		list.add(new Member("박보검","01045631234","parkBogum.jpg"));
		list.add(new Member("쥴리아로버츠","01045632244","juliaRoberts.jpg"));
		list.add(new Member("맷데이먼","01045634567","mattDamon.jpg"));
		
		String csv = "";//이 변수에 데이터만 구분자를 넣고 누적시킨다.
		for(int i=0; i<list.size(); i++) {
			if(i!=0) csv+="\n";
			csv+=list.get(i); //toString==이름, 전화번호, 프로필
		}
		//[\n] 는 구분자
		//박보범,000001234,parkbogum.jpg[\n]쥴리아로버츠,134123,jul.jpg[\n]...
		//String으로 정리된 자료를 클라이언트에게 전송~
		response.setContentType("text/csv; charset=UTF-8");
		response.getWriter().append(csv);
		
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
