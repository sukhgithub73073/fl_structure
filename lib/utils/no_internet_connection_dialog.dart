
import 'package:fl_structure/bussiness_logic/blocs/network_bloc/network_bloc.dart';
import 'package:fl_structure/utils/common.dart';
import 'package:fl_structure/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';


class NoConnectionDialog extends StatelessWidget {
  static const keyPrefix = 'NoConnectionDialog';

  const NoConnectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      key: const Key('$keyPrefix-widget-dialog'),
      elevation: 0,
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.black)),
      child: BlocBuilder<NetworkBloc, NetworkState>(
        builder: (context, state) {
          return Container(
            key: const Key('$keyPrefix-widget-container'),
            constraints: BoxConstraints.loose(const Size(600, double.infinity)),
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(12, 26),
                      blurRadius: 50,
                      spreadRadius: 0,
                      color: Colors.grey.withOpacity(.1)),
                ]),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                key: const Key('$keyPrefix-widget-column'),
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight(context)*0.75,
                    child: Lottie.asset(
                      'assets/network_json/under_maintenance.json',
                      height: screenHeight(context)*0.5,
                      width:  screenWidth(context)*0.8,
                    ),
                  ),
                  yHeight(10),
                  Text(trans(context, 'No Internet Connection'),
                      key: const Key(
                          '$keyPrefix-widget-no-internet-connection'),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  yHeight(10),
                  Text(trans(context, 'Please Check Your Internet Connection'),
                      key: const Key(
                          '$keyPrefix-widget-please-check-internet-connection'),
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  yHeight(10),
                  Row(
                    key: const Key('$keyPrefix-widget-row'),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GeneralBtn(
                        key: const Key('$keyPrefix-widget-btn'),
                        title: trans(context, 'Check Status'),
                        // loading: state is NetworkLoading,
                        onTap: () {
                          // if (state is NetworkLoaded) {
                            context.read<NetworkBloc>().add(ListenConnection());
                          // } else {
                          //   toast(
                          //       msg:
                          //           trans(context, 'Please Check Your Internet Connection'),
                          //       isError: true);
                          // }
                        },
                      ),
                    ],
                  ),
                  yHeight(10)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

