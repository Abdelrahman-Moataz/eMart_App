import 'package:emart/consts/consts.dart';
import 'package:emart/services/firestore_services.dart';
import 'package:emart/widgets_common/loading_indecator.dart';
import 'orders_details.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My order".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),

      body: StreamBuilder(
        stream: FireStoreServices.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: loadingIndicator(),
            );
          }else if(snapshot.data!.docs.isEmpty){
            return "No orders yet!".text.color(darkFontGrey).makeCentered();
          }else{

            var data = snapshot.data!.docs;

            return ListView.builder(
              itemCount: data.length,
                itemBuilder: (BuildContext context, int index){
                return ListTile(
                  leading: "${index+1}".text.fontFamily(bold).color(darkFontGrey).xl.make(),
                  title:  data[index]['order_code'].toString().text.color(redColor).fontFamily(semibold).make(),
                  subtitle: data[index]['total_amount'].toString().numCurrency.text.fontFamily(semibold).make(),
                  trailing: IconButton(onPressed: (){
                    Get.to(()=>    const OrdersDetails());
                  }, icon: const Icon(Icons.arrow_forward_rounded,color: darkFontGrey,)),
                );
                }
            );
          }
        },
      ),


    );
  }
}
