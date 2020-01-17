package com.kinsight.kinsightmultiplatform.kinsightandroidsharedlibrary.ViewModels.Notifications
import android.app.Activity
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.PendingIntent.FLAG_UPDATE_CURRENT
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.os.Build
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import com.kinsight.kinsightmultiplatform.kinsightandroidsharedlibrary.R

//import android.support.v4.app.NotificationManagerCompat
//import android.support.v4.app.NotificationCompat.WearableExtender

object NotificationHelper {

    /**
     * Sets up the notification channels for API 26+.
     * Note: This uses package name + channel name to create unique channelId's.
     *
     * @param context     application context
     * @param importance  importance level for the notificaiton channel
     * @param showBadge   whether the channel should have a notification badge
     * @param name        name for the notification channel
     * @param description description for the notification channel
     */
    fun createNotificationChannel(context: Context, importance: Int, showBadge: Boolean, name: String, description: String) {

        // Create the NotificationChannel, but only on API 26+ because
        // the NotificationChannel class is new and not in the support library
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channelId = "${context.packageName}-kinsight"
            val channel = NotificationChannel(channelId, name, importance)
            channel.description = description
            channel.setShowBadge(showBadge)

            // Register the channel with the system
            val notificationManager = context.getSystemService(NotificationManager::class.java)
            notificationManager.createNotificationChannel(channel)
            println("notification channel created")

            val notChannel = notificationManager.getNotificationChannel(channelId)
            println(notChannel)
        }
    }

    /**
     * Helps issue the default application channels (package name + app name) notifications.
     * @param context    current application context
     * @param title      title for the notification
     * @param message    content text for the notification when it's not expanded
     * @param bigText    long form text for the expanded notification
     * @param autoCancel `true` or `false` for auto cancelling a notification.
     * if this is true, a [PendingIntent] is attached to the notification to
     * open the application.
     */
    fun sendNotification(activity: Activity, context: Context, title: String, message: String,
                         bigText: String, autoCancel: Boolean, ideaId: Int = 0) {

        val channelId = "${context.packageName}-kinsight"

        val intent = Intent(context, activity::class.java)
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_SINGLE_TOP or Intent.FLAG_ACTIVITY_CLEAR_TOP
        // intent.flags = Intent.FLAG_ACTIVITY_CLEAR_TOP
        intent.putExtra("notificationExtra", ideaId)
        // setContentIntent(intent)
        val pendingIntent = PendingIntent.getActivity(context, 0, intent, FLAG_UPDATE_CURRENT)


        val mainAction =
            NotificationCompat.Action.Builder(
                R.drawable.ic_fish_24,
                "Open",
                pendingIntent)

                .build()

        val notificationBuilder = NotificationCompat.Builder(context, channelId).apply {
            setSmallIcon(R.drawable.ic_fish_24)
            setColor(Color.YELLOW)
           /*setLargeIcon(
               BitmapFactory.decodeResource(context.getResources(),
               R.drawable.ic_fish_24))*/
            setContentTitle(title)
            setContentText(message)
           setShowWhen(true)
           // setAutoCancel(autoCancel)
           //  setSound(defaultSoundUri)
        //    setStyle(NotificationCompat.BigTextStyle().bigText(bigText))
            priority = NotificationCompat.PRIORITY_MAX

            setAutoCancel(false)

            val wearableExtender =
                NotificationCompat.WearableExtender()

            addAction(mainAction)
            extend(wearableExtender)

           /* val actionExtender = NotificationCompat.Action.WearableExtender()
                .setHintLaunchesActivity(true)
                .setHintDisplayActionInline(true)
            wearableExtender.addAction(actionBuilder.extend(actionExtender).build())*/




           // val pendingIntent = PendingIntent.getActivity(context, 0, intent, FLAG_ACTIVITY_NEW_TASK or FLAG_ACTIVITY_SINGLE_TOP)
          //  setContentIntent(pendingIntent)
        }

        val notificationManager = NotificationManagerCompat.from(context)
        notificationManager.notify(1001, notificationBuilder.build())
    }
}