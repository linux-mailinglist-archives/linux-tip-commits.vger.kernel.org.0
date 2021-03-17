Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0DD33F474
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 16:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhCQPte (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 11:49:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51114 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbhCQPtB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 11:49:01 -0400
Date:   Wed, 17 Mar 2021 15:48:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615996140;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xDBbh6KiF/1HtL6QjkeaRVdjuhbLcf4joSA+VK8FIAA=;
        b=T1KKJFWF1mqIXdRx64HtxcczWBpMqs+UMNd54vfku8IdsG5HS5/xLbVLTFGC+xhN32EM8u
        skQx7CxZ5NVH7RVg0OkOCsRHWqqsWSrndWolzjJU2rf4WZDCUkJFGd6Up0AoAy25/6pie1
        N5ML3QQovlw46YLQm19Vr7MqHC78qxc+Y4u5CdqoMBmBSnXK+PWoDxNx9Kf1ZNEIUp5JJz
        PO4hOM5k/rIIhKt6GwdMaMKLPLavpyf4rIfporllMZ5RDMYLgZdnlrmtbEjncQU0fkHpw/
        0Btnt2JFKq4jRHW0a3mhUcjVXZWam8QlSG05zkhIu23ltQzuYCqJaWJcYCBlxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615996140;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xDBbh6KiF/1HtL6QjkeaRVdjuhbLcf4joSA+VK8FIAA=;
        b=Bi5moRiLvAnZ9F0QzTlIAeMhoMPq+CKUfgYAmjxXT5FJNvEVyPka13OBeWqC1MNcQqg5YV
        2NrZKz19scIrDdDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] tasklets: Use static inlines for stub implementations
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210309084241.407702697@linutronix.de>
References: <20210309084241.407702697@linutronix.de>
MIME-Version: 1.0
Message-ID: <161599613970.398.10047531715735568988.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     6951547a1399c8f56468ed93bea8f769b891aec3
Gitweb:        https://git.kernel.org/tip/6951547a1399c8f56468ed93bea8f769b891aec3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 09 Mar 2021 09:42:05 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Mar 2021 16:33:51 +01:00

tasklets: Use static inlines for stub implementations

Inlines exist for a reason.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210309084241.407702697@linutronix.de

---
 include/linux/interrupt.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index d689fd7..0a4ce25 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -676,9 +676,9 @@ static inline void tasklet_unlock_wait(struct tasklet_struct *t)
 		cpu_relax();
 }
 #else
-#define tasklet_trylock(t) 1
-#define tasklet_unlock_wait(t) do { } while (0)
-#define tasklet_unlock(t) do { } while (0)
+static inline int tasklet_trylock(struct tasklet_struct *t) { return 1; }
+static inline void tasklet_unlock(struct tasklet_struct *t) { }
+static inline void tasklet_unlock_wait(struct tasklet_struct *t) { }
 #endif
 
 extern void __tasklet_schedule(struct tasklet_struct *t);
