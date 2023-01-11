package com.ibm.demo;

import java.util.ArrayList;
import java.util.Iterator;

public class ManagementThread extends Thread
{
    public void run()
	{
		while(true)
		{
			try
            {
                Thread.sleep(5000);
                ArrayList<RunResults> oldList;
                synchronized (StartTests.list) 
                {
                    oldList = StartTests.list;
                    StartTests.list = new ArrayList<RunResults>();
                }
                Iterator<RunResults> iteratorResults = oldList.iterator();
                synchronized(StartTests.currentSummary)
                {
                    StartTests.currentSummary = new SummaryOfResults();
                    while(iteratorResults.hasNext())
                    {
                        StartTests.currentSummary.processResult(iteratorResults.next());
                    }
                    System.out.println("Summary="+StartTests.currentSummary.toString());
                    oldList.clear();
                }
            }
            catch(Exception e)
            {
                e.printStackTrace();
            }
		}
	}
}