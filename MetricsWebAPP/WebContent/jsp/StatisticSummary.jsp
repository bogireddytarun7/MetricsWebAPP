<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@page import="java.util.*"%>
<%@page import="com.metrics.domain.Statistics"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="UTF-8">
<%
	response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<title>Metrics API</title>
<link href="css/bootstrap.css" rel="stylesheet">

<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<link href="css/bootstrap-responsive.min.css" rel="stylesheet">
<link rel="stylesheet"
	href="http://netdna.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<link href="css/style.css" rel="stylesheet" />
<link href="http://www.jqueryscript.net/css/jquerysctipttop.css"
	rel="stylesheet" type="text/css">
<link href='http://fonts.googleapis.com/css?family=Open+Sans'
	rel='stylesheet' type='text/css'>
<script src="js/jquery-1.7.1.min.js" type="text/javascript"></script>

<script type="text/javascript" language="javascript"
	src="js/jquery.dataTables.min.js">
	
</script>
<script type="text/javascript" language="javascript"
	src="js/dataTables.bootstrap.min.js">
	
</script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.10.11/css/dataTables.bootstrap.min.css">


<script src="js/bootstrap.min.js" type="text/javascript"></script>
<script type="text/javascript" class="init">
	$(document).ready(function() {
		$('#example').DataTable();
	});
</script>
</head>
<body>
	<%
		Map<String, ArrayList<Double>> map = (HashMap<String, ArrayList<Double>>) session.getAttribute("metricMap");
		String metric = (String) request.getAttribute("metricName");
		Statistics metricStats = (Statistics) request.getAttribute("stats");
		ArrayList<Double> values = (ArrayList<Double>) map.get(metric);
		if (values == null) {
			values = new ArrayList<Double>();
		}

		Iterator<Double> itr = values.iterator();
	%>
	<div class="container">

		<div class="row"
			style="border-bottom: 2px solid rgba(0, 0, 0, 0.15); background-color: #4a89dc; padding-left: 15px">
			<div style="color: white; font-size: 40px;">METRIC API</div>
		</div>
		<div class="row">
			<div class="col-md-1"></div>
			<div class="col-md-10" style="padding: 15px 40px 40px 40px;">

				<h3>
					Statistic Summary -
					<%=metric%></h3>
				<div class="row"
					style="padding: 30px 50px 20px 50px; border: 2px solid rgba(0, 0, 0, 0.33);">

					<table id="example" class="table table-striped table-bordered"
						cellspacing="0" width="100%">
						<thead>
							<tr>
								<th>Metric Name</th>
								<th>Value</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<th>Metric Name</th>
								<th>Value</th>
							</tr>
						</tfoot>
						<tbody>
							<%
								while (itr.hasNext()) {
									Double value = itr.next();
							%>
							<tr>

								<td><%=metric%></td>

								<td><%=value%></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
					<div style="padding-top: 10px; padding-left: 40%">

						<form name="form" id="form" action="./MetricMaster"
							class="form-horizontal" enctype="multipart/form-data"
							method="GET">

							<table>
								<tr>
									<td style="text-align: left"><label>Arithmetic
											Mean</label></td>
									<td style="padding-left: 10px">
										<%
											if (values.size() != 0) {
										%> <label>- <%=metricStats.getMean()%></label>
										<%
											} else {
										%> <label>- Values Not Defined </label> <%
 	}
 %>
									</td>
								</tr>

								<tr>
									<td style="text-align: left"><label>Median</label></td>
									<td style="padding-left: 10px">
										<%
											if (values.size() != 0) {
										%> <label>- <%=metricStats.getMedian()%></label>
										<%
											} else {
										%> <label>- Values Not Defined </label> <%
 	}
 %>
									</td>
								</tr>
								<tr>
									<td style="text-align: left"><label>Minimum Value</label>
									</td>
									<td style="padding-left: 10px">
										<%
											if (values.size() != 0) {
										%> <label>- <%=metricStats.getMin()%></label>
										<%
											} else {
										%> <label>- Values Not Defined </label> <%
 	}
 %>
									</td>
								</tr>
								<tr>
									<td style="text-align: left"><label>Maximum Value</label>

									</td>
									<td style="padding-left: 10px">
										<%
											if (values.size() != 0) {
										%> <label>- <%=metricStats.getMax()%></label>
										<%
											} else {
										%> <label>- Values Not Defined </label> <%
 	}
 %>
									</td>
								</tr>
								<tr>

									<td colspan="2"
										style="padding-top: 20px; text-align: center; align-content: center; padding-left: 0px;">
										<button type="submit" class="btn btn-primary">
											<span class="fa fa-home" style="padding-right: 5px"></span>Home
										</button>
									</td>
								</tr>

							</table>
						</form>
					</div>
				</div>

			</div>
		</div>
	</div>
</body>
</html>