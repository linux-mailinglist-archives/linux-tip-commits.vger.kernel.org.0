Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A053BB847
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jul 2021 09:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhGEH4O (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jul 2021 03:56:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59068 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhGEH4N (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jul 2021 03:56:13 -0400
Date:   Mon, 05 Jul 2021 07:53:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625471615;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F56OkhqMYKLV2rUyCNDsST0BwOUxOHhe8mnEjAiQtUs=;
        b=BLCa7fRWxRtHtyFB3euhWC1SU/Got2w5kt187gGtIExSZtdfiOeQzxAo3kvIvT0Gb52NxM
        VW9xb+U/hfamdvg0lS/LBmF5R3dTo8a3zq1kF6QSWnBUP+YwmYeE9x5PsPwI3JHh9020Jn
        pqgp6AR17usvUK1y6hOVlX+fQsZi5seUcZWu7/CwmJC1mVzfSKROWW5/ybjYPBYjjrLXnp
        yVWkFvgP3ppmvVTifFkayfCUJcvp7gD4WlWLSZqAamdIWYzZo4OIUb/jAnkui8WAOQnUTe
        wkLkQ5bXlaJhvdFVFb/cCcwWskImE12cUfvvTgP9x0i/DNM+zsORMzqJJPaffA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625471615;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F56OkhqMYKLV2rUyCNDsST0BwOUxOHhe8mnEjAiQtUs=;
        b=Ejl1b9PLGPL+qU6eONa3Ndb0EsFww97MmHJSxqb4CGFVLSJRK2/jha9srFDLTz4gOTSxLf
        Q30Vb2K8PG7x2xAA==
From:   "tip-bot2 for Xiongwei Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/lockdep: Fix meaningless usages output
 of lock classes
Cc:     Xiongwei Song <sxwjean@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210629135916.308210-1-sxwjean@me.com>
References: <20210629135916.308210-1-sxwjean@me.com>
MIME-Version: 1.0
Message-ID: <162547161509.395.12111477332753183993.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     a23fb0cfa911423327e5a2089d33ab6cddc6a6aa
Gitweb:        https://git.kernel.org/tip/a23fb0cfa911423327e5a2089d33ab6cddc6a6aa
Author:        Xiongwei Song <sxwjean@gmail.com>
AuthorDate:    Tue, 29 Jun 2021 21:59:16 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Jul 2021 15:58:26 +02:00

locking/lockdep: Fix meaningless usages output of lock classes

When enabling CONFIG_LOCK_STAT, then CONFIG_LOCKDEP is forcedly enabled.
We can get output from /proc/lockdep, which currently includes usages of
lock classes. But the usages are meaningless, see the output below:

/ # cat /proc/lockdep
all lock classes:
ffffffff9af63350 ....: cgroup_mutex

ffffffff9af54eb8 ....: (console_sem).lock

ffffffff9af54e60 ....: console_lock

ffffffff9ae74c38 ....: console_owner_lock

ffffffff9ae74c80 ....: console_owner

ffffffff9ae66e60 ....: cpu_hotplug_lock

Only one usage context for each lock, this is because each usage is only
changed in mark_lock() that is in CONFIG_PROVE_LOCKING defined section,
however in the test situation, it's not.

The fix is to move the usages reading and seq_print from
CONFIG_PROVE_LOCKING undefined setcion to its defined section. Also,
locks_after list of lock_class is empty when CONFIG_PROVE_LOCKING
undefined, so do the same thing as what have done for usages of lock
classes.

With this patch with CONFIG_PROVE_LOCKING undefined, we can get the
results below:

/ # cat /proc/lockdep
all lock classes:
ffffffff85163290: cgroup_mutex
ffffffff85154dd8: (console_sem).lock
ffffffff85154d80: console_lock
ffffffff85074b58: console_owner_lock
ffffffff85074ba0: console_owner
ffffffff85066d60: cpu_hotplug_lock

a class key and the relevant class name each line.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/20210629135916.308210-1-sxwjean@me.com
---
 kernel/locking/lockdep_proc.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 8069783..b8d9a05 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -70,26 +70,28 @@ static int l_show(struct seq_file *m, void *v)
 #ifdef CONFIG_DEBUG_LOCKDEP
 	seq_printf(m, " OPS:%8ld", debug_class_ops_read(class));
 #endif
-#ifdef CONFIG_PROVE_LOCKING
-	seq_printf(m, " FD:%5ld", lockdep_count_forward_deps(class));
-	seq_printf(m, " BD:%5ld", lockdep_count_backward_deps(class));
-#endif
+	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
+		seq_printf(m, " FD:%5ld", lockdep_count_forward_deps(class));
+		seq_printf(m, " BD:%5ld", lockdep_count_backward_deps(class));
 
-	get_usage_chars(class, usage);
-	seq_printf(m, " %s", usage);
+		get_usage_chars(class, usage);
+		seq_printf(m, " %s", usage);
+	}
 
 	seq_printf(m, ": ");
 	print_name(m, class);
 	seq_puts(m, "\n");
 
-	list_for_each_entry(entry, &class->locks_after, entry) {
-		if (entry->distance == 1) {
-			seq_printf(m, " -> [%p] ", entry->class->key);
-			print_name(m, entry->class);
-			seq_puts(m, "\n");
+	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
+		list_for_each_entry(entry, &class->locks_after, entry) {
+			if (entry->distance == 1) {
+				seq_printf(m, " -> [%p] ", entry->class->key);
+				print_name(m, entry->class);
+				seq_puts(m, "\n");
+			}
 		}
+		seq_puts(m, "\n");
 	}
-	seq_puts(m, "\n");
 
 	return 0;
 }
