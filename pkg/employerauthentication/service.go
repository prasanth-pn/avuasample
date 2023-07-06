package employerauthentication
import (
	
)

type Service interface {
	Register(em EmployerRegister) error
}

type service struct {
	rep Repository
}

func NewService(repo Repository) Service {
	return &service{repo}
}

func (c *service) Register(emp EmployerRegister) error {

	err := c.rep.Register(emp)

	return err

}
