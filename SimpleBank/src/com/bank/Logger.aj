package com.bank;

import java.io.FileNotFoundException;

public aspect Logger {

    pointcut userCreate() : call(* *.createUser());
	pointcut transaction(): call(* *.moneyMakeTransaction());
	pointcut withdraw() : call(* *.moneyWithdrawal());

    after() : userCreate() {
    	System.out.println("**** User created ****");
    }
    
    after() : withdraw(){
		if(writeFile("Withdraw"))
			System.out.println("***Withdraw Complete***");
	}
	
	public boolean writeFile(String type) {
		PrintWriter outputStream=null;
		try {
			outputStream = new PrintWriter(new FileOutputStream("D:\\Log.txt",true));
			Calendar cal = Calendar.getInstance();
			String output = type+";"+cal.getTime().toString();
			outputStream.println(output);
			return true;
		}catch(FileNotFoundException e){
			System.out.println("An error has ocurred");
			return false;
		}finally {
			if(outputStream != null) {
				outputStream.close();
			}
		}
	}
}

