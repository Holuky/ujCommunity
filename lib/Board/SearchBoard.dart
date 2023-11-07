import 'package:flutter/material.dart';


import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchMetadata {
  final int nbHits;

  const SearchMetadata(this.nbHits);

  factory SearchMetadata.fromResponse(SearchResponse response) =>
      SearchMetadata(response.nbHits);
}

class Post {
  final String title;
  final String content;

  Post(this.title, this.content);

  static Post fromJson(Map<String, dynamic> json) {
    return Post(json['title'], json['content'][0]);
  }
}

class HitsPage {
  const HitsPage(this.posts, this.pageKey, this.nextPageKey);

  final List<Post> posts;
  final int pageKey;
  final int? nextPageKey;

  factory HitsPage.fromResponse(SearchResponse response) {
    final posts = response.hits.map(Post.fromJson).toList();
    final isLastPage = response.page >= response.nbPages;
    final nextPageKey = isLastPage ? null : response.page + 1;
    return HitsPage(posts, response.page, nextPageKey);
  }
}

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final _productsSearcher = HitsSearcher(applicationID: 'ERTX3VBRPT',
      apiKey: '8aa04fd9daf2781be0ad1be63d86d242',
      indexName: 'Board_Free');
  final _searchTextController = TextEditingController();
  final PagingController<int, Post> _pagingController = PagingController(firstPageKey: 0);


  Stream<SearchMetadata> get _searchMetadata => _productsSearcher.responses.map(SearchMetadata.fromResponse);
  Stream<HitsPage> get _searchPage => _productsSearcher.responses.map(HitsPage.fromResponse);
  


  @override
  void initState() {
    super.initState();
    _searchTextController.addListener(
          () => _productsSearcher.applyState(
            (state) => state.copyWith(
          query: _searchTextController.text,
          page: 0,
        ),
      ),
    );
    _searchPage.listen((page) {
      if (page.pageKey == 0) {
        _pagingController.refresh();
      }
      _pagingController.appendPage(page.posts, page.nextPageKey);
    }).onError((error) => _pagingController.error = error);
    _pagingController.addPageRequestListener(
            (pageKey) => _productsSearcher.applyState(
                (state) => state.copyWith(
              page: pageKey,
            )
        )
    );
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _productsSearcher.dispose();
    super.dispose();
  }

  Widget _hits(BuildContext context) => PagedListView<int, Post>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Post>(
          noItemsFoundIndicatorBuilder: (_) => const Center(
            child: Text('No results found'),
          ),
          itemBuilder: (_, post, __) => Container(
            color: Colors.white,
            height: 80,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                SizedBox(width: 50, child: Text(post.content)),
                const SizedBox(width: 20),
                Expanded(child: Text(post.title))
              ],
            ),
          )));


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Algolia & Flutter'),
      ),
      body: Center(
        child: Column(children: <Widget>[
          SizedBox(
              height: 44,
              child: TextField(
                controller: _searchTextController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter a search term',
                  prefixIcon: Icon(Icons.search),
                ),
              )),
          StreamBuilder<SearchMetadata>(
            stream: _searchMetadata,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${snapshot.data!.nbHits} hits'),
              );
            },
          ),
          Expanded(
            child: _hits(context),
          )
        ],)
      ),
    );
  }
}