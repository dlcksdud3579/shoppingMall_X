#pragma once
#include "Data.h"
class Var :
	public Data
{
private:
	string var;
public:
	virtual string toString();
	string getVal(){return var;}
	Var(string _var);
	~Var();
};

