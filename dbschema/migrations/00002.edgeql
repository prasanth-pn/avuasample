CREATE MIGRATION m164sksbuemnqqq6ajhbcnf6caotmudd4vsku2gry3aofcheol6ipq
    ONTO m1c6n4sk53b267csj2tccrfbisi3n2sdmxbslzniw4eqpop4gvgsja
{
  ALTER TYPE default::User {
      DROP PROPERTY user_type;
  };
};
