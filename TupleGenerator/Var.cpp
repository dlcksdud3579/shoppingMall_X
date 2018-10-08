#include "Var.h"



Var::Var(string _var)
{
	this->var = _var;
}
string Var::toString() 
{ 
	return "\'" + var + "\'";
}

Var::~Var()
{
}
