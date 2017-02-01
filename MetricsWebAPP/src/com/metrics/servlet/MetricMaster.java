package com.metrics.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MetricMaster extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		if (session.isNew()) {
			System.out.println("hello");
			Map<String, ArrayList<Double>> map = new HashMap<String, ArrayList<Double>>();

			session.setAttribute("metricMap", map);
		}
		RequestDispatcher rd = request.getRequestDispatcher("./jsp/MetricMaster.jsp");
		rd.forward(request, response);

	}

}
