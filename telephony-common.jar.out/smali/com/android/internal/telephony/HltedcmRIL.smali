.class public Lcom/android/internal/telephony/HltedcmRIL;
.super Lcom/android/internal/telephony/SamsungQcomRIL;
.source "HltedcmRIL.java"


# direct methods
.method public constructor <init>(Landroid/content/Context;II)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "networkMode"    # I
    .param p3, "cdmaSubscription"    # I

    .prologue
    .line 31
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, p3, v0}, Lcom/android/internal/telephony/SamsungQcomRIL;-><init>(Landroid/content/Context;IILjava/lang/Integer;)V

    .line 32
    iget-object v0, p0, Lcom/android/internal/telephony/HltedcmRIL;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 33
    const-string/jumbo v1, "mobile_data_always_on"

    const/4 v2, 0x1

    .line 32
    invoke-static {v0, v1, v2}, Landroid/provider/Settings$Global;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 30
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;IILjava/lang/Integer;)V
    .locals 3
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "preferredNetworkType"    # I
    .param p3, "cdmaSubscription"    # I
    .param p4, "instanceId"    # Ljava/lang/Integer;

    .prologue
    .line 38
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/android/internal/telephony/SamsungQcomRIL;-><init>(Landroid/content/Context;IILjava/lang/Integer;)V

    .line 39
    iget-object v0, p0, Lcom/android/internal/telephony/HltedcmRIL;->mContext:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    .line 40
    const-string/jumbo v1, "mobile_data_always_on"

    const/4 v2, 0x1

    .line 39
    invoke-static {v0, v1, v2}, Landroid/provider/Settings$Global;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    .line 37
    return-void
.end method


# virtual methods
.method public setupDataCall(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/os/Message;)V
    .locals 3
    .param p1, "radioTechnology"    # Ljava/lang/String;
    .param p2, "profile"    # Ljava/lang/String;
    .param p3, "apn"    # Ljava/lang/String;
    .param p4, "user"    # Ljava/lang/String;
    .param p5, "password"    # Ljava/lang/String;
    .param p6, "authType"    # Ljava/lang/String;
    .param p7, "protocol"    # Ljava/lang/String;
    .param p8, "result"    # Landroid/os/Message;

    .prologue
    .line 50
    invoke-super/range {p0 .. p8}, Lcom/android/internal/telephony/SamsungQcomRIL;->setupDataCall(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/os/Message;)V

    .line 54
    :try_start_0
    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v2

    add-int/lit8 v1, v2, -0x2

    .line 55
    .local v1, "prefNwType":I
    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Lcom/android/internal/telephony/HltedcmRIL;->setPreferredNetworkType(ILandroid/os/Message;)V
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 48
    .end local v1    # "prefNwType":I
    :goto_0
    return-void

    .line 56
    :catch_0
    move-exception v0

    .local v0, "nfe":Ljava/lang/NumberFormatException;
    goto :goto_0
.end method
