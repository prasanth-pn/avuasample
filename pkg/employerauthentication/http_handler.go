package employerauthentication
import (
	"log"

	"github.com/gin-gonic/gin"
)


func (h *Handler)Mountroutes(engin *gin.Engine){
engin.POST("/login",h.Login)


}

type Handler struct {
	usecase Service
}

func NewHandler(usecase Service) *Handler {
	return &Handler{usecase}
}

func (cr *Handler) Login(c *gin.Context) {

var user EmployerRegister

if err:=c.ShouldBind(&user);err!=nil{
	log.Fatalf("error while getting user data %v", err)
}
err:=cr.usecase.Register(user)
if err!=nil{
c.JSON(400,gin.H{
	"message":"sucess",
	"error":err.Error(),
})
}
c.JSON(201,gin.H{
	"message":"sucess",
	"error":"no errror",
})

}
