
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_management/app/route/route_define.dart';
import 'package:health_management/presentation/chat/bloc/contacts/contacts_cubit.dart';
import 'package:health_management/presentation/chat/ui/main/home/chat_screen/chat_page.dart';
import 'package:health_management/presentation/chat/ui/main/home/general/contacts/contacts_card.dart';
import 'package:health_management/presentation/chat/widgets/custom_loading.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ContactsCubit>(context).getAllContacts();
    return SizedBox(
      height: 150,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Contacts On App',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          BlocBuilder<ContactsCubit, ContactsState>(
            builder: (context, state) {
              if (state is GetAllContactsLoading) {
                return const Center(
                  child: CustomLoading(
                      borderColor: Colors.red,
                      backgroundColor: Colors.red,
                      size: 30,
                      opacity: 0.5),
                );
              } else if (state is GetAllContactsSuccess) {
                return SizedBox(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                      itemCount: state.contacts.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final contact = state.contacts[index];
                        return InkWell(
                          onTap: () {
                            print('contact: $contact');
                                                      context.pushNamed(RouteDefine.chatDetails,
                              extra: ChatPageData(
                                name: contact.userName,
                                receiverId: contact.uid,
                                profilePicture: contact.profileImage,
                                isGroupChat: false,
                              ),
                              pathParameters: {'userId': contact.userName});
                          //update unread message to 0
                          // context.push();
                          },
                          child: ContactsCard(
                            image: contact.profileImage,
                            name: contact.userName,
                          ),
                        );
                      },
                    ),
                  ),
                );
              } else if (state is GetAllContactsError) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return const Center(
                  child: Text('No contacts'),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
