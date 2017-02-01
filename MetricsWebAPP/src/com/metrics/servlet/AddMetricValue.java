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
 * Servlet implementation class AddMetricValue
 */
public class AddMetricValue extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String metricName = request.getParameter("metricName");
		double metricValue = Double.parseDouble(request.getParameter("mvalue"));
		System.out.println("Metric Name=" + metricName);
		HttpSession session = request.getSession(false);
		Map<String, ArrayList<Double>> map = (HashMap<String, ArrayList<Double>>) session.getAttribute("metricMap");

		ArrayList<Double> values = (ArrayList<Double>) map.get(metricName);
		if (values == null) {
			values = new ArrayList<Double>();
		}
		values.add(metricValue);
		map.put(metricName, values);

		System.out.println("metric " + metricName + " values = " + values);
		RequestDispatcher rd = request.getRequestDispatcher("PostValues.jsp");
		rd.forward(request, response);

	}

}
