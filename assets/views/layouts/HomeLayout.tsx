import React from 'react'
import { Outlet } from 'react-router-dom'
import Footer from 'views/Footer'
import Header from 'views/Header'

function HomeLayout() {
    return (
        <div>
            <Header />
            <main>
                <Outlet />
            </main>
            <Footer />
        </div>
    )
}

export default HomeLayout
