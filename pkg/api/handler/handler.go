package handler

import (
	"fmt"
	"log"

	"github.com/gin-gonic/gin"
	employerauth "github.com/prasanthpn-pn/avua-erecruitement/pkg/employerauthentication"
	"github.com/prasanthpn-pn/avua-erecruitement/pkg/usecase"
)

type Employe struct {
	usecase usecase.Employe
}

func NewEmployerHandler(use usecase.Employe) *Employe {
	return &Employe{use}
}

func (cr *Employe) EmployeRegister(c *gin.Context) {
	var employe employerauth.EmployerRegister
	if err := c.ShouldBind(&employe); err != nil {
		fmt.Println("failed to get the employee details ")
	}
	fmt.Println(employe.FirstName)
	c.JSON(201, gin.H{
		"message": "ok created",
		"data":    employe,
	})
	err := cr.usecase.Register(employe)
	if err != nil {
		fmt.Println("errror while inserting into database")
		log.Fatalf("%v", err)
	}



}
