package com.example.myapplicationlab2_pam

import android.content.Intent
import android.os.Bundle
import android.widget.LinearLayout
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_main)

        val sportwearProduct = findViewById<LinearLayout>(R.id.sportwearProduct)

        sportwearProduct.setOnClickListener {
            val intent = Intent(this, ProductActivity::class.java)
            startActivity(intent)
        }
    }
}