Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9C845F5E5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 26 Nov 2021 21:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244204AbhKZU32 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 26 Nov 2021 15:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhKZU11 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 26 Nov 2021 15:27:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73106C06175F;
        Fri, 26 Nov 2021 12:23:01 -0800 (PST)
Date:   Fri, 26 Nov 2021 20:22:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637958180;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yTCEB3Pp67T2vA0hq9r/h5UK/UH29evlE8hR+HpUF6U=;
        b=kPHCN34UQL5mODF+3ptpaHULaIB+4vm1HZpaPA8TpkNMIbuxjRNcwcYwRYuxKIkMHFvftT
        8hRtppjTgdbmJz8apYZQPjzxAzPTY7/SytmE16L5ESWN7I05mSG5rcq9m+EN61wRulAxff
        2cCuRUVEPhuTmDlAw9uwpsuXKu67cL1SdFKT/It/DRhh4JC86S1bnVMI4Pc6fLZa6T7fav
        AkO/xNmLZSzKxsbie+cej/ZNqlPeil93fyP+EuYxDma94YFK9S5T9MwTGFLiyhddFM2ciX
        PP8uEtbBePxlZ7YTcJecarn9lnebXUdW7FwgDYufvLODKTMiKLu5I1aArycSIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637958180;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yTCEB3Pp67T2vA0hq9r/h5UK/UH29evlE8hR+HpUF6U=;
        b=yUWnGpUSojXXBltKjG3EzUyDr3/5h8fZ42EJ7rKht6kmsYFudTZYRL7PW4EPn3fV3lBqLz
        uels2i0vW+38GGCg==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] sched: Snapshot thread flags
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211117163050.53986-4-mark.rutland@arm.com>
References: <20211117163050.53986-4-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <163795817915.11128.11435793636982229812.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     13a405dc6f7f01635c1e849c42b2b8941cec2968
Gitweb:        https://git.kernel.org/tip/13a405dc6f7f01635c1e849c42b2b8941cec2968
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 17 Nov 2021 16:30:41 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 26 Nov 2021 21:20:13 +01:00

sched: Snapshot thread flags

Some thread flags can be set remotely, and so even when IRQs are
disabled, the flags can change under our feet. Generally this is
unlikely to cause a problem in practice, but it is somewhat unsound, and
KCSAN will legitimately warn that there is a data race.

To avoid such issues, a snapshot of the flags has to be taken prior to
using them. Some places already use READ_ONCE() for that, others do not.

Convert them all to the new flag accessor helpers.

The READ_ONCE(ti->flags) .. cmpxchg(ti->flags) loop in set_nr_if_polling()
is left as-is for clarity.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20211117163050.53986-4-mark.rutland@arm.com
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3c9b0fd..7ba05de 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8520,7 +8520,7 @@ void sched_show_task(struct task_struct *p)
 	rcu_read_unlock();
 	pr_cont(" stack:%5lu pid:%5d ppid:%6d flags:0x%08lx\n",
 		free, task_pid_nr(p), ppid,
-		(unsigned long)task_thread_info(p)->flags);
+		read_task_thread_flags(p));
 
 	print_worker_info(KERN_INFO, p);
 	print_stop_info(KERN_INFO, p);
