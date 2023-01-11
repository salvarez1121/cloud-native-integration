package com.ibm.demo;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Arrays;

import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;

public class CallAPI 
{
	private static final String inputData = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Path><runtime>runtime</runtime></Path>";
	
	public static RunResults callAPI()
	{
		URL url;
		try {
			//System.out.print("Calling");
			url = new URL("http://infinite-is:7800/infinitescale");
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("POST");
			con.setDoOutput(true);
			
			OutputStream os = con.getOutputStream();
			os.write(inputData.getBytes());
			os.flush();
			os.close();
			

			InputStream is = con.getInputStream();
			byte[] dataReceived = new byte[1024];
			int readBytes = is.read(dataReceived);
			RunResults result = RunResults.parseData(Arrays.copyOf(dataReceived, readBytes));
			//System.out.println(Thread.currentThread().getName() + " " + result);
			con.disconnect();
			return result;
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SAXException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
