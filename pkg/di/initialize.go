package di

import (
	http "github.com/prasanthpn-pn/avua-erecruitement/pkg/api"
	"github.com/prasanthpn-pn/avua-erecruitement/pkg/db"
	employerauthentication "github.com/prasanthpn-pn/avua-erecruitement/pkg/employerauthentication"
)

func InitiallizeEvent() (*http.ServeHTTP, error) {

	DB := db.ConnectDB()
	employerauthenticationrepository := employerauthentication.NewRepository(DB)
	employeeAuthService := employerauthentication.NewService(employerauthenticationrepository)
	employeeAuthHandler := employerauthentication.NewHandler(employeeAuthService)

	serverHttp := http.NewServeHttp(*employeeAuthHandler)

	return serverHttp, nil
}
