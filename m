Return-Path: <linux-tip-commits+bounces-3139-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E439FC17F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 19:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33FE1884A18
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 18:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3E121324B;
	Tue, 24 Dec 2024 18:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MZdcYeUP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NAiZIkj2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01835212F9D;
	Tue, 24 Dec 2024 18:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735066483; cv=none; b=Pxb0tk9/D4tZ17M8oOg0O0aN3Q5vWpR+N7U91z8N53rSAK8LgnkFI1QX6+HgUwpxPqiMTAf/dJGyUJSLGu/acs3adMGlKgJAjlj5hztt/LyLImLNWK0e/ysTXeJmodbn1yanPngpiO+gHpAWSZG649uFCBytbtmEVrLOvKn8WqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735066483; c=relaxed/simple;
	bh=p/CrTdD7XoTw1kaiWw9uOZXhxsOla4uEq0CbGu1Dhs4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=i2HwiraFMHx4jRfWNvwq+EVsTIALzPDdHXK3PpRUQzYGxZmKZFx7G8WX2wnBwHDuPdphsysOALD1JePtGBzjxIrsFM6KF75qO6qmw0JUZLgsuDobqDbKTGG/u+ulty/zf7vOiLoJhjkbeTeSvPY1Qlj9yDnHiyFTQ7p+MCHomrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MZdcYeUP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NAiZIkj2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 18:54:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735066479;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GPAljFROjaGd+vem33goFCcAz89+7XiekumOnNBFt7w=;
	b=MZdcYeUPqi7RJ40C/3KzBfdiw7i+zoQNseCmS4tZuX7KunVnvX5Gs/8IMIMKT9Fmnm9lRx
	uBr6KIC5VH5NgNFN9TUsCCexA/jkc89A584skFbwiI5rCGwaxz19voSfbbci0V86eC4QZO
	Td40VxqYQirZObCsviwYiAPPkWuwhEkPvAh6yFO+Ch31fiajHSA6Rjks9eI7KwjvuvhG8j
	N/A4RkUHvT0/BwtiewVo6mc7U1o26Abc+KkjXqrEQjyyZKSXYt4EeEMfQ0jplYrybxFokE
	aYw4g+ZsQVZHxzpFZgfjCTZlPMCi+gAY3ucNqKvtANyF6Z65KJy8nrUU5nIwvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735066479;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GPAljFROjaGd+vem33goFCcAz89+7XiekumOnNBFt7w=;
	b=NAiZIkj2nI++GN3JuL9iaxolpfK1DjNqoBKc/JiiOm6h7eLoiVevwL7lYo92yj3ER3fzho
	mS01lsN82/+2lPAQ==
From: "tip-bot2 for Swapnil Sapkal" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] docs: Update Schedstat version to 17
Cc: Swapnil Sapkal <swapnil.sapkal@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241220063224.17767-7-swapnil.sapkal@amd.com>
References: <20241220063224.17767-7-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173506647883.399.6518170303000515262.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7c8cd569ff66755f17b0c0c03a9d8df1b6f3e9ed
Gitweb:        https://git.kernel.org/tip/7c8cd569ff66755f17b0c0c03a9d8df1b6f3e9ed
Author:        Swapnil Sapkal <swapnil.sapkal@amd.com>
AuthorDate:    Fri, 20 Dec 2024 06:32:24 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Dec 2024 15:31:18 +01:00

docs: Update Schedstat version to 17

Update the Schedstat version to 17 as more fields are added to report
different kinds of imbalances in the sched domain. Also domain field
started printing corresponding domain name.

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241220063224.17767-7-swapnil.sapkal@amd.com
---
 Documentation/scheduler/sched-stats.rst | 126 +++++++++++++----------
 kernel/sched/stats.c                    |   2 +-
 2 files changed, 76 insertions(+), 52 deletions(-)

diff --git a/Documentation/scheduler/sched-stats.rst b/Documentation/scheduler/sched-stats.rst
index 7c2b16c..caea83d 100644
--- a/Documentation/scheduler/sched-stats.rst
+++ b/Documentation/scheduler/sched-stats.rst
@@ -2,6 +2,12 @@
 Scheduler Statistics
 ====================
 
+Version 17 of schedstats removed 'lb_imbalance' field as it has no
+significance anymore and instead added more relevant fields namely
+'lb_imbalance_load', 'lb_imbalance_util', 'lb_imbalance_task' and
+'lb_imbalance_misfit'. The domain field prints the name of the
+corresponding sched domain from this version onwards.
+
 Version 16 of schedstats changed the order of definitions within
 'enum cpu_idle_type', which changed the order of [CPU_MAX_IDLE_TYPES]
 columns in show_schedstat(). In particular the position of CPU_IDLE
