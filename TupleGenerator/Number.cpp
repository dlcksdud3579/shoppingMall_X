#include "Number.h"



Number::Number(int _val)
{
	this->val = _val;
}
string Number::toString()
{
	std::ostringstream ostr;
	ostr << val;
	return ostr.str();
}

Number::~Number()
{
}
