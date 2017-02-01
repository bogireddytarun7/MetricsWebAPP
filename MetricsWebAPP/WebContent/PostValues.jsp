<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@page import="java.util.*"%>
<%@page import="java.net.*"%>
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
        } );

    </script>
<script>
    function validateDecimal()
    {
    	var mvalue=document.getElementById('mvalue').value;
    	var pattern=/^[+-]?\d+(\.\d+)?$/;
    	if(!pattern.test(mvalue))
    		{
    			document.getElementById('message').innerHTML="<span style='color:red'>Enter Correct Decimal!</span>";
    			document.getElementById('mvalue').focus();
    		}
    	else
    		{
    		document.getElementById('form').submit();
    		}
    	
    }
    </script>
</head>
<body>
	<%
		Map<String, ArrayList<Double>> map = (HashMap<String, ArrayList<Double>>) session.getAttribute("metricMap");
		String metric = (String) request.getParameter("metricName");

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

				<h3>Post Values</h3>
				<div class="row"
					style="padding: 30px 50px 20px 50px; border: 2px solid rgba(0, 0, 0, 0.33);">
					<form name="form" id="form" action="AddMetricValue"
						class="form-horizontal" enctype="multipart/form-data" method="GET">
						<input type="hidden" name="metricName" value=<%=metric%> />
						<table>
							<tr>
								<td style="text-align: left"><label>Metric Value</label></td>
								<td style="padding-left: 10px"><input type="text"
									id="mvalue" name="mvalue" class="form-control" /></td>
								<td>
									<div id="message"></div>
								</td>
							</tr>
							<tr>
								<td style="padding-top: 20px; text-align: right"><a
									href="./MetricMaster"><button type="button"
											class="btn btn-default">Cancel</button></a></td>
								<td
									style="padding-top: 20px; text-align: left; padding-left: 10px">
									<button type="button" class="btn btn-primary"
										onclick=validateDecimal()>
										<span class="fa fa-floppy-o" style="padding-right: 5px"></span>Save
									</button>
								</td>

							</tr>

						</table>
					</form>
				</div>
				<div class="row" style="padding: 30px 50px 20px 50px;">
					<table id="example" class="table table-striped table-bordered"
						cellspacing="0" width="100%">
						<thead>
							<tr>
								<th>Metric Name</th>
								<th>Value</th>
								<th>Action</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<th>Metric Name</th>
								<th>Value</th>
								<th>Action</th>
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

								<%
									metric = URLEncoder.encode(metric, "UTF-8");
										String metricValue = URLEncoder.encode("" + value, "UTF-8");
										String deleteurl = "./DeleteMetricValue?metricName=" + metric + "&mvalue=" + metricValue;
								%>
								<td><a href=<%=deleteurl%>>Delete</a></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>