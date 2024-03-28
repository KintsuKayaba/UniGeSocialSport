#include <iostream>
#include <cmath>
using namespace std;
// Matrice A
int norma_a(int x[][4])
{
    int max = 0, sum;
    for (int i = 0; i < 4; i++)
    {
        sum = 0;
        for (int j = 0; j < 4; j++)
        {
            sum += abs(x[i][j]);
        }
        if (max < sum)
            max = sum;
    }
    return max;
}
// Matrice Pascal
int norma_b(int x[][10])
{
    int max = 0, sum;
    for (int i = 0; i < 10; i++)
    {
        sum = 0;
        for (int j = 0; j < 10; j++)
        {
            sum += abs(x[i][j]);
        }
        if (max < sum)
            max = sum;
    }
    return max;
}
// Matrice Tridiagonale
int norma_c(int x[][89])
{
    int max = 0, sum;
    for (int i = 0; i < 89; i++)
    {
        sum = 0;
        for (int j = 0; j < 89; j++)
        {
            sum += abs(x[i][j]);
        }
        if (max < sum)
            max = sum;
    }
    return max;
}
double fattoriale(int n)
{
    if (n == 0)
        return 1;
    return (n * fattoriale(n - 1));
}
int value(int i, int j)
{
    return (fattoriale(i + j - 2) / (fattoriale(i - 1) * fattoriale(j - 1)));
}
void stampa(int L[][10])
{
    for (int i = 0; i < 10; i++)
    {
        for (int j = 0; j < 10; j++)
        {
            cout << L[i][j] << "\t";
        }
        cout << endl;
    }
}
int main()
{
    int a[4][4] = {3, 1, -1, 0, 0, 7, -3, 0, 0, -3, 9, -2, 0, 0, 4, -10};
    int b[4][4] = {2, 4, -2, 0, 1, 2, 0, 1, 3, -1, 1, 2, 0, -1, 2, 1};
    // PART1
    cout << "-----------START PART a-------------\n\n";
    int na = norma_a(a);
    int nb = norma_a(b);
    cout << "Norma inf matrice a: " << na << "\n";
    cout << "Norma inf matrice b: " << nb << "\n\n";
    cout << "-----------END PART a-------------\n";
    // PART2
    cout << "-----------START PART b-------------\n\n";
    int p[10][10];
    for (int i = 0; i < 10; i++)
    {
        for (int j = 0; j < 10; j++)
        {
            p[i][j] = value(i + 1, j + 1);
        }
    }
    int np = norma_b(p);
    cout << "Norma inf matrice Pascal: " << np << "\n\n";
    cout << "-----------END PART b-------------\n";
    // PART3
    cout << "-----------START PART c-------------\n";
    const int n = 89;
    int t[n][n];
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
            if (i == j)
                t[i][j] = 2;
            else if (abs(i - j) == 1)
                t[i][j] = -1;
            else
                t[i][j] = 0;
        }
    }
    int nt = norma_c(t);
    cout << "\nNorma inf matrice Tridiagonale: " << nt << "\n\n";
    cout << "-----------END PART c-------------\n";
}