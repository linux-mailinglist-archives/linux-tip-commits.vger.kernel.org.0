Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38BC31BB8C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhBOO4m (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:56:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33170 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhBOO43 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:56:29 -0500
Date:   Mon, 15 Feb 2021 14:55:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xy/KLKNvhr1dzOykrr9GbaOujdgK4dGqybjuM4XPsVA=;
        b=uz36fmA1tXaKJNJTISR3CXdqX4KYAr71jNA9P9rH/VBjah5ECGA9cX2wyZTHmAEYsF1sdF
        LFVHbsxeDAAJtsk0ZE4fqV8jeh/uMfJthF6cQf9av8u+JYQx547c+seDTV2ZQR7kyzKIai
        Mugo+7aKE4wzn01cy8MNvYB6oVdERjisQ9BpwrqwQxUA6jhodnRfIlm2hNEMxlOTB5Qvbm
        ilN2pBKvjRUWeEIiN9PmXAIE0ITzKtTaiMNCo/830GOuZWRp24+FVdni2LI8/KmAiJQrP+
        GCCdFr9ES1s7M+50fxvHeT73s8Ut4xAVlWVvWRClHiysg+Z+QueP4/OFP4bfGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xy/KLKNvhr1dzOykrr9GbaOujdgK4dGqybjuM4XPsVA=;
        b=pzImbTZN/g9pqFx2qoVQZiHoztAsA/D3RWvykQev7GcM9Q1k2Miod61+SNDKnHoUdzOmlR
        VkMBSVxCMI66F2Dw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] srcu: Make Tiny SRCU use multi-bit grace-period counter
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094543.20312.12812461473979360371.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     74612a07b83fc46c2b2e6f71a541d55b024ebefc
Gitweb:        https://git.kernel.org/tip/74612a07b83fc46c2b2e6f71a541d55b024ebefc
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 12 Nov 2020 16:34:09 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 13:53:36 -08:00

srcu: Make Tiny SRCU use multi-bit grace-period counter

There is a need for a polling interface for SRCU grace periods.  This
polling needs to distinguish between an SRCU instance being idle on the
one hand or in the middle of a grace period on the other.  This commit
therefore converts the Tiny SRCU srcu_struct structure's srcu_idx from
a defacto boolean to a free-running counter, using the bottom bit to
indicate that a grace period is in progress.  The second-from-bottom
bit is thus used as the index returned by srcu_read_lock().

Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
[ paulmck: Fix ->srcu_lock_nesting[] indexing per Neeraj Upadhyay. ]
Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutiny.h | 6 +++---
 kernel/rcu/srcutiny.c    | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 5a5a194..b8b42d0 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -15,7 +15,7 @@
 
 struct srcu_struct {
 	short srcu_lock_nesting[2];	/* srcu_read_lock() nesting depth. */
-	short srcu_idx;			/* Current reader array element. */
+	unsigned short srcu_idx;	/* Current reader array element in bit 0x2. */
 	u8 srcu_gp_running;		/* GP workqueue running? */
 	u8 srcu_gp_waiting;		/* GP waiting for readers? */
 	struct swait_queue_head srcu_wq;
@@ -59,7 +59,7 @@ static inline int __srcu_read_lock(struct srcu_struct *ssp)
 {
 	int idx;
 
-	idx = READ_ONCE(ssp->srcu_idx);
+	idx = ((READ_ONCE(ssp->srcu_idx) + 1) & 0x2) >> 1;
 	WRITE_ONCE(ssp->srcu_lock_nesting[idx], ssp->srcu_lock_nesting[idx] + 1);
 	return idx;
 }
@@ -80,7 +80,7 @@ static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
 {
 	int idx;
 
-	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
+	idx = ((READ_ONCE(ssp->srcu_idx) + 1) & 0x2) >> 1;
 	pr_alert("%s%s Tiny SRCU per-CPU(idx=%d): (%hd,%hd)\n",
 		 tt, tf, idx,
 		 READ_ONCE(ssp->srcu_lock_nesting[!idx]),
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 6208c1d..5598cf6 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -124,11 +124,12 @@ void srcu_drive_gp(struct work_struct *wp)
 	ssp->srcu_cb_head = NULL;
 	ssp->srcu_cb_tail = &ssp->srcu_cb_head;
 	local_irq_enable();
-	idx = ssp->srcu_idx;
-	WRITE_ONCE(ssp->srcu_idx, !ssp->srcu_idx);
+	idx = (ssp->srcu_idx & 0x2) / 2;
+	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
 	WRITE_ONCE(ssp->srcu_gp_waiting, true);  /* srcu_read_unlock() wakes! */
 	swait_event_exclusive(ssp->srcu_wq, !READ_ONCE(ssp->srcu_lock_nesting[idx]));
 	WRITE_ONCE(ssp->srcu_gp_waiting, false); /* srcu_read_unlock() cheap. */
+	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
 
 	/* Invoke the callbacks we removed above. */
 	while (lh) {
