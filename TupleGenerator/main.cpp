#include <iostream>
#include <fstream>
#include "List.h"
#include "Var.h"
#include "Number.h"
#include "Tuple.h"
#include "Date.h"
#include "Null.h"
#include <time.h>

using namespace std;
List* genItem();
List* genBrand();
List* genSupplier();
List* genCategory();
List* genShoppingBasket();
List* genCustomer();
List* genItemOrder();
List* genLocation();
List* genShiPper();
string* StringSplit(string strTarget, string strTok);
string randString(int number);


int rNum;
int main()
{
	const int MAXLIST = 9;
	List** lList = new   List*[MAXLIST];
	int i = 0;
	srand(time(0));
	rNum = rand() + 1000000;

	lList[i++] = genItem();
	lList[i++] = genBrand();
	lList[i++] =  genSupplier();
	lList[i++] =  genCategory();
	lList[i++] = genShoppingBasket();
	lList[i++] = genCustomer();
	lList[i++] = genItemOrder();
	lList[i++] =  genLocation();
	lList[i] =  genShiPper();

	ofstream F = ofstream("INSERT.sql");
	for (int i = 0; i < MAXLIST; i++)
	{
		if (lList[i] != NULL)
		{
			F << lList[i]->toString() << endl;
		}
	}
	return 0;
}
List* genItem()
{
	ifstream f = ifstream("item.txt");
	List ItemList;
	string temp;	
	List* itemList = new List();
	
	string *splitTemp;
	string *splitTemp2;
	getline(f, temp);
	while (!f.eof())
	{
		Tuple *item = new Tuple("ITEM");
		getline(f,temp);
		splitTemp = StringSplit(temp, "\t");
		splitTemp2 = StringSplit(splitTemp[9], " ");


		Var* ItemName = new Var(splitTemp[3]);
		item->insert(ItemName);

		Var* Specification = new Var(splitTemp[4]);
		item->insert(Specification);
		

		Number* ItemPrice = new Number(stoi(splitTemp[6]));
		item->insert(ItemPrice);

		Var* ItemCode = new Var(splitTemp[7]);
		item->insert(ItemCode);
	
		
		Number* Stock = new Number(stoi(splitTemp[8]));
		item->insert(Stock);

	
		Number* BundleSize = new Number(stoi(splitTemp2[0]));
		item->insert(BundleSize);

		Var* unit = new Var(splitTemp2[2]);
		item->insert(unit);

		
		Number* SoldCount = new Number(stoi(splitTemp[10]));
		item->insert(SoldCount);

		itemList->insert(item);
		//delete(splitTemp);
		splitTemp = NULL;
	}

	f.close();
	return itemList;
}

string* StringSplit(string strTarget, string strTok)
{
	int     nCutPos;
	int     nIndex = 0;
	string* strResult = new string[20];

	while ((nCutPos = strTarget.find_first_of(strTok)) != strTarget.npos)
	{
		if (nCutPos > 0)
		{
			strResult[nIndex++] = strTarget.substr(0, nCutPos);
		}
		strTarget = strTarget.substr(nCutPos + 1);
	}

	if (strTarget.length() > 0)
	{
		strResult[nIndex++] = strTarget.substr(0, nCutPos);
	}
	return strResult;
}

