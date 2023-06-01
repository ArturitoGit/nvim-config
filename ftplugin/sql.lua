require('lspconfig').setup {
  connections: {
    {
      name= "sql-language-server",
      adapter= "mysql",
      host= "localhost",
      port= 3306,
      user= "root",
      password= "root",
      database= "test",
      projectPaths= { "/Users/joe-re/src/sql-language-server" },
    }
  }
}
