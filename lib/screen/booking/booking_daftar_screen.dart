import 'package:barbershop/providers/booking_provider.dart';
import 'package:barbershop/service/home_service.dart';
import 'package:barbershop/service/booking_service.dart';
import 'package:barbershop/utils/constants/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingDaftarScreen extends StatefulWidget {
  final String idDoc;
  const BookingDaftarScreen({super.key, required this.idDoc});

  @override
  State<BookingDaftarScreen> createState() => _BookingDaftarScreenState();
}

class _BookingDaftarScreenState extends State<BookingDaftarScreen> {
  @override
  Widget build(BuildContext context) {
    // HomeProvider homeProvider =
    //     Provider.of<HomeProvider>(context, listen: false);
    BookingProvider bookingProvider =
        Provider.of<BookingProvider>(context, listen: false);
    final formKey = GlobalKey<FormState>();
    HomeService homeService = HomeService();
    BookingService bookingService = BookingService();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Booking',
                  style: blackTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Nama Barbershop',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: regular,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<DocumentSnapshot<Object?>>(
                        future: homeService.getByIDDaftar(widget.idDoc),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            final data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            bookingProvider.namaBarbershop.text = data['nama'];
                            return TextFormField(
                              controller: bookingProvider.namaBarbershop,
                              readOnly: true,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                hintStyle: greyTextStyle.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Nama Pemesan',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: regular,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: bookingProvider.namaPemesan,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          hintText: 'Masukan Nama',
                          hintStyle: greyTextStyle.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Nama tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'No Telp',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: regular,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: bookingProvider.noPemesan,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          hintText: 'Masukan No Telp',
                          hintStyle: greyTextStyle.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'No tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Pilih Tanggal Booking',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: regular,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Consumer<BookingProvider>(
                        builder: (_, booking, child) {
                          return TextFormField(
                            onTap: () {
                              booking.datePicker(context);
                            },
                            controller: booking.tanggalPemesan,
                            readOnly: true,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              hintText: 'Pilih Tanggal Booking',
                              hintStyle: greyTextStyle.copyWith(
                                fontSize: 14,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Tanggal tidak boleh kosong';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Pilih Jam Booking',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: regular,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Consumer<BookingProvider>(
                        builder: (_, booking, child) {
                          return TextFormField(
                            onTap: () {
                              booking.timePicker(context);
                            },
                            controller: booking.jamPemesan,
                            readOnly: true,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              hintText: 'Pilih Jam Booking',
                              hintStyle: greyTextStyle.copyWith(
                                fontSize: 14,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Jam tidak boleh kosong';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Silahkan tuliskan yang ingin di treatment',
                        style: blackTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: regular,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: bookingProvider.pesanPemesan,
                        maxLines: 6,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          hintText: 'Contoh : potong rambut',
                          hintStyle: greyTextStyle.copyWith(
                            fontSize: 14,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pesan tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        height: 70,
                        width: 400,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Konfirmasi'),
                                  content: SingleChildScrollView(
                                    child: Text(
                                      'Apakah anda yakin data yang dimasukan sudah benar ?',
                                      style: blackTextStyle,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        bookingService.tambahData(context);
                                      },
                                      child: const Text('Ya'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Tidak'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Selanjutnya',
                            style: whiteTextStyle.copyWith(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
