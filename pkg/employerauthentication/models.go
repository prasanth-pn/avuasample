package employerauth

import "github.com/edgedb/edgedb-go"

type Employer struct {
	ID          edgedb.UUID `edgedb:"id"`
	FirstName   string      `edgedb:"first_name"`
	LastName    string      `edgedb:"last_name"`
	Email       string      `edgedb:"email"`
	DateOfBirth string      `edgedb:"date_of_birth"`
	Gender      string      `edgedb:"gender"`
	Company     Company     `edgedb:"company"`
	Industry    string      `edgedb:"industry"`
	Phone       Phone       `edgedb:"phone"`
}
type Phone struct {
	ID     edgedb.UUID `edgedb:"id"`
	Number string      `edgedb:"number"`
	Cid    string      `edgedb:"cid"`
}
type Company struct {
	ID               edgedb.UUID `edgedb:"id"`
	Name             string      `edgedb:"name"`
	Company_size     string      `edgedb:"company_size"`
	About_company    string      `edgedb:"company_description"`
	Website          string      `edgedb:"website"`
	Address          Address     `edgedb:"address"`
	Profile_url_slug string      `edgedb:"profile_url_slug"`
	Founded_date     string      `edgedb:"founded_date"`
	Image            Image       `edgedb:"image"`
}
type Image struct {
	ID     edgedb.UUID `edgedb:"id"`
	Data   []byte      `edgedb:"data"`
	Format string      `edgedb:"format"`
	Name   string      `edgedb:"name"`
}
type Address struct {
	edgedb.Optional
	ID      edgedb.UUID `edgedb:"id"`
	Address string      `edgedb:"address"`
	Country string      `edgedb:"country"`
	State   string      `edgedb:"state"`
	ZIPCode string      `edgedb:"pincode"`
}
type EmployerRegister struct{
	FirstName   string      `json:"first_name"`
	LastName    string      `json:"last_name"`
	Email       string      `json:"email"`
	DateOfBirth string      `json:"date_of_birth"`
	Gender      string      `json:"gender"`
	Name             string      `json:"name"`
	Company_size     string      `json:"company_size"`
	About_company    string      `json:"company_description"`
	Website          string      `json:"website"`
	Address          string    `json:"address"`
	Profile_url_slug string      `json:"profile_url_slug"`
	Founded_date     string      `json:"founded_date"`
	Image            string      `json:"image,omitempty"`
	Industry    string      `json:"industry"`
	Number string      `json:"number"`
	Cid    string      `json:"cid"`
	Password string     `json:"password"`

}