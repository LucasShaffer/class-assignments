/*
This program acts as a airplane reservation system.
This program gets the prices of the seats from SeatPrices.txt which must be in C:/ to work properly.
*/
#include<iostream>
#include<iomanip>
#include<string>
#include<cstdlib>
#include<fstream>
using namespace std;

// Global constants.
const int FIRST_CLASS_COLS = 4;
const int COACH_COLS = 6;

// Function prototypes.
int displayMenu();
void getFirstClassReservation(char[][FIRST_CLASS_COLS], int &);
void getCoachReservation(char[][COACH_COLS], int &);
void displayAvailability(char[][FIRST_CLASS_COLS], char[][COACH_COLS]);
void displayTotalSeatsSold(char[][FIRST_CLASS_COLS], char[][COACH_COLS]);
void displayEmptySeatsInRow(char[][FIRST_CLASS_COLS], char[][COACH_COLS]);
void displayTotalEmptySeats(char[][FIRST_CLASS_COLS], char[][COACH_COLS]);
void displayTotalSales(char[][FIRST_CLASS_COLS], char[][COACH_COLS], double[]);
//******************
// main funcntion. *
//******************
void main()
{
	// Used to open and read our text file.
	ifstream inFile;
	// Initalize local variables.
	double prices[3];
	int choice = 0,
		section = 0,
		numberOfAvailableSeatsInFirstClass = 20,
		numberOfAvailableSeatsInCoach = 60;
	char cont;
	char firstClassAvailability[5][FIRST_CLASS_COLS] =
	{ { '#', '#', '#', '#' },
	{ '#', '#', '#', '#' },
	{ '#', '#', '#', '#' },
	{ '#', '#', '#', '#' },
	{ '#', '#', '#', '#' } };
	char coachAvailability[10][COACH_COLS] =
	{ { '#', '#', '#', '#', '#', '#' },
	{ '#', '#', '#', '#', '#', '#' },
	{ '#', '#', '#', '#', '#', '#' },
	{ '#', '#', '#', '#', '#', '#' },
	{ '#', '#', '#', '#', '#', '#' },
	{ '#', '#', '#', '#', '#', '#' },
	{ '#', '#', '#', '#', '#', '#' },
	{ '#', '#', '#', '#', '#', '#' },
	{ '#', '#', '#', '#', '#', '#' },
	{ '#', '#', '#', '#', '#', '#' } };

	// Attempt to open the SeatPrices.txt file.
	inFile.open("c:\\SeatPrices.txt");
	// If it failed to open, put error on the screen and exit.
	if (inFile.fail())
	{
		cout << "**ERROR: The file SeatPrices.txt did not open properly. Please make sure that the file is in your C:\ directory and try again.**\n";
		exit(0);
	}
	// If it was opened just fine, continue.
	else
	{
		// For each line in the file read the values and put them in the prices array.
		for (int count = 0; count < 3; count++)
		{
			inFile >> prices[count];
		}
		// Close the file.
		inFile.close();
	}

	// Diaplay title.
	cout << "\t\t AIRLINE RESERVATIONS\n";

	// Main do while loop that repeats unless the user wants to exit.
	do
	{
		// Call displayMenu and set the returned value in choice.
		choice = displayMenu();
		// Switch for user input.
		switch (choice)
		{
		case 1:
			// Call displayAvailability.
			displayAvailability(firstClassAvailability, coachAvailability);
			// Do-while loop for user input validation.
			do
			{
				// Display input options.
				cout << "Where would you like to reserve your seat(s)?\n"
					<< "1) First Class\n"
					<< "2) Coach\n";
				// Get input.
				cin >> section;
				// If input is invalid, display error and retry.
				if (section < 1 || section > 2)
				{
					cout << "**ERROR: That entry is not valid please try again.**\n";
				}
			} while (section < 1 || section > 2); // Repeat while invalid.
			// If user wants to reserve in first class.
			if (section == 1)
			{
				// Call getFirstClassReservation.
				getFirstClassReservation(firstClassAvailability, numberOfAvailableSeatsInFirstClass);
			}
			// If user wants to reserve in coach.
			if (section == 2)
			{
				// Call getCoachReservation.
				getCoachReservation(coachAvailability, numberOfAvailableSeatsInCoach);
			}
			break;
		case 2:
			// Call displayTotalSeatsSold.
			displayTotalSeatsSold(firstClassAvailability, coachAvailability);
			break;
		case 3:
			// Call displatEmptySeatsInRow.
			displayEmptySeatsInRow(firstClassAvailability, coachAvailability);
			break;
		case 4:
			// Call displayTotalEmptySeats.
			displayTotalEmptySeats(firstClassAvailability, coachAvailability);
			break;
		case 5:
			// Call displayTotalSales.
			displayTotalSales(firstClassAvailability, coachAvailability, prices);
			break;
		case 6:
			// Exit.
			exit(EXIT_SUCCESS);
			break;
		default:
			break;
		}
		// Do-while loop for if the user wants to continue.
		do
		{
			// Ask if user wants to continue.
			cout << "Would you like to continue?(y/n)\n";
			// Get user input.
			cin >> cont;
			// If input is invalid.
			if (cont != 'y' && cont != 'Y' && cont != 'n' && cont != 'N')
			{
				// Display error
				cout << "**ERROR: That is not a valid entry. Please try again.**\n";
			}
		} while ((cont != 'y') && ( cont != 'Y') && (cont != 'n') && (cont != 'N')); // Repeat while input is invalid.
		// Exit if user does not want to continue.
		if (cont == 'n' || cont == 'N')
		{
			exit(EXIT_SUCCESS);
		}
	} while (choice != 6); // Repeat while user input is not the exit option.
}

