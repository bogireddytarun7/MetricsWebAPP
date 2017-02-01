<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@page import="java.util.*"%>
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
		Set<String> metrics;

		if (map != null) {
			metrics = map.keySet();

		} else
			metrics = new HashSet<String>();
		Iterator<String> itr = metrics.iterator();
	%>
	<div class="container">

		<div class="row"
			style="border-bottom: 2px solid rgba(0, 0, 0, 0.15); background-color: #4a89dc; padding-left: 15px">
			<div style="color: white; font-size: 40px;">METRIC API</div>
		</div>

		<div class="row">
			<div class="col-md-1"></div>
			<div class="col-md-10" style="padding: 15px 40px 40px 40px;">

				<div style="padding-bottom: 15px">
					<h3 style="border-bottom: 2px solid rgba(15, 15, 15, 0.38);">Metric
						Master</h3>
				</div>

				<form action="./AddMetric.jsp" method="GET">
					<div style="padding-bottom: 15px">
						<button type="submit" class="btn btn-primary">
							<span class="fa fa-plus" style="padding-right: 5px"></span>Add
							Metric
						</button>
					</div>
				</form>


				<table id="example" class="table table-striped table-bordered"
					cellspacing="0" width="100%">
					<thead>
						<tr>
							<th>Metric Name</th>
							<th>Action</th>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<th>Metric Name</th>
							<th>Action</th>
						</tr>
					</tfoot>
					<tbody>
						<%
							while (itr.hasNext()) {
								String metric = itr.next();
						%>
						<tr>

							<td><%=metric%></td>
							<%
								String posturl = "./PostValues.jsp?metricName=" + metric;
									String summaryurl = "./StatisticSummary?metricName=" + metric;
									String deleteurl = "./DeleteMetric?metricName=" + metric;
							%>
							<td><a href=<%=posturl%>>PostValues</a> | <a
								href=<%=summaryurl%>>Statistics</a> | <a href=<%=deleteurl%>>Delete</a></td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>

			</div>

		</div>
	</div>
</body>
</html>