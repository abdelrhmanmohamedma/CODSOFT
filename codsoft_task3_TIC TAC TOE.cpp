#include <iostream>
#include <iomanip>

using namespace std;

class Grid{
private:
    char board[3][3];

    void reset(){
        for(int i = 0; i < 3; ++i)
            for(int j = 0; j < 3; ++j)
                board[i][j] = ' ';
    }
    bool horizontal_line(){
        bool is_line = false;
        char symbol;
        for(int i = 0; i < 3; ++i){
            symbol = board[i][0];
            for(int j = 0; j < 3; ++j) {
                //cout << "s: " << symbol << "  " << i << "  " << j << "\n";
                if(board[i][j] != symbol || symbol == ' ') {
                    is_line = false;
                    break;
                }
                is_line = true;
            }
            if(is_line) return true;
        }
        return false;
    }
    bool vertical_line(){
        bool is_line = false;
        char symbol;
        for(int i = 0; i < 3; ++i){
            symbol = board[0][i];
            for(int j = 0; j < 3; ++j) {
                if(board[j][i] != symbol || symbol == ' ') {
                    is_line = false;
                    break;
                }
                is_line = true;
            }
            if(is_line) return true;
        }
        return false;
    }
    bool left_diagonal(){
        return (board[0][0] != ' ' && board[0][0] == board[1][1] && board[1][1] == board[2][2]);
    }
    bool right_diagonal(){
        return (board[0][2] != ' ' && board[0][2] == board[1][1] && board[1][1] == board[2][0]);
    }
public:
    Grid(){
        reset();
    }
    void update(int row, int column, char value) {
        board[row][column] = value;
    }
    bool is_empty(int row, int column){
        return board[row][column] == ' ';
    }
    void display() {
        printf("    0     1     2  \n");
        // first row
        printf("0   %c  |  %c  |  %c  \n", board[0][0], board[0][1], board[0][2]);
        printf("  -----|-----|-----\n");

        // second row
        printf("1   %c  |  %c  |  %c  \n", board[1][0], board[1][1], board[1][2]);
        printf("  -----|-----|-----\n");

        // third row
        printf("2   %c  |  %c  |  %c  \n", board[2][0], board[2][1], board[2][2]);
        cout << '\n';
    }
    bool get_status(){
        if(horizontal_line() || vertical_line() || left_diagonal() || right_diagonal())
            return true;
        return false;
    }
};

class player{
private:
    string name;
    char symbol;
public:
    void set_name(string &player_name){
        this->name = player_name;
    }
    void set_symbol(char player_symbol){
        this->symbol = player_symbol;
    }
    string get_name() const{
        return name;
    }
    char get_symbol() const{
        return symbol;
    }
    void display(){
        cout << "Name: " << left << setw(30) << setfill(' ') << name;
        cout << "Symbol: " << left << setw(20) << setfill(' ') <<  symbol;
        cout << '\n';
    }
};

class Game{
private:
    Grid grid;
    player players[2];

    void move(int &row, int &column, char symbol){
        while(!grid.is_empty(row, column)) {
            cout << "** INVALID MOVE **\n";
            cout << "Enter row:\n";
            cin >> row;
            cout << "Enter column:\n";
            cin >> column;
        }
        grid.update(row, column, symbol);
        grid.display();
    }
public:
    Game(string &name1, string &name2) {
        players[0].set_name(name1);
        players[0].set_symbol('X');

        players[1].set_name(name2);
        players[1].set_symbol('O');

        cout << "----------------\n"
                "Players Details\n"
                "----------------\n";
        players[0].display();
        players[1].display();

        grid.display();
    }
    bool start(){
        int row, column;
        int i = 0;
        string player_name;
        char player_symbol;
        int empty_cells = 9;
        while(empty_cells--) {
            player_name = players[i].get_name();
            player_symbol = players[i].get_symbol();

            cout << "Player(" << player_symbol << "): " << player_name << '\n';
            cout << "Enter row:\n";
            cin >> row;
            cout << "Enter column:\n";
            cin >> column;

            move(row, column, player_symbol);
            if(grid.get_status()){
                cout << player_symbol << " is winner.\n";
                return true;
            }
            if(i > 0) i = 0;
            else ++i;
        }
        cout << "DRAW\n";
        return false;
    }
};

int main(){
    cout << right << setw(100) << setfill(' ') << "** TIC TAC TOE **";
    cout << '\n';
    string n1, n2;
    cout << "name of player X:\n";
    cin >> n1;
    cout << "name of player O:\n";
    cin >> n2;

    Game game(n1, n2);
    game.start();
}
