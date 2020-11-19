Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDA82B8F84
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Nov 2020 11:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgKSJzE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Nov 2020 04:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgKSJzD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Nov 2020 04:55:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DE9C0613CF;
        Thu, 19 Nov 2020 01:55:03 -0800 (PST)
Date:   Thu, 19 Nov 2020 09:55:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605779701;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3DQSNsph71EEutR0chQxF5I5BKA8rkECQKtDlpymFSE=;
        b=ApoJztcibtoEhcl/J0J6qJ7UqKEpJLuU6QPUfaSXDgIEUJgCjbG3Prnr7dOvTDGeGqdBm0
        u32lP4OxV68TvLONeSdSwnovMDFrbeb3AHK0vitvhLLJX1wUd94QyGUUo2p5kdZC6kBueu
        gX2v9Vf2zXCbIyM5AdHkXYYEJxCoSBlrrlW68rg0TVX+BXKkTNaicxKhlgSyIO4NFcFaCw
        2ebJvFVM9zgmtk8/fjsxFSmArIrHeYzQItVPCDFEot+Ou/f2mMerj9vNi8/fOL2qGw9a0d
        YZiOGf0g8xUssx2X9KFFa/Cinofqr5JU+34R9rZEht00KR9M29Q/ab5WZQ1wVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605779701;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3DQSNsph71EEutR0chQxF5I5BKA8rkECQKtDlpymFSE=;
        b=yuDm4JkhHuYrFTCCN+7NhkIkjZasQzVA1T+B5RKCRkULmv+6RjF40ao3hPqcWYd3yiriou
        a97v5k9vK+octoAw==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] lockdep: Put graph lock/unlock under
 lock_recursion protection
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201113110512.1056501-1-boqun.feng@gmail.com>
References: <20201113110512.1056501-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <160577970070.11244.15107414792591573894.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     43be4388e94b915799a24f0eaf664bf95b85231f
Gitweb:        https://git.kernel.org/tip/43be4388e94b915799a24f0eaf664bf95b85231f
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Fri, 13 Nov 2020 19:05:03 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 17 Nov 2020 13:15:35 +01:00

lockdep: Put graph lock/unlock under lock_recursion protection

A warning was hit when running xfstests/generic/068 in a Hyper-V guest:

[...] ------------[ cut here ]------------
[...] DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())
[...] WARNING: CPU: 2 PID: 1350 at kernel/locking/lockdep.c:5280 check_flags.part.0+0x165/0x170
[...] ...
[...] Workqueue: events pwq_unbound_release_workfn
[...] RIP: 0010:check_flags.part.0+0x165/0x170
[...] ...
[...] Call Trace:
[...]  lock_is_held_type+0x72/0x150
[...]  ? lock_acquire+0x16e/0x4a0
[...]  rcu_read_lock_sched_held+0x3f/0x80
[...]  __send_ipi_one+0x14d/0x1b0
[...]  hv_send_ipi+0x12/0x30
[...]  __pv_queued_spin_unlock_slowpath+0xd1/0x110
[...]  __raw_callee_save___pv_queued_spin_unlock_slowpath+0x11/0x20
[...]  .slowpath+0x9/0xe
[...]  lockdep_unregister_key+0x128/0x180
[...]  pwq_unbound_release_workfn+0xbb/0xf0
[...]  process_one_work+0x227/0x5c0
[...]  worker_thread+0x55/0x3c0
[...]  ? process_one_work+0x5c0/0x5c0
[...]  kthread+0x153/0x170
[...]  ? __kthread_bind_mask+0x60/0x60
[...]  ret_from_fork+0x1f/0x30

The cause of the problem is we have call chain lockdep_unregister_key()
-> <irq disabled by raw_local_irq_save()> lockdep_unlock() ->
arch_spin_unlock() -> __pv_queued_spin_unlock_slowpath() -> pv_kick() ->
__send_ipi_one() -> trace_hyperv_send_ipi_one().

Although this particular warning is triggered because Hyper-V has a
trace point in ipi sending, but in general arch_spin_unlock() may call
another function having a trace point in it, so put the arch_spin_lock()
and arch_spin_unlock() after lock_recursion protection to fix this
problem and avoid similiar problems.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201113110512.1056501-1-boqun.feng@gmail.com
---
 kernel/locking/lockdep.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index d9fb9e1..c1418b4 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -108,19 +108,21 @@ static inline void lockdep_lock(void)
 {
 	DEBUG_LOCKS_WARN_ON(!irqs_disabled());
 
+	__this_cpu_inc(lockdep_recursion);
 	arch_spin_lock(&__lock);
 	__owner = current;
-	__this_cpu_inc(lockdep_recursion);
 }
 
 static inline void lockdep_unlock(void)
 {
+	DEBUG_LOCKS_WARN_ON(!irqs_disabled());
+
 	if (debug_locks && DEBUG_LOCKS_WARN_ON(__owner != current))
 		return;
 
-	__this_cpu_dec(lockdep_recursion);
 	__owner = NULL;
 	arch_spin_unlock(&__lock);
+	__this_cpu_dec(lockdep_recursion);
 }
 
 static inline bool lockdep_assert_locked(void)
