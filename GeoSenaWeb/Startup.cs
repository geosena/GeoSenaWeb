using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(GeoSenaWeb.Startup))]
namespace GeoSenaWeb
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
