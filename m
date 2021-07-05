Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F3F3BB9D0
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jul 2021 11:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhGEJH6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jul 2021 05:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhGEJH6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jul 2021 05:07:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411AEC061760;
        Mon,  5 Jul 2021 02:05:21 -0700 (PDT)
Date:   Mon, 05 Jul 2021 09:05:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625475919;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=thE07WZP4wf0fIvtLf9G8CAydKbYEd6EINtpLSX7O3c=;
        b=b3vGacI11kMu+DdP0LpXKdKxTeZpJ2+bQhvjgf52PRupOF9WH/pFkAnIas7G+EKGe/fBP2
        AyWKqweQr4b+x0fV58IGRzh3mLuqdtG5o/O7ZF+3gd6y73RUBbsigA/LxH6DKaF2lksXJc
        iuoUoLRgIG8YfK2HozR34xgOOU6TDhtg9wMqMxoQPQ//1qPV9WibUCRwt/2JAAP3uQt+wp
        PgQ02qwPilhyGnc+ghwoAfEOPPQE4gYNHw30xWM2SKrfvrpmh0xrE4UnWjHtiWVZcMbsc3
        z5WMGLztEOKrygDtVWFqgorjkxlHEhNV+RemJPG5go9mXwcofuJocC/K9JG8Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625475919;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=thE07WZP4wf0fIvtLf9G8CAydKbYEd6EINtpLSX7O3c=;
        b=Ucocgz7qM6Zi9fXbA5YHCZZgQDS1IeiZKobPyv/JuD9MLeYWWPkDFw2ZZO1DJuZMs7XXHc
        V/r/fnKYrogmt2DA==
From:   "tip-bot2 for Xiongwei Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/lockdep: Fix meaningless /proc/lockdep
 output of lock classes on !CONFIG_PROVE_LOCKING
Cc:     Xiongwei Song <sxwjean@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210629135916.308210-1-sxwjean@me.com>
References: <20210629135916.308210-1-sxwjean@me.com>
MIME-Version: 1.0
Message-ID: <162547591914.395.12424245649522104664.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     4840ce2267f9d887f333d88a037c82c566f84081
Gitweb:        https://git.kernel.org/tip/4840ce2267f9d887f333d88a037c82c566f84081
Author:        Xiongwei Song <sxwjean@gmail.com>
AuthorDate:    Tue, 29 Jun 2021 21:59:16 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 05 Jul 2021 10:44:52 +02:00

locking/lockdep: Fix meaningless /proc/lockdep output of lock classes on !CONFIG_PROVE_LOCKING

When enabling CONFIG_LOCK_STAT=y, then CONFIG_LOCKDEP=y is forcedly enabled,
but CONFIG_PROVE_LOCKING is disabled.

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
changed in mark_lock() that is in the CONFIG_PROVE_LOCKING=y section,
however in the test situation, it's not.

The fix is to move the usages reading and seq_print from the
!CONFIG_PROVE_LOCKING section to its defined section.

Also, locks_after list of lock_class is empty when !CONFIG_PROVE_LOCKING,
so do the same thing as what have done for usages of lock classes.

With this patch with !CONFIG_PROVE_LOCKING we can get the results below:

	/ # cat /proc/lockdep
	all lock classes:
	ffffffff85163290: cgroup_mutex
	ffffffff85154dd8: (console_sem).lock
	ffffffff85154d80: console_lock
	ffffffff85074b58: console_owner_lock
	ffffffff85074ba0: console_owner
	ffffffff85066d60: cpu_hotplug_lock

... a class key and the relevant class name each line.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
