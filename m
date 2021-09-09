Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC7A40490F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Sep 2021 13:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbhIILTg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 9 Sep 2021 07:19:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58478 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbhIILTf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 9 Sep 2021 07:19:35 -0400
Date:   Thu, 09 Sep 2021 11:18:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631186305;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oTTxEH8xFSQJF9A0O70Kwt77HWgnbVfMMOOrB3eogkw=;
        b=D/AlaiBDvKahiXtecxqOWnUnCRJTZay5PTPywrKhTUZDN3yX1bn6G6rqTAxPraEwfZrb52
        kDnDWLPg51P612oEbQ2PgcEJ12hM5enOKDstmECP3DyhJFWA1+Q0c5BqY28DWMEVhk7fI6
        urfDA6mefQ14VT3/9hnEpPsWi2hmweUalVQt2PjrPf5iPiZVlytatIqkC9+9WvAY5fDtcH
        nURpcSBj0FcYF2pGpzJxa26xtWYwRtRFYaYOXiY40g1m6l9I3VOrApmlelW82aHX32wjbC
        ppDl9sMlZdxgnuWrKVe8JC5+tqi1tY3ahkP1mUOk8qKySugxCsOLzuzKwWWgnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631186305;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oTTxEH8xFSQJF9A0O70Kwt77HWgnbVfMMOOrB3eogkw=;
        b=5Bqj1pOVPAf6yQWeL58or2WTrtg03Tk+n7DzvqhJxn3Jrgz+uOqWpgoNDxFObQHCbEafDN
        4VtCC3RQp1gI5fCA==
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
Message-ID: <163118630434.25758.9828481837978815456.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9964e5cf7598cbef7ebd34f8c3a760019dfb55e3
Gitweb:        https://git.kernel.org/tip/9964e5cf7598cbef7ebd34f8c3a760019dfb55e3
Author:        Li Zhijian <lizhijian@cn.fujitsu.com>
AuthorDate:    Thu, 02 Sep 2021 10:43:33 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 09 Sep 2021 11:27:32 +02:00

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
index 63fe652..1829383 100644
--- a/tools/testing/selftests/sched/cs_prctl_test.c
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -64,6 +64,17 @@ enum pid_type {PIDTYPE_PID = 0, PIDTYPE_TGID, PIDTYPE_PGID};
 
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
@@ -80,8 +91,14 @@ static int _prctl(int option, unsigned long arg2, unsigned long arg3, unsigned l
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
 
@@ -108,13 +125,6 @@ static unsigned long get_cs_cookie(int pid)
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
@@ -214,10 +224,7 @@ void _validate(int line, int val, char *msg)
 
 int main(int argc, char *argv[])
 {
-	struct child_args procs[MAX_PROCESSES];
-
 	int keypress = 0;
-	int num_processes = 2;
 	int num_threads = 3;
 	int delay = 0;
 	int res = 0;
@@ -264,6 +271,7 @@ int main(int argc, char *argv[])
 
 	printf("\n## Create a thread/process/process group hiearchy\n");
 	create_processes(num_processes, num_threads, procs);
+	need_cleanup = 1;
 	disp_processes(num_processes, procs);
 	validate(get_cs_cookie(0) == 0);
 