@@ -9,7 +15,9 @@ and __CPU_NOT_IDLE changed places. The size of the array is unchanged.
 
 Version 15 of schedstats dropped counters for some sched_yield:
 yld_exp_empty, yld_act_empty and yld_both_empty. Otherwise, it is
-identical to version 14.
+identical to version 14. Details are available at
+
+	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/scheduler/sched-stats.txt?id=1e1dbb259c79b
 
 Version 14 of schedstats includes support for sched_domains, which hit the
 mainline kernel in 2.6.20 although it is identical to the stats from version
@@ -26,7 +34,14 @@ cpus on the machine, while domain0 is the most tightly focused domain,
 sometimes balancing only between pairs of cpus.  At this time, there
 are no architectures which need more than three domain levels. The first
 field in the domain stats is a bit map indicating which cpus are affected
-by that domain.
+by that domain. Details are available at
+
+	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/sched-stats.txt?id=b762f3ffb797c
+
+The schedstat documentation is maintained version 10 onwards and is not
+updated for version 11 and 12. The details for version 10 are available at
+
+	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/sched-stats.txt?id=1da177e4c3f4
 
 These fields are counters, and only increment.  Programs which make use
 of these will need to start with a baseline observation and then calculate
@@ -71,88 +86,97 @@ Domain statistics
 -----------------
 One of these is produced per domain for each cpu described. (Note that if
 CONFIG_SMP is not defined, *no* domains are utilized and these lines
-will not appear in the output.)
+will not appear in the output. <name> is an extension to the domain field
+that prints the name of the corresponding sched domain. It can appear in
+schedstat version 17 and above, and requires CONFIG_SCHED_DEBUG.)
 
-domain<N> <cpumask> 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36
+domain<N> <name> <cpumask> 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45
 
 The first field is a bit mask indicating what cpus this domain operates over.
 
-The next 24 are a variety of sched_balance_rq() statistics in grouped into types
-of idleness (idle, busy, and newly idle):
+The next 33 are a variety of sched_balance_rq() statistics in grouped into types
+of idleness (busy, idle and newly idle):
 
     1)  # of times in this domain sched_balance_rq() was called when the
+        cpu was busy
+    2)  # of times in this domain sched_balance_rq() checked but found the
+        load did not require balancing when busy
+    3)  # of times in this domain sched_balance_rq() tried to move one or
+        more tasks and failed, when the cpu was busy
+    4)  Total imbalance in load when the cpu was busy
+    5)  Total imbalance in utilization when the cpu was busy
+    6)  Total imbalance in number of tasks when the cpu was busy
+    7)  Total imbalance due to misfit tasks when the cpu was busy
+    8)  # of times in this domain pull_task() was called when busy
+    9)  # of times in this domain pull_task() was called even though the
+        target task was cache-hot when busy
+    10) # of times in this domain sched_balance_rq() was called but did not
+        find a busier queue while the cpu was busy
+    11) # of times in this domain a busier queue was found while the cpu
+        was busy but no busier group was found
+
+    12) # of times in this domain sched_balance_rq() was called when the
         cpu was idle
-    2)  # of times in this domain sched_balance_rq() checked but found
+    13) # of times in this domain sched_balance_rq() checked but found
         the load did not require balancing when the cpu was idle
-    3)  # of times in this domain sched_balance_rq() tried to move one or
+    14) # of times in this domain sched_balance_rq() tried to move one or
         more tasks and failed, when the cpu was idle
-    4)  sum of imbalances discovered (if any) with each call to
-        sched_balance_rq() in this domain when the cpu was idle
-    5)  # of times in this domain pull_task() was called when the cpu
+    15) Total imbalance in load when the cpu was idle
+    16) Total imbalance in utilization when the cpu was idle
+    17) Total imbalance in number of tasks when the cpu was idle
+    18) Total imbalance due to misfit tasks when the cpu was idle
+    19) # of times in this domain pull_task() was called when the cpu
         was idle
-    6)  # of times in this domain pull_task() was called even though
+    20) # of times in this domain pull_task() was called even though
         the target task was cache-hot when idle
-    7)  # of times in this domain sched_balance_rq() was called but did
+    21) # of times in this domain sched_balance_rq() was called but did
         not find a busier queue while the cpu was idle
