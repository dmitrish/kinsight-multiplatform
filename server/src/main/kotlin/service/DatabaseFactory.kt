package kinsight.server.api.service

import com.zaxxer.hikari.HikariConfig
import com.zaxxer.hikari.HikariDataSource
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import kinsight.server.api.model.*
import org.jetbrains.exposed.sql.Database
import org.jetbrains.exposed.sql.SchemaUtils.create
import org.jetbrains.exposed.sql.insert
import org.jetbrains.exposed.sql.transactions.transaction

object DatabaseFactory {

    fun init() {
        // Database.connect("jdbc:h2:mem:test;DB_CLOSE_DELAY=-1", driver = "org.h2.Driver")
        Database.connect(hikari())
        transaction {
            create(Widgets)
            create(WidgetDetails)
            Widgets.insert {
                it[name] = "widget one"
                it[quantity] = 27
                it[dateUpdated] = System.currentTimeMillis()
            }
            Widgets.insert {
                it[name] = "widget two"
                it[quantity] = 14
                it[dateUpdated] = System.currentTimeMillis()
            }

            WidgetDetails.insert {
                it[name] = "widget details one"
                it[quantity] = 1
                it[dateUpdated] = System.currentTimeMillis()
            }

        }
    }

    private fun hikari(): HikariDataSource {
        val config = HikariConfig()


        config.driverClassName = "org.h2.Driver"
        config.jdbcUrl = "jdbc:h2:mem:test"


/*
        config.driverClassName = "com.mysql.jdbc.GoogleDriver" //"org.h2.Driver"
        config.jdbcUrl = "jdbc:google:mysql://project-kinsight:us-east1:tradeideas2019"//"jdbc:h2:mem:test"
        config.username = ""
        config.password = ""
        config.isRegisterMbeans = false
//config.dataSource = "TIData"
*/
        config.maximumPoolSize = 3
        config.isAutoCommit = false
        config.transactionIsolation = "TRANSACTION_REPEATABLE_READ"




        config.validate()
        return HikariDataSource(config)
    }

    suspend fun <T> dbQuery(
        block: () -> T): T =
        withContext(Dispatchers.IO) {
            transaction { block() }
        }

}