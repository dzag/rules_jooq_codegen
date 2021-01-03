package com.trerry.jooqcodegen;

import com.mysql.cj.jdbc.MysqlDataSource;
import liquibase.Contexts;
import liquibase.Liquibase;
import liquibase.database.Database;
import liquibase.database.DatabaseFactory;
import liquibase.database.jvm.JdbcConnection;
import liquibase.resource.ClassLoaderResourceAccessor;
import org.testcontainers.containers.JdbcDatabaseContainer;
import org.testcontainers.containers.MySQLContainer;
import org.jooq.codegen.GenerationTool;
import org.jooq.meta.jaxb.Configuration;
import org.jooq.meta.jaxb.Jdbc;

import java.io.FileInputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Connection;

import static com.trerry.jooqcodegen.JooqCodegen.recursiveDeleteOnExit;

public class JooqCodegen2 {

    public static void main(String[] argv) throws Exception {
        String outputSourceJar = argv[0];
        String codeGenConfigXmlPath = argv[1];

        String mysqlDockerImage = argv[2]; // "mysql:8.0.22"
        String databaseName = argv[3];
        String changeLogMasterPath = argv[4];

        String rootUser = "root";
        String rootPassword = "test";

        JdbcDatabaseContainer container =
                (JdbcDatabaseContainer) new MySQLContainer(mysqlDockerImage)
                .withDatabaseName(databaseName)
                .withEnv("MYSQL_ROOT_PASSWORD", rootPassword);
        container.start();

        MysqlDataSource dataSource = new MysqlDataSource();
        dataSource.setServerName(container.getHost());
        dataSource.setPort(container.getFirstMappedPort());
        dataSource.setUser("root");
        dataSource.setPassword("test");
        dataSource.setDatabaseName(container.getDatabaseName());

        Connection connection = dataSource.getConnection();
        Database database = DatabaseFactory.getInstance()
                .findCorrectDatabaseImplementation(new JdbcConnection(connection));

        Liquibase liquibase = new Liquibase(
                changeLogMasterPath, // "/migration/db.changelog-master.xml"
                new ClassLoaderResourceAccessor(),
                database);

        liquibase.update(new Contexts());

        Path path = Files.createTempDirectory("jooq_codegen");
        try (FileInputStream file = new FileInputStream(codeGenConfigXmlPath)) {
            Configuration configuration = GenerationTool.load(file);

            configuration.getGenerator()
                    .getTarget()
                    .setDirectory(path.toAbsolutePath().toString());

            configuration.setJdbc(new Jdbc()
                    .withDriver("com.mysql.cj.jdbc.Driver")
                    .withUrl(container.getJdbcUrl())
                    .withUser(rootUser)
                    .withPassword(rootPassword));

            new GenerationTool().run(configuration);

            ZipUtil.zipDirectory(path.toFile(), outputSourceJar);
        } catch (Exception ex) {
            ex.printStackTrace();
            System.exit(1);
        } finally {
            recursiveDeleteOnExit(path);
        }
    }


}