//***************************************************
// displayMenu funtion.								*
// This function will display a menu for the user.	*
// Get the user input, validate it, and return it.	*
//***************************************************
int displayMenu()
{
	// Initalize variable to hold user input.
	int choice = 0;
	// Do-while loop to display the menu and validate user input.
	do
	{
		// Display the menu.
		cout << "What would you like to do?\n"
			<< "1) Reserve your seat(s).\n"
			<< "2) Display the total number of seats sold.\n"
			<< "3) Display the total number of empty seats in a row.\n"
			<< "4) Display the total number of empty seats on the plane.\n"
			<< "5) Display the total amount of sales.\n"
			<< "6) Exit.\n";
		// Get the input and put it in choice.
		cin >> choice;
		// If input is invalid display an error.
		if (choice < 1 || choice > 6)
		{
			cout << "**ERROR: That entry is not valid please try again.**\n";
		}
	} while (choice < 1 || choice > 6); // Repeat while invalid.
	return choice;
}

//*******************************************************************
// displayAvailability funciton.									*
// This function will display a map and availability of the plane.	*
//*******************************************************************
void displayAvailability(char firstClassAvailability[][FIRST_CLASS_COLS], char coachAvailability[][COACH_COLS])
{
	// Print prompt.
	cout << "The current availability of the plane is.\n";
	// Print column numbers.
	cout << setw(9) << "12" << setw(3) << "34" << endl;
	// For loop to print out the availability of first class.
	for (int row = 0; row < 5; row++)
	{
		// Print "Row" and its number.
		cout << "Row " << setw(2) << row + 1;
		// For loop to print the individual seats availability.
		for (int col = 0; col < FIRST_CLASS_COLS; col++)
		{
			// If it is the first or thrid column print with a gap.
			if (col == 0 || col == 2)
			{
				cout << setw(2) << firstClassAvailability[row][col];
			}
			// Otherwise just print without a gap.
			else
			{
				cout << firstClassAvailability[row][col];
			}
		}
		// After the last column move to the next line
		cout << endl;
	}
	// After displaying first class, leave a gap and display coach.
	cout << endl;
	// Print column numbers.
	cout << setw(10) << "123" << setw(4) << "456" << endl;
	// For each row.
	for (int row = 0; row < 10; row++)
	{
		// Print row number
		cout << "Row " << setw(2) << row + 6;
		// For each Column print availability
		for (int col = 0; col < COACH_COLS; col++)
		{
			// If it is the first or fourth column leave a gap
			if (col == 0 || col == 3)
			{
				cout << setw(2) << coachAvailability[row][col];
			}
			// Otherwise do not leave a gap
			else
			{
				cout << coachAvailability[row][col];
			}
		}
		// Move to the next line after printing each column availability.
		cout << endl;
	}
}

