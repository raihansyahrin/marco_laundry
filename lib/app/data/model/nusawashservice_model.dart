class NuswaWashService {
  String title;
  int? time;
  double price;

  NuswaWashService({
    required this.title,
    this.time,
    required this.price,
  });
}

var listCuciLipat = [
  NuswaWashService(
    title: 'Cuci Lipat Regular',
    time: 48,
    price: 6000,
  ),
  NuswaWashService(
    title: 'Cuci Lipat Ngebut',
    time: 24,
    price: 7500,
  ),
  NuswaWashService(
    title: 'Cuci Lipat Kilat',
    time: 6,
    price: 10000,
  ),
];

var listCuciSetrika = [
  NuswaWashService(
    title: 'Cuci Setrika',
    time: 48,
    price: 7000,
  ),
  NuswaWashService(
    title: 'Cuci Setrika Ngebut',
    time: 24,
    price: 8500,
  ),
  NuswaWashService(
    title: 'Cuci Setrika Kilat',
    time: 6,
    price: 12000,
  ),
];

var listLaundrySatuan = [
  NuswaWashService(
    title: 'Selimut',
    price: 15000,
  ),
  NuswaWashService(
    title: 'Bedcover',
    price: 20000,
  ),
  NuswaWashService(
    title: 'Sprei Kasur',
    price: 15000,
  ),
  NuswaWashService(
    title: 'Jas',
    price: 20000,
  ),
  NuswaWashService(
    title: 'Kemeja Formal',
    price: 10000,
  ),
  NuswaWashService(
    title: 'Celana Formal',
    price: 10000,
  ),
  NuswaWashService(
    title: 'Kebaya',
    price: 25000,
  ),
  NuswaWashService(
    title: 'Dress',
    price: 15000,
  ),
  NuswaWashService(
    title: 'Karpet Bulu',
    price: 20000,
  ),
  NuswaWashService(
    title: 'Boneka Kecil',
    price: 30000,
  ),
  NuswaWashService(
    title: 'Boneka Besar',
    price: 40000,
  ),
];
