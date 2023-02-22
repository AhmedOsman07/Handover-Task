import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handover/data/model/parcel_model.dart';
import 'package:handover/shared/app_constants/app_numbers.dart';
import 'package:handover/ui/details/details_map.dart';
import '../../bloc/home_bloc/home_bloc.dart';
import '../../data/repo/home/home_repo_iml.dart';
import '../../service_locater/navigator_service.dart';
import '../../service_locater/service_locater.dart';
import '../../shared/app_constants/app_colors.dart';
import '../../shared/widget/custom_circle_progress.dart';
import '../../shared/widget/dismissableScaffold.dart';
import 'component/create_track.dart';
import 'component/empty_list.dart';
import 'component/home_title.widget.dart';
import 'component/parcel_item.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/HomeScreen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc? _bloc;

  HomeBloc get bloc => _bloc ??= HomeBloc(homeRepoIml: sl<HomeRepoIml>());

  final TextEditingController parcelTextController = TextEditingController();

  List<ParcelModel>? list;

  @override
  void dispose() {
    parcelTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) {
          bloc.add(FetchingList());
          return bloc;
        },
        child: DismissibleScaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: const HomeTitleWidget(),
                centerTitle: false,
                floating: true,
                snap: false,
                pinned: true,
                titleSpacing: 0,
                actions: const [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 8, right: AppNumbers.horizontalPadding),
                    child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.delivery_dining,
                          color: Colors.black,
                        )),
                  ),
                ],
                shadowColor: Colors.transparent,
                expandedHeight: 200,
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                flexibleSpace: FlexibleSpaceBar(
                  background: CreateTrackWidget(
                    parcelTextController: parcelTextController,
                  ),
                ),
              ),
              SliverFillRemaining(
                child: Container(
                  color: AppColors.mainAppColor,
                  padding: const EdgeInsets.only(
                    top: 18,
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: AppNumbers.horizontalPadding,
                        right: AppNumbers.horizontalPadding),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30.0)),
                    ),
                    child: BlocConsumer<HomeBloc, HomeState>(
                        listener: (ct, state) {
                      if (state is HomeListFetched && state.shouldAppend) {
                        sl<NavigationService>().navigateTo(
                            DetailsMapWidget.routeName,
                            params: {"id": state.list[0].id});
                      }
                    }, builder: (BuildContext context, state) {
                      if (state is HomeInitial) {
                        return const CustomProgressIndicatorWidget(
                          color: AppColors.mainAppColor,
                          size: 80,
                        );
                      } else if (state is HomeListFetched) {
                        if (state.shouldAppend) {
                          list ??= [];
                          list!.addAll(state.list);
                        } else {
                          list = state.list;
                        }
                      }
                      return RefreshIndicator(
                          onRefresh: () async {
                            bloc.add(FetchingList());
                            return;
                          },
                          child: list == null || list!.isEmpty
                              ? const EmptyList()
                              : ListView.separated(
                                  shrinkWrap: true,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  itemBuilder: (context, index) {
                                    return ParcelItem(
                                        key: ValueKey(list![index].id!),
                                        item: list![index]);
                                  },
                                  itemCount: list!.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider(color: Colors.grey);
                                  },
                                ));
                    }),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
