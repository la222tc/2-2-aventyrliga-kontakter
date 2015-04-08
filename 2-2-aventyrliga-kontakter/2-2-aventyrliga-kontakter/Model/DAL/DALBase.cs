using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace _2_2_aventyrliga_kontakter.Model.DAL
{
    public class DALBase
    {
        private static string _connectionString;

        public DALBase()
        {
            _connectionString = WebConfigurationManager.ConnectionStrings["1dv406_AdventureWorksAssignmentConnectionString"].ConnectionString;
        }

        protected static SqlConnection CreateConnection()
        {
            return new SqlConnection(_connectionString);
        }
    }
}