//***************************************************************************************
// gteFirstClassReservation function													*
// This function is called when the user wants to make a reservation in first class.	*
//***************************************************************************************
void getFirstClassReservation(char firstClassAvailability[][FIRST_CLASS_COLS], int &numberOfAvailableSeats)
{
	// Declare and define variables.
	int quantity = 0,
		rowSelection = 0,
		seatSelection = 0;

	// Print current availability.
	cout << "The current availability of First Class is.\n";
	// Print column numbers.
	cout << setw(9) << "12" << setw(3) << "34" << endl;
	// For each row.
	for (int row = 0; row < 5; row++)
	{
		// Print row number
		cout << "Row " << setw(2) << row + 1;
		// For each column in that row.
		for (int col = 0; col < FIRST_CLASS_COLS; col++)
		{
			// Leave space for the first and third columns.
			if (col == 0 || col == 2)
			{
				cout << setw(2) << firstClassAvailability[row][col];
			}
			// Dont leave space for other columns.
			else
			{
				cout << firstClassAvailability[row][col];
			}
		}
		// Move to next line after last column.
		cout << endl;
	}
	// Do-while loop that will verify user input is within range of available seats.
	do
	{
		// Ask user to input how many seats they want to reserve.
		cout << "How many seats would you like to reserve?\n";
		// Get the user input.
		cin >> quantity;
		// If the input is invalid.
		if (quantity < 0 || quantity > numberOfAvailableSeats)
		{
			// Print an error.
			cout << "**ERROR: You must enter a number from 1 to " << numberOfAvailableSeats << ".**\n";
		}
	} while (quantity < 0 || quantity > numberOfAvailableSeats); // Loop if input was invalid.
	// Loop through for how ever many seats the user wants to reserve.
	for (int count = 0; count < quantity; count++)
	{
		// Prompt the user for input.
		cout << "Please enter where you would like to reserve the seats.\n"
			<< "For seat number " << count + 1 << " please enter the:\n";
		// Do-while loop for input validation.
		do
		{
			// Prompt for row number.
			cout << "Row: ";
			// Get user input.
			cin >> rowSelection;
			// Promt for seat number.
			cout << "Seat: ";
			// Get user input.
			cin >> seatSelection;
			// If the user input was invalid.
			if (rowSelection < 1 || rowSelection > 5 || seatSelection < 1 || seatSelection > 4)
			{
				// Print an error.
				cout << "**ERROR: That entry is not valid.  Please pick a row from 1 to 5 and a seat from 1 to 4.**\n";
			}
		} while (rowSelection < 1 || rowSelection > 5 || seatSelection < 1 || seatSelection > 4); // Loop if the input was invalid.
		// If the user picked a seat that was already taken.
		if (firstClassAvailability[rowSelection - 1][seatSelection - 1] == '*')
		{
			// Display an error to have them try again.
			cout << "**ERROR: That seat is taken. Please try a different seat.**\n";
			// Offset the count increment if there is an error.
			count--;
		}
		// If the user input was valid.
		else
		{
			// Set that seat as taken.
			firstClassAvailability[rowSelection - 1][seatSelection - 1] = '*';
		}
	}
	// Update the number of available seats.
	numberOfAvailableSeats = numberOfAvailableSeats - quantity;
}

