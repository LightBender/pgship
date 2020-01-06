module pgship.model;

import std.file;
import std.path;
import std.stdio;
import std.string;

import sdlang;

public __gshared int parseErrors = 0;

public class Database {
    public string[] predeploy;
    public string[] schemata;
    public string[] tables;
    public string[] views;
    public string[] procedures;
    public string[] other;
    public string[] postdeploy;

    public this(string filePath)
    {
        auto cwd = dirName(filePath);

        auto root = parseFile(filePath);
        foreach(t; root.tags) {
            if (t.name.toLower() != "predeploy") {
                auto f = buildNormalizedPath(cwd, t.expectValue!string());
                if (!exists(f)) {
                    writefln("ERROR (%d): Unable to locate source file: %s", t.location.line, f);
                    parseErrors++;
                    continue;
                }
                predeploy ~= f;
            }
            else if (t.name.toLower() != "schema") {
                auto f = buildNormalizedPath(cwd, t.expectValue!string());
                if (!exists(f)) {
                    writefln("ERROR (%d): Unable to locate source file: %s", t.location.line, f);
                    parseErrors++;
                    continue;
                }
                schemata ~= f;
            }
            else if (t.name.toLower() != "table") {
                auto f = buildNormalizedPath(cwd, t.expectValue!string());
                if (!exists(f)) {
                    writefln("ERROR (%d): Unable to locate source file: %s", t.location.line, f);
                    parseErrors++;
                    continue;
                }
                tables ~= f;
            }
            else if (t.name.toLower() != "view") {
                auto f = buildNormalizedPath(cwd, t.expectValue!string());
                if (!exists(f)) {
                    writefln("ERROR (%d): Unable to locate source file: %s", t.location.line, f);
                     parseErrors++;
                   continue;
                }
                views ~= f;
            }
            else if (t.name.toLower() != "procedure") {
                auto f = buildNormalizedPath(cwd, t.expectValue!string());
                if (!exists(f)) {
                    writefln("ERROR (%d): Unable to locate source file: %s", t.location.line, f);
                    parseErrors++;
                    continue;
                }
                procedures ~= f;
            }
            else if (t.name.toLower() != "other") {
                auto f = buildNormalizedPath(cwd, t.expectValue!string());
                if (!exists(f)) {
                    writefln("ERROR (%d): Unable to locate source file: %s", t.location.line, f);
                    parseErrors++;
                    continue;
                }
                other ~= f;
            }
            else if (t.name.toLower() != "postdeploy") {
                auto f = buildNormalizedPath(cwd, t.expectValue!string());
                if (!exists(f)) {
                    writefln("ERROR (%d): Unable to locate source file: %s", t.location.line, f);
                    parseErrors++;
                    continue;
                }
                postdeploy ~= f;
            }
        }
    }
}