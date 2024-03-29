import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/components/progress_circular.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';


class TransactionsList extends StatelessWidget {

  final TransactionWebClient _webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        // delayed pra testar o progress circular enquanto carrega a page
        future: Future.delayed(Duration(seconds: 2)).then((value) => _webClient.findaAll()),
        builder: (context, snapshot) {

          // o snapshot pode demorar pra trazer as infos
          switch(snapshot.connectionState) {

            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return ProgressCircular();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                // snapshot busca as info
                final List<Transaction> transactions = snapshot.data;
                if (transactions.isNotEmpty) {
                  return ListView.builder(itemBuilder: (context, index) {
                    final Transaction transaction = transactions[index];
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.monetization_on),
                        title: Text(
                          transaction.value.toString(),
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          transaction.contact.accountNumber.toString(),
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    );
                  },
                    itemCount: transactions.length,
                  );
                }
              }

              return CenteredMessage('No transactions found', icon: Icons.warning,);
              break;
          }

          return CenteredMessage('Unknown error');
        },
      ),
    );
  }
}
