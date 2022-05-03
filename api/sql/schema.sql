create table if not exists "User"
(
    id          serial      not null
        constraint user_pk
            primary key,
    "firstName" varchar(20) not null,
    "lastName"  varchar(40) not null,
    email       varchar(80) not null,
    password    varchar(80) not null,
    phone       varchar(16) not null,
    "isAdmin"   boolean     not null
);

comment on table "User" is 'People who use the app';

create table if not exists "State"
(
    abbreviation varchar(2)  not null
        constraint state_pk
            primary key,
    name         varchar(20) not null
);

comment on table "State" is 'state in US user is in';

create table if not exists "Vehicle Type"
(
    id   integer     not null
        constraint "vehicle type_pk"
            primary key,
    type varchar(20) not null
);

comment on table "Vehicle Type" is 'type of vehicle';

create table if not exists "Vehicle"
(
    id              serial           not null
        constraint vehicle_pk
            primary key,
    make            varchar(20)      not null,
    model           varchar(20)      not null,
    color           varchar(20)      not null,
    "vehicleTypeId" integer          not null
        constraint "vehicle_typeId_fk"
            references "Vehicle Type",
    capacity        integer          not null,
    mpg             double precision not null,
    "licenseState"  varchar(20)      not null
        constraint "vehicle_licenseState_fk"
            references "State",
    "licensePlate"  varchar(16)      not null
);

create table if not exists "Driver"
(
    id              serial      not null
        constraint driver_pk
            primary key,
    "userId"        integer     not null
        constraint "driver_userId_fk"
            references "User",
    "licenseNumber" varchar(16) not null,
    "licenseState"  varchar(2)  not null
        constraint "driver_licenseState_fk"
            references "State"
);

comment on table "Driver" is 'employees, drivers of the cars';

create table if not exists "Authorization"
(
    "driverId"  integer not null
        constraint authorization_driver_id_fk
            references "Driver",
    "vehicleId" integer not null
        constraint authorization_vehicle_id_fk
            references "Vehicle",
    constraint authorization_pk
        primary key ("driverId", "vehicleId")
);

comment on table "Authorization" is 'authorize drivers and their vehicles';

create table if not exists "Location"
(
    id        serial      not null
        constraint location_pk
            primary key,
    name      varchar(60) not null,
    address   varchar(60) not null,
    city      varchar(40) not null,
    state     varchar(2)  not null
        constraint location_state_abbreviation_fk
            references "State",
    "zipCode" varchar(6)  not null
);

comment on table "Location" is 'where the ride takes place';

create table if not exists "Ride"
(
    id               serial           not null
        constraint ride_pk
            primary key,
    date             timestamp        not null,
    time             time             not null,
    distance         double precision not null,
    "fuelPrice"      double precision not null,
    fee              double precision not null,
    "vehicleId"      integer          not null
        constraint ride_vehicle_id_fk
            references "Vehicle",
    "fromLocationId" integer          not null
        constraint ride_location_id_fk
            references "Location",
    "toLocationId"   integer          not null
        constraint ride_location_id_fk_2
            references "Location"
);

comment on table "Ride" is 'details about the ride';

create table if not exists "Drivers"
(
    "driverId" integer not null
        constraint drivers_driver_id_fk
            references "Driver",
    "rideId"   integer not null
        constraint drivers_ride_id_fk
            references "Ride",
    constraint drivers_pk
        primary key ("driverId", "rideId")
);

comment on table "Drivers" is 'connects drivers to their rides';

create table if not exists "Passenger"
(
    "userId" integer not null
        constraint passenger_user_id_fk
            references "User",
    "rideId" integer not null
        constraint passenger_ride_id_fk
            references "Ride",
    constraint passenger_pk
        primary key ("userId", "rideId")
);

comment on table "Passenger" is 'connects passengers to their ride';


