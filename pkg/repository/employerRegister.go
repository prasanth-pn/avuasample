package repo

import (
	"context"

	"github.com/edgedb/edgedb-go"
	employerauth "github.com/prasanthpn-pn/avua-erecruitement/pkg/employerauthentication"
)

type Employer interface {
	Register(employerauth.EmployerRegister) error
}
type Emp struct {
	DB *edgedb.Client
}

func NewEmpRepo(db *edgedb.Client) Employer {
	return &Emp{db}
}

func (cr *Emp) Register(emp employerauth.EmployerRegister) error {

	var inserted struct{ id edgedb.UUID }
	err := cr.DB.QuerySingle(context.Background(), `
	INSERT Employer {
		first_name := <str>$0,
		email := <str>$1,
		password :=<str>$3,
		phone:=(Insert Phone{number:=<str>$4,cid:=<str>$10}),
		company:=(Insert Company{name:=<str>$5,company_description:=<str>$6,
			company_size:=<str>$7,website:=<str>$9,image:=<str>$11
,address:=(Insert Address{address:=<str>$1})}),
		industry:=<str>$8,
		email_verified:=<bool>$12
	}`, &inserted, emp.FirstName,  emp.Email, emp.Password, emp.Number, emp.Name, emp.About_company,emp.Address, emp.Company_size, emp.Industry,
		emp.Website,
		emp.Cid, "hi.jpeg", false)

	return err
	// FirstName   string      `json:"first_name"`
	// LastName    string      `json:"last_name"`
	// Email       string      `json:"email"`
	// DateOfBirth string      `json:"date_of_birth"`
	// Gender      string      `json:"gender"`
	// Name             string      `json:"name"`
	// Company_size     string      `json:"company_size"`
	// About_company    string      `json:"company_description"`
	// Website          string      `json:"website"`
	// Address          string    `json:"address"`
	// Profile_url_slug string      `json:"profile_url_slug"`
	// Founded_date     string      `json:"founded_date"`
	// Image            string      `json:"image,omitempty"`
	// Industry    string      `json:"industry"`
	// Number string      `json:"number"`
	// Cid    string      `json:"cid"`
	// Password string     `json:"password"`

}
