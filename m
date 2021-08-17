Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFF63EF339
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbhHQUOk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34608 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbhHQUOj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:39 -0400
Date:   Tue, 17 Aug 2021 20:14:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jHW8KLnuzuuDgHUqTiOcY+shqi5JnbRHGkhG+it1hp8=;
        b=dUI2Y28OjZM691TwRvMust91GNs149A/RrsiUsc0d7TXZyui5vb+l/vs0P042RMlQPkULH
        wWDwN65joNvFpZhOcvLNv6FbXt52uyWwOQnWlrJ64y91JKqhNtgQSyIfqk4q1OxEq+18/Y
        KmPsupoFdvc1rEIFhQe/H8Q679Etn27diLsnHSUtFZowAwOfKUA8RSJumPknKpi4SHvJrx
        9PaESwK+2kzi2EsVIoOkBeVRDTqZKAffBxZdnv5JbsD5LmkfnqBCKYLvEdKkNS1F3g3FLz
        JBgTGPMUl/SZvXNnf3P8rag6UkvDO7hSaGNnErR+SwJwDWaym9BMJmvQHWVLRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jHW8KLnuzuuDgHUqTiOcY+shqi5JnbRHGkhG+it1hp8=;
        b=99unrUwgs0/ROimlMWcqQDRlM9ICuEG0AGLtPAzUinwQniVsX6IxtGYy+Nyjvxh3VRb5bh
        sYrIIEyss71VyiBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Clarify futex_requeue() PI handling
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211305.305142462@linutronix.de>
References: <20210815211305.305142462@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923124403.25758.11720506820501552422.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f6f4ec00b57a2c950235435bff8e888daafad5af
Gitweb:        https://git.kernel.org/tip/f6f4ec00b57a2c950235435bff8e888daafad5af
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:29:07 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:05:41 +02:00

futex: Clarify futex_requeue() PI handling

When requeuing to a PI futex, then the requeue code tries to trylock the PI
futex on behalf of the topmost waiter on the inner 'waitqueue' futex. If
that succeeds, then PI state has to be allocated in order to requeue further
waiters to the PI futex.

The comment and the code are confusing, as the PI state allocation uses
lookup_pi_state(), which either attaches to an existing waiter or to the
owner. As the PI futex was just acquired, there cannot be a waiter on the
PI futex because the hash bucket lock is held.

Clarify the comment and use attach_to_pi_owner() directly. As the task on
which behalf the PI futex has been acquired is guaranteed to be alive and
not exiting, this call must succeed. Add a WARN_ON() in case that fails.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211305.305142462@linutronix.de
---
 kernel/futex.c | 61 ++++++++++++++++++-------------------------------
 1 file changed, 23 insertions(+), 38 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index bc5395e..c39d5f1 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1299,27 +1299,6 @@ static int attach_to_pi_owner(u32 __user *uaddr, u32 uval, union futex_key *key,
 	return 0;
 }
 
-static int lookup_pi_state(u32 __user *uaddr, u32 uval,
-			   struct futex_hash_bucket *hb,
-			   union futex_key *key, struct futex_pi_state **ps,
-			   struct task_struct **exiting)
-{
-	struct futex_q *top_waiter = futex_top_waiter(hb, key);
-
-	/*
-	 * If there is a waiter on that futex, validate it and
-	 * attach to the pi_state when the validation succeeds.
-	 */
-	if (top_waiter)
-		return attach_to_pi_state(uaddr, uval, top_waiter->pi_state, ps);
-
-	/*
-	 * We are the first waiter - try to look up the owner based on
-	 * @uval and attach to it.
-	 */
-	return attach_to_pi_owner(uaddr, uval, key, ps, exiting);
-}
-
 static int lock_pi_update_atomic(u32 __user *uaddr, u32 uval, u32 newval)
 {
 	int err;
@@ -2038,8 +2017,8 @@ retry_private:
 		 * At this point the top_waiter has either taken uaddr2 or is
 		 * waiting on it.  If the former, then the pi_state will not
 		 * exist yet, look it up one more time to ensure we have a
-		 * reference to it. If the lock was taken, ret contains the
-		 * vpid of the top waiter task.
+		 * reference to it. If the lock was taken, @ret contains the
+		 * VPID of the top waiter task.
 		 * If the lock was not taken, we have pi_state and an initial
 		 * refcount on it. In case of an error we have nothing.
 		 */
@@ -2047,19 +2026,25 @@ retry_private:
 			WARN_ON(pi_state);
 			task_count++;
 			/*
-			 * If we acquired the lock, then the user space value
-			 * of uaddr2 should be vpid. It cannot be changed by
-			 * the top waiter as it is blocked on hb2 lock if it
-			 * tries to do so. If something fiddled with it behind
-			 * our back the pi state lookup might unearth it. So
-			 * we rather use the known value than rereading and
-			 * handing potential crap to lookup_pi_state.
+			 * If futex_proxy_trylock_atomic() acquired the
+			 * user space futex, then the user space value
+			 * @uaddr2 has been set to the @hb1's top waiter
+			 * task VPID. This task is guaranteed to be alive
+			 * and cannot be exiting because it is either
+			 * sleeping or blocked on @hb2 lock.
+			 *
+			 * The @uaddr2 futex cannot have waiters either as
+			 * otherwise futex_proxy_trylock_atomic() would not
+			 * have succeeded.
 			 *
-			 * If that call succeeds then we have pi_state and an
-			 * initial refcount on it.
+			 * In order to requeue waiters to @hb2, pi state is
+			 * required. Hand in the VPID value (@ret) and
+			 * allocate PI state with an initial refcount on
+			 * it.
 			 */
-			ret = lookup_pi_state(uaddr2, ret, hb2, &key2,
-					      &pi_state, &exiting);
+			ret = attach_to_pi_owner(uaddr2, ret, &key2, &pi_state,
+						 &exiting);
+			WARN_ON(ret);
 		}
 
 		switch (ret) {
@@ -2183,9 +2168,9 @@ retry_private:
 	}
 
 	/*
-	 * We took an extra initial reference to the pi_state either
-	 * in futex_proxy_trylock_atomic() or in lookup_pi_state(). We
-	 * need to drop it here again.
+	 * We took an extra initial reference to the pi_state either in
+	 * futex_proxy_trylock_atomic() or in attach_to_pi_owner(). We need
+	 * to drop it here again.
 	 */
 	put_pi_state(pi_state);
 
@@ -2364,7 +2349,7 @@ static int __fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 	 * Modifying pi_state _before_ the user space value would leave the
 	 * pi_state in an inconsistent state when we fault here, because we
 	 * need to drop the locks to handle the fault. This might be observed
-	 * in the PID check in lookup_pi_state.
+	 * in the PID checks when attaching to PI state .
 	 */
 retry:
 	if (!argowner) {
