import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart'; //3rd party package used here
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid(); //Uuid is a class object here we use

enum Category {work, travel, food, leisure} //enum is a keyword which allows only defined strings

const cateogryIcons = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.travel:Icons.flight_takeoff,
  Category.work: Icons.work,
};

class Expense{
  //Constructor
  Expense({
    //Passing Named Arguments
    required this.title, 
    required this.amount, 
    required this.date,
    required this.category,
  }) : id = uuid.v4(); //class property "id" v4 is method to generate string unique id

  //Initializing the variables
  final String id;
  final String title;
  final DateTime date;
  final double amount;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category, 
    required this.expenses}
  );

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category) 
  : expenses = allExpenses.where(
    (expense) => expense.category == category)
    .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for(final expense in expenses){
      sum+=expense.amount;
    }
    return sum;
  }
}