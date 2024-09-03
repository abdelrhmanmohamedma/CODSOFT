/*
 ** description
 * this is a number guessing game. program generate random number and user true to guess this number.

 ** rules **
 * program generate random number in specific range.
 * user try to guess this random number.
 * program provide a feedback(hint) for user. (like, "number is to high", etc..)
 * when user guess is true, the program ask user if he/she want to continue?
 * user enter -1 to exit the program.
*/
#include <iostream>
#include <cstdlib>
#include <ctime>

using namespace std;
int main() {
    srand(time(nullptr));

    int range = 100;
    int random = (rand() % range) + 1;              // generate a random number in specific range.
    cout << random << endl;
    int user_input;

    while(true){
        cout << "Enter your guess: \n";
        cin >> user_input;

        if(user_input == -1)                // exit
            break;
        else if(user_input < random)
            cout << ">> your guess is too low. please try again.\n";
        else if(user_input > random)
            cout << ">> your guess is too high. please try again.\n";
        else{
            cout << "\n>> congratulation, your guess is true. <<\n";

            int x;
            cout << "\nDo you want to continue?\n"
                    "#1 yes.\n"
                    "#2no.\n";
            cin >> x;
            if(x == 1) {
                random = (rand() % range) + 1;
                cout << random << endl;
            }
            else
                break;
        }
    }
    return 0;
}
