import { useMain } from "context/Main";
import { Navigate } from "react-router-dom";
import url from "utils/url";
import toast from "react-hot-toast";

export default function PrivateRoute({ children }: { children: JSX.Element }) {
    /*
    const { user } = useMain();

    if (!user) {
        toast.error("403");
        return <Navigate to={url('home')} />
    }
    */

    return children;
}