//*******************************************************************************
// getCoachReservation function.												*
// This function is called if the user wants to make a reservation in coach.	*
//*******************************************************************************
void getCoachReservation(char coachAvailability[][COACH_COLS], int &numberOfAvailableSeats)
{
	// Declare and define variables.
	int quantity = 0,
		rowSelection = 0,
		seatSelection = 0;
	// Print the availability of coach.
	cout << "The current availability of Coach is.\n";
	// Print the column numbers.
	cout << setw(10) << "123" << setw(4) << "456" << endl;
	// For each row.
	for (int row = 0; row < 10; row++)
	{
		// Print the row number.
		cout << "Row " << setw(2) << row + 6;
		// For each column in coach.
		for (int col = 0; col < COACH_COLS; col++)
		{
			// If it is the first or fourth column leave a gap.
			if (col == 0 || col == 3)
			{
				cout << setw(2) << coachAvailability[row][col];
			}
			// Do not leave a gap for the other columns.
			else
			{
				cout << coachAvailability[row][col];
			}
		}
		// Print a new line after the last column.
		cout << endl;
	}
	// Do-while loop for input validation.
	do
	{
		// Ask how many seats to reserve and get the number.
		cout << "How many seats would you like to reserve?\n";
		cin >> quantity;
		// If the input is not within range.
		if (quantity < 0 || quantity > numberOfAvailableSeats)
		{
			// Print an error.
			cout << "**ERROR: You must enter a number from 1 to " << numberOfAvailableSeats << ".**\n";
		}
	} while (quantity < 0 || quantity > numberOfAvailableSeats); // Repeat while input is not within valid range.
	// For loop that will get the seat info for each seat to be reserved.
	for (int count = 0; count < quantity; count++)
	{
		// Ask where the user wants to reserve a seat.
		cout << "Please enter where you would like to reserve the seats.\n"
			<< "For seat number " << count + 1 << " please enter the:\n";
		// Do-while loop that checks for input validity.
		do
		{
			// Ask for and get user input.
			cout << "Row: ";
			cin >> rowSelection;
			cout << "Seat: ";
			cin >> seatSelection;
			// If the input is not valid then display error.
			if (rowSelection < 6 || rowSelection > 15 || seatSelection < 1 || seatSelection > 6)
			{
				// Print error.
				cout << "**ERROR: That entry is not valid.  Please pick a row from 6 to 15 and a seat from 1 to 4.**\n";
			}
		} while (rowSelection < 6 || rowSelection > 15 || seatSelection < 1 || seatSelection > 6); // Repeat while input is not valid.
		// Check the availability of the selected seat.
		if (coachAvailability[rowSelection - 6][seatSelection - 1] == '*')
		{
			// Print the error if the seat is already taken.
			cout << "**ERROR: That seat is taken. Please try a different seat.**\n";
			count--;
		}
		// If the seat is not already taken.
		else
		{
			// Set that seat to taken.
			coachAvailability[rowSelection - 6][seatSelection - 1] = '*';
		}
	}
	// Update the number of available seats.
	numberOfAvailableSeats = numberOfAvailableSeats - quantity;
}

