#include <bits/stdc++.h>

using namespace std;

int get(char c)
{
	if (c >= '0' && c <= '9')
		return c - '0';
	return c - 'A' + 10;
}

int main()
{
	ifstream fin("b1_sm.dat");

	string line;
	int cnt = 0;
	vector <string> w;
	while (getline(fin, line))
	{
		//cout << "Line is: " << line << endl;
		int num = get(line[1]) + 16 * get(line[0]);
		//cout << num << endl;
		
		string s = "";
		for (int i = 7 ; i >= 0 ; i--)
			if ((1 << i) & num)
				s += "1";
			else
				s += "0";
		//cout << s << endl;
		//w.push_back(s);

        
		//if ((cnt + 1) % 30 == 0)
		//{
			cout << "assign bh" + to_string(cnt) << " = 8'b";
			cout << s << endl;
			//w.clear();
		//}

		cnt++;
	}
}