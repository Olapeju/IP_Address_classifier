# IP_Address_classifier
An IOS application that takes an IP address and net mask and calculates the resulting broadcast, network and host range. The IP address is inputted by the user using the dotted decimal and the net mask is inputted using the CIDR notation. The class of each resulting IP address is also displayed.


QUESTION

In this assignment you are to develop an app that computes the list of IP addresses, and the netmask of a network. You are to use a table view to display the entire list of IP addresses within a network. You will enter the network IP address in a text filed, and you will enter the number of netmask bits in another text filed. Your view should have two buttons, one button to display the first and last IP addresses in the subnet, and the other is to display a new table view to replace the existing view that contains the list of IP addresses in the network (you need to have an entirely new MVC). 

Upon pushing the first button, you need to display in an alert view the first and the last IP addresses in the list along with the Subnet mask in the form of x.y.z.w

Upon pushing the second button, you will display a new view (segue) and populate a table view with the entire list of IP addresses within the network.  Once you have the list, you should be able to click on any cell in the table and segue to a third new MVC that display information that has the value of the IP address and if the IP address is a class A, class B, class C, class D, or class E IP address, you can look that information up in any networking book or online to find out what class it is. The third view should contain two additional button, both buttons once pushed should take you back to the first view where you enter the information. The first button should be labeled Modify and it should take you back to the original view while maintaining its contents so you can modify them. The Second button labeled Enter New and it should take you back to the original view with all of its contents cleared. 

Example:
If the user enters 192.168.1.0 and a number of netmask bits is 28, then the following information must be computed:

First IP address: 192.168.1.1 and the last IP address is 192.168.1.15 and in this case the netmask is: 255.255.255.240

With respect to error checking, look at the following:
If you enter an IP address that is 278.2.33.189 this will be an invalid IP address. You also should limit the network mask bits to a minimum of 1 and a maximum of 16, anything else would cause an error, and it should also be an integer number. In other words, you must check for all conditions that could cause the program to crash.

Your program must use autolayouts and must work and display properly on any iOS device. Also, documenting your code is necessary, as well as labeling your output and making the app as user friendly as possible. It is a must that your code adheres to the MVC design strategy. 
