package com.metrics.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class DeleteMetricValue
 */
public class DeleteMetricValue extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String metricName = request.getParameter("metricName");
		System.out.println("Metric Name=" + metricName);
		double metricValue = Double.parseDouble(request.getParameter("mvalue"));
		HttpSession session = request.getSession(false);
		Map<String, ArrayList<Double>> map = (HashMap<String, ArrayList<Double>>) session.getAttribute("metricMap");
		if (map != null) {
			ArrayList<Double> values = (ArrayList<Double>) map.get(metricName);
			if (values == null) {
				values = new ArrayList<Double>();
			}

			values.remove(metricValue);
			System.out.println("metric " + metricName + " with value " + metricValue + " deleted");
			RequestDispatcher rd = request.getRequestDispatcher("PostValues.jsp");
			rd.forward(request, response);

		} else {
			RequestDispatcher rd = request.getRequestDispatcher("PostValues.jsp");
			rd.forward(request, response);
		}

	}

}
