using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Articulo
    {
        public Articulo() 
        {
            this.Marca = new Caracteristica();
            this.Categoria = new Caracteristica();
        }
        public int Id { get; set; }

        [DisplayName("Código")]
        public string Codigo { get; set; }
        public string Nombre { get; set; }

        [DisplayName("Descripción")]
        public string Descripcion { get; set; }
        public string UrlImg { get; set; }
        public decimal Precio { get; set; }

        public Caracteristica Marca { get; set; }

        [DisplayName("Categoría")]
        public Caracteristica Categoria { get; set; }
    }
}
