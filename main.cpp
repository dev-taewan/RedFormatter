#include <QGuiApplication>
#include <QQmlApplicationEngine>

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
    engine.loadFromModule("RedFormatter", "Main");

    return app.exec();
}
<<<<<<< HEAD
=======
/Users/ioip/Desktop/study/project/qtproject/qmlcpplist/MyModel.h
>>>>>>> bc1a527 (qt set)
