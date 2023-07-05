CREATE MIGRATION m13wn7sup37vw2ccfxx2zrv7oglakkj5nolbzxa37zm4alomlh3idq
    ONTO m164sksbuemnqqq6ajhbcnf6caotmudd4vsku2gry3aofcheol6ipq
{
  ALTER TYPE default::Applicant {
      DROP LINK image;
  };
  ALTER TYPE default::Applicant {
      CREATE OPTIONAL PROPERTY image: std::str;
  };
  ALTER TYPE default::Company {
      DROP LINK image;
  };
  ALTER TYPE default::Company {
      CREATE REQUIRED PROPERTY image: std::str {
          SET REQUIRED USING (<std::str>{});
      };
  };
  DROP TYPE default::Image;
};
