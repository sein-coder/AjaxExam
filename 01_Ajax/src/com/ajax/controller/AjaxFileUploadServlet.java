package com.ajax.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class AjaxFileUploadServlet
 */
@WebServlet("/ajaxFile")
public class AjaxFileUploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxFileUploadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(!ServletFileUpload.isMultipartContent(request)) {
			response.sendRedirect("/");
			return;
		}
		
		//저장경로
		String path = getServletContext().getRealPath("/upload");
		//크기
		int maxSize = 1024*1024*100;
		MultipartRequest mr = new MultipartRequest(request, path, maxSize, "UTF-8", new DefaultFileRenamePolicy());
		
		/* System.out.println(mr.getFilesystemName("upfile")); */
		
		/*
		 * System.out.println(mr.getFilesystemName("file0"));
		 * System.out.println(mr.getFilesystemName("file1"));
		 * System.out.println(mr.getFilesystemName("file2"));
		 * System.out.println(mr.getFilesystemName("file3"));
		 * System.out.println(mr.getFilesystemName("file4"));
		 * System.out.println(mr.getFilesystemName("file5"));
		 * System.out.println(mr.getFilesystemName("file6"));
		 * System.out.println(mr.getFilesystemName("file7"));
		 */
		
		List<String> fileNames = new ArrayList();
		
		Enumeration<String> e = mr.getFileNames();
		//iterator와 비슷한 방식으로 리스트에 쌓는다.
		while(e.hasMoreElements()) {
			fileNames.add(mr.getFilesystemName(e.nextElement()));
		}
		
		for(String str : fileNames) {
			System.out.println(str);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
