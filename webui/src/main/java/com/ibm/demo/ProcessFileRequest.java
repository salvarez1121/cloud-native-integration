package com.ibm.demo;


import java.io.IOException;
import java.io.OutputStream;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;


public class ProcessFileRequest implements HttpHandler
{

	@Override
	public void handle(HttpExchange exchange) throws IOException 
	{
		try
		{
			OutputStream os = exchange.getResponseBody();
	        String response = StartTests.currentSummary.toJson();
	        exchange.sendResponseHeaders(200, response.length());
	        
	        os.write(StartTests.currentSummary.toJson().getBytes());
	        os.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			throw e;
		}
		
	}

}
