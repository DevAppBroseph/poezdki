import 'server_data.dart';

// all trips
const tripsUrl = '$serverURL/trips';
const addTripUrl = '$tripsUrl/add_trip';
const deleteTripUrl = '$tripsUrl/delete';
const getAllTripsUrl = '$tripsUrl/get_all_trips'; // все поездки
const getAllDriverTripsUrl = '$tripsUrl/get_all_drivers_trips'; // все поездки созданные пассажирами
const getDriverTripsUrl =
    '$tripsUrl/get_trips'; // запланированные поездки от лица водителя
const getPassengerTripsUrl =
    '$tripsUrl/get_booked_trips'; //запланированные поездки от лица пассажира
const getDriverPastTripsUrl =
    '$tripsUrl/get_past_trips'; //прошедшие поездки от лица водителя
const getPassPastTripsUrl =
    '$tripsUrl/get_past_booked_trips'; //прошедшие поездки от лица пассажира



    //Booking trips

  const bookTripUrl = '$serverURL/booking'; // бронирование 
const bookingTripUrl = '$bookTripUrl/book'; // бронирование ( /add:ID)
const cancelBookingTripUrl = '$bookTripUrl/cancel'; // бронирование ( /cancel:ID)


