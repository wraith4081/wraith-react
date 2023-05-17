import React, { createContext, useContext, useState } from "react";

const Context = createContext(undefined as any);

export const MainProvider = ({children}: {children: JSX.Element}) => {

    const [user, setUser] = useState(false);

    const data = {

        user,

        setUser

    };

    return <Context.Provider value={data}>{children}</Context.Provider>

}

export const useMain = () => useContext(Context) as {

    user: any;

    setUser: React.Dispatch<React.SetStateAction<any>>;

}
