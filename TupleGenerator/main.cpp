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
List* genShipper();

List* genBasketContains();
List* genOrderContains();
List* genOrderShipTo();



string* StringSplit(string strTarget, string strTok);
string randString(int number);
List** lList;
enum ListName {  Suppler, Brand,  Category, Customer, Shipper,Item, ShoppingBasket, Location, ItemOrder, BasketContains, OrderContains, OrderShipTo};

int rNum;
int main()
{
	const int MAXLIST =11;
	lList = new   List*[MAXLIST];
	int i = 0;
	srand(time(0));

	rNum = rand() + 1000000;
	lList[Suppler] = genSupplier();//2
	lList[Customer] = genCustomer();//5
	lList[Brand] = genBrand();//1
	lList[Category] =  genCategory();//3
	lList[Item] = genItem(); // 0
	lList[ShoppingBasket] = genShoppingBasket();//4
	lList[Shipper] = genShipper(); //6
	lList[Location] =  genLocation();//7
	lList[BasketContains] =  genBasketContains();
	
	lList[ItemOrder] = genItemOrder();//8
	lList[OrderContains] = genOrderContains();
	//lList[OrderShipTo] = genOrderShipTo();
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
		Tuple *item = new Tuple("Item");
		getline(f,temp);
		splitTemp = StringSplit(temp, "\t");
		splitTemp2 = StringSplit(splitTemp[9], " ");


		Var* ItemCode = new Var(splitTemp[7]);
		item->insert(ItemCode);

		Var* ItemName = new Var(splitTemp[3]);
		item->insert(ItemName);

		Var* Specification = new Var(splitTemp[4]);
		item->insert(Specification);
		
		Number* SoldCount = new Number(stoi(splitTemp[10]));
		item->insert(SoldCount);

		Var* unit = new Var(splitTemp2[2]);
		item->insert(unit);

		Number* BundleSize = new Number(stoi(splitTemp2[0]));
		item->insert(BundleSize);

		Number* Stock = new Number(stoi(splitTemp[8]));
		item->insert(Stock);

		Number* ItemPrice = new Number(stoi(splitTemp[6]));
		item->insert(ItemPrice);

		
	
		for (int i = 0; i < lList[Brand]->size(); i++)
		{
			string temp = dynamic_cast<Var*>(lList[Brand]->getTuple(i)->getDate(1))->getVal();
			if (splitTemp[5] == temp)
			{
				Var * BrandId = new Var(dynamic_cast<Var*>(lList[Brand]->getTuple(i)->getDate(0))->getVal()); //VARCHAR(5),
				item->insert(BrandId);
			}
		}

		for (int i = 0; i < lList[Category]->size(); i++)
		{
			if (splitTemp[0] == dynamic_cast<Var*>(lList[Category]->getTuple(i)->getDate(1))->getVal() && 
				splitTemp[1] == dynamic_cast<Var*>(lList[Category]->getTuple(i)->getDate(2))->getVal() && 
				splitTemp[2] == dynamic_cast<Var*>(lList[Category]->getTuple(i)->getDate(3))->getVal())
			{
				Var * CategoryId = new Var(dynamic_cast<Var*>(lList[Category]->getTuple(i)->getDate(0))->getVal()); //VARCHAR(5),
				item->insert(CategoryId);
			}
		}
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
	int rnadnNum = rand() % 8000 + 1000;
	string *splitTemp;
	int cnt = 0;
	getline(f, temp);
	while (!f.eof())
	{
		Tuple *brand = new Tuple("Brand");
		getline(f, temp);
		splitTemp = StringSplit(temp, "\t");
		
		Var* id = new Var("B"+ to_string(rnadnNum + cnt++));
		brand->insert(id);

		Var* Name = new Var(splitTemp[0]);
		brand->insert(Name);

		Number* soldCount = new Number(stoi(splitTemp[2]));
		brand->insert(soldCount);

		for (int i = 0; i < lList[Suppler]->size(); i++)
		{
			if (splitTemp[3] == dynamic_cast<Var*> (lList[Suppler]->getTuple(i)->getDate(1))->getVal())
			{
				Var* Supplierid = new Var(dynamic_cast<Var*> (lList[Suppler]->getTuple(i)->getDate(0))->getVal());
				brand->insert(Supplierid);
				break;
			}
		}

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
	int rnadnNum = rand() % 8000 + 1000;
	int cnt = 0;
	string *splitTemp;
	getline(f, temp);
	while (!f.eof())
	{
		//Tuple *brand = new Tuple("SUPPLIER");
		Tuple *brand = new Tuple("Supplier");
		getline(f, temp);
		splitTemp = StringSplit(temp, "\t");

		Var* id = new Var("S" + to_string(rnadnNum + cnt++));
		brand->insert(id);
		
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
	int rnadnNum = rand() % 9000000 + 1000000;
	int cnt = 0;
	string *splitTemp;
	getline(f, temp);
	while (!f.eof())
	{
		Tuple *brand = new Tuple("Category");
		getline(f, temp);
		splitTemp = StringSplit(temp, "\t");
		

		Var* id = new Var("C" + to_string(rnadnNum + cnt++));
		brand->insert(id);

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
		Tuple* tuple = new Tuple("ShoppingBasket");
		Var* ShoppingBasketId = new Var(randString(rand()%5+2)+to_string(rNum +i*7));
		tuple->insert(ShoppingBasketId);
		
		Number *SumPrice = new Number(0);
		tuple->insert(SumPrice);

		Var * CustomerId = new Var(dynamic_cast<Var*>(lList[Customer]->getTuple(i)->getDate(0))->getVal()); //VARCHAR(30),
		tuple->insert(CustomerId);

		ShoppingBasketList->insert(tuple);
	}
	return ShoppingBasketList;

}

List* genCustomer()
{
	List* customerList = new List();
	for (int i = 0; i < 60; i++)
	{
		Tuple* tuple = new Tuple("Customer");
		
		Var *Id = new Var(randString(rand()%15+ 3)+to_string(rand() % 15 + 3)); //: Text 타입.고객이 로그인할 때 사용하는 아이디.Key attribute
		tuple->insert(Id);

		Var	* Password = new Var(randString(rand() % 15 + 3) + to_string(rand() % 10000 + 100));// : Text 타입.고객이 로그인 할 때 사용하는 비밀번호.
		tuple->insert(Password);
		
		Var*HomeAddress = new Var(randString(rand() % 15 + 3)+ "\, "+randString(rand() % 15 + 3) + to_string(rand() % 1000 +100)); //: Text 타입.고객의 집 주소.
		tuple->insert(HomeAddress);

		Var	* PhoneNumber = new Var("010-"+ to_string(rand() % 1000 + 100)+"-" + to_string(rand() % 1000 + 100)); //: Text 타입.고객의 전화번호.
		tuple->insert(PhoneNumber);

		Var	* Sex =NULL;;// : CHAR 타입.고객의 성별.(M, W).
		if (rand() % 2 == 0)
			Sex = new Var("M");
		else
			Sex = new Var("W");
		tuple->insert(Sex);

		Var	* Name = new Var(randString(rand() % 15 + 3)+" "+randString(1)+" "+ randString(rand() % 15 + 3));// : Text 타입.고객의 이름.
		tuple->insert(Name);

		Number	* Age = new Number(rand()%100);// : Integer 타입.고객의 나의.
		tuple->insert(Age);

		Var	* Job = new Var(randString(rand() % 15 + 3));// : Text 타입.고객의 직업
		tuple->insert(Job);

		Var	* Type = NULL;// : 고객의 분류(도매업자, 소매업자, 기타)
		switch (rand() % 3)
		{
		case 0:
			Type = new Var("Wholesaler");
			break;
		case 1:
			Type = new Var("Retailer");
			break;
		default:
			Type = new Var("Nomal");
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
		Tuple* tuple = new Tuple("ItemOrder");



		Var *OrderId = new Var("IO-"+randString(rand()%5)+to_string(1000+ rNum +i*17));// : Integer 타입.주문번호.Key attribute.
		tuple->insert(OrderId);

		Number * SumPrice =new Number(0);// : Integer 타입.주문에 대한 총 결제금액.Item 과의 Contains Relation의 purchasedPrice들과 배송업체의 배송비용의 합으로 결정됨.
		tuple->insert(SumPrice);

		Date * OrderDate  = new Date(2000+ rand()%18,rand() % 12+1, rand() % 28+1);// : DateTime 타입.주문 일자
		tuple->insert(OrderDate);


		Var	* OrderStatus;// : Text 타입.주문 상태(결제대기, 결제 확인, 배송중, 수령 완료)
		switch (rand() % 4)
		{
		case 0:
			OrderStatus = new Var("Waiting for payment");
			break;
		case 1:
			OrderStatus = new Var("Confirm payment");
			break;
		case 2:
			OrderStatus = new Var("shipping");
			break;
		default:
			OrderStatus = new Var("recived");
			break;
		}
		tuple->insert(OrderStatus);

		Var * PurchasedCustomerId = new Var(dynamic_cast<Var*>(lList[Customer]->getTuple(rand()% (lList[Customer]->size()))->getDate(0))->getVal()); //VARCHAR(30),
		tuple->insert(PurchasedCustomerId);
		
		for (int i = 0; i < lList[Location]->size(); i++)
		{
			if (PurchasedCustomerId->getVal() == dynamic_cast<Var*>(lList[Location]->getTuple(i)->getDate(5))->getVal())
			{

				Var * LocationId = new Var(dynamic_cast<Var*>(lList[Location]->getTuple(i)->getDate(0))->getVal()); //VARCHAR(15)
				tuple->insert(LocationId);
				Var * ShipperName = new Var(dynamic_cast<Var*>(lList[Location]->getTuple(i)->getDate(4))->getVal()); //VARCHAR(15)
				tuple->insert(ShipperName);
			
			}
		}






		ItemOrderList->insert(tuple);
	}
	return ItemOrderList;
}
List* genLocation()
{
	List* locationList = new List();
	int rnadNum = rand() % 800 + 100;
	int cnt = 0;

	for (int i = 0; i < 60; i++)
	{
		Tuple* tuple = new Tuple("ShippingLocation");
		
		
		Var	* id = new Var("SL"+to_string(rnadNum+cnt++));// 
		tuple->insert(id);

		Var	* CityOrStateName = new Var(randString(rand() % 15 + 3));// : Text 타입.시 / 도명.
		tuple->insert(CityOrStateName);

		Var	* SpecificAddress = new Var(randString(rand() % 15 + 3));// : Text 타입.상세주소
		tuple->insert(SpecificAddress);

		Var	* MainCategory = NULL;// : Text 타입.배송업체에게 배송을 할당하기 위한 분류기준. (수도권 및 경기도, 지방, 도서산간지역으로 구분)
		Var * ShipperName = NULL;

		switch (rand() % 3)
		{
		case 0:
			MainCategory = new Var("Seoul and Gyeonggi");
			ShipperName = new Var(dynamic_cast<Var*>(lList[Shipper]->getTuple(0)->getDate(0))->getVal());
			break;
		case 1:
			MainCategory = new Var("Provinces");
			ShipperName = new Var(dynamic_cast<Var*>(lList[Shipper]->getTuple(1)->getDate(0))->getVal());
			break;
		default:
			MainCategory = new Var("Mountains and Islands");
			ShipperName = new Var(dynamic_cast<Var*>(lList[Shipper]->getTuple(2)->getDate(0))->getVal());
			break;
		}
		
		tuple->insert(MainCategory);
		tuple->insert(ShipperName);
		Var * CustomerId = new Var(dynamic_cast<Var*>(lList[Customer]->getTuple(i)->getDate(0))->getVal()); //VARCHAR(30),
		tuple->insert(CustomerId);
		
		

		locationList->insert(tuple);
	}
	return locationList;
}
List* genShipper()
{
	List* shipperList = new List();
	ifstream f = ifstream("shipper.txt");
	int randNum = rand() % 800 + 100;
	int cnt = 0;
	string temp;
	string *splitTemp;

	getline(f, temp);

	while (!f.eof())
	{
		Tuple *shipper = new Tuple("Shipper");
		getline(f, temp);
		splitTemp = StringSplit(temp, "\t");


		Var* id = new Var("SH"+to_string(randNum+ cnt++));
		shipper->insert(id);

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

List* genBasketContains()
{
	List *BasketContainsList = new List();
	for (int i = 0; i < 200; i++)
	{


		Tuple * tuple = new Tuple("BasketContains");

		Tuple * basketMaster = lList[ShoppingBasket]->getTuple(rand()%lList[ShoppingBasket]->size());

		Var * CustomerId = new Var(dynamic_cast<Var*>(basketMaster->getDate(2))->getVal());// VARCHAR(30)
		tuple->insert(CustomerId);
		Var * ShoppingBasketId = new Var(dynamic_cast<Var*>(basketMaster->getDate(0))->getVal());// VARCHAR(15) NOT NULL
		tuple->insert(ShoppingBasketId);
		Var * ItemCode = new Var(dynamic_cast<Var*>(lList[Item]->getTuple(rand() % lList[Item]->size())->getDate(0))->getVal()); // VARCHAR(20) NOT NULL
		tuple->insert(ItemCode);
		Number * ItemCount = new Number(rand()%50); //INT
		tuple->insert(ItemCount);
		BasketContainsList->insert(tuple);
	}


	return BasketContainsList;
}
List* genOrderContains()
{

	List *OrderContainsList = new List();

	for (int i = 0; i < lList[ItemOrder]->size(); i++)
	{
		Tuple * tuple = new Tuple("OrderContains");
		Var *ItemCode = new Var(dynamic_cast<Var*>( lList[Item]->getTuple(rand()% lList[Item]->size())->getDate(0))->getVal()); //VARCHAR(20) NOT NULL,
		tuple->insert(ItemCode);
		Var * OrderId = new Var(dynamic_cast<Var*>(lList[ItemOrder]->getTuple(i)->getDate(0))->getVal()); //VARCHAR(30),
		tuple->insert(OrderId);
		Number* PurchasedPrice = new Number(0); //INT,
		tuple->insert(PurchasedPrice);
		Number* ItemCount = new Number(rand()%50);
		tuple->insert(ItemCount);
		OrderContainsList->insert(tuple);
	}
	for (int i = 0; i < 200; i++)
	{
		Tuple * tuple = new Tuple("OrderContains");
		Var *ItemCode = new Var(dynamic_cast<Var*>(lList[Item]->getTuple(rand() % lList[Item]->size())->getDate(0))->getVal()); //VARCHAR(20) NOT NULL,
		tuple->insert(ItemCode);

		Var * OrderId = new Var(dynamic_cast<Var*>(lList[ItemOrder]->getTuple(rand()% lList[ItemOrder]->size())->getDate(0))->getVal()); //VARCHAR(30),
		tuple->insert(OrderId);

		Number* PurchasedPrice = new Number(0); //INT,
		tuple->insert(PurchasedPrice);

		Number* ItemCount = new Number(rand() % 50);
		tuple->insert(ItemCount);

		OrderContainsList->insert(tuple);
	}
	

	return OrderContainsList;
}
List* genOrderShipTo()
{
	List *OrderShipToList = new List();
	for (int i = 0; i < lList[ItemOrder]->size(); i++)
	{
		Tuple * tuple = new Tuple("OrderShipTo");

		Var* CustomerId = new Var(dynamic_cast<Var*>(lList[Location]->getTuple(rand()%lList[Location]->size())->getDate(4))->getVal());  //VARCHAR(30),
		tuple->insert(CustomerId);
		Var*	OrderId = new Var(dynamic_cast<Var*>(lList[ItemOrder]->getTuple(i)->getDate(0))->getVal());//VARCHAR(30),
		tuple->insert(OrderId);
		Var*	CityOrStateName = new Var(dynamic_cast<Var*>(lList[Location]->getTuple(rand() % lList[Location]->size())->getDate(0))->getVal()); //VARCHAR(10),
		tuple->insert(CityOrStateName);
		Var*	SpecificAddress = new Var(dynamic_cast<Var*>(lList[Location]->getTuple(rand() % lList[Location]->size())->getDate(1))->getVal()); //VARCHAR(50),
		tuple->insert(SpecificAddress);

		OrderShipToList->insert(tuple);
	}
	
	return OrderShipToList;
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