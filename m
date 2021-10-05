Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9891E422A72
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 16:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbhJEOOc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 10:14:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51268 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235648AbhJEOOD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 10:14:03 -0400
Date:   Tue, 05 Oct 2021 14:12:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443131;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pft8RC9sDr1zdCAVElwNR8jLhF6DQlshfdTSfFVM+R4=;
        b=f73WclyEZf1Z1974/7iyW2Ww+rqS/QSPGIHDFfaWeyTSF/fIw3kZmD7iO9dhnrQPa7K+xf
        KGLa6BTnQtX4tbCq7wyYox6Ft5uwy+KwUJQ3Mk75sjgH1faiRKfHRxrx0L/AlWn7Rt2ogZ
        tcB8DVga0LyX+KS7C9dAoCR3hS2ai463gsHf9gvQoPA9EymJkXmuS/Yhqq6ZgRQ1hgJYqj
        O5EjG3hNOpXYOmbx3ocS+eC28DuMBwHa95ucMZZ6r2tXr2XbTSD5AgN5QU2Gt0Pd0/kxAW
        mbgjABJjjQWDAo/ArLWiEkYJWzVQjzq+fv3UslGcYFeQ4fb8eYJhICiGF5DijQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443131;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pft8RC9sDr1zdCAVElwNR8jLhF6DQlshfdTSfFVM+R4=;
        b=aM/MImgksFcIHMMrw+/l+8whVPMQdV7s22GhI94Ay7F83Wb3ekwmNSql3nx+cLua34Rs0j
        N1lKIaSntl2TY/AQ==
From:   "tip-bot2 for Li Zhijian" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] kselftests/sched: cleanup the child processes
Cc:     kernel test robot <lkp@intel.com>,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris Hyser <chris.hyser@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210902024333.75983-1-lizhijian@cn.fujitsu.com>
References: <20210902024333.75983-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Message-ID: <163344313095.25758.4677858848460758653.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1c36432b278cecf1499f21fae19836e614954309
Gitweb:        https://git.kernel.org/tip/1c36432b278cecf1499f21fae19836e614954309
Author:        Li Zhijian <lizhijian@cn.fujitsu.com>
AuthorDate:    Thu, 02 Sep 2021 10:43:33 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Oct 2021 15:51:43 +02:00

kselftests/sched: cleanup the child processes

Previously, 'make -C sched run_tests' will block forever when it occurs
something wrong where the *selftests framework* is waiting for its child
processes to exit.

[root@iaas-rpma sched]# ./cs_prctl_test

 ## Create a thread/process/process group hiearchy
Not a core sched system
tid=74985, / tgid=74985 / pgid=74985: ffffffffffffffff
Not a core sched system
    tid=74986, / tgid=74986 / pgid=74985: ffffffffffffffff
Not a core sched system
        tid=74988, / tgid=74986 / pgid=74985: ffffffffffffffff
Not a core sched system
        tid=74989, / tgid=74986 / pgid=74985: ffffffffffffffff
Not a core sched system
        tid=74990, / tgid=74986 / pgid=74985: ffffffffffffffff
Not a core sched system
    tid=74987, / tgid=74987 / pgid=74985: ffffffffffffffff
Not a core sched system
        tid=74991, / tgid=74987 / pgid=74985: ffffffffffffffff
Not a core sched system
        tid=74992, / tgid=74987 / pgid=74985: ffffffffffffffff
Not a core sched system
        tid=74993, / tgid=74987 / pgid=74985: ffffffffffffffff

Not a core sched system
(268) FAILED: get_cs_cookie(0) == 0

 ## Set a cookie on entire process group
-1 = prctl(62, 1, 0, 2, 0)
core_sched create failed -- PGID: Invalid argument
(cs_prctl_test.c:272) -
[root@iaas-rpma sched]# ps
    PID TTY          TIME CMD
   4605 pts/2    00:00:00 bash
  74986 pts/2    00:00:00 cs_prctl_test
  74987 pts/2    00:00:00 cs_prctl_test
  74999 pts/2    00:00:00 ps

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Chris Hyser <chris.hyser@oracle.com>
Link: https://lore.kernel.org/r/20210902024333.75983-1-lizhijian@cn.fujitsu.com
---
 tools/testing/selftests/sched/cs_prctl_test.c | 28 +++++++++++-------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
index 7db9cf8..8109b17 100644
--- a/tools/testing/selftests/sched/cs_prctl_test.c
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -62,6 +62,17 @@ enum pid_type {PIDTYPE_PID = 0, PIDTYPE_TGID, PIDTYPE_PGID};
 
 const int THREAD_CLONE_FLAGS = CLONE_THREAD | CLONE_SIGHAND | CLONE_FS | CLONE_VM | CLONE_FILES;
 
+struct child_args {
+	int num_threads;
+	int pfd[2];
+	int cpid;
+	int thr_tids[MAX_THREADS];
+};
+
+static struct child_args procs[MAX_PROCESSES];
+static int num_processes = 2;
+static int need_cleanup = 0;
+
 static int _prctl(int option, unsigned long arg2, unsigned long arg3, unsigned long arg4,
 		  unsigned long arg5)
 {
@@ -78,8 +89,14 @@ static int _prctl(int option, unsigned long arg2, unsigned long arg3, unsigned l
 #define handle_error(msg) __handle_error(__FILE__, __LINE__, msg)
 static void __handle_error(char *fn, int ln, char *msg)
 {
+	int pidx;
 	printf("(%s:%d) - ", fn, ln);
 	perror(msg);
+	if (need_cleanup) {
+		for (pidx = 0; pidx < num_processes; ++pidx)
+			kill(procs[pidx].cpid, 15);
+		need_cleanup = 0;
+	}
 	exit(EXIT_FAILURE);
 }
 
@@ -106,13 +123,6 @@ static unsigned long get_cs_cookie(int pid)
 	return cookie;
 }
 
-struct child_args {
-	int num_threads;
-	int pfd[2];
-	int cpid;
-	int thr_tids[MAX_THREADS];
-};
-
 static int child_func_thread(void __attribute__((unused))*arg)
 {
 	while (1)
@@ -212,10 +222,7 @@ void _validate(int line, int val, char *msg)
 
 int main(int argc, char *argv[])
 {
-	struct child_args procs[MAX_PROCESSES];
-
 	int keypress = 0;
-	int num_processes = 2;
 	int num_threads = 3;
 	int delay = 0;
 	int res = 0;
@@ -262,6 +269,7 @@ int main(int argc, char *argv[])
 
 	printf("\n## Create a thread/process/process group hiearchy\n");
 	create_processes(num_processes, num_threads, procs);
+	need_cleanup = 1;
 	disp_processes(num_processes, procs);
 	validate(get_cs_cookie(0) == 0);
 
