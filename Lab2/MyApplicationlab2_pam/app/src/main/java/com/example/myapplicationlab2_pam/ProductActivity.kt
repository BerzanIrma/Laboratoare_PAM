package com.example.myapplicationlab2_pam

import android.os.Bundle
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity

class ProductActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_product)

        val backButton = findViewById<TextView>(R.id.backButton)

        backButton.setOnClickListener {
            finish()
        }
    }
}