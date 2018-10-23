#pragma once
#include "Tuple.h"

class List
{
private:
	vector<Tuple*> val;

public:
	void insert(Tuple *_data) { val.push_back(_data);}
	int size() { if (val.empty())return 0;  return val.size(); }
	Tuple* getTuple(int _index);
	virtual string toString();
	List();
	~List();
};

