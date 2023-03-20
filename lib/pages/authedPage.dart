
import 'package:flutter/material.dart';


class TaskListPage extends StatelessWidget {
  bool isCanLoadMore = true;
  bool stop =false;
  int totalValueItems=0;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () {
                      //TaskRepo.allTasks.clear();
                      Navigator.pushReplacementNamed(context, "/SignIn",
                          arguments: false);
                    }),
              ],
              title: Text('ToDoList'),
            ),

            body: ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context,int index) {
                return Expanded(
                    child: 
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        height: 30,
                        color: Colors.amber,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                        onPressed:(){
                           //BlocProvider.of<TaskListBloc>(context).add(TaskDeleteEvent(id: state.taskList[index].id));
                        }, 
                        icon: Icon(Icons.delete_forever_outlined))
                          
                          ],
                        )
                        ),

                       
                    
                  
                );
              } ,

            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () { 
                try{
                //state.taskList.clear();
                }catch (e){

                }
                Navigator.pushNamed(context, "/CreateTask");
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.add_box_outlined),
            ),
          );
  }
}
