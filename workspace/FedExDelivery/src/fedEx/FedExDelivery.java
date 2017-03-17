package fedEx;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FedExDelivery {

	public static void main(String[] args) {
		
		OrderCreationThread thread1 = new OrderCreationThread();
		OrderCreationThread thread2 = new OrderCreationThread();
		OrderCreationThread thread3 = new OrderCreationThread();
		OrderSimulation thread4 = new OrderSimulation();
		
		thread1.start();
		thread2.start();
		thread3.start();
		thread4.start();
		
		Liabrary lib = new Liabrary();
		BufferedReader br = null;
		br = new BufferedReader(new InputStreamReader(System.in));
		String input = null;
		Map<String,String> inputData = new HashMap<String,String>();
		while(true){
			System.out.println("\nWelcome to FedEx Delivery!!\n");
			System.out.println("Whats In Your Mind\n"
					+ "1. Create New Order\n"
					+ "2. Track Order\n"
					+ "3. Exit");
			
			try {
				input = br.readLine();
			} catch (IOException e) {
				System.out.println("Something Went Wrong Please Try Again!!");
				continue;
			}
			
			if(input.equalsIgnoreCase("1")){
				
				//-------------Service
				System.out.println("Thanks for Choosing FedEx!\n"
						+ "Please Provide Following Information To Place The Order\n"
						+ "Select Type of Service\n"
						+ "1. FedEx Home Delivery\n"
						+ "2. FedEx Courier\n");
				try {
					input = br.readLine();
					if(input.equalsIgnoreCase("1"))
						input = "FedEx Home Delivery";
					else
						input = "FedEx Courier";
				} catch (IOException e) {
					System.out.println("Something Went Wrong Please Try Again!!");
					continue;
				}
				inputData.put("service", input);
				
				//-------------Weight
				System.out.println("\nEnter the weight of package\n");
				try {
					input = br.readLine();
				} catch (IOException e) {
					System.out.println("Something Went Wrong Please Try Again!!");
					continue;
				}
				inputData.put("weight", input);
				
				
				//-------------Dimension
				System.out.println("\nEnter the dimension of package\n");
				try {
					input = br.readLine();
				} catch (IOException e) {
					System.out.println("Something Went Wrong Please Try Again!!");
					continue;
				}
				inputData.put("dimensions", input);
				
				
				//-------------Signature Service
				System.out.println("\nSelect Type of Signature Service\n"
						+ "1. Direct Signature Required\n"
						+ "2. No Direct Signature Required\n");
				try {
					input = br.readLine();
					if(input.equalsIgnoreCase("1"))
						input = "Direct Signature Required";
					else
						input = "No Direct Signature Required";
				} catch (IOException e) {
					System.out.println("Something Went Wrong Please Try Again!!");
					continue;
				}
				inputData.put("signature_service", input);
				
				
				//-------------Total Pieces
				System.out.println("\nEnter the Total Pieces of package\n");
				try {
					input = br.readLine();
				} catch (IOException e) {
					System.out.println("Something Went Wrong Please Try Again!!");
					continue;
				}
				inputData.put("total_pieces", input);
				
				
				//-------------Packaging
				System.out.println("\nSelect Type of Packaging\n"
						+ "1. Package\n"
						+ "2. Letter\n"
						+ "3. Box\n");
				try {
					input = br.readLine();
					if(input.equalsIgnoreCase("1"))
						input = "Package";
					else if(input.equalsIgnoreCase("2"))
						input = "Letter";
					else
						input = "Box";
				} catch (IOException e) {
					System.out.println("Something Went Wrong Please Try Again!!");
					continue;
				}
				inputData.put("packaging", input);
				
				//-------------Special Handeling 
				System.out.println("\nSelect Type of Special Handeling\n"
						+ "1. Direct Signature Required\n"
						+ "2. Extra Care\n"
						+ "3. None\n");
				try {
					input = br.readLine();
					if(input.equalsIgnoreCase("1"))
						input = "Direct Signature Required";
					else if(input.equalsIgnoreCase("2"))
						input = "Extra Care";
					else
						input = "None";
				} catch (IOException e) {
					System.out.println("Something Went Wrong Please Try Again!!");
					continue;
				}
				inputData.put("special_handeling_section", input);
				
				//-------------Source And Destination 
				System.out.println("\nPlease Enter Source Location\n");
				try {
					input = br.readLine();
				} catch (IOException e) {
					System.out.println("Something Went Wrong Please Try Again!!");
					continue;
				}
				inputData.put("sourceCity", input);
				
				System.out.println("\nPlease Enter Destination Location\n");
				try {
					input = br.readLine();
				} catch (IOException e) {
					System.out.println("Something Went Wrong Please Try Again!!");
					continue;
				}
				inputData.put("destinationCity", input);
				
				lib.createOrder(inputData);
				
			}
			else if(input.equalsIgnoreCase("2")){
				
				System.out.println("Please Enter Tracking Id:");
				try {
					input = br.readLine();
					if(!input.matches("-?\\d+")){
						System.out.println("Please Enter Only Number!");
						continue;
					}
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				String orderData = lib.getOrderInfo(Integer.parseInt(input));
				System.out.println(orderData);
				String[] orderDataArray = orderData.split(",");
				System.out.println("\nShipment Facts:\n"
						+ "\nTracking Number: "+orderDataArray[0]+"\t\t\t\tService: "+orderDataArray[1]
						+ "\nWeight: "+orderDataArray[2]+"\t\t\t\t\tDimension: "+orderDataArray[3]
						+ "\nSignature Service: "+orderDataArray[4]+"\tTotal Pieces:"+orderDataArray[5]
						+ "\nPackaging: "+orderDataArray[6]+"\t\t\t\tSpecial Handeling Section: "+orderDataArray[7]
						+ "\n\n     Order Status:"+orderDataArray[9]+"\n");
				
				
				System.out.println("Travel History:\n");
				List<String> orderTrackingData = lib.getOrderStatus(Integer.parseInt(input));
				for(String str : orderTrackingData){
					System.out.println(str.split("@")[2].replace(".0","")+"\t"+str.split("@")[1]+"\t"+str.split("@")[0]);
				}
			}
			else if(input.equalsIgnoreCase("3")){
				System.exit(0);
				
			}
			else{
				System.out.println("Please enter Correct Input!");
				continue;
			}
		}
		
	}

	
}
