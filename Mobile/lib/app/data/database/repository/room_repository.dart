import '../DAO/room_dao.dart';

abstract class RoomRepository {}

class RoomRepositoryImpl extends RoomRepository {
  final RoomDAO dbDao;

  RoomRepositoryImpl(this.dbDao);
}
