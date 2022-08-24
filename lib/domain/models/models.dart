//----------------------------- onBoarding Models ------------
// Details appear on  the onboarding screen
class SliderObject {
  String title;
  String subTitle;
  String image;
  SliderObject(
    this.title,
    this.subTitle,
    this.image,
  );
}

// data requeested to operate the onboarding screens
class SliderViewObject {
  SliderObject sliderObject;
  // length of the list
  int numOfSlides;
  // the certain screen
  int currentIndex2;
  SliderViewObject(
    this.sliderObject,
    this.numOfSlides,
    this.currentIndex2,
  );
}

//---------------------------------------------------
// Login models

class User {
  String userId;
  String firstName;
  String lastName;
  String email;
  String imageUrl;
  String address;
  String role;

  User(this.userId, this.firstName, this.lastName, this.email, this.imageUrl,
      this.address, this.role);
}
//-----------------------------------------------------------------------------

class Data {
  User? user;
  String accessToken;
  String refreshToken;

  Data(this.user, this.accessToken, this.refreshToken);
}

class Authontication {
  Data? data;
  Authontication(this.data);
}
//-----------------------------------------------------------------------------
