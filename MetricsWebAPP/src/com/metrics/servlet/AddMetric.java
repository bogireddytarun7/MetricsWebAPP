package com.metrics.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class AddMetric
 */
public class AddMetric extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String metricName = request.getParameter("mname");
		System.out.println("Metric Name=" + metricName);
		HttpSession session = request.getSession(false);
		Map<String, ArrayList<Double>> map = (HashMap<String, ArrayList<Double>>) session.getAttribute("metricMap");
		Set<String> metrics = (Set<String>) map.keySet();
		if (!metrics.contains(metricName)) {

			map.put(metricName, null);

			System.out.println("new metric is inserted");
			RequestDispatcher rd = request.getRequestDispatcher("jsp/MetricMaster.jsp");
			rd.forward(request, response);

		} else {
			RequestDispatcher rd = request.getRequestDispatcher("AddMetric.jsp");
			request.setAttribute("status", false);
			request.setAttribute("oldvalue", metricName);
			rd.forward(request, response);
		}

	}

}
