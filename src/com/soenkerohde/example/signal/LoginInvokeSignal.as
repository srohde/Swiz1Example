package com.soenkerohde.example.signal
{
	import org.osflash.signals.Signal;

	public class LoginInvokeSignal extends Signal
	{
		public function LoginInvokeSignal()
		{
			super(String, String);
		}
	}
}