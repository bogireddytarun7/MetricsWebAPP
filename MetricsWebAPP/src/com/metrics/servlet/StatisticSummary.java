package com.metrics.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.metrics.domain.Statistics;

/**
 * Servlet implementation class StatisticSummary
 */
public class StatisticSummary extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String metricName = request.getParameter("metricName");
		System.out.println("Metric Name=" + metricName);
		HttpSession session = request.getSession(false);
		Map<String, ArrayList<Double>> map = (HashMap<String, ArrayList<Double>>) session.getAttribute("metricMap");

		ArrayList<Double> values = (ArrayList<Double>) map.get(metricName);
		if (values == null) {
			values = new ArrayList<Double>();
		}
		Statistics stats = new Statistics();
		if (values.size() > 0) {

			Iterator<Double> itr = values.iterator();
			double sum = 0;
			while (itr.hasNext()) {
				sum = sum + itr.next();

			}
			double mean = sum / values.size();
			stats.setMean(mean);

			double min = Collections.min(values);
			stats.setMin(min);

			double max = Collections.max(values);
			stats.setMax(max);

			Collections.sort(values);
			double median = 0;
			int index = values.size() / 2;
			if (values.size() % 2 == 0) {
				median = (values.get(index) + values.get(index - 1)) / 2;
			} else {
				median = values.get(index);
			}

			stats.setMedian(median);

			System.out.println("metric " + metricName + " values = " + values);
			System.out.println("metric " + metricName + " statistics:");
			System.out.println("Mean=" + stats.getMean());
			System.out.println("Median=" + stats.getMedian());
			System.out.println("Min=" + stats.getMin());
			System.out.println("Max=" + stats.getMax());

			RequestDispatcher rd = request.getRequestDispatcher("jsp/StatisticSummary.jsp");
			request.setAttribute("stats", stats);
			request.setAttribute("metricName", metricName);
			rd.forward(request, response);
		} else {
			RequestDispatcher rd = request.getRequestDispatcher("jsp/StatisticSummary.jsp");
			request.setAttribute("stats", stats);
			request.setAttribute("metricName", metricName);
			rd.forward(request, response);
		}

	}

}
