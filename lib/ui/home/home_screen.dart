import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handover/data/model/parcel_model.dart';
import 'package:handover/shared/app_constants/app_numbers.dart';
import '../../bloc/home_bloc/home_bloc.dart';
import '../../data/repo/home/home_repo_iml.dart';
import '../../service_locater/service_locater.dart';
import '../../shared/app_constants/app_colors.dart';
import '../../shared/widget/dismissableScaffold.dart';
import 'empty_list.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/HomeScreen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc? _bloc;

  HomeBloc get bloc => _bloc ??= HomeBloc(homeRepoIml: sl<HomeRepoIml>());

  List<QueryDocumentSnapshot<ParcelModel>>? list;

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
                flexibleSpace: const FlexibleSpaceBar(
                  background: CreateTrackWidget(),
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
                    child: BlocBuilder<HomeBloc, HomeState>(
                        builder: (BuildContext context, state) {
                      return RefreshIndicator(
                          onRefresh: () async {
                            bloc.add(FetchingList());
                            return;
                          },
                          child: list == null || list!.isEmpty
                              ? const EmptyList()
                              : ListView.separated(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8),
                                  itemBuilder: (context, index) {
                                    return ParcelItem(
                                        key:
                                            ValueKey(list![index].data().id!),
                                        item: list![index].data());
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

class HomeTitleWidget extends StatelessWidget {
  const HomeTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppNumbers.horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Ahmed',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(height: 1),
          ),
          Text(
            'Handover helps in organising & tracking parcels.',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ],
      ),
    );
  }
}

class CreateTrackWidget extends StatelessWidget {
  const CreateTrackWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppNumbers.horizontalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 49,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
                      hintText: "Enter parcel number or scan QR code",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Container(
                  padding: const EdgeInsets.all(14),
                  width: 50,
                  height: 49,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.qr_code))
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            height: 48,
            width: double.infinity,
            child: TextButton(
              onPressed: () {},
              style: Theme.of(context).textButtonTheme.style,
              child: Text(
                'Track parcel',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}

class ParcelItem extends StatefulWidget {
  final ParcelModel item;

  const ParcelItem({super.key, required this.item});

  @override
  State<ParcelItem> createState() => _ParcelItemState();
}

class _ParcelItemState extends State<ParcelItem> with TickerProviderStateMixin {
  bool completed = false;
  late AnimationController controller;
  late Animation animation;
  late ParcelModel item;

  @override
  void initState() {
    super.initState();
    item = widget.item;
    if (item.state == "Completed") {
      completed = true;
    }
    controller = AnimationController(
      duration: const Duration(milliseconds: 225),
      vsync: this,
    );
    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.linear);
    animation = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() => setState(() {}));
    controller.forward(from: 0.0);
  }

  _onTap() {
    item = item.copyWith(state: "Completed");
    setState(() => completed = !completed);
    controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.identity()..scale(animation.value, 1.0),
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
              onTap: () {
                if (item.state == "Pending") {
                  // final bloc = BlocProvider.of<HomeBloc>(context);
                  // bloc.add(SetToCompleteEvent(item.id!));
                  _onTap();
                }
              },
              child: Icon(
                item.state == "Pending"
                    ? Icons.check_box_outline_blank
                    : Icons.check_box,
                size: 30,
              )),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "id item name: ${item.id!} ",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                Text(
                  item.fileName!,
                  maxLines: 2,
                  style: TextStyle(
                      decoration: completed
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: completed
                          ? AppColors.textColor.withOpacity(0.6)
                          : AppColors.textColor,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'In transit',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  'Last update: 3 hours ago',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2.5),
                    child: LinearProgressIndicator(
                      value: 0.7,
                      color: Theme.of(context).appBarTheme.backgroundColor,
                      backgroundColor: const Color(0xFFF8F8F8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
