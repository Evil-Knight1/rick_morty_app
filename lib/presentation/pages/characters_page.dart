import '../../business_logic/cubit/character_cubit.dart';
import '../../data/models/character_model.dart';
import '../widgets/character_not_found.dart';
import '../widgets/grid_view_items.dart';
import '../widgets/search_field.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../../constants.dart';
import 'package:flutter/material.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  List<CharacterModel> allCharacters = [];
  List<CharacterModel> searchedCharactersList = [];
  bool _isSearching = false;
  final TextEditingController _controller = TextEditingController();

  final NumberPaginatorController _pageController = NumberPaginatorController();
  int _currentPage = 0;
  int allPagesNumber = 1;
  int pagesNumber = 1;
  @override
  void initState() {
    context.read<CharacterCubit>().getAllCharacters();
    super.initState();
  }

  NumberPaginator buildBottomNav(BuildContext context) {
    return NumberPaginator(
      numberPages: !_isSearching && _controller.text.isEmpty
          ? allPagesNumber
          : pagesNumber,
      initialPage: 0,
      controller: _pageController,
      onPageChange: (int index) {
        setState(() {
          _currentPage = index;
        });
        context.read<CharacterCubit>().getPageCharacters(index + 1);
      },
    );
  }

  BlocBuilder<CharacterCubit, CharacterState> buildBody() {
    return BlocBuilder<CharacterCubit, CharacterState>(
        builder: (context, state) {
      if (state is CharacterLoaded) {
        allCharacters = state.characters['characters'];
        int newAllPagesNumber = state.characters['pages'];
        if (allPagesNumber != newAllPagesNumber) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              allPagesNumber = newAllPagesNumber;
            });
          });
        }
        return _controller.text.isNotEmpty && searchedCharactersList.isEmpty
            ? const Center(
                child: Text(
                  'No Characters Found',
                  style: TextStyle(color: Colors.redAccent, fontSize: 32),
                ),
              )
            : GridViewItems(characterList: allCharacters);
      } else if (state is CharacterFilteredLoaded) {
        if (state.filteredCharacters['characters'].length != 0) {
          searchedCharactersList = state.filteredCharacters['characters'];
          pagesNumber = state.filteredCharacters['pages'];
          return _controller.text.isNotEmpty && searchedCharactersList.isEmpty
              ? const CharacterNotFound()
              : GridViewItems(
                  characterList: _isSearching && _controller.text.isNotEmpty
                      ? searchedCharactersList
                      : allCharacters);
        } else {
          pagesNumber = 1;
          return const CharacterNotFound();
        }
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'Characters',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            if (_controller.text != "") {
              _controller.clear();
            } else {
              _isSearching = false;
              setState(() {});
              Navigator.pop(context);
            }
          },
          icon: const Icon(Icons.clear),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(Icons.search),
        ),
      ];
    }
  }

  void addSearchedForItemsToSearchedList(String searchedCharacters) {
    if (searchedCharacters.isNotEmpty) {
      context.read<CharacterCubit>().getFilteredCharacters(searchedCharacters);
      setState(() {});
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    _controller.clear();
    setState(() {
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          leading: _isSearching
              ? BackButton(
                  onPressed: () {
                    setState(() {
                      _controller.clear();
                      _isSearching = false;
                    });
                    Navigator.pop(context);
                  },
                )
              : null,
          title: _isSearching
              ? SearchField(
                  controller: _controller,
                  hint: 'Find Characters',
                  onChanged: (searchedCharacters) {
                    addSearchedForItemsToSearchedList(searchedCharacters);
                  },
                )
              : _buildAppBarTitle(),
          actions: _buildAppBarActions(),
        ),
        backgroundColor: kSecondaryColor,
        body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            List<ConnectivityResult> connectivity,
            Widget child,
          ) {
            final bool connected =
                !connectivity.contains(ConnectivityResult.none);
            if (connected) {
              return buildBody();
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/no_internet.png'),
                  const SizedBox(height: 16),
                  Text(
                    'No Internet Connection',
                    style: TextStyle(color: Colors.grey[500], fontSize: 16),
                  )
                ],
              );
            }
          },
          child: const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
        bottomNavigationBar: buildBottomNav(context));
  }
}
