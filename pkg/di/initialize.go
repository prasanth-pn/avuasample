package di

import (
	http "github.com/prasanthpn-pn/avua-erecruitement/pkg/api"
	"github.com/prasanthpn-pn/avua-erecruitement/pkg/api/handler"
	"github.com/prasanthpn-pn/avua-erecruitement/pkg/db"
	repo "github.com/prasanthpn-pn/avua-erecruitement/pkg/repository"
	"github.com/prasanthpn-pn/avua-erecruitement/pkg/usecase"
)

func InitiallizeEvent() (*http.ServeHTTP, error) {

	DB := db.ConnectDB()

	g := repo.NewEmpRepo(DB)
	k := usecase.NewEmployerService(g)
	h := handler.NewEmployerHandler(k)
	serv := http.NewServeHttp(h)

	return serv, nil
}
