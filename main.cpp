#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <cpprest/http_client.h>
#include <cpprest/filestream.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Redformatter", "Main");

    return app.exec();
}
