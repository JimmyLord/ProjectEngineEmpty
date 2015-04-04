package com.flathead.EmptyReplaceMePackage;

import android.os.Bundle;
import com.flathead.MYFWPackage.*;

public class EmptyReplaceMeActivity extends MYFWActivity
{
	@Override protected void onCreate(Bundle savedInstanceState)
	{
		m_MainViewResourceID = R.layout.main;
		m_MainLayoutResourceID = R.id.mainLayout;
		
		super.onCreate( savedInstanceState );
	}

	static
	{
		System.loadLibrary( "EmptyReplaceMe" ); // load libEmptyReplaceMe.so
	}
}