-    8)  # of times in this domain a busier queue was found while the
+    22) # of times in this domain a busier queue was found while the
         cpu was idle but no busier group was found
-    9)  # of times in this domain sched_balance_rq() was called when the
-        cpu was busy
-    10) # of times in this domain sched_balance_rq() checked but found the
-        load did not require balancing when busy
-    11) # of times in this domain sched_balance_rq() tried to move one or
-        more tasks and failed, when the cpu was busy
-    12) sum of imbalances discovered (if any) with each call to
-        sched_balance_rq() in this domain when the cpu was busy
-    13) # of times in this domain pull_task() was called when busy
-    14) # of times in this domain pull_task() was called even though the
-        target task was cache-hot when busy
-    15) # of times in this domain sched_balance_rq() was called but did not
-        find a busier queue while the cpu was busy
-    16) # of times in this domain a busier queue was found while the cpu
-        was busy but no busier group was found
 
-    17) # of times in this domain sched_balance_rq() was called when the
-        cpu was just becoming idle
-    18) # of times in this domain sched_balance_rq() checked but found the
+    23) # of times in this domain sched_balance_rq() was called when the
+        was just becoming idle
+    24) # of times in this domain sched_balance_rq() checked but found the
         load did not require balancing when the cpu was just becoming idle
-    19) # of times in this domain sched_balance_rq() tried to move one or more
+    25) # of times in this domain sched_balance_rq() tried to move one or more
         tasks and failed, when the cpu was just becoming idle
-    20) sum of imbalances discovered (if any) with each call to
-        sched_balance_rq() in this domain when the cpu was just becoming idle
-    21) # of times in this domain pull_task() was called when newly idle
-    22) # of times in this domain pull_task() was called even though the
+    26) Total imbalance in load when the cpu was just becoming idle
+    27) Total imbalance in utilization when the cpu was just becoming idle
+    28) Total imbalance in number of tasks when the cpu was just becoming idle
+    29) Total imbalance due to misfit tasks when the cpu was just becoming idle
+    30) # of times in this domain pull_task() was called when newly idle
+    31) # of times in this domain pull_task() was called even though the
         target task was cache-hot when just becoming idle
-    23) # of times in this domain sched_balance_rq() was called but did not
+    32) # of times in this domain sched_balance_rq() was called but did not
         find a busier queue while the cpu was just becoming idle
-    24) # of times in this domain a busier queue was found while the cpu
+    33) # of times in this domain a busier queue was found while the cpu
         was just becoming idle but no busier group was found
 
    Next three are active_load_balance() statistics:
 
-    25) # of times active_load_balance() was called
-    26) # of times active_load_balance() tried to move a task and failed
-    27) # of times active_load_balance() successfully moved a task
+    34) # of times active_load_balance() was called
+    35) # of times active_load_balance() tried to move a task and failed
+    36) # of times active_load_balance() successfully moved a task
 
    Next three are sched_balance_exec() statistics:
 
-    28) sbe_cnt is not used
-    29) sbe_balanced is not used
-    30) sbe_pushed is not used
+    37) sbe_cnt is not used
+    38) sbe_balanced is not used
+    39) sbe_pushed is not used
 
    Next three are sched_balance_fork() statistics:
 
-    31) sbf_cnt is not used
-    32) sbf_balanced is not used
-    33) sbf_pushed is not used
+    40) sbf_cnt is not used
+    41) sbf_balanced is not used
+    42) sbf_pushed is not used
 
    Next three are try_to_wake_up() statistics:
 
-    34) # of times in this domain try_to_wake_up() awoke a task that
+    43) # of times in this domain try_to_wake_up() awoke a task that
         last ran on a different cpu in this domain
-    35) # of times in this domain try_to_wake_up() moved a task to the
+    44) # of times in this domain try_to_wake_up() moved a task to the
         waking cpu because it was cache-cold on its own cpu anyway
-    36) # of times in this domain try_to_wake_up() started passive balancing
+    45) # of times in this domain try_to_wake_up() started passive balancing
 
 /proc/<pid>/schedstat
 ---------------------
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 5f56396..4346fd8 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -103,7 +103,7 @@ void __update_stats_enqueue_sleeper(struct rq *rq, struct task_struct *p,
  * Bump this up when changing the output format or the meaning of an existing
  * format, so that tools can adapt (or abort)
  */
-#define SCHEDSTAT_VERSION 16
+#define SCHEDSTAT_VERSION 17
 
 static int show_schedstat(struct seq_file *seq, void *v)
 {

