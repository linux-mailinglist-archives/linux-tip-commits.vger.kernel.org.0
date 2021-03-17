Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A2633F472
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 16:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhCQPtd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 11:49:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51134 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbhCQPtA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 11:49:00 -0400
Date:   Wed, 17 Mar 2021 15:48:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615996139;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DSj/pxmyuDi59Jed2LrW6VzvgKxDgsXPTkvJ+iSnF60=;
        b=v4Zpm7yJcB3ok6PeVTESrLLXBc8cBesD/4XrhnofIivuLJJ3dfNNqKk2QHp9vjn+SM9kRu
        OpXtWGTchtIq9C8t3u6UTfgDLOLGLPeTEcP1ItdJe62vBj8tZX72oI2uEc2ZeIxkIXMCUg
        eeCp6xsTM1dSIDx1Y+vJWDUrUrXkQxtdd2XB6Je6hic8IyioWGqZFK13fr1UYDG/RmLrK6
        Dj1Jdtr8JB+d//QNQp+mB0iMqj+3c5BC5LfmQmUVvgturHKhTu2OiYL//NBY972LHAHwG2
        WEFl+LDfFr+rgXw8Qpn4yIbAASUogXhkmuUZhixJiA3SAqZcXWBBHOPRmOu4YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615996139;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DSj/pxmyuDi59Jed2LrW6VzvgKxDgsXPTkvJ+iSnF60=;
        b=szY0yBx4d8qlTY5+9ucIBsCzj8PwaW94yiCY2Nx9RxlOzmA4Un6th/6HXR49nzQLKvJVEt
        qGyc3kyxFQJ9ITAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] tasklets: Provide tasklet_disable_in_atomic()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210309084241.563164193@linutronix.de>
References: <20210309084241.563164193@linutronix.de>
MIME-Version: 1.0
Message-ID: <161599613929.398.10403047362776200822.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ca5f625118955fc544c3cb3dee7055d33ecadafb
Gitweb:        https://git.kernel.org/tip/ca5f625118955fc544c3cb3dee7055d33ecadafb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 09 Mar 2021 09:42:06 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Mar 2021 16:33:52 +01:00

tasklets: Provide tasklet_disable_in_atomic()

Replacing the spin wait loops in tasklet_unlock_wait() with
wait_var_event() is not possible as a handful of tasklet_disable()
invocations are happening in atomic context. All other invocations are in
teardown paths which can sleep.

Provide tasklet_disable_in_atomic() and tasklet_unlock_spin_wait() to
convert the few atomic use cases over, which allows to change
tasklet_disable() and tasklet_unlock_wait() in a later step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210309084241.563164193@linutronix.de

---
 include/linux/interrupt.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 0a4ce25..3c8a291 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -675,10 +675,21 @@ static inline void tasklet_unlock_wait(struct tasklet_struct *t)
 	while (test_bit(TASKLET_STATE_RUN, &t->state))
 		cpu_relax();
 }
+
+/*
+ * Do not use in new code. Waiting for tasklets from atomic contexts is
+ * error prone and should be avoided.
+ */
+static inline void tasklet_unlock_spin_wait(struct tasklet_struct *t)
+{
+	while (test_bit(TASKLET_STATE_RUN, &t->state))
+		cpu_relax();
+}
 #else
 static inline int tasklet_trylock(struct tasklet_struct *t) { return 1; }
 static inline void tasklet_unlock(struct tasklet_struct *t) { }
 static inline void tasklet_unlock_wait(struct tasklet_struct *t) { }
+static inline void tasklet_unlock_spin_wait(struct tasklet_struct *t) { }
 #endif
 
 extern void __tasklet_schedule(struct tasklet_struct *t);
@@ -703,6 +714,17 @@ static inline void tasklet_disable_nosync(struct tasklet_struct *t)
 	smp_mb__after_atomic();
 }
 
+/*
+ * Do not use in new code. Disabling tasklets from atomic contexts is
+ * error prone and should be avoided.
+ */
+static inline void tasklet_disable_in_atomic(struct tasklet_struct *t)
+{
+	tasklet_disable_nosync(t);
+	tasklet_unlock_spin_wait(t);
+	smp_mb();
+}
+
 static inline void tasklet_disable(struct tasklet_struct *t)
 {
 	tasklet_disable_nosync(t);
