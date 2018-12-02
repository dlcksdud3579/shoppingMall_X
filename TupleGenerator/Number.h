#pragma once
#include "Data.h"
class Number :
	public Data
{
private:
	int val;
public:
	virtual string toString();
	Number(int _var);
	int getVal() { return val; }
	void setVal(int data) { this->val = data; }
	void addVal(int data) { this->val += data; }
	~Number();
};

