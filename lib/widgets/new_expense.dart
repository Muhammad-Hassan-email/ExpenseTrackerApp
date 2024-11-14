import 'dart:io';

import 'package:expense_tracker/models/expense_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
DateTime? _selectedDate;
Category _selectedCategory = Category.leisure;
final _titleController = TextEditingController(); //It's a buildin class to controlling the input
final _amountController = TextEditingController();

//Showing Calender and set the date
void _datePicker() async{
  final now = DateTime.now();
  final firstDate = DateTime(now.year -1, now.month, now.day);
  final datePick = await showDatePicker(
    context: context, 
    initialDate: now, 
    firstDate: firstDate, 
    lastDate: now
    );
    setState(() {
      _selectedDate = datePick;
    });
}

void _showDialog(){
  if(Platform.isIOS){
    showCupertinoDialog(context: context, builder: (ctx) => 
      CupertinoAlertDialog(
        title: const Text('Invalid input'),
      content: const Text('Please make sure a valid title, amount, date and category was entered'),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(ctx);
        },
        child: const Text('Okay'))
      ],
    ));
  }
  else
  {
    //show error message
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: const Text('Invalid input'),
      content: const Text('Please make sure a valid title, amount, date and category was entered'),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(ctx);
        },
        child: const Text('Okay'))
      ],
    )
    );
  }    
}

void _submitExpenseData(){
  final enteredAmount = double.tryParse(_amountController.text); //tryParse is a buid in class which convert the value string to the number.
  final amountIsInvalid = enteredAmount == null || enteredAmount <=0; //Checking the value
  if(_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null){
    _showDialog();
    return;
  }
  widget.onAddExpense(Expense(
    title: _titleController.text, 
    amount: enteredAmount, 
    date: _selectedDate!, 
    category: _selectedCategory,
    )
  );
  Navigator.pop(context); //Text form close after if condition
}

@override
void dispose(){
  _titleController.dispose();
  _amountController.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom; //Extra information the UI
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
          child: Column(
            children: [
              //Landscape Textfield and amount field settings
              if(width>=600)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          label: Text('Title'),
                        ),
                      ),
                    ),
                  const SizedBox(width: 20,),
                  Expanded( 
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _amountController,
                      decoration: const InputDecoration(
                        prefixText: 'Rs. ',
                        label: Text('Amount'),
                      ),
                    ),
                  ),
                ],
                )
              else
                //Input Field
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                ),

              if(width>=600)
                Row(children: [
                  DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase())
                      ),).toList(),
                      onChanged: (value){
                        if(value == null)
                        {
                          return;
                        }
                        setState(() {
                          _selectedCategory = value;
                        });
                      }
                    ),
                    const SizedBox(width: 24,),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_selectedDate == null ? 
                          'Date not selected' : formatter.format(_selectedDate!)),
                          IconButton(
                            onPressed: _datePicker,
                            icon: const Icon(Icons.calendar_month),
                          ),
                        ]
                    ),
                  ),
                ],)

              else
                //Amount Text Field
                Row(
                  children:[ 
                  Expanded(
                    child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _amountController,
                          decoration: const InputDecoration(
                            prefixText: 'Rs. ',
                            label: Text('Amount'),
                          ),
                        ),
                  ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_selectedDate == null ? 
                          'Date not selected' : formatter.format(_selectedDate!)),
                          IconButton(
                            onPressed: _datePicker,
                            icon: const Icon(Icons.calendar_month),
                          ),
                        ]
                    ),
                  ),
                ],
              ),
        
              const SizedBox(height: 16),
              if(width>=600)
                Row(children: [
                  const Spacer(),
                  TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },  
                    child: const Text('Cancel'),
                  ),
              
                  ElevatedButton(
                    onPressed: _submitExpenseData,
                    child: const Text('Save Expense'),
                  ),
                ],
                )
                else
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                        .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase())
                        ),).toList(),
                        onChanged: (value){
                          if(value == null)
                          {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        }
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },  
                        child: const Text('Cancel'),
                      ),
              
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save Expense'),
                      ),
                    ],
            ),
          ]
          ),
        ),
      ),
    );
  }
  );
  }
}