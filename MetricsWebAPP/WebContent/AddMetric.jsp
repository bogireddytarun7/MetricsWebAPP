<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
    <title>Metrics API</title>
    <link href="css/bootstrap.css" rel="stylesheet">
    
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <link href="css/bootstrap-responsive.min.css" rel="stylesheet">
    <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
    <link href="css/style.css" rel="stylesheet"/>
    <link href="http://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
    <script src="js/jquery-1.7.1.min.js" type="text/javascript"></script>
    
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
    <script>
    function validateMetric()
    {
    	var mvalue=document.getElementById('mname').value;
    	var pattern=/^\w+$/;
    	if(!pattern.test(mvalue))
    		{
    			document.getElementById('message').innerHTML="<span style='color:red'>Enter Correct Metric!</span>";
    			document.getElementById('mname').focus();
    		}
    	else
    	document.getElementById('form').submit();
    }
    function f()
    {	
    	if(document.getElementById('status').value=="false")
		{
			document.getElementById('message').innerHTML="<span style='color:red'>Metric already exists!</span>";
			document.getElementById('mname').focus();
		}	
    }	    
    </script>
    
</head>
<body onload=f()>
<%
            Map<String,ArrayList<Double>> map=(HashMap<String,ArrayList<Double>>)session.getAttribute("metricMap");
			Boolean status=true;
			status=(Boolean)request.getAttribute("status");
			String oldvalue=(String)request.getAttribute("oldvalue");
			if(oldvalue==null)
				oldvalue="";
			if(status==null)
			{
				status=true;
				
			}
			Set<String> metrics;

			if(map!=null) {
			metrics=map.keySet();
			
			}
			else
				metrics=new HashSet<String>();
			Iterator<String> itr=metrics.iterator();
			
            %>
<div class="container">

    <div class="row" style="border-bottom:2px solid rgba(0, 0, 0, 0.15);background-color:#4a89dc;padding-left: 15px">
        <div style="color:white;font-size:40px;">
           METRIC API
			
        </div>
    </div>
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10" style="padding:15px 40px 40px 40px; ">

            <h3>Add Metric</h3>
            <div class="row" style="padding:30px 50px 20px 50px;border:2px solid rgba(0, 0, 0, 0.33);">
            <input type="hidden" id="status" value=<%= status %> />
            <input type="hidden" id="oldvalue" />
                <form name="form" id="form" action="./AddMetric" class="form-horizontal" enctype="multipart/form-data" method="GET">
                <table>
                    <tr>
                        <td style="text-align: left">
                            <label>Metric Name</label>
                        </td>
                        <td style="padding-left: 10px">
                            <input type="text" id="mname" name="mname" class="form-control" value='<%= oldvalue %>' />
                        </td>
                       <td>
                       	<div id="message"></div>
                       </td>
                    </tr>
                    <tr>
                        <td style="padding-top:20px;text-align:right">
                            <a href="./MetricMaster"><button type="button"  class="btn btn-default">Cancel</button></a>
                        </td>
                        <td style="padding-top:20px;text-align: left;padding-left:10px ">
                            <button type="button" class="btn btn-primary" onclick=validateMetric() ><span class="fa fa-floppy-o" style="padding-right: 5px"></span>Save</button>
                        </td>
                    </tr>

                </table>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>