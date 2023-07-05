module default {


  type Phone {
    required property cid -> str {
      constraint max_len_value(4);
    }
    required property number -> str {
      constraint max_len_value(15);
      
    }
  }

  # User and User Types

  abstract type User {
    required property first_name -> str{
      constraint max_len_value(25);
    };
    required property last_name->str{
      constraint max_len_value(25);
      default:=""
    };
    
    required property email -> str {
      constraint exclusive;
      
    };
    required property password -> str;
    required property email_verified -> bool;
    required property date_of_birth -> str{
     default:="";
    };
    required property gender-> str{
      default:="";
    };
  }

  type Employer extending User {
    # Additional properties specific to employers
     
    required link company -> Company{
      on source delete delete target if orphan;
    };
    required property industry -> str {
      constraint max_len_value(25);
    };
    required link phone -> Phone;
    multi link draft_jobs -> Job{
      on target delete allow;
    };
    multi link published_jobs -> Job{
      on target delete allow;
    };
    multi link messages -> Message{
      on source delete delete target if orphan ;
    };
    multi link payment_credentials -> PaymentCredential{
      on source delete delete target ;
    };
    multi link packages -> Package{
      on source delete delete target ;
    };
  }

  type Recruiter extending User {
    # Additional properties specific to recruiters
    
    required multi link company -> Company;
    required property industry -> str {
      constraint max_len_value(25);
    };
    required link phone -> Phone{
      on source delete delete target;
    };
    multi link messages -> Message{
      on source delete delete target if orphan ;
    };
    multi link payment_credentials -> PaymentCredential{
      on source delete delete target ;
    };
    multi link packages -> Package{
       on source delete delete target ;
    };
  }

  type Applicant extending User {
    # Additional properties specific to applicants
    
    optional property resume -> bytes;
   optional property image :str;
    multi link scores -> Score{
       on source delete delete target ;
    };
    multi link messages -> Message{
       on source delete delete target if orphan;
    };
  }

  # Job Types
  
  type Job {
      required property title -> str;
      required link description -> JobDescription;
      required property status -> str {
        default := "DRAFT";
      };
      required property createdAt -> datetime {
        default := datetime_current();
      };
      property deadline -> datetime;
      link employer -> Employer{
        on target delete allow;
      };
      link recruiter->Recruiter{
        on target delete allow;
      };
      multi link applicants -> Applicant{
        on target delete allow;
      };
      multi link interviews -> Interview;
     
  }

  type JobDescription {
    required property job_type -> str;
    required property description -> str;
    property skills -> array<str>;
    required property job_category -> str;
    property career_level -> str;
    property department -> str;
    property experience -> str;
    property qualification -> str;
    property quantity -> int64;
    property gender -> str;
    property tags->array<str>;
    link company -> Company{
      on target delete allow;
    };
    link location -> Address{
      on target delete allow;
    };
    required link salary -> Salary{
      on target delete allow;
    };
  }

  type Company {
    required property name -> str {
      constraint max_len_value(25);
    };
    required property company_size -> str;
    required property company_description -> str;
    required property image ->str;
    required property website -> str;
    required property profile_url_slug -> str{
      default:="PLZ FILL INFO";
    };
    required link address -> Address{
       on source delete delete target if orphan;
    };
     required property founded_date->str{
      default:="PLZ FILL INFO";
    };
  }
  type Package {
    required property type -> str;
    required property duration -> int64;  # Duration in months
    required property price -> float64;
  }

  type PaymentCredential {
    required property card_number -> str;
    required property card_holder_name -> str;
    required property expiration_month -> str;
    required property expiration_year -> str;
    required property cvv -> str;
  }

  type Address {
     required property address -> str;
     required property state -> str{
      default:="PLZ FILL INFO";
     };
     required property country -> str{
      default:="PLZ FILL INFO";
     };
     required property pincode -> str{
      default:="PLZ FILL INFO";
     };
  }

  type Salary {
    required property salary_type -> str;
    required property currency_type -> str;
    required property min_salary -> float64;
    required property max_salary -> float64;
  }

  type Score {
    required property value -> float64;
    link job -> Job;
  }

  type Interview {
    required property datetime -> datetime;
    required property meet_link-> str;
    required link job -> Job;
    required link applicant -> Applicant;
    link employer -> Employer;
    link recruiter -> Recruiter;
  }

  # Message Types

  type Message {
    required property content -> str;
    required property timestamp -> datetime;
    required link sender -> User;
    required link receiver -> User;
  }

  # Page and Day Types

  type Day {
    required property date -> datetime;
    required property view_count_employer -> int64;
    required property view_count_recruiter -> int64;
    required property view_count_non_registered -> int64;
    required property view_count_applicant -> int64;
  }

  type Page {
    required property url -> str;
    multi link views -> Day;
  }

  type Company_enrichment{
    required property domain->str{
      constraint exclusive;
    }
    required property industry->str{
      default:="We dont have";
    };
    required property founded_year->str{
      default:="We dont have";
    };
    required property locality -> array<str> {
    default := ["We dont have"];
    };
    required property country->str{
      default:="We dont have";
    };
    required property linkedin_url->str{
      default:="We dont have";
    };
  }
type Admin extending User{
    multi link blogs->Blog{
      on target delete allow;
      on source delete delete target;
    };
 }
 type Blog{
    required property content->json;
    required property createdAt -> datetime {
        default := datetime_current();
    };
    
 }
 type Beta {
  required property name ->str;
  
 }
 
}
