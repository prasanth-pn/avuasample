package http

import (
	"github.com/gin-gonic/gin"
	"github.com/prasanthpn-pn/avua-erecruitement/pkg/api/handler"
)

type ServeHTTP struct {
	engine *gin.Engine
}

func NewServeHttp(employe *handler.Employe) *ServeHTTP {
	engine := gin.New()

	engine.POST("/login", employe.EmployeRegister)

	return &ServeHTTP{engine}

}
func (s *ServeHTTP)Start(){

	s.engine.Run(":9090")
}
