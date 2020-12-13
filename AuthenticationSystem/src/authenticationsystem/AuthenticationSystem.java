/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package authenticationsystem;

import java.util.Scanner;
import java.security.MessageDigest;
import java.io.File;
import java.io.FileNotFoundException;
import java.security.NoSuchAlgorithmException;


public class AuthenticationSystem {
    
   public static void main(String[] args) throws FileNotFoundException, NoSuchAlgorithmException {
        //Create a scanner object to read input from the console
        Scanner readInput=new Scanner(System.in);
        //Declare a variable to keep track the number of attempts
        int attempts=0;
        
        while(true) {
            //Ask the user for a username
            System.out.print("Enter user name: ");
            String uName=readInput.nextLine();
            //Ask the user for a password
            System.out.print("Enter password: ");
            String original = readInput.nextLine();  
            //Replace "password" with the actual password input by the user
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(original.getBytes());
            byte[] digest = md.digest();
            StringBuilder sb = new StringBuilder();
            for (byte b : digest) {
                sb.append(String.format("%02x", b & 0xff));
            }
            //Declare a boolean variable to keep track whether
            //a login is successful or not
            boolean authenticationSuccess=false;
            //Open credentials file
            Scanner readCred=new Scanner(new File("credentials.txt"));
            //Search for the user credentials in the credentials file
                
            while(readCred.hasNextLine()){
                String record=readCred.nextLine();
                String columns[]=record.split("\t");
                //Check user name.
                if(columns[0].trim().equals(uName)){
                    if(columns[1].trim().equals(sb.toString())){
                        //If the passwords are same, set the boolean value
                        //AuthenticationSuccess to true
                        authenticationSuccess=true;//Login success
                        //Open the role file
                        Scanner readRole=new Scanner(new File(columns[3].trim()+".txt"));
                        //Display the information stored in the role file
                        while(readRole.hasNextLine()){
                            System.out.println(readRole.nextLine());
                        }
                        break;

                    }

                }

            }
            //If login successful, ask the user whether the user wants to log out or not
            if(authenticationSuccess){
                System.out.println("Do you want to log out(y/n): ");
                String choice=readInput.nextLine();
                //If user wants to log out, exit the system.
                if(choice.toLowerCase().charAt(0)=='y'){
                    System.out.println("Successfully loged out.");
                    
                    break;
                }
                //If user wants to continue, set the boolean value
                //authenticationSuccess to true for new login
                else{
                    authenticationSuccess=false;
                }
            }
            //If login is not successful, update the number of attempts
            else{
                attempts++;
                //If maximum attempts reached, notify the user and exit the program
                if(attempts==3){
                    System.out.println("Maximum attempts reached!\nExiting...");
                    break;
                }
                //otherwise, prompt to enter credentials again
                else{
                    System.out.println("Please enter correct credentials!");
                }
            }
       }
   }

}
        
        
    
   

