import 'package:equatable/equatable.dart';

class FindOneEntity extends Equatable {
  final int? id;
  final int? userId;
  final String? arnCode;
  final String? riaCode;
  final String? pan;
  final String? arnStartDate;
  final String? arnEndDate;
  final String? equityName;
  final String? equityShortName;
  final String? website;
  final String? tanCode;
  final bool? sipDemat;
  final String? agreement;
  final String? address1;
  final String? address2;
  final String? address3;
  final String? pincode;
  final String? country;
  final String? state;
  final String? city;
  final String? location;
  final String? area;
  final String? primaryLandline;
  final String? alternateLandline;
  final String? primaryFax;
  final String? alternateFax;
  final String? primaryMobile;
  final String? alternateMobile;
  final String? primaryEmail;
  final String? alternateEmail;
  final String? sameAsPermanentAddress;
  final String? communicationAddress1;
  final String? communicationAddress2;
  final String? communicationAddress3;
  final String? communicationPincode;
  final String? communicationCountry;
  final String? communicationState;
  final String? communicationCity;
  final String? communicationLocation;
  final String? communicationArea;
  final String? communicationPrimaryLandline;
  final String? communicationAlternateLandline;
  final String? communicationPrimaryFax;
  final String? communicationAlternateFax;
  final String? communicationPrimaryMobile;
  final String? communicationAlternateMobile;
  final String? communicationPrimaryEmail;
  final String? communicationAlternateEmail;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const FindOneEntity({
    this.id,
    this.userId,
    this.arnCode,
    this.riaCode,
    this.pan,
    this.arnStartDate,
    this.arnEndDate,
    this.equityName,
    this.equityShortName,
    this.website,
    this.tanCode,
    this.sipDemat,
    this.agreement,
    this.address1,
    this.address2,
    this.address3,
    this.pincode,
    this.country,
    this.state,
    this.city,
    this.location,
    this.area,
    this.primaryLandline,
    this.alternateLandline,
    this.primaryFax,
    this.alternateFax,
    this.primaryMobile,
    this.alternateMobile,
    this.primaryEmail,
    this.alternateEmail,
    this.sameAsPermanentAddress,
    this.communicationAddress1,
    this.communicationAddress2,
    this.communicationAddress3,
    this.communicationPincode,
    this.communicationCountry,
    this.communicationState,
    this.communicationCity,
    this.communicationLocation,
    this.communicationArea,
    this.communicationPrimaryLandline,
    this.communicationAlternateLandline,
    this.communicationPrimaryFax,
    this.communicationAlternateFax,
    this.communicationPrimaryMobile,
    this.communicationAlternateMobile,
    this.communicationPrimaryEmail,
    this.communicationAlternateEmail,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        riaCode,
        id,
        userId,
        arnCode,
        pan,
        arnStartDate,
        arnEndDate,
        equityName,
        equityShortName,
        website,
        tanCode,
        sipDemat,
        agreement,
        address1,
        address2,
        address3,
        pincode,
        country,
        state,
        city,
        location,
        area,
        primaryLandline,
        alternateLandline,
        primaryFax,
        alternateFax,
        primaryMobile,
        alternateMobile,
        primaryEmail,
        alternateEmail,
        sameAsPermanentAddress,
        communicationAddress1,
        communicationAddress2,
        communicationAddress3,
        communicationPincode,
        communicationCountry,
        communicationState,
        communicationCity,
        communicationLocation,
        communicationArea,
        communicationPrimaryLandline,
        communicationAlternateLandline,
        communicationPrimaryFax,
        communicationAlternateFax,
        communicationPrimaryMobile,
        communicationAlternateMobile,
        communicationPrimaryEmail,
        communicationAlternateEmail,
        createdAt,
        updatedAt,
      ];
}
