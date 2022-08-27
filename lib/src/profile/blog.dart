import 'package:app_poezdka/bloc/profile/profile_bloc.dart';
import 'package:app_poezdka/const/colors.dart';
import 'package:app_poezdka/const/server/server_data.dart';
import 'package:app_poezdka/export/blocs.dart';
import 'package:app_poezdka/src/profile/components/blog_article.dart';
import 'package:app_poezdka/widget/src_template/k_statefull.dart';
import 'package:flutter/material.dart';

class Blog extends StatefulWidget {
  const Blog({Key? key}) : super(key: key);

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  @override
  void initState() {
    BlocProvider.of<ProfileBloc>(context).add(GetBlog());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        print(state);
        var bloc = BlocProvider.of<ProfileBloc>(context);
        return KScaffoldScreen(
          isLeading: true,
          title: "Блог",
          body: state is BlogLoaded
              ? Container(
                  color: kPrimaryWhite,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: state.blogs.length,
                    itemBuilder: (context, int index) => BlogArticle(
                      image: "$serverURL/${state.blogs[index].image}",
                      subtitle: state.blogs[index].text,
                      title: state.blogs[index].header,
                    ),
                  ),
                )
              : Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        );
      },
    );
  }
}