List* genBrand()
{
	List * brandList = new List();
	ifstream f = ifstream("brand.txt");
	string temp;

	string *splitTemp;
	getline(f, temp);
	while (!f.eof())
	{
		Tuple *brand = new Tuple("BRAND");
		getline(f, temp);
		splitTemp = StringSplit(temp, "\t");
		
		Var* Name = new Var(splitTemp[0]);
		brand->insert(Name);

		Number* soldCount = new Number(stoi(splitTemp[2]));
		brand->insert(soldCount);

		brandList->insert(brand);
		splitTemp = NULL;
	}
	return brandList;
}
List* genSupplier()
{
	List *supplierList = new List();
	ifstream f = ifstream("supplier.txt");

	List ItemList;
	string temp;

	string *splitTemp;
	getline(f, temp);
	while (!f.eof())
	{
		Tuple *brand = new Tuple("SUPPLIER");
		getline(f, temp);
		splitTemp = StringSplit(temp, "\t");

		Var* name = new Var(splitTemp[0]);
		brand->insert(name);
		Var* CEOName = new Var(splitTemp[3]);
		brand->insert(CEOName);
		Var* CompanyPhoneNumber = new Var(splitTemp[4]);
		brand->insert(CompanyPhoneNumber);
		Var* CompanyEMail = new Var(splitTemp[5]);
		brand->insert(CompanyEMail);
		
		supplierList->insert(brand);
		splitTemp = NULL;
	}
	return supplierList;
}
List* genCategory()
{
	List *categoryList =new List();
	ifstream f = ifstream("category.txt");

	List ItemList;
	string temp;

	string *splitTemp;
	getline(f, temp);
	while (!f.eof())
	{
		Tuple *brand = new Tuple("CATEGORY");
		getline(f, temp);
		splitTemp = StringSplit(temp, "\t");

		Var* mainName = new Var(splitTemp[0]);
		brand->insert(mainName);
		Var* middleName = new Var(splitTemp[1]);
		brand->insert(middleName);
		Var* smallName = new Var(splitTemp[2]);
		brand->insert(smallName);

		Number* soldCount = new Number(stoi(splitTemp[4]));
		brand->insert(soldCount);

		categoryList->insert(brand);
		splitTemp = NULL;
	}
	return categoryList;
}
List* genShoppingBasket()
{
	List* ShoppingBasketList = new List();
	 
	for (int i = 0; i < 60; i++)
	{
		Tuple* tuple = new Tuple("SHOPPINGBASKET");
		Var* ShoppingBasketId = new Var(to_string(rNum +i));
		tuple->insert(ShoppingBasketId);
		
		Number *SumPrice = new Number(0);
		tuple->insert(SumPrice);

		ShoppingBasketList->insert(tuple);
	}
	return ShoppingBasketList;

}
List* genCustomer()
{
	List* customerList = new List();
	for (int i = 0; i < 60; i++)
	{
		Tuple* tuple = new Tuple("CUSTOMER");
		
		Var *Id = new Var(randString(rand()%15+ 3)+to_string(rand() % 15 + 3)); //: Text Ÿ��.���� �α����� �� ����ϴ� ���̵�.Key attribute
		tuple->insert(Id);

		Var	* Password = new Var(randString(rand() % 15 + 3) + to_string(rand() % 10000 + 100));// : Text Ÿ��.���� �α��� �� �� ����ϴ� ��й�ȣ.
		tuple->insert(Password);
		
		Var*HomeAddress = new Var(randString(rand() % 15 + 3)+ "\, "+randString(rand() % 15 + 3) + to_string(rand() % 1000 +100)); //: Text Ÿ��.���� �� �ּ�.
		tuple->insert(HomeAddress);
		Var	* PhoneNumber = new Var("010-"+ to_string(rand() % 1000 + 100)+"-" + to_string(rand() % 1000 + 100)); //: Text Ÿ��.���� ��ȭ��ȣ.
		tuple->insert(PhoneNumber);
		Var	* Sex =NULL;;// : CHAR Ÿ��.���� ����.(M, W).
		if (rand() % 2 == 0)
			Sex = new Var("M");
		else
			Sex = new Var("W");
		tuple->insert(Sex);

		Var	* Name = new Var(randString(rand() % 15 + 3)+" "+randString(1)+" "+ randString(rand() % 15 + 3));// : Text Ÿ��.���� �̸�.
		tuple->insert(Name);
		Number	* Age = new Number(rand()%100);// : Integer Ÿ��.���� ����.
		tuple->insert(Age);
		Var	* Job = new Var(randString(rand() % 15 + 3));// : Text Ÿ��.���� ����
		tuple->insert(Job);
		Var	* Type = NULL;// : ���� �з�(���ž���, �Ҹž���, ��Ÿ)
		switch (rand() % 3)
		{
		case 0:
			Type = new Var("���ž���");
			break;
		case 1:
			Type = new Var("�Ҹž���");
			break;
		default:
			Type = new Var("��Ÿ");
			break;
		}
		tuple->insert(Type);

		customerList->insert(tuple);
	}
	return customerList;
}
List* genItemOrder()
{
	List* ItemOrderList = new List();
	for (int i = 0; i < 200; i++)
	{
		Tuple* tuple = new Tuple("ITEMORDER");

		Number *OrderId = new Number(rNum +10000 -300 +i*6);// : Integer Ÿ��.�ֹ���ȣ.Key attribute.
		tuple->insert(OrderId);
		Null * SumPrice =new Null();// : Integer Ÿ��.�ֹ��� ���� �� �����ݾ�.Item ���� Contains Relation�� purchasedPrice��� ��۾�ü�� ��ۺ���� ������ ������.
		tuple->insert(SumPrice);
		Date * OrderDate  = new Date(2000+ rand()%18,rand() % 12+1, rand() % 31+1);// : DateTime Ÿ��.�ֹ� ����
		tuple->insert(OrderDate);
		
		Var	* OrderStatus;// : Text Ÿ��.�ֹ� ����(�������, ���� Ȯ��, �����, ���� �Ϸ�)
		switch (rand() % 4)
		{
		case 0:
			OrderStatus = new Var("�������");
			break;
		case 1:
			OrderStatus = new Var("���� Ȯ��");
			break;
		case 2:
			OrderStatus = new Var("�����");
			break;
		default:
			OrderStatus = new Var("���� �Ϸ�");
			break;
		}
		tuple->insert(OrderStatus);

		ItemOrderList->insert(tuple);
	}
	return ItemOrderList;
}
List* genLocation()
{
	List* locationList = new List();
	for (int i = 0; i < 60; i++)
	{
		Tuple* tuple = new Tuple("LOCATION");
		
		Var *Address = new Var(randString(rand() % 15 + 3) + "\, " + randString(rand() % 15 + 3) + to_string(rand() % 1000 + 100));// : Text Ÿ��.������� �ּ�.�� / �� �� + ���ּҷ� ������.Key attribute.
		tuple->insert(Address);

		Var	* MainCategory = NULL;// : Text Ÿ��.��۾�ü���� ����� �Ҵ��ϱ� ���� �з�����. (������ �� ��⵵, ����, �����갣�������� ����)
		switch (rand() % 3)
		{
		case 0:
			MainCategory = new Var("������ �� ��⵵");
			break;
		case 1:
			MainCategory = new Var("����");
			break;
		default:
			MainCategory = new Var("�����갣��������");
			break;
		}
		
		tuple->insert(MainCategory);

		Var	* CityOrStateName = new Var(randString(rand() % 15 + 3));// : Text Ÿ��.�� / ����.
		tuple->insert(CityOrStateName);
		
		Var	* SpecificAddress = new Var(randString(rand() % 15 + 3));// : Text Ÿ��.���ּ�
		tuple->insert(SpecificAddress);

		locationList->insert(tuple);
	}
	return locationList;
}
List* genShiPper()
{
	List* shipperList = new List();
	ifstream f = ifstream("shipper.txt");

	string temp;
	string *splitTemp;

	getline(f, temp);

	while (!f.eof())
	{
		Tuple *shipper = new Tuple("SHIPPER");
		getline(f, temp);
		splitTemp = StringSplit(temp, "\t");

		Var* name = new Var(splitTemp[0]);
		shipper->insert(name);
		
		Number* ExpectedDeliveryTime = new Number(stoi(splitTemp[2]));
		shipper->insert(ExpectedDeliveryTime);

		Number* ShippingFee = new Number(stoi(splitTemp[3]));
		shipper->insert(ShippingFee);

		shipperList->insert(shipper);
		splitTemp = NULL;
	}
	return shipperList;
}

string randString(int number)
{
	std::ostringstream ostr;
	
	ostr << (char)(rand() % 26 + 'A');

	for (int i = 1; i < number; i++)
	{
		ostr << (char)(rand() % 26 + 'a');
	}
	return ostr.str(); 
}