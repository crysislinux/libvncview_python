// remoteview.sip

class RemoteView : public QWidget {
    
%TypeHeaderCode
#include "remoteview.h"
%End

public:

    enum Quality {
        Unknown,
        High,
        Medium,
        Low
    };

    enum DotCursorState {
        CursorOn,  ///< Always show local cursor (and the remote one).
        CursorOff, ///< Never show local cursor, only the remote one.
        /// Try to measure the lag and enable the local cursor if the latency is too high.
        CursorAuto
    };

    enum RemoteStatus {
        Connecting     = 0,
        Authenticating = 1,
        Preparing      = 2,
        Connected      = 3,
        Disconnecting  = -1,
        Disconnected   = -2
    };

    enum ErrorCode {
        None = 0,
        Internal,
        Connection,
        Protocol,
        IO,
        Name,
        NoServer,
        ServerBlocked,
        Authentication
    };
    
    //RemoteView(QWidget *parent /TransferThis/ = 0);
    virtual ~RemoteView();
    virtual bool supportsScaling() const;
    virtual bool scaling() const;
    virtual bool supportsLocalCursor() const;
    virtual void showDotCursor(DotCursorState state);
    virtual DotCursorState dotCursorState() const;
    virtual bool viewOnly();
    virtual bool grabAllKeys();
    virtual QSize framebufferSize();
    virtual void startQuitting();
    virtual bool isQuitting();
    virtual QString host();
    virtual int port();
    virtual bool start() = 0;
    virtual void updateConfiguration();
    virtual QPixmap takeScreenshot();
    RemoteStatus status();
    QUrl url();
    
public slots:
    virtual void enableScaling(bool scale);
    virtual void setViewOnly(bool viewOnly);
    virtual void setGrabAllKeys(bool grabAllKeys);
    virtual void switchFullscreen(bool on);
    virtual void keyEvent(QKeyEvent *event);
    virtual void scaleResize(int w, int h);
signals:
    void framebufferSizeChanged(int w, int h);
    void connected();
    void disconnected();
    void disconnectedError();
    void errorMessage(const QString &title, const QString &message);
    void statusChanged(RemoteView::RemoteStatus s);
    void showingPasswordDialog(bool b);
    void mouseStateChanged(int x, int y, int buttonMask);
protected:
    RemoteView(QWidget *parent  /TransferThis/ = 0);
    void focusInEvent(QFocusEvent *event);
    void focusOutEvent(QFocusEvent *event);
    virtual void setStatus(RemoteStatus s);
    QCursor localDotCursor() const;
};
