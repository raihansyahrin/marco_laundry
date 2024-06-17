import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      init: EditProfileController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Ubah Profil'),
            centerTitle: true,
          ),
          body: controller.isLoading
              ? const Center(child: CircularProgressIndicator.adaptive())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => controller.pickImage(),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey.withOpacity(0.4),
                              backgroundImage: controller.image != null
                                  ? FileImage(controller.image!)
                                  : controller.profileImageUrl != null
                                      ? NetworkImage(
                                              controller.profileImageUrl!)
                                          as ImageProvider
                                      : null,
                              child: (controller.image == null &&
                                      controller.profileImageUrl == null)
                                  ? const Icon(
                                      Icons.person,
                                      size: 50,
                                      color: Colors.white,
                                    )
                                  : null, // Hanya tampilkan Icon jika tidak ada gambar
                            ),
                            const Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.blue,
                                child: Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: controller.nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                        ),
                      ),
                      TextField(
                        controller: controller.phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                            Colors.lightBlue,
                          ),
                          foregroundColor: MaterialStatePropertyAll<Color>(
                            Colors.white,
                          ),
                        ),
                        onPressed: controller.isLoadingSaveEdit
                            ? null
                            : () => controller.saveUserData(),
                        child: controller.isLoadingSaveEdit
                            ? const Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 3,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : const Text('Simpan'),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
