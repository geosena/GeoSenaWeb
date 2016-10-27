using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace GeoSenaWeb.Tests
{
    [TestClass]
    public class CADAdminUnitTest
    {
        [TestMethod]
        public void ProbarExisteAdmin()
        {
            //Arrange
            var identificacion = "123456789";
            var password = "admin123";

            if (identificacion == string.Empty || password == string.Empty)
            {
                Assert.Fail("Los parametros no deben ser vacios");
            }
            else
            {
                //Act
                var resultado = CAD.CADAdministrador.ExisteAdministrador(identificacion, password);
                
                //Assert
                
                Assert.AreEqual(resultado, true, "Se esperaba 'Verdadero'");
            }
        }

        [TestMethod]
        public void ProbarExisteAdminByIdentificacion()
        {
            //Arrange
            var CADAdministrador = new CAD.CADAdministrador();

            //Act
            var resultado = CAD.CADAdministrador.ExsteAdministradorByIdAdministrador(1);

            //Assert

            Assert.AreEqual(resultado, true, "Se esperaba 'Verdadero'");
        }

        [TestMethod]
        public void ProbarInserAdmin()
        {
            try
            {
                CAD.CADAdministrador.InsertAdministrador("William", "Hurtado", "williandres8@gmail.com", "", "admin1234");
            }
            catch (Exception)
            {

                Assert.Fail("No es posible insertar");
            }
        }
    }
}
