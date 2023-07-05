CREATE MIGRATION m1c6n4sk53b267csj2tccrfbisi3n2sdmxbslzniw4eqpop4gvgsja
    ONTO initial
{
  CREATE TYPE default::Address {
      CREATE REQUIRED PROPERTY address: std::str;
      CREATE REQUIRED PROPERTY country: std::str {
          SET default := 'PLZ FILL INFO';
      };
      CREATE REQUIRED PROPERTY pincode: std::str {
          SET default := 'PLZ FILL INFO';
      };
      CREATE REQUIRED PROPERTY state: std::str {
          SET default := 'PLZ FILL INFO';
      };
  };
  CREATE TYPE default::Image {
      CREATE REQUIRED PROPERTY data: std::bytes;
      CREATE REQUIRED PROPERTY format: std::str;
      CREATE REQUIRED PROPERTY name: std::str {
          SET default := 'image';
      };
  };
  CREATE TYPE default::Company {
      CREATE REQUIRED LINK address: default::Address {
          ON SOURCE DELETE DELETE TARGET IF ORPHAN;
      };
      CREATE REQUIRED LINK image: default::Image {
          ON SOURCE DELETE DELETE TARGET IF ORPHAN;
      };
      CREATE REQUIRED PROPERTY company_description: std::str;
      CREATE REQUIRED PROPERTY company_size: std::str;
      CREATE REQUIRED PROPERTY founded_date: std::str {
          SET default := 'PLZ FILL INFO';
      };
      CREATE REQUIRED PROPERTY name: std::str {
          CREATE CONSTRAINT std::max_len_value(25);
      };
      CREATE REQUIRED PROPERTY profile_url_slug: std::str {
          SET default := 'PLZ FILL INFO';
      };
      CREATE REQUIRED PROPERTY website: std::str;
  };
  CREATE TYPE default::Salary {
      CREATE REQUIRED PROPERTY currency_type: std::str;
      CREATE REQUIRED PROPERTY max_salary: std::float64;
      CREATE REQUIRED PROPERTY min_salary: std::float64;
      CREATE REQUIRED PROPERTY salary_type: std::str;
  };
  CREATE TYPE default::JobDescription {
      CREATE LINK location: default::Address {
          ON TARGET DELETE ALLOW;
      };
      CREATE LINK company: default::Company {
          ON TARGET DELETE ALLOW;
      };
      CREATE REQUIRED LINK salary: default::Salary {
          ON TARGET DELETE ALLOW;
      };
      CREATE PROPERTY career_level: std::str;
      CREATE PROPERTY department: std::str;
      CREATE REQUIRED PROPERTY description: std::str;
      CREATE PROPERTY experience: std::str;
      CREATE PROPERTY gender: std::str;
      CREATE REQUIRED PROPERTY job_category: std::str;
      CREATE REQUIRED PROPERTY job_type: std::str;
      CREATE PROPERTY qualification: std::str;
      CREATE PROPERTY quantity: std::int64;
      CREATE PROPERTY skills: array<std::str>;
      CREATE PROPERTY tags: array<std::str>;
  };
  CREATE TYPE default::Blog {
      CREATE REQUIRED PROPERTY content: std::json;
      CREATE REQUIRED PROPERTY createdAt: std::datetime {
          SET default := (std::datetime_current());
      };
  };
  CREATE ABSTRACT TYPE default::User {
      CREATE REQUIRED PROPERTY date_of_birth: std::str {
          SET default := '';
      };
      CREATE REQUIRED PROPERTY email: std::str {
          CREATE CONSTRAINT std::exclusive;
      };
      CREATE REQUIRED PROPERTY email_verified: std::bool;
      CREATE REQUIRED PROPERTY first_name: std::str {
          CREATE CONSTRAINT std::max_len_value(25);
      };
      CREATE REQUIRED PROPERTY gender: std::str {
          SET default := '';
      };
      CREATE REQUIRED PROPERTY last_name: std::str {
          SET default := '';
          CREATE CONSTRAINT std::max_len_value(25);
      };
      CREATE REQUIRED PROPERTY password: std::str;
      CREATE REQUIRED PROPERTY user_type: std::str;
  };
  CREATE TYPE default::Admin EXTENDING default::User {
      CREATE MULTI LINK blogs: default::Blog {
          ON SOURCE DELETE DELETE TARGET;
          ON TARGET DELETE ALLOW;
      };
  };
  CREATE TYPE default::Message {
      CREATE REQUIRED LINK receiver: default::User;
      CREATE REQUIRED LINK sender: default::User;
      CREATE REQUIRED PROPERTY content: std::str;
      CREATE REQUIRED PROPERTY timestamp: std::datetime;
  };
  CREATE TYPE default::Applicant EXTENDING default::User {
      CREATE OPTIONAL LINK image: default::Image {
          ON SOURCE DELETE DELETE TARGET;
      };
      CREATE MULTI LINK messages: default::Message {
          ON SOURCE DELETE DELETE TARGET IF ORPHAN;
      };
      CREATE OPTIONAL PROPERTY resume: std::bytes;
  };
  CREATE TYPE default::Score {
      CREATE REQUIRED PROPERTY value: std::float64;
  };
  ALTER TYPE default::Applicant {
      CREATE MULTI LINK scores: default::Score {
          ON SOURCE DELETE DELETE TARGET;
      };
  };
  CREATE TYPE default::Package {
      CREATE REQUIRED PROPERTY duration: std::int64;
      CREATE REQUIRED PROPERTY price: std::float64;
      CREATE REQUIRED PROPERTY type: std::str;
  };
  CREATE TYPE default::PaymentCredential {
      CREATE REQUIRED PROPERTY card_holder_name: std::str;
      CREATE REQUIRED PROPERTY card_number: std::str;
      CREATE REQUIRED PROPERTY cvv: std::str;
      CREATE REQUIRED PROPERTY expiration_month: std::str;
      CREATE REQUIRED PROPERTY expiration_year: std::str;
  };
  CREATE TYPE default::Phone {
      CREATE REQUIRED PROPERTY cid: std::str {
          CREATE CONSTRAINT std::max_len_value(4);
      };
      CREATE REQUIRED PROPERTY number: std::str {
          CREATE CONSTRAINT std::max_len_value(15);
      };
  };
  CREATE TYPE default::Recruiter EXTENDING default::User {
      CREATE REQUIRED MULTI LINK company: default::Company;
      CREATE MULTI LINK messages: default::Message {
          ON SOURCE DELETE DELETE TARGET IF ORPHAN;
      };
      CREATE MULTI LINK packages: default::Package {
          ON SOURCE DELETE DELETE TARGET;
      };
      CREATE MULTI LINK payment_credentials: default::PaymentCredential {
          ON SOURCE DELETE DELETE TARGET;
      };
      CREATE REQUIRED LINK phone: default::Phone {
          ON SOURCE DELETE DELETE TARGET;
      };
      CREATE REQUIRED PROPERTY industry: std::str {
          CREATE CONSTRAINT std::max_len_value(25);
      };
  };
  CREATE TYPE default::Interview {
      CREATE REQUIRED LINK applicant: default::Applicant;
      CREATE LINK recruiter: default::Recruiter;
      CREATE REQUIRED PROPERTY datetime: std::datetime;
      CREATE REQUIRED PROPERTY meet_link: std::str;
  };
  CREATE TYPE default::Job {
      CREATE MULTI LINK applicants: default::Applicant {
          ON TARGET DELETE ALLOW;
      };
      CREATE MULTI LINK interviews: default::Interview;
      CREATE REQUIRED LINK description: default::JobDescription;
      CREATE LINK recruiter: default::Recruiter {
          ON TARGET DELETE ALLOW;
      };
      CREATE REQUIRED PROPERTY createdAt: std::datetime {
          SET default := (std::datetime_current());
      };
      CREATE PROPERTY deadline: std::datetime;
      CREATE REQUIRED PROPERTY status: std::str {
          SET default := 'DRAFT';
      };
      CREATE REQUIRED PROPERTY title: std::str;
  };
  CREATE TYPE default::Employer EXTENDING default::User {
      CREATE REQUIRED LINK company: default::Company {
          ON SOURCE DELETE DELETE TARGET IF ORPHAN;
      };
      CREATE MULTI LINK draft_jobs: default::Job {
          ON TARGET DELETE ALLOW;
      };
      CREATE MULTI LINK messages: default::Message {
          ON SOURCE DELETE DELETE TARGET IF ORPHAN;
      };
      CREATE MULTI LINK packages: default::Package {
          ON SOURCE DELETE DELETE TARGET;
      };
      CREATE MULTI LINK payment_credentials: default::PaymentCredential {
          ON SOURCE DELETE DELETE TARGET;
      };
      CREATE REQUIRED LINK phone: default::Phone;
      CREATE MULTI LINK published_jobs: default::Job {
          ON TARGET DELETE ALLOW;
      };
      CREATE REQUIRED PROPERTY industry: std::str {
          CREATE CONSTRAINT std::max_len_value(25);
      };
  };
  CREATE TYPE default::Company_enrichment {
      CREATE REQUIRED PROPERTY country: std::str {
          SET default := 'We dont have';
      };
      CREATE REQUIRED PROPERTY domain: std::str {
          CREATE CONSTRAINT std::exclusive;
      };
      CREATE REQUIRED PROPERTY founded_year: std::str {
          SET default := 'We dont have';
      };
      CREATE REQUIRED PROPERTY industry: std::str {
          SET default := 'We dont have';
      };
      CREATE REQUIRED PROPERTY linkedin_url: std::str {
          SET default := 'We dont have';
      };
      CREATE REQUIRED PROPERTY locality: array<std::str> {
          SET default := (['We dont have']);
      };
  };
  CREATE TYPE default::Day {
      CREATE REQUIRED PROPERTY date: std::datetime;
      CREATE REQUIRED PROPERTY view_count_applicant: std::int64;
      CREATE REQUIRED PROPERTY view_count_employer: std::int64;
      CREATE REQUIRED PROPERTY view_count_non_registered: std::int64;
      CREATE REQUIRED PROPERTY view_count_recruiter: std::int64;
  };
  CREATE TYPE default::Page {
      CREATE MULTI LINK views: default::Day;
      CREATE REQUIRED PROPERTY url: std::str;
  };
  ALTER TYPE default::Interview {
      CREATE LINK employer: default::Employer;
      CREATE REQUIRED LINK job: default::Job;
  };
  ALTER TYPE default::Job {
      CREATE LINK employer: default::Employer {
          ON TARGET DELETE ALLOW;
      };
  };
  ALTER TYPE default::Score {
      CREATE LINK job: default::Job;
  };
};
