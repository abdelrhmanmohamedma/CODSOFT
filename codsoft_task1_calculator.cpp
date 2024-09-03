/*
 * simple calculator that takes two numbers from the user and perform one of the basic operations on these numbers
*/
#include <iostream>

using namespace std;
int main() {
    long long first_number, second_number;
    int c;

    while (true) {
        cout << "Enter the first number:\n";
        cin >> first_number;

        cout << "Enter the second number:\n";
        cin >> second_number;

        cout << "--------------\n"
                "operations\n"
                "--------------\n";
        cout << "#1 addition.\n"
                "#2 subtraction.\n"
                "#3 multiplication.\n"
                "#4 division.\n";
        cout << "Enter the operation to perform:\n";
        cin >> c;

        cout << endl;
        switch(c) {
            case 1:
                cout << "Result: " << first_number + second_number;
                break;
            case 2:
                cout << "Result: " << first_number - second_number;
                break;
            case 3:
                cout << "Result: " << first_number * second_number;
                break;
            case 4:
                cout << "Result: " << first_number / second_number;
                break;
            default:
                break;
        }
        cout << "\n\n";

        cout << "#1 yes.\n"
                "#2 no.\n";
        cout << "Do you want to continue?\n";
        cin >> c;
        if(c == 2)
            break;
    }
    return 0;
}
