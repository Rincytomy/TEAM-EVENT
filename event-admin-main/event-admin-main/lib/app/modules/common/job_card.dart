import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_url.dart';
import '../../data/model/vacancy.dart';
import '../home/controllers/vaccency_controller.dart';

class JobCard extends StatelessWidget {
  const JobCard({super.key, required this.vacancy, this.isCompany = false});

  final Job vacancy;
  final bool isCompany;

  @override
  Widget build(BuildContext context) {
    final VacancyController vacancyController = Get.put(VacancyController());
    return Theme(
      data: ThemeData(
        dividerColor: Colors.transparent,
        useMaterial3: true,
      ),
      child: ExpansionTile(
        childrenPadding: const EdgeInsets.only(left: 20),
        title: Text(vacancy.title ?? ''),
        subtitle: Text(vacancy.location ?? ''),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            AppUrl.imageUrl + vacancy.companies!.logo.toString(),
          ),
        ),
        trailing: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Text('₹ ${vacancy.salary.toString()}'),
        ),
        children: [
          Row(
            children: [
              const SizedBox(
                width: 145,
                child: Text('Name Of Company'),
              ),
              const SizedBox(
                width: 15,
                child: Text(':'),
              ),
              Expanded(
                child: Text(
                  vacancy.companies?.name ?? '',
                  style: TextStyle(color: Colors.pinkAccent.shade700, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const SizedBox(
                width: 145,
                child: Text('Job Vacancies'),
              ),
              const SizedBox(
                width: 15,
                child: Text(':'),
              ),
              Expanded(
                child: Text(
                  vacancy.vacancy.toString(),
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const SizedBox(
                width: 145,
                child: Text('Phone Number'),
              ),
              const SizedBox(
                width: 15,
                child: Text(':'),
              ),
              Expanded(
                child: Text(
                  vacancy.companies?.phone ?? ''.toString(),
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const SizedBox(
                width: 145,
                child: Text('Website Link'),
              ),
              const SizedBox(
                width: 15,
                child: Text(':'),
              ),
              Expanded(
                child: Text(
                  vacancy.companies?.website ?? ''.toString(),
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const SizedBox(
                width: 145,
                child: Text('Address'),
              ),
              const SizedBox(
                width: 15,
                child: Text(':'),
              ),
              Expanded(
                child: Text(
                  vacancy.companies?.address ?? ''.toString(),
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const SizedBox(
                width: 145,
                child: Text('Location'),
              ),
              const SizedBox(
                width: 15,
                child: Text(':'),
              ),
              Text(
                vacancy.companies?.location ?? '',
                style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(40),
            ),
            onPressed: () async {
              if (isCompany) {
                vacancyController.deleteJob(vacancy.id!);
              } else {
                //call
              }
            },
            // onPressed: () async {
            //   final ProfileController profileController =
            //       Get.put(ProfileController());
            //   final data = <String, dynamic>{
            //     "company_id": profileController.state?.company?.id,
            //     'user_id': profileController.state?.id,
            //     "title": vacancy.title,
            //     "phone": vacancy.companies?.phone,
            //     "website": vacancy.companies?.website,
            //     "address": vacancy.companies?.address,
            //     "location": vacancy.companies?.location,
            //   };
            //   await vacancyController.remove(data);
            // },
            child: Text(isCompany ? 'Delete' : 'Call Now'),
          ),
        ],
      ),
    );
  }
}
