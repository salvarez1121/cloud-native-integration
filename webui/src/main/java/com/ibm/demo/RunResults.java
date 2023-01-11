package com.ibm.demo;

import java.io.ByteArrayInputStream;
import java.io.IOException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.xml.sax.SAXException;

public class RunResults 
{

	String requestFlowServer;
	String responseFlowServer;
	String backendServer;
	String requestQMGR;
	String responseQMGR;
	
	public RunResults(String requestFlowServer, String responseFlowServer, String backendServer, String requestQMGR, String responseQMGR) 
	{
		this.requestFlowServer = requestFlowServer;
		this.requestQMGR = requestQMGR;
		this.responseFlowServer = responseFlowServer;
		this.responseQMGR = responseQMGR;
		this.backendServer = backendServer;
	}
	
	public static RunResults parseData(byte[] xmlData) throws ParserConfigurationException, SAXException, IOException
	{
		ByteArrayInputStream input = new ByteArrayInputStream(xmlData);
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();
		Document doc = builder.parse(input);
		String requestFlowServer = doc.getDocumentElement().getChildNodes().item(1).getTextContent();
		requestFlowServer = requestFlowServer.substring(requestFlowServer.lastIndexOf(":")+2);
		
		String responseFlowServer = doc.getDocumentElement().getChildNodes().item(5).getTextContent();
		responseFlowServer = responseFlowServer.substring(responseFlowServer.lastIndexOf(":")+2);
		
		String backendServer = doc.getDocumentElement().getChildNodes().item(3).getTextContent(); 
		backendServer = backendServer.substring(backendServer.lastIndexOf(":")+2);
		
		String requestQMGR = doc.getDocumentElement().getChildNodes().item(2).getTextContent();
		requestQMGR = requestQMGR.substring(requestQMGR.lastIndexOf(":")+2);
		
		String responseQMGR = doc.getDocumentElement().getChildNodes().item(4).getTextContent();
		responseQMGR = responseQMGR.substring(responseQMGR.lastIndexOf(":")+2);
		
		return new RunResults(requestFlowServer, responseFlowServer, backendServer, requestQMGR, responseQMGR);
		
	}
	
	public boolean queueManagersTheSame()
	{
		return requestQMGR.equals(responseQMGR);
	}
	
	public boolean integrationServersTheSame()
	{
		return requestFlowServer.equals(responseFlowServer);
	}
	
	public String getIntegrationServer()
	{
		return requestFlowServer;
	}
	
	public String getRequestQueueManager()
	{
		return requestQMGR;
	}
	
	public String getResponseQueueManager()
	{
		return responseQMGR;
	}
	
	public String getBackendIntegrationServer()
	{
		return backendServer;
	}
	
	public String toString()
	{
		if(! responseQMGR.equals(requestQMGR))
		{
			return "QMGR DO NOT MATCH **********************************";
		}
		return "requestFlowServer: "+ requestFlowServer+ " responseFlowServer: "+ responseFlowServer + " backendServer: "+ backendServer+ " requestQMGR: " + requestQMGR + " responseQMGR: " + responseQMGR;
	}
}
