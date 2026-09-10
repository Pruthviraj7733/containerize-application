<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    java.util.Date now = new java.util.Date();
    String serverTime = new java.text.SimpleDateFormat("dd MMM yyyy, hh:mm:ss a").format(now);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DeployHub | Java Application2</title>

    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --navy: #0f1f33;
            --navy2: #162a43;
            --blue: #1976ed;
            --blue2: #2563eb;
            --text: #172033;
            --muted: #6b7280;
            --border: #e5eaf1;
            --bg: #f5f7fb;
            --green: #16a36a;
            --red: #e05252;
            --orange: #e98a15;
            --purple: #7057d9;
        }

        body {
            font-family: Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Arial, sans-serif;
            background: var(--bg);
            color: var(--text);
            min-height: 100vh;
        }

        .app { display: flex; min-height: 100vh; }

        .sidebar {
            width: 245px;
            background: linear-gradient(180deg, var(--navy), #0c1929);
            color: white;
            padding: 22px 12px;
            position: fixed;
            inset: 0 auto 0 0;
            z-index: 20;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 0 14px 28px;
        }

        .brand-icon {
            width: 45px;
            height: 45px;
            border-radius: 12px;
            display: grid;
            place-items: center;
            background: linear-gradient(135deg, #2089ff, #1557b8);
            font-size: 24px;
            font-weight: 800;
            box-shadow: 0 8px 20px rgba(20, 100, 210, .25);
        }

        .brand h2 { font-size: 20px; }
        .brand span { display: block; color: #aebbd0; font-size: 11px; margin-top: 2px; }

        .nav { display: grid; gap: 7px; }
        .nav-item {
            border: 0;
            background: transparent;
            color: #c2ccda;
            padding: 13px 16px;
            border-radius: 9px;
            display: flex;
            align-items: center;
            gap: 13px;
            font-size: 15px;
            cursor: pointer;
            text-align: left;
            width: 100%;
        }

        .nav-item:hover, .nav-item.active {
            background: linear-gradient(90deg, #1768cf, #1d5db4);
            color: white;
        }

        .nav-icon { width: 21px; text-align: center; font-size: 18px; }

        .sidebar-bottom {
            position: absolute;
            bottom: 25px;
            left: 25px;
            right: 25px;
            color: #8392a7;
            font-size: 12px;
            line-height: 1.8;
        }

        .main { margin-left: 245px; width: calc(100% - 245px); }

        .topbar {
            height: 67px;
            background: white;
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 28px;
        }

        .hamburger { font-size: 23px; color: #64748b; }
        .top-actions { display: flex; align-items: center; gap: 22px; }

        .bell {
            position: relative;
            border: 0;
            background: transparent;
            font-size: 20px;
            cursor: pointer;
        }

        .badge {
            position: absolute;
            top: -8px;
            right: -9px;
            background: #df4759;
            color: white;
            width: 17px;
            height: 17px;
            border-radius: 50%;
            font-size: 10px;
            display: grid;
            place-items: center;
        }

        .admin { display: flex; align-items: center; gap: 9px; color: #475569; }
        .avatar {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background: #dbe2eb;
            display: grid;
            place-items: center;
            font-size: 18px;
        }

        .content { padding: 29px 27px 40px; }

        .page-head {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 24px;
        }

        .page-head h1 { font-size: 29px; margin-bottom: 6px; }
        .page-head p { color: var(--muted); }

        .clock {
            background: white;
            border: 1px solid var(--border);
            padding: 12px 17px;
            border-radius: 10px;
            color: #536174;
            font-size: 13px;
        }

        .kpis {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 17px;
            margin-bottom: 18px;
        }

        .card {
            background: white;
            border: 1px solid var(--border);
            border-radius: 11px;
            box-shadow: 0 3px 13px rgba(18, 38, 63, .045);
        }

        .kpi {
            padding: 20px;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .kpi-icon {
            width: 52px;
            height: 52px;
            border-radius: 50%;
            display: grid;
            place-items: center;
            font-size: 23px;
        }

        .i-green { background: #e1f7ed; color: var(--green); }
        .i-blue { background: #e4efff; color: var(--blue); }
        .i-orange { background: #fff0d8; color: var(--orange); }
        .i-red { background: #ffe5e8; color: var(--red); }

        .kpi strong { font-size: 28px; display: block; }
        .kpi span { color: var(--muted); font-size: 13px; }

        .layout {
            display: grid;
            grid-template-columns: 1.75fr 1fr;
            gap: 18px;
        }

        .section { padding: 20px; margin-bottom: 18px; }
        .section-title {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 17px;
        }

        .section-title h2 { font-size: 18px; }
        .section-title a { color: var(--blue); font-size: 13px; cursor: pointer; }

        .actions { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }

        .action {
            border: 0;
            color: white;
            border-radius: 8px;
            padding: 14px;
            font-size: 14px;
            cursor: pointer;
            font-weight: 600;
        }

        .action:hover { filter: brightness(.95); transform: translateY(-1px); }
        .a-blue { background: #1d6fe5; }
        .a-green { background: #18a56a; }
        .a-purple { background: #6b50d5; }
        .a-gray { background: #68788d; }

        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 13px 8px; text-align: left; border-bottom: 1px solid #edf0f4; font-size: 13px; }
        th { color: #667085; font-weight: 600; }
        td { color: #344054; }

        .pill {
            display: inline-block;
            padding: 5px 9px;
            border-radius: 14px;
            font-size: 11px;
            font-weight: 700;
        }

        .success { background: #dff6eb; color: #147d54; }
        .failed { background: #ffe2e4; color: #bd3842; }
        .running { background: #dfeeff; color: #1766c4; }

        .pipeline {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 8px;
        }

        .stage { text-align: center; flex: 1; }
        .stage-icon {
            width: 48px;
            height: 48px;
            margin: auto;
            border-radius: 50%;
            display: grid;
            place-items: center;
            color: white;
            font-size: 20px;
        }

        .git { background: #e0445c; }
        .jenkins { background: #2676d9; }
        .docker { background: #6754d8; }
        .deploy { background: #159c68; }

        .stage b { display: block; font-size: 12px; margin-top: 8px; }
        .stage small { color: #7b8798; font-size: 10px; }
        .arrow { color: #9aa5b4; font-size: 21px; }

        .status-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 11px 0;
            border-bottom: 1px solid #edf0f4;
            font-size: 13px;
        }

        .status-name { display: flex; align-items: center; gap: 9px; }
        .dot { width: 10px; height: 10px; border-radius: 50%; background: #19a66b; }

        .progress-row { margin: 16px 0; }
        .progress-label { display: flex; justify-content: space-between; font-size: 12px; margin-bottom: 7px; }
        .bar { height: 7px; background: #e8edf3; border-radius: 10px; overflow: hidden; }
        .fill { height: 100%; border-radius: inherit; }
        .blue-fill { width: 32%; background: #2676d9; }
        .green-fill { width: 48%; background: #18a56a; }
        .orange-fill { width: 62%; background: #e49320; }

        .modal-overlay {
            position: fixed;
            inset: 0;
            background: rgba(15, 31, 51, .48);
            backdrop-filter: blur(4px);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 100;
            padding: 20px;
        }

        .modal-overlay.show { display: flex; animation: fadeIn .2s ease; }

        .modal {
            width: 100%;
            max-width: 510px;
            background: white;
            border-radius: 14px;
            padding: 30px;
            position: relative;
            box-shadow: 0 25px 70px rgba(0,0,0,.22);
            animation: pop .22s ease;
        }

        .close {
            position: absolute;
            right: 18px;
            top: 14px;
            border: 0;
            background: transparent;
            color: #8994a5;
            font-size: 27px;
            cursor: pointer;
        }

        .check {
            width: 65px;
            height: 65px;
            background: #19ae70;
            color: white;
            border-radius: 50%;
            display: grid;
            place-items: center;
            margin: 0 auto 17px;
            font-size: 34px;
            font-weight: bold;
        }

        .modal h2 { text-align: center; font-size: 23px; }
        .modal-sub { text-align: center; color: #667085; margin: 8px 0 22px; font-size: 14px; }

        .details {
            background: #f6f8fb;
            border-radius: 9px;
            padding: 13px 17px;
        }

        .detail {
            display: grid;
            grid-template-columns: 130px 1fr;
            gap: 10px;
            padding: 9px 0;
            border-bottom: 1px solid #e7ebf0;
            font-size: 13px;
        }

        .detail:last-child { border-bottom: 0; }
        .detail label { color: #667085; }
        .detail b { color: #344054; }

        .modal-btn {
            width: 100%;
            margin-top: 20px;
            border: 0;
            background: #1976ed;
            color: white;
            padding: 13px;
            border-radius: 8px;
            font-weight: 700;
            cursor: pointer;
        }

        .toast {
            position: fixed;
            left: 28px;
            bottom: 27px;
            background: white;
            border: 1px solid #e4e8ee;
            box-shadow: 0 12px 30px rgba(0,0,0,.14);
            border-radius: 10px;
            padding: 15px 18px;
            display: flex;
            align-items: center;
            gap: 12px;
            transform: translateY(130px);
            opacity: 0;
            transition: .3s ease;
            z-index: 120;
            font-size: 14px;
        }

        .toast.show { transform: translateY(0); opacity: 1; }
        .toast-check {
            width: 30px; height: 30px; border-radius: 50%;
            display: grid; place-items: center; background: #dff6eb; color: #159c68;
            font-weight: bold;
        }

        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
        @keyframes pop { from { transform: scale(.93); opacity: 0; } to { transform: scale(1); opacity: 1; } }

        @media (max-width: 1050px) {
            .kpis { grid-template-columns: 1fr 1fr; }
            .layout { grid-template-columns: 1fr; }
        }

        @media (max-width: 750px) {
            .sidebar { width: 70px; }
            .brand h2, .brand span, .nav-item span:not(.nav-icon), .sidebar-bottom { display: none; }
            .brand { padding: 0 0 28px; justify-content: center; }
            .main { margin-left: 70px; width: calc(100% - 70px); }
            .nav-item { justify-content: center; padding: 13px 5px; }
            .kpis { grid-template-columns: 1fr; }
            .page-head { display: block; }
            .clock { margin-top: 15px; display: inline-block; }
            .pipeline { flex-wrap: wrap; }
            .arrow { display: none; }
        }
    </style>
</head>

<body>

<div class="app">

    <aside class="sidebar">
        <div class="brand">
            <div class="brand-icon">◇</div>
            <div>
                <h2>DeployHub</h2>
                <span>Java Web Application</span>
            </div>
        </div>

        <nav class="nav">
            <button class="nav-item active"><span class="nav-icon">⌂</span><span>Dashboard</span></button>
            <button class="nav-item" onclick="showToast('Applications section selected')"><span class="nav-icon">◈</span><span>Applications</span></button>
            <button class="nav-item" onclick="openModal()"><span class="nav-icon">🚀</span><span>Deployments</span></button>
            <button class="nav-item" onclick="showToast('All servers are healthy')"><span class="nav-icon">▤</span><span>Servers</span></button>
            <button class="nav-item" onclick="showToast('Application logs are available')"><span class="nav-icon">▧</span><span>Logs</span></button>
            <button class="nav-item" onclick="showToast('Settings opened')"><span class="nav-icon">⚙</span><span>Settings</span></button>
        </nav>

        <div class="sidebar-bottom">
            <div>✦ Built with ♥</div>
            <div>Java | Tomcat | Docker | Jenkins</div>
        </div>
    </aside>

    <main class="main">

        <header class="topbar">
            <div class="hamburger">☰</div>
            <div class="top-actions">
                <button class="bell" onclick="showToast('You have 3 notifications')">
                    🔔 <span class="badge">3</span>
                </button>
                <div class="admin">
                    <div class="avatar">●</div>
                    <span>Admin⌄</span>
                </div>
            </div>
        </header>

        <section class="content">

            <div class="page-head">
                <div>
                    <h1>Welcome to DeployHub 👋</h1>
                    <p>Manage and monitor your Java application deployment.</p>
                </div>
                <div class="clock">🗓 <%= serverTime %></div>
            </div>

            <div class="kpis">
                <div class="card kpi">
                    <div class="kpi-icon i-green">◈</div>
                    <div><strong>1</strong><span>Total Applications</span></div>
                </div>

                <div class="card kpi">
                    <div class="kpi-icon i-blue">🚀</div>
                    <div><strong>5</strong><span>Total Deployments</span></div>
                </div>

                <div class="card kpi">
                    <div class="kpi-icon i-orange">▤</div>
                    <div><strong>3</strong><span>Active Servers</span></div>
                </div>

                <div class="card kpi">
                    <div class="kpi-icon i-red">◷</div>
                    <div><strong>100%</strong><span>Uptime</span></div>
                </div>
            </div>

            <div class="layout">

                <div>

                    <div class="card section">
                        <div class="section-title">
                            <h2>Quick Actions</h2>
                            <a onclick="showToast('Dashboard refreshed successfully')">Refresh</a>
                        </div>

                        <div class="actions">
                            <button class="action a-blue" onclick="openModal()">▶ Deploy Application</button>
                            <button class="action a-green" onclick="showToast('Application creation wizard opened')">＋ Add Application</button>
                            <button class="action a-purple" onclick="showToast('Showing latest application logs')">▧ View Logs</button>
                            <button class="action a-gray" onclick="showToast('Settings opened')">⚙ Settings</button>
                        </div>
                    </div>

                    <div class="card section">
                        <div class="section-title">
                            <h2>Recent Deployments</h2>
                            <a onclick="showToast('Showing all deployments')">View All Deployments →</a>
                        </div>

                        <table>
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Application</th>
                                    <th>Build</th>
                                    <th>Status</th>
                                    <th>Date</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>1</td><td>java-application</td><td>#25</td>
                                    <td><span class="pill success">Success</span></td><td>10 Sep 2026</td>
                                    <td><button onclick="openModal()" style="border:0;background:#e7f0ff;color:#1766c4;padding:6px 10px;border-radius:6px;cursor:pointer;">View</button></td>
                                </tr>
                                <tr>
                                    <td>2</td><td>java-application</td><td>#24</td>
                                    <td><span class="pill success">Success</span></td><td>09 Sep 2026</td>
                                    <td><button onclick="showToast('Build #24 details loaded')" style="border:0;background:#e7f0ff;color:#1766c4;padding:6px 10px;border-radius:6px;cursor:pointer;">View</button></td>
                                </tr>
                                <tr>
                                    <td>3</td><td>java-application</td><td>#23</td>
                                    <td><span class="pill failed">Failed</span></td><td>09 Sep 2026</td>
                                    <td><button onclick="showToast('Build #23 logs loaded')" style="border:0;background:#e7f0ff;color:#1766c4;padding:6px 10px;border-radius:6px;cursor:pointer;">View</button></td>
                                </tr>
                                <tr>
                                    <td>4</td><td>java-application</td><td>#22</td>
                                    <td><span class="pill success">Success</span></td><td>08 Sep 2026</td>
                                    <td><button onclick="showToast('Build #22 details loaded')" style="border:0;background:#e7f0ff;color:#1766c4;padding:6px 10px;border-radius:6px;cursor:pointer;">View</button></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                </div>

                <div>

                    <div class="card section">
                        <div class="section-title"><h2>Deployment Pipeline</h2></div>

                        <div class="pipeline">
                            <div class="stage">
                                <div class="stage-icon git">◆</div>
                                <b>Git</b><small>Code Push</small>
                            </div>
                            <div class="arrow">→</div>
                            <div class="stage">
                                <div class="stage-icon jenkins">♞</div>
                                <b>Jenkins</b><small>Build & Test</small>
                            </div>
                            <div class="arrow">→</div>
                            <div class="stage">
                                <div class="stage-icon docker">◇</div>
                                <b>Docker</b><small>Build Image</small>
                            </div>
                            <div class="arrow">→</div>
                            <div class="stage">
                                <div class="stage-icon deploy">▤</div>
                                <b>Deploy</b><small>Run Container</small>
                            </div>
                        </div>
                    </div>

                    <div class="card section">
                        <div class="section-title"><h2>System Status</h2></div>

                        <div class="status-row"><div class="status-name"><span class="dot"></span>Tomcat</div><span class="pill success">Running</span></div>
                        <div class="status-row"><div class="status-name"><span class="dot"></span>Docker</div><span class="pill success">Running</span></div>
                        <div class="status-row"><div class="status-name"><span class="dot"></span>Jenkins</div><span class="pill success">Running</span></div>
                        <div class="status-row"><div class="status-name"><span class="dot"></span>Application</div><span class="pill success">Running</span></div>
                    </div>

                    <div class="card section">
                        <div class="section-title"><h2>Resource Usage</h2></div>

                        <div class="progress-row">
                            <div class="progress-label"><span>CPU Usage</span><b>32%</b></div>
                            <div class="bar"><div class="fill blue-fill"></div></div>
                        </div>

                        <div class="progress-row">
                            <div class="progress-label"><span>Memory Usage</span><b>48%</b></div>
                            <div class="bar"><div class="fill green-fill"></div></div>
                        </div>

                        <div class="progress-row">
                            <div class="progress-label"><span>Disk Usage</span><b>62%</b></div>
                            <div class="bar"><div class="fill orange-fill"></div></div>
                        </div>
                    </div>

                </div>
            </div>

            <footer style="text-align:right;color:#8994a5;font-size:12px;margin-top:8px;">
                © 2026 DeployHub. Java + Tomcat + Docker + Jenkins.
            </footer>

        </section>
    </main>
</div>

<!-- Deployment success popup -->
<div class="modal-overlay" id="deployModal" onclick="closeIfOutside(event)">
    <div class="modal">
        <button class="close" onclick="closeModal()">×</button>

        <div class="check">✓</div>

        <h2>Deployment Successful!</h2>
        <p class="modal-sub">Your application has been successfully built and deployed.</p>

        <div class="details">
            <div class="detail"><label>Application</label><b>java-application</b></div>
            <div class="detail"><label>Build Number</label><b>#25</b></div>
            <div class="detail"><label>Status</label><b style="color:#159c68;">● Running</b></div>
            <div class="detail"><label>Server</label><b>Apache Tomcat 10</b></div>
            <div class="detail"><label>Container</label><b>myapplication</b></div>
            <div class="detail"><label>Port</label><b>9090 → 8080</b></div>
            <div class="detail"><label>Deployed At</label><b><%= serverTime %></b></div>
            <div class="detail"><label>Access URL</label><b style="color:#1766c4;">http://EC2-IP:9090/java-application/</b></div>
        </div>

        <button class="modal-btn" onclick="closeModal()">OK</button>
    </div>
</div>

<!-- Toast notification -->
<div class="toast" id="toast">
    <div class="toast-check">✓</div>
    <div id="toastText">Application deployed successfully!</div>
</div>

<script>
    function openModal() {
        document.getElementById("deployModal").classList.add("show");
    }

    function closeModal() {
        document.getElementById("deployModal").classList.remove("show");
    }

    function closeIfOutside(event) {
        if (event.target.id === "deployModal") closeModal();
    }

    function showToast(message) {
        const toast = document.getElementById("toast");
        document.getElementById("toastText").textContent = message;
        toast.classList.add("show");

        clearTimeout(window.toastTimer);
        window.toastTimer = setTimeout(function () {
            toast.classList.remove("show");
        }, 2800);
    }

    document.addEventListener("keydown", function(event) {
        if (event.key === "Escape") closeModal();
    });

    window.addEventListener("load", function() {
        setTimeout(function() {
            showToast("Application deployed successfully");
        }, 900);
    });
</script>

</body>
</html>
