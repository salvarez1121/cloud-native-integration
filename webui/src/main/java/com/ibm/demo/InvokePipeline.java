package com.ibm.demo;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;

public class InvokePipeline implements HttpHandler
{
	private String pipelineID;
	
	public InvokePipeline(String pipelineID) 
	{
		super();
		this.pipelineID = pipelineID;
	}

	@Override
	public void handle(HttpExchange exchange) throws IOException 
	{
		String urlString="http://el-"+this.pipelineID+"-pipeline-event-listener:8080";
		System.out.println("urlString="+urlString);
		URL url=new URL(urlString);

		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setDoOutput(true);
		con.setDoInput(true);
		con.setRequestProperty("Content-Type", "application/json");
		con.setRequestProperty("Accept", "application/json");
		con.setRequestMethod("POST");
		
		con.getOutputStream().write("{}".getBytes());
		
		StringBuffer sb = new StringBuffer();
		int httpResult = con.getResponseCode(); 
		if (httpResult == HttpURLConnection.HTTP_OK) {
		    BufferedReader br = new BufferedReader(
		            new InputStreamReader(con.getInputStream(), "utf-8"));
		    String line = null;  
		    while ((line = br.readLine()) != null) {  
		        sb.append(line + "\n");  
		    }
		    br.close();
		    System.out.println("" + sb.toString());  
		} else {
		    System.out.println(con.getResponseMessage());  
		}
		OutputStream os = exchange.getResponseBody();
        String response = "Success!";
        exchange.sendResponseHeaders(200, response.length());
        
        os.write(StartTests.currentSummary.toJson().getBytes());
        os.close();
	}

}
