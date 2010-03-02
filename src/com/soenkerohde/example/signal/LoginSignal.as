package com.soenkerohde.example.signal
{
	import com.soenkerohde.example.domain.User;

	import org.osflash.signals.Signal;

	public class LoginSignal extends Signal
	{
		public function LoginSignal()
		{
			super(User);
		}
	}
}