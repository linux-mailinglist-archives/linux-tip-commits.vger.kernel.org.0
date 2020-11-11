Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EB92AEAFF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 09:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgKKIXP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 03:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgKKIXO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D140C0613D1;
        Wed, 11 Nov 2020 00:23:14 -0800 (PST)
Date:   Wed, 11 Nov 2020 08:23:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605082991;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TY5TxBKNnEAFKhri/u5pCFAsNXAeU2T4LtZ6aNmY0Z0=;
        b=z7xBxPe35S8KIGqOSEt19AcdrkEtP/OAkrbE5twdme04W7XDlXGeVqBDBIvmwWAKV006zj
        2+2hUF8gAOuXAZez1UZzbrrgfaCq4HtVMgBnbSXLinm2gRdj35hTe9aJjrvx+Jz9c3kSpg
        n1zsrP0MDN8r5IopEOynD0ORAjE6c945GdHgTjMONl3m69uUkVBqR7ZfGu/hckRyhlO7tU
        JIpFjw7G92s5j1DqfXj40C3n9QUOR9HPfvL2Dh9zNfDop+cjDp1ksxMJ4c8LL0xhx9LJjA
        RFfgkPblMbHjOvWF+0wCw9UQy9Vmo09B9alEq+Z0px+36S34L2HLMzrRBSj7Uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605082991;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TY5TxBKNnEAFKhri/u5pCFAsNXAeU2T4LtZ6aNmY0Z0=;
        b=Z6P4KAJURu7FXXjMfIgrbzsDzXz0LuJLmLijPxhKUJNw5uigNZtHk9cLHI7nW3HJogmQsx
        P4PY7pfis4dxWvCg==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] lockdep: Avoid to modify chain keys in validate_chain()
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201102053743.450459-1-boqun.feng@gmail.com>
References: <20201102053743.450459-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <160508299029.11244.18427700216581701358.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     d61fc96a37603384cd531622c1e89de1096b5123
Gitweb:        https://git.kernel.org/tip/d61fc96a37603384cd531622c1e89de1096b5123
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Mon, 02 Nov 2020 13:37:41 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Nov 2020 18:38:38 +01:00

lockdep: Avoid to modify chain keys in validate_chain()

Chris Wilson reported a problem spotted by check_chain_key(): a chain
key got changed in validate_chain() because we modify the ->read in
validate_chain() to skip checks for dependency adding, and ->read is
taken into calculation for chain key since commit f611e8cf98ec
("lockdep: Take read/write status in consideration when generate
chainkey").

Fix this by avoiding to modify ->read in validate_chain() based on two
facts: a) since we now support recursive read lock detection, there is
no need to skip checks for dependency adding for recursive readers, b)
since we have a), there is only one case left (nest_lock) where we want
to skip checks in validate_chain(), we simply remove the modification
for ->read and rely on the return value of check_deadlock() to skip the
dependency adding.

Reported-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201102053743.450459-1-boqun.feng@gmail.com
---
 kernel/locking/lockdep.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index b71ad8d..d9fb9e1 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2765,7 +2765,9 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
  * (Note that this has to be done separately, because the graph cannot
  * detect such classes of deadlocks.)
  *
- * Returns: 0 on deadlock detected, 1 on OK, 2 on recursive read
+ * Returns: 0 on deadlock detected, 1 on OK, 2 if another lock with the same
+ * lock class is held but nest_lock is also held, i.e. we rely on the
+ * nest_lock to avoid the deadlock.
  */
 static int
 check_deadlock(struct task_struct *curr, struct held_lock *next)
@@ -2788,7 +2790,7 @@ check_deadlock(struct task_struct *curr, struct held_lock *next)
 		 * lock class (i.e. read_lock(lock)+read_lock(lock)):
 		 */
 		if ((next->read == 2) && prev->read)
-			return 2;
+			continue;
 
 		/*
 		 * We're holding the nest_lock, which serializes this lock's
@@ -3593,15 +3595,12 @@ static int validate_chain(struct task_struct *curr,
 		if (!ret)
 			return 0;
 		/*
-		 * Mark recursive read, as we jump over it when
-		 * building dependencies (just like we jump over
-		 * trylock entries):
-		 */
-		if (ret == 2)
-			hlock->read = 2;
-		/*
 		 * Add dependency only if this lock is not the head
-		 * of the chain, and if it's not a secondary read-lock:
+		 * of the chain, and if the new lock introduces no more
+		 * lock dependency (because we already hold a lock with the
+		 * same lock class) nor deadlock (because the nest_lock
+		 * serializes nesting locks), see the comments for
+		 * check_deadlock().
 		 */
 		if (!chain_head && ret != 2) {
 			if (!check_prevs_add(curr, hlock))
