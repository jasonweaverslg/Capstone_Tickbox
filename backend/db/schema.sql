DROP TABLE IF EXISTS answer_option;
DROP TABLE IF EXISTS question_option;
DROP TABLE IF EXISTS answer;
DROP TABLE IF EXISTS response;
DROP TABLE IF EXISTS question;
DROP TABLE IF EXISTS form;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS lookup;


CREATE TABLE user (
  id serial PRIMARY KEY,
  display_name text NOT NULL,
  email text UNIQUE NOT NULL,
  password text NOT NULL,
  active boolean NOT NULL,
  last_login_at datetime,
  created_at datetime NOT NULL,
  created_by int NOT NULL,
  updated_at datetime NOT NULL,
  updated_by id NOT NULL
);

CREATE TABLE lookup (
  id serial PRIMARY KEY,
  category text NOT NULL,
  title text NOT NULL,
  sort_order int,
  active boolean NOT NULL,
  created_at datetime NOT NULL,
  created_by int NOT NULL,
  updated_at datetime NOT NULL,
  updated_by id NOT NULL
);

CREATE TABLE form (
  id serial PRIMARY KEY,
  owner_user_id int NOT NULL REFERENCES user(id),
  title text NOT NULL,
  description text,
  status_id int NOT NULL REFERENCES lookup(id),
  site_bg_color text,
  form_bg_color text,
  published_at datetime,
  active boolean NOT NULL,
  created_at datetime NOT NULL,
  created_by int NOT NULL,
  updated_at datetime NOT NULL,
  updated_by id NOT NULL
 );

 
CREATE TABLE question (
  id serial PRIMARY KEY,
  form_id int NOT NULL REFERENCES form(id),
  question_type_id int NOT NULL REFERENCES lookup(id),
  label text NOT NULL,
  is_required boolean NOT NULL,
  sort_order int NOT NULL,
  scale_min int,
  scale_max int,
  low_label text,
  high_label text,
  active boolean NOT NULL,
  created_at datetime NOT NULL,
  created_by int NOT NULL,
  updated_at datetime NOT NULL,
  updated_by id NOT NULL
 );

 CREATE TABLE question_option (
   id serial PRIMARY KEY,
   question_id int NOT NULL REFERENCES question(id),
   label text NOT NULL,
   sort_order int NOT NULL,
   active boolean NOT NULL,
   created_at datetime NOT NULL,
   created_by int NOT NULL,
   updated_at datetime NOT NULL,
   updated_by id NOT NULL
 )

 CREATE TABLE response (
  id serial PRIMARY KEY,
  form_id int NOT NULL REFERENCES form(id),
  submitted_at datetime NOT NULL
 )

CREATE TABLE answer (
  id serial PRIMARY KEY,
  response_id int NOT NULL REFERENCES response(id),
  question_id int NOT NULL REFERENCES question(id),
  text_value text,
  number_value int,
  date_value date
)

CREATE TABLE answer_option (
  answer_id int NOT NULL REFERENCES answer(id),
  option_id integer NOT NULL REFERENCES option(id),
  UNIQUE (answer_id, option_id)
);
