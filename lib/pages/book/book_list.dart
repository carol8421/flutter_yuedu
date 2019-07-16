import 'package:flutter/material.dart';
import 'package:flutter_yuedu/pages/home/home_widget.dart';
import 'package:flutter_yuedu/widget/loading_animation.dart';
import 'package:flutter_yuedu/widget/my_app_bar.dart';
import 'package:provider/provider.dart';

import 'book_list_provider.dart';

class BookList extends StatefulWidget {
  final String id;

  BookList(this.id);

  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<BookListProvider>(context, listen: false);
    provider.fetchData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 12),
        child: _getList(context),
      ),
    );
  }

  _getList(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Consumer<BookListProvider>(builder: (context, state, widget) {
      return LoadingAnimation(
        loading: state.isLoading,
        child: GridView.builder(
            itemCount: state.data?.length ?? 0,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (screenSize.width > screenSize.height) ? 6 : 3,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.64),
            itemBuilder: (_, index) => HomeNormalBookItem(state.data[index])),
      );
    });
  }
}