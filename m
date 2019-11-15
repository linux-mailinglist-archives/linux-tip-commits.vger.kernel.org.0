Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4DBFE4E2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2019 19:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfKOSTx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Nov 2019 13:19:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44321 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfKOST1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Nov 2019 13:19:27 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVgBk-00059m-8k; Fri, 15 Nov 2019 19:19:20 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DD21F1C18D0;
        Fri, 15 Nov 2019 19:19:19 +0100 (CET)
Date:   Fri, 15 Nov 2019 18:19:19 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Sanitize exit state handling
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191106224556.645603214@linutronix.de>
References: <20191106224556.645603214@linutronix.de>
MIME-Version: 1.0
Message-ID: <157384195985.12247.4843110256427761171.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8e9a078792b2025e92492431992e4c898b1be36b
Gitweb:        https://git.kernel.org/tip/8e9a078792b2025e92492431992e4c898b1be36b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 06 Nov 2019 22:55:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 15 Nov 2019 19:10:52 +01:00

futex: Sanitize exit state handling

Instead of having a smp_mb() and an empty lock/unlock of task::pi_lock move
the state setting into to the lock section.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191106224556.645603214@linutronix.de

---
 kernel/futex.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 3488fb0..f618562 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3703,16 +3703,19 @@ void futex_exit_recursive(struct task_struct *tsk)
 
 void futex_exit_release(struct task_struct *tsk)
 {
-	tsk->futex_state = FUTEX_STATE_EXITING;
-	/*
-	 * Ensure that all new tsk->pi_lock acquisitions must observe
-	 * FUTEX_STATE_EXITING. Serializes against attach_to_pi_owner().
-	 */
-	smp_mb();
 	/*
-	 * Ensure that we must observe the pi_state in exit_pi_state_list().
+	 * Switch the state to FUTEX_STATE_EXITING under tsk->pi_lock.
+	 *
+	 * This ensures that all subsequent checks of tsk->futex_state in
+	 * attach_to_pi_owner() must observe FUTEX_STATE_EXITING with
+	 * tsk->pi_lock held.
+	 *
+	 * It guarantees also that a pi_state which was queued right before
+	 * the state change under tsk->pi_lock by a concurrent waiter must
+	 * be observed in exit_pi_state_list().
 	 */
 	raw_spin_lock_irq(&tsk->pi_lock);
+	tsk->futex_state = FUTEX_STATE_EXITING;
 	raw_spin_unlock_irq(&tsk->pi_lock);
 
 	futex_exec_release(tsk);
