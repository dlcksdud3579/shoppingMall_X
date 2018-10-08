#pragma once
#include "Tuple.h"

class List
{
private:
	vector<Tuple*> val;

public:
	void insert(Tuple *_data) { val.push_back(_data);}
	virtual string toString();
	List();
	~List();
};

