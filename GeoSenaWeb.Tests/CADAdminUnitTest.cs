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
            //Arrange planeamiento
            var identificacion = "123456789";
            var password = "admin123";

            if (identificacion == string.Empty || password == string.Empty)
            {
                Assert.Fail("Los parametros no deben ser vacios");
            }
            else
            {
                //Act prueba
                var resultado = CAD.CADAdministrador.ExisteAdministrador(identificacion, password);

                //Assert afirmacion
                Assert.AreEqual(resultado, true, "Se esperaba 'Verdadero'");
            }
        }

        [TestMethod]
        public void ProbarExisteAdminByIdentificacion()
        {
            //Arrange
            int IdAdministrador = 1;

            //Act
            if (IdAdministrador <= 0)
            {
                Assert.Fail("Los parametros deben ser validos");
            }
            else
            {
                var resultado = CAD.CADAdministrador.ExsteAdministradorByIdAdministrador(IdAdministrador);

                //Assert
                Assert.AreEqual(resultado, true, "Se esperaba 'Verdadero'");
            }
        }

        [TestMethod]
        public void ProbarInserAdmin()
        {
            string nombres = "";
            string apellidos = "";
            string correo = "";
            string identificacion = "";
            string clave = "";

            if (nombres == string.Empty || apellidos == string.Empty || correo == string.Empty
                || identificacion == string.Empty || clave == string.Empty)
            {
                Assert.Fail("No es posible insertar");
            }
            else
            {
                CAD.CADAdministrador.InsertAdministrador(nombres, apellidos, correo, identificacion, clave);
            }
        }
    }
}
