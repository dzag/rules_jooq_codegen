package com.trerry.jooqcodegen;

import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.FileVisitResult;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;

import org.jooq.codegen.GenerationTool;
import org.jooq.meta.jaxb.Jdbc;
import org.jooq.meta.jaxb.Configuration;

public class JooqCodegen {
    public static void main(String[] argv) throws Exception {
        String outputSourceJar = argv[0];
        String codeGenConfigXmlPath = argv[1];

        String url = argv[2];
        String user = argv[3];
        String password = argv[4];

        Path path = Files.createTempDirectory("jooq_codegen");

        try (FileInputStream file = new FileInputStream(codeGenConfigXmlPath)) {
            Configuration configuration = GenerationTool.load(file);

            configuration.getGenerator()
                    .getTarget()
                    .setDirectory(path.toAbsolutePath().toString());

            configuration.setJdbc(new Jdbc()
                    .withDriver("com.mysql.cj.jdbc.Driver")
                    .withUrl(url)
                    .withUser(user)
                    .withPassword(password));

            new GenerationTool().run(configuration);

            ZipUtil.zipDirectory(path.toFile(), outputSourceJar);
        } catch (Exception ex) {
            ex.printStackTrace();
            System.exit(1);
        } finally {
            recursiveDeleteOnExit(path);
        }
    }

    public static void recursiveDeleteOnExit(Path path) throws IOException {
        Files.walkFileTree(
                path,
                new SimpleFileVisitor<Path>() {
                    @Override
                    public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) {
                        file.toFile().deleteOnExit();
                        return FileVisitResult.CONTINUE;
                    }

                    @Override
                    public FileVisitResult preVisitDirectory(Path dir, BasicFileAttributes attrs) {
                        dir.toFile().deleteOnExit();
                        return FileVisitResult.CONTINUE;
                    }
                });
    }
}