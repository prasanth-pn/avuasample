package http

import (
	"github.com/gin-gonic/gin"
	employerauth "github.com/prasanthpn-pn/avua-erecruitement/pkg/employerauthentication"
)

type ServeHTTP struct {
	engine *gin.Engine
}

func NewServeHttp(employeeAuthenication employerauth.Handler) *ServeHTTP {
	engine := gin.New()
	employeeAuthenication.Mountroutes(engine)

	return &ServeHTTP{engine}

}
func (s *ServeHTTP) Start() {

	s.engine.Run(":9090")
}
