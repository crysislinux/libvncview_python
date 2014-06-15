%Module(name=vncview, keyword_arguments="Optional", version=1)
 
%Import QtCore/QtCoremod.sip
%Import QtGui/QtGuimod.sip
%Import QtNetwork/QtNetworkmod.sip 
%Import QtWidgets/QtWidgetsmod.sip

%Include remoteview.sip
 
class VncView : public RemoteView {

%TypeHeaderCode
#include "vncview.h"
%End
 
public:
    explicit VncView(QWidget *parent  /TransferThis/ = 0, const QUrl &url = QUrl());
     ~VncView();

    QSize framebufferSize();
    QSize sizeHint() const;
    QSize minimumSizeHint() const;
    void startQuitting();
    bool isQuitting();
    bool start();
    bool supportsScaling() const;
    bool supportsLocalCursor() const;
    
    void setViewOnly(bool viewOnly);
    void showDotCursor(DotCursorState state);
    void enableScaling(bool scale);

    void setUrl(QUrl &url);
    void restart();

    virtual void updateConfiguration();

signals:
    void disconnected();
    void restarted();
    void mouseLeftButtonClicked();
    void keyPressed();


public slots:
    void scaleResize(int w, int h);

protected:
    void paintEvent(QPaintEvent *event);
    bool event(QEvent *event);
    void resizeEvent(QResizeEvent *event);
    bool eventFilter(QObject *obj, QEvent *event);
private:
    void keyEventHandler(QKeyEvent *e);
    void unpressModifiers();
    void wheelEventHandler(QWheelEvent *event);
    void mouseEventHandler(QMouseEvent *event);
private slots:
    void updateImage(int x, int y, int w, int h);
    void setCut(const QString &text);
    void requestPassword(bool includingUsername);
    void outputErrorMessage(const QString &message);
    void clipboardDataChanged();
};


