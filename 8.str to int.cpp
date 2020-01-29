#include <iostream>

using namespace std;

int myAtoi(string str) {
	unsigned long i{ 0 };
	//check empty input
	if (str.empty() || str[i] == '\0') { return 0; }

	// skip index pointer past leading spaces
	for (; isspace(str[i]); i++);

	// if first char -, negative, if + ignore
	bool neg{ false };
	if (str[i] == '-' || str[i] == '+') {
		neg = (str[i] == '-');
		++i;
	}

	int ret{ 0 };
	for (; isdigit(str[i]); i++) {
		int digit = (str[i] - '0');
		// bounds check. note: ret is itself negative
		if (neg && (ret < (INT32_MIN + digit) / 10)) { return INT32_MIN; }
		if (!neg && (-ret > (INT32_MAX - digit) / 10)) { return INT32_MAX; }

		ret = 10 * ret - digit;
	}
	// keep return negative, which has one more posible digit. 
	// saves on conversion, still handles edge case of input == INT_MIN
	return neg ? ret : -ret;

}

int main(int argc, char const *argv[])
{
    int d=0;
   char a='0';
   char b='9';
   char c='1';
   string as="42";
   cout<<myAtoi(as);
  
    return a;
}