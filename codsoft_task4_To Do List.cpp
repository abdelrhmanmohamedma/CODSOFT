/*
 ** TO-DO-LIST
 * allows users to add new tasks with assigned status. (initially "pending").
 * users can update status of any task.
 * users can remove any task.
 * users can display recorded tasks.
*/

#include <iostream>
#include <iomanip>
#include <vector>
#include <string>
using namespace std;

void display(const vector<string>& task, const vector<string>& status) {
    if(task.empty()) cout << ">> list is empty. <<\n";
    else {
        cout << left << setw(80) << setfill('-') << ""; cout << endl;

        cout << left << setw(10) << setfill(' ') << "#no";
        cout << left << setw(50) << setfill(' ') << "Task";
        cout << left << setw(20) << setfill(' ') << "Status";

        cout << endl;
        cout << left << setw(80) << setfill('-') << ""; cout << endl;

        for(int i = 0; i < task.size(); ++i) {
            cout << left << setw(10) << setfill(' ') << i+1;
            cout << left << setw(50) << setfill(' ') << task[i];
            cout << left << setw(20) << setfill(' ') << status[i];

            cout << endl;
        }
    }
    cout << endl;
}

int main() {
    vector<string> tasks, statuses;
    string task, status;
    int c;

    display(tasks, statuses);
    while(true) {
        cout << ">> Actions.\n"
                "#1 add new task.\n"
                "#2 remove task.\n"
                "#3 update status.\n"
                "#4 start task.\n"
                "#5 display list.\n"
                "#6 exit.\n";
        cout << "Enter Action number:\n";
        cin >> c;

        if(c == 1) {
            cout << "Enter the New task:\n";

            cin.ignore();
            getline(cin, task);

            tasks.emplace_back(task);
            statuses.emplace_back("pending");

            cout << ">> task added successfully. <<\n\n";
        }
        else if(c == 2) {
            if(!tasks.empty()) {
                display(tasks, statuses);

                cout << "Enter task number:\n";
                cin >> c;

                auto it = tasks.begin();
                tasks.erase(it+(c-1));
                it = statuses.begin();
                statuses.erase(it+(c-1));

                cout << ">> task removed successfully. <<\n\n";
            }
            else
                cout << ">> list is already empty. <<\n\n";
        }
        else if(c == 3) {
            if(!tasks.empty()) {
                display(tasks, statuses);

                cout << "Enter task number:\n";
                cin >> c;
                cout << "Enter new Status:\n";
                cin.ignore();
                getline(cin, status);
                statuses[c-1] = status;

                cout << ">> task updated successfully. <<\n\n";
            }
            else
                cout << ">> list is already empty. <<\n\n";

        }
        else if(c == 4) {
            if(!tasks.empty()) {
                display(tasks, statuses);

                cout << "Enter task number:\n";
                cin >> c;
                statuses[c-1] = "in progress..";

                cout << ">> task updated successfully. <<\n\n";
            }
            else
                cout << ">> list is already empty. <<\n\n";
        }
        else if(c == 5)
            display(tasks, statuses);
        else
            break;
    }
}
