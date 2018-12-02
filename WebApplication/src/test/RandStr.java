package test;
import java.util.Random;

public class RandStr {
	
	
	
	public String getString(int n)
	{
		String result  = "";
		Random rnd = new Random();

		for(int i=0;i<n;i++)
		{
			switch(rnd.nextInt(3))
			{
				case 0:
					result += String.valueOf((char) ((int) (rnd.nextInt(26)) + 97));
					break;
				case 1:
					result += String.valueOf((char) ((int) (rnd.nextInt(26)) + 65));
					break;
				case 2:
					result += String.valueOf(rnd.nextInt(10));
					break;
			}			
		}
		return result;
	}
	public int getInt(int n)
	{
		Random rnd = new Random();
		String result = "";
		for(int i=0;i<n;i++)
		{
			result += String.valueOf(rnd.nextInt(10));	
		}
		return Integer.parseInt(result);
	}

}
