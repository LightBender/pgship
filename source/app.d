import pgship.model;

import std.stdio;
import std.string;

public const string appver = "0.1.0";

int main(string[] args)
{
    writeln("PGship Database Migration Tool");
    writeln("Version: ", appver);
    writeln();

    if (args.length < 4) {
        displayUsage();
        return 0;
    }

    auto deploymentFile = args[1];
    auto serverUrl = args[2];
    auto database = args[3];
    bool requireSsl = false;
    string user = null;
    string password = null;

    if (args.length > 4) {
        for(int i = 4; i < args.length; i++) {
            if (args[i].toLower() == "-requireSSL".toLower()) requireSsl = true;
            if (args[i].toLower() == "-user".toLower()) {
                user = args[i+1];
                i++;
            }
            if (args[i].toLower() == "-password".toLower()) {
                password = args[i+1];
                i++;
            }
        }
    }

    return 0;
}

public void displayUsage()
{
    writeln("Usage: pgship <path to deployment file> <server url> <database> [options]");
    writeln();
    writeln("Options:");
    writeln("    -requireSSL                 Require SSL to connect to the server.");
    writeln("    -user                       Username to use for the connection.");
    writeln("    -password                   Password for the supplied username.");
}
