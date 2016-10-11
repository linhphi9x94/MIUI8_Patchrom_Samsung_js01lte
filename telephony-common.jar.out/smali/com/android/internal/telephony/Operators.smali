.class public Lcom/android/internal/telephony/Operators;
.super Ljava/lang/Object;
.source "Operators.java"


# static fields
.field private static stored:Ljava/lang/String;

.field private static storedOperators:Ljava/lang/String;


# instance fields
.field private unOptOperators:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 81
    sput-object v0, Lcom/android/internal/telephony/Operators;->stored:Ljava/lang/String;

    .line 82
    sput-object v0, Lcom/android/internal/telephony/Operators;->storedOperators:Ljava/lang/String;

    .line 36
    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 113
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/android/internal/telephony/Operators;->unOptOperators:Ljava/util/Map;

    .line 36
    return-void
.end method

.method private initList()Ljava/util/HashMap;
    .locals 13
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 40
    new-instance v4, Ljava/util/HashMap;

    invoke-direct {v4}, Ljava/util/HashMap;-><init>()V

    .line 43
    .local v4, "init":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    new-instance v8, Ljava/io/File;

    invoke-static {}, Landroid/os/Environment;->getRootDirectory()Ljava/io/File;

    move-result-object v10

    const-string/jumbo v11, "etc/selective-spn-conf.xml"

    invoke-direct {v8, v10, v11}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 46
    .local v8, "spnFile":Ljava/io/File;
    :try_start_0
    new-instance v9, Ljava/io/FileReader;

    invoke-direct {v9, v8}, Ljava/io/FileReader;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 54
    .local v9, "spnReader":Ljava/io/FileReader;
    :try_start_1
    invoke-static {}, Landroid/util/Xml;->newPullParser()Lorg/xmlpull/v1/XmlPullParser;

    move-result-object v7

    .line 55
    .local v7, "parser":Lorg/xmlpull/v1/XmlPullParser;
    invoke-interface {v7, v9}, Lorg/xmlpull/v1/XmlPullParser;->setInput(Ljava/io/Reader;)V

    .line 57
    const-string/jumbo v10, "spnOverrides"

    invoke-static {v7, v10}, Lcom/android/internal/util/XmlUtils;->beginDocument(Lorg/xmlpull/v1/XmlPullParser;Ljava/lang/String;)V

    .line 60
    :goto_0
    invoke-static {v7}, Lcom/android/internal/util/XmlUtils;->nextElement(Lorg/xmlpull/v1/XmlPullParser;)V

    .line 62
    invoke-interface {v7}, Lorg/xmlpull/v1/XmlPullParser;->getName()Ljava/lang/String;

    move-result-object v5

    .line 63
    .local v5, "name":Ljava/lang/String;
    const-string/jumbo v10, "spnOverride"

    invoke-virtual {v10, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    :try_end_1
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_2

    move-result v10

    if-nez v10, :cond_0

    .line 77
    .end local v5    # "name":Ljava/lang/String;
    .end local v7    # "parser":Lorg/xmlpull/v1/XmlPullParser;
    :goto_1
    return-object v4

    .line 47
    .end local v9    # "spnReader":Ljava/io/FileReader;
    :catch_0
    move-exception v1

    .line 48
    .local v1, "e":Ljava/io/FileNotFoundException;
    const-string/jumbo v10, "Operatorcheck"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v12, "Can not open "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    .line 49
    invoke-static {}, Landroid/os/Environment;->getRootDirectory()Ljava/io/File;

    move-result-object v12

    .line 48
    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v11

    .line 49
    const-string/jumbo v12, "/etc/selective-spn-conf.xml"

    .line 48
    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/telephony/Rlog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 50
    return-object v4

    .line 67
    .end local v1    # "e":Ljava/io/FileNotFoundException;
    .restart local v5    # "name":Ljava/lang/String;
    .restart local v7    # "parser":Lorg/xmlpull/v1/XmlPullParser;
    .restart local v9    # "spnReader":Ljava/io/FileReader;
    :cond_0
    :try_start_2
    const-string/jumbo v10, "numeric"

    const/4 v11, 0x0

    invoke-interface {v7, v11, v10}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 68
    .local v6, "numeric":Ljava/lang/String;
    const-string/jumbo v10, "spn"

    const/4 v11, 0x0

    invoke-interface {v7, v11, v10}, Lorg/xmlpull/v1/XmlPullParser;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 70
    .local v0, "data":Ljava/lang/String;
    invoke-virtual {v4, v6, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_2
    .catch Lorg/xmlpull/v1/XmlPullParserException; {:try_start_2 .. :try_end_2} :catch_1
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2

    goto :goto_0

    .line 72
    .end local v0    # "data":Ljava/lang/String;
    .end local v5    # "name":Ljava/lang/String;
    .end local v6    # "numeric":Ljava/lang/String;
    .end local v7    # "parser":Lorg/xmlpull/v1/XmlPullParser;
    :catch_1
    move-exception v3

    .line 73
    .local v3, "e":Lorg/xmlpull/v1/XmlPullParserException;
    const-string/jumbo v10, "Operatorcheck"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v12, "Exception in spn-conf parser "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/telephony/Rlog;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1

    .line 74
    .end local v3    # "e":Lorg/xmlpull/v1/XmlPullParserException;
    :catch_2
    move-exception v2

    .line 75
    .local v2, "e":Ljava/io/IOException;
    const-string/jumbo v10, "Operatorcheck"

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v12, "Exception in spn-conf parser "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v11}, Landroid/telephony/Rlog;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_1
.end method

.method public static operatorReplace(Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .param p0, "response"    # Ljava/lang/String;

    .prologue
    .line 87
    if-eqz p0, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v3

    const/4 v4, 0x5

    if-eq v4, v3, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v3

    const/4 v4, 0x6

    if-eq v3, v4, :cond_1

    .line 88
    :cond_0
    return-object p0

    .line 92
    :cond_1
    sget-object v3, Lcom/android/internal/telephony/Operators;->storedOperators:Ljava/lang/String;

    if-eqz v3, :cond_2

    sget-object v3, Lcom/android/internal/telephony/Operators;->stored:Ljava/lang/String;

    if-eqz v3, :cond_2

    sget-object v3, Lcom/android/internal/telephony/Operators;->stored:Ljava/lang/String;

    invoke-virtual {v3, p0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 93
    sget-object v3, Lcom/android/internal/telephony/Operators;->storedOperators:Ljava/lang/String;

    return-object v3

    .line 95
    :cond_2
    sput-object p0, Lcom/android/internal/telephony/Operators;->stored:Ljava/lang/String;

    .line 98
    :try_start_0
    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 105
    new-instance v1, Lcom/android/internal/telephony/Operators;

    invoke-direct {v1}, Lcom/android/internal/telephony/Operators;-><init>()V

    .line 106
    .local v1, "init":Lcom/android/internal/telephony/Operators;
    invoke-direct {v1}, Lcom/android/internal/telephony/Operators;->initList()Ljava/util/HashMap;

    move-result-object v2

    .line 107
    .local v2, "operators":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-interface {v2, p0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-interface {v2, p0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    :goto_0
    sput-object v3, Lcom/android/internal/telephony/Operators;->storedOperators:Ljava/lang/String;

    .line 108
    sget-object v3, Lcom/android/internal/telephony/Operators;->storedOperators:Ljava/lang/String;

    return-object v3

    .line 99
    .end local v1    # "init":Lcom/android/internal/telephony/Operators;
    .end local v2    # "operators":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    :catch_0
    move-exception v0

    .line 101
    .local v0, "E":Ljava/lang/NumberFormatException;
    sput-object p0, Lcom/android/internal/telephony/Operators;->storedOperators:Ljava/lang/String;

    .line 102
    sget-object v3, Lcom/android/internal/telephony/Operators;->storedOperators:Ljava/lang/String;

    return-object v3

    .end local v0    # "E":Ljava/lang/NumberFormatException;
    .restart local v1    # "init":Lcom/android/internal/telephony/Operators;
    .restart local v2    # "operators":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    :cond_3
    move-object v3, p0

    .line 107
    goto :goto_0
.end method


# virtual methods
.method public unOptimizedOperatorReplace(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p1, "response"    # Ljava/lang/String;

    .prologue
    .line 120
    if-eqz p1, :cond_0

    .line 121
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    const/4 v2, 0x5

    if-eq v2, v1, :cond_1

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    const/4 v2, 0x6

    if-eq v1, v2, :cond_1

    .line 122
    :cond_0
    return-object p1

    .line 127
    :cond_1
    :try_start_0
    invoke-static {p1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 133
    iget-object v1, p0, Lcom/android/internal/telephony/Operators;->unOptOperators:Ljava/util/Map;

    if-nez v1, :cond_2

    .line 134
    invoke-direct {p0}, Lcom/android/internal/telephony/Operators;->initList()Ljava/util/HashMap;

    move-result-object v1

    iput-object v1, p0, Lcom/android/internal/telephony/Operators;->unOptOperators:Ljava/util/Map;

    .line 137
    :cond_2
    iget-object v1, p0, Lcom/android/internal/telephony/Operators;->unOptOperators:Ljava/util/Map;

    invoke-interface {v1, p1}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_3

    iget-object v1, p0, Lcom/android/internal/telephony/Operators;->unOptOperators:Ljava/util/Map;

    invoke-interface {v1, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    :goto_0
    return-object v1

    .line 128
    :catch_0
    move-exception v0

    .line 130
    .local v0, "E":Ljava/lang/NumberFormatException;
    return-object p1

    .end local v0    # "E":Ljava/lang/NumberFormatException;
    :cond_3
    move-object v1, p1

    .line 137
    goto :goto_0
.end method