//*******************************************************
// displayTotalSeatsSold function.						*
// This function will display the how many are sold.	*
//*******************************************************
void displayTotalSeatsSold(char firstClassAvailability[][FIRST_CLASS_COLS], char coachAvailability[][COACH_COLS])
{
	// Set total to 0.
	int total = 0;
	// For loop to count through first class.
	for (int row = 0; row < 5; row++)
	{
		// For loop to count through first class.
		for (int col = 0; col < FIRST_CLASS_COLS; col++)
		{
			// If the seat is taken.
			if (firstClassAvailability[row][col] == '*')
			{
				// Increment the total.
				total += 1;
			}
		}
	}
	// For loop to count through coach.
	for (int row = 0; row < 10; row++)
	{
		// For loop to count through coach.
		for (int col = 0; col < 6; col++)
		{
			// If the seat is taken.
			if (coachAvailability[row][col] == '*')
			{
				// Increment the total.
				total += 1;
			}
		}
	}
	// Display the total sold seats.
	cout << "There are " << total << " seats sold.\n";
}
//***************************************************************
// displayEmptySeatsInRow function.								*
// This function displays how many empty seats are in a row.	*
//***************************************************************
void displayEmptySeatsInRow(char firstClassAvailability[][FIRST_CLASS_COLS], char coachAvailability[][COACH_COLS])
{
	// Declare and define variables.
	int selection = 0,
		total = 0;
	// Do while loop for input validation.
	do
	{
		// Prompt user for input and get it.
		cout << "Which row would you like to know about it's empty seats?\n";
		cin >> selection;
		// If the selection is 1 - 5 we know it is first class.
		if (selection >= 1 && selection <= 5)
		{
			// For loop to count through first class.
			for (int col = 0; col < FIRST_CLASS_COLS; col++)
			{
				// If the seat is empty.
				if (firstClassAvailability[selection - 1][col] == '#')
				{
					// Increase the total by 1.
					total += 1;
				}
			}
		}
		// If the selection is 5 - 15 we know it is coach.
		if (selection >= 6 && selection <= 15)
		{
			// For loop to count through coach.
			for (int col = 0; col < 6; col++)
			{
				// If the seat is empty.
				if (coachAvailability[selection - 6][col] == '#')
				{
					// Increaase the total.
					total += 1;
				}
			}
		}
		// If the selection is not 1 - 15 then input is invalid.
		if (selection < 1 || selection > 15)
		{
			// Display an error.
			cout << "**ERROR: That selection is not valid. Pleas enter a number from 1 to 15.**\n";
		}
	} while (selection < 1 || selection > 15); // Repeat while input is invalid.
	// Print how many seats are empty.
	cout << "The number of empty seats in row " << selection << " is " << total << ".\n";
}
//***************************************************************
// displayTotalEmptySeats function								*
// This function will display the total number of empty seats.	*
//***************************************************************
void displayTotalEmptySeats(char firstClassAvailability[][FIRST_CLASS_COLS], char coachAvailability[][COACH_COLS])
{
	// Set total to 0.
	int total = 0;
	// For loop to count through first class.
	for (int row = 0; row < 5; row++)
	{
		// For loop to count through first class.
		for (int col = 0; col < FIRST_CLASS_COLS; col++)
		{
			// If the seat is empty.
			if (firstClassAvailability[row][col] == '#')
			{
				// Increment the total.
				total += 1;
			}
		}
	}
	// For loop to count through coach.
	for (int row = 0; row < 10; row++)
	{
		// For loop to count through coach.
		for (int col = 0; col < 6; col++)
		{
			// If the seat is empty.
			if (coachAvailability[row][col] == '#')
			{
				// Increment total.
				total += 1;
			}
		}
	}
	// Print the result.
	cout << "The total number of empty seats are " << total << " seats.\n";
}
//*******************************************************************
// displayTotalSales function.										*
// This function will display the total sales from the sold seats.	*
//*******************************************************************
void displayTotalSales(char firstClassAvailability[][FIRST_CLASS_COLS], char coachAvailability[][COACH_COLS], double prices[])
{
	// Declare and defien the variables.
	double firstClassSales = 0,
		frontCoachSales = 0,
		backCoachSales = 0,
		totalSales = 0;
	int firstClassTotal = 0;
	// For loop to count through first class.
	for (int row = 0; row < 5; row++)
	{
		// For loop to count through first class.
		for (int col = 0; col < FIRST_CLASS_COLS; col++)
		{
			// If the seat is sold.
			if (firstClassAvailability[row][col] == '*')
			{
				// Increment how many seats are sold in first class.
				firstClassTotal += 1;
			}
		}
	}
	// Set frontCoachTotal to 0.
	int frontCoachTotal = 0;
	// For loop to count through front coach.
	for (int row = 0; row < 5; row++)
	{
		// For loop to count through front coach.
		for (int col = 0; col < 6; col++)
		{
			// If the seat is sold.
			if (coachAvailability[row][col] == '*')
			{
				// Increment how many are sold in front coach.
				frontCoachTotal += 1;
			}
		}
	}
	// Set backCoachTotal to 0.
	int backCoachTotal = 0;
	// For loop to count through back coach.
	for (int row = 5; row < 10; row++)
	{
		// For loop to count through back coach.
		for (int col = 0; col < 6; col++)
		{
			// If the seat is sold.
			if (coachAvailability[row][col] == '*')
			{
				// Increment how many are sold in back coach.
				backCoachTotal += 1;
			}
		}
	}
	// Calculate and set the totals.
	firstClassSales = firstClassTotal * prices[0];
	frontCoachSales = frontCoachTotal * prices[1];
	backCoachSales = backCoachTotal * prices[2];
	totalSales = firstClassSales + frontCoachSales + backCoachSales;
	// Display the total sold.
	cout << "The total sales so far are $" << totalSales << ".\n";
}