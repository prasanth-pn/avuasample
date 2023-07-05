package usecase

import (
	employerauth "github.com/prasanthpn-pn/avua-erecruitement/pkg/employerauthentication"
	repo "github.com/prasanthpn-pn/avua-erecruitement/pkg/repository"
)

type Employe interface {
	Register(em employerauth.EmployerRegister) error
}

type employe struct {
	rep repo.Employer
}

func NewEmployerService(emp repo.Employer) Employe {
	return &employe{emp}
}

func (c *employe) Register(emp employerauth.EmployerRegister) error {

	err := c.rep.Register(emp)

	return err

}
