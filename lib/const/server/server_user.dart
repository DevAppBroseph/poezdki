import 'server_data.dart';

const usersUrl = '$serverURL/users';
const authVK = '$serverURL/users/login/vk-oauth2/';
const authUrl = '$usersUrl/auth';
const regUrl = '$usersUrl/registration';
const deleteUserUrl = '$usersUrl/delete_user';
const currentUser = '$usersUrl/get_user';
const getQuestionUrl = '$usersUrl/get_questions';
const getBlogsUrl = '$usersUrl/get_blog';
const changePhoto = '$usersUrl/change_photo';
const updateUser = '$usersUrl/update_user';
const addPhone = '$usersUrl/put_phone';
const rating = '$serverURL/trips/rank';
const info = '$usersUrl/info';
const offer = '$usersUrl/offer';
const politic = '$usersUrl/politic';

const serverUserLogin = "user@mail.ru";
const serverUserPassword = "password";
