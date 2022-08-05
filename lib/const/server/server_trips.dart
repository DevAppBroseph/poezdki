import 'server_data.dart';

const tripsUrl = '$serverURL/trips';
const addTripUrl = '$tripsUrl/add_trip';
const deleteTripUrl = '$tripsUrl/delete';
const getAllTripsUrl = '$tripsUrl/get_all_trips'; // все поездки
const getAllDriverTripsUrl = '$tripsUrl/get_all_drivers_trips'; // все поездки созданные пассажирами
const bookTripUrl = '$tripsUrl/booking'; // бронирование (/add:ID; /cancel:ID)
const getDriverTripsUrl =
    '$tripsUrl/get_all_drivers_trips'; // запланированные поездки от лица водителя
const getPassengerTripsUrl =
    '$tripsUrl/get_all_trips'; //запланированные поездки от лица пассажира
const getDriverPastTripsUrl =
    '$tripsUrl/get_past_trips'; //прошедшие поездки от лица водителя
const getPassPastTripsUrl =
    '$tripsUrl/get_past_booked_trips'; //прошедшие поездки от лица пассажира


