#pragma once
#include "Data.h";
#include <vector>

using namespace std;

class Tuple
{
private:
	vector<Data*> val;
	string tableName;

public:
	void insert(Data *_data) { val.push_back(_data);}
	Data* getDate(int _index);
	virtual string toString();
	Tuple(string tableName);
	~Tuple();
};

