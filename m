Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA66436248B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 17:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbhDPPyL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 11:54:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58196 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbhDPPyH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 11:54:07 -0400
Date:   Fri, 16 Apr 2021 15:53:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618588421;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QdZ8omTBGZFtGauysxoGOuCkoXNz90w+g2GgF6tMu5U=;
        b=ljEZt5fhCKLpWS1yQg6yWlWUzq5lFz60Q8nJ1mbP50RCwR1Bbk/rJHiilRjMb7UoSggFVI
        igrQsh6u2deVVS9gE+p61R6gqKIjTDXWRD21HHkmJmdCZQhqJmsevf8KlEtN4BqYrYQFmN
        7PXvTEVTJoTzG2cJ8BFNHds/D5wtsOAvtg4RdM9QYv+/G1q4XUbnbWXBHGzrksTXrL9oTV
        HpSpu2KADT67VShmLJFVYSZHiVWD93zOHMoAaPMvmJPZlcT0ovDu5nvig6OCraaUAd3xh6
        Uzu/w8Oi+yHJlUYr2kYgSr2Dt8bD208QYDe/NE6BvYwcVY89SwmEBp7pA2vNyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618588421;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QdZ8omTBGZFtGauysxoGOuCkoXNz90w+g2GgF6tMu5U=;
        b=yE81qg4Rn0arTiXdYNLnr3v+4lYjPsron/DihIz1G1NHhDVk1NpJlKO9Jvs/hH4AtebtKW
        rz3jU8AcgvQylgCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Move /proc/sched_debug to debugfs
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210412102001.548833671@infradead.org>
References: <20210412102001.548833671@infradead.org>
MIME-Version: 1.0
Message-ID: <161858842118.29796.7361131956143217353.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d27e9ae2f244805bbdc730d85fba28685d2471e5
Gitweb:        https://git.kernel.org/tip/d27e9ae2f244805bbdc730d85fba28685d2471e5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 25 Mar 2021 15:18:19 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Apr 2021 17:06:35 +02:00

sched: Move /proc/sched_debug to debugfs

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210412102001.548833671@infradead.org
---
 kernel/sched/debug.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index b25de7b..bf199d6 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -277,6 +277,20 @@ static const struct file_operations sched_dynamic_fops = {
 
 __read_mostly bool sched_debug_enabled;
 
+static const struct seq_operations sched_debug_sops;
+
+static int sched_debug_open(struct inode *inode, struct file *filp)
+{
+	return seq_open(filp, &sched_debug_sops);
+}
+
+static const struct file_operations sched_debug_fops = {
+	.open		= sched_debug_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 static struct dentry *debugfs_sched;
 
 static __init int sched_init_debug(void)
@@ -314,6 +328,8 @@ static __init int sched_init_debug(void)
 	debugfs_create_u32("scan_size_mb", 0644, numa, &sysctl_numa_balancing_scan_size);
 #endif
 
+	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
+
 	return 0;
 }
 late_initcall(sched_init_debug);
@@ -847,15 +863,6 @@ static const struct seq_operations sched_debug_sops = {
 	.show		= sched_debug_show,
 };
 
-static int __init init_sched_debug_procfs(void)
-{
-	if (!proc_create_seq("sched_debug", 0444, NULL, &sched_debug_sops))
-		return -ENOMEM;
-	return 0;
-}
-
-__initcall(init_sched_debug_procfs);
-
 #define __PS(S, F) SEQ_printf(m, "%-45s:%21Ld\n", S, (long long)(F))
 #define __P(F) __PS(#F, F)
 #define   P(F) __PS(#F, p->F)
