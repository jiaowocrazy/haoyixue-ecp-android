# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in /Applications/adt-bundle-mac-x86_64-20140702/sdk/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
-optimizationpasses 5

-dontusemixedcaseclassnames

-dontskipnonpubliclibraryclasses

-dontskipnonpubliclibraryclassmembers
#不做预校验，可以加快混淆速度
-dontpreverify

#有了这句话，浑厚会生成映射文件
#包含有类名——>混淆后类名的映射关系
#然后使用printmapping指定映射文件名称
-verbose
-printmapping proguardMapping.txt

#指定混淆使用的算法，一般不改变
-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*

#保护代码中的Annotation不被混淆
#这在json实体映射时候十分重要
-keepattributes Signature

#抛出异常时保留行号
-keepattributes SourceFile,LineNumberTable

-keep class net.dxtek.haoyixue.ecp.android.localmodel.**{*;}
-keep class net.dxtek.haoyixue.ecp.android.model.** {*;}
-keep class net.dxtek.haoyixue.ecp.android.netmodel.** {*;}
####################################################################################################
#                                       下面是一些固定配置                                         #
####################################################################################################
# FastJson
-dontwarn com.alibaba.fastjson.**
-keep class com.alibaba.fastjson.** { *; }
-keepattributes Signature
-keepattributes *Annotation*

#保留本地有native的方法不被混淆
-keepclasseswithmembernames class * {
    native <methods>;
 }
 #保持V4包不被混淆
  -keep class android.support.v4.** { *; }
  -keep public class * extends android.support.v4.**
  -keep public class * extends android.app.Fragment

  #保留Activity中方法参数是View的方法，防止onClick被混淆
  -keepclassmembers class * extends android.app.Activity{
     public void * (android.view.View);
  }

  #枚举类不被混淆
  -keepclassmembers enum * {
     public static **[] values();
     public static ** valueOf(java.lang.String);
  }

  #保留自定义控件不被混淆
  -keep public class * extends android.view.View{
     *** get* ();
     void set* (***);
     public <init>(andorid.content.Context);
     public <init>(andorid.content.Context,android.util.AttributeSet);
     public <init>(andorid.content.Context,android.util.AttributeSet,int);
     public <init>(andorid.content.Context,android.util.AttributeSet,int,int);
  }

  #保留序列化类不被混淆
  -keep class * implements android.os.Parcelable{
     public static final android.os.Parcelable$Creator *;
  }

  #保留Serializable序列化不被混淆
  -keepclassmembers class * implements java.io.Serializable {
      static final long serialVersionUID;
      private static final java.io.ObjectStreamField[] serialPersistentFields;
      private void writeObject(java.io.ObjectOutputStream);
      private void readObject(java.io.ObjectInputStream);
      java.lang.Object writeReplace();
      java.lang.Object readResolve();
  }

  #R资源下的方法不被混淆
  -keep class **.R$* {*;}

  #带有回调的onXXEvent不能被混淆
  -keepclassmembers class * {
     void *(**On*Event);
     void *(**On*Listener);
  }
  #Glide混淆配置
  -keep public class * implements com.bumptech.glide.module.GlideModule
  -keep public enum com.bumptech.glide.load.resource.bitmap.ImageHeaderParser$** {
    **[] $VALUES;
    public *;
  }
  # webView处理，项目中没有使用到webView忽略即可
  -keepclassmembers class fqcn.of.javascript.interface.for.webview {
      *;
  }
  -keepclassmembers class * extends android.webkit.webViewClient {
      public void *(android.webkit.WebView, java.lang.String, android.graphics.Bitmap);
      public boolean *(android.webkit.WebView, java.lang.String);
  }
  -keepclassmembers class * extends android.webkit.webViewClient {
      public void *(android.webkit.webView, jav.lang.String);
  }

-keep class net.dxtek.haoyixue.ecp.android.activity.splash.LoadingActivity{*;}
