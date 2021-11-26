Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5F145F5C8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 26 Nov 2021 21:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbhKZU2K (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 26 Nov 2021 15:28:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33238 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbhKZU0I (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 26 Nov 2021 15:26:08 -0500
Date:   Fri, 26 Nov 2021 20:22:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637958174;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WWTuQQeYtJIjYNa0KeVvIfnaFef4GCsl2kVSbFXoL0E=;
        b=bwCbjtz8GmBuESkkgEnaHHOcZSy/0dbjaJT/57M1WMqyIdwKbKoBWH7CplktQtdUFiIGv9
        jSTo/YSFWlK0h697sVQng5BRo0FvvZFvMlkTexyVXr0ih2PiWolfOhqt1m6lFlBgL5Wxfd
        vhUrQN7WqQzy8jPfIfEbLE3pn5RF5r3gr/KeMktkrqKe1S/qHJ9b+gGIbV45EnLNXfPxSg
        pv+znDNhgh93DRLdtYWzceVbZQsqeHf1V6+AWrO29yDuOcyRPJKFefHhNV/QKm6yGNr3JP
        C2U/psiDpU7Q2V3EOHGCUF3KJnENSkKvr09HWNGsIicOCq+DHc8iC1phbXKdtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637958174;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WWTuQQeYtJIjYNa0KeVvIfnaFef4GCsl2kVSbFXoL0E=;
        b=Q1jCiQ9OKrWWbIacq6WYyp/1sVFn2D3c9ddi7qbDaYN+HKWFpMxmqYLgfjFxeSpxt8nGya
        o3gvqYdBzMlqNsDA==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] x86: Snapshot thread flags
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211117163050.53986-12-mark.rutland@arm.com>
References: <20211117163050.53986-12-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <163795817286.11128.6655021756969582658.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     5796ee48d26a18930a8b86fb865ba195282889d0
Gitweb:        https://git.kernel.org/tip/5796ee48d26a18930a8b86fb865ba195282889d0
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 17 Nov 2021 16:30:49 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 26 Nov 2021 21:20:14 +01:00

x86: Snapshot thread flags

Some thread flags can be set remotely, and so even when IRQs are
disabled, the flags can change under our feet. Generally this is
unlikely to cause a problem in practice, but it is somewhat unsound, and
KCSAN will legitimately warn that there is a data race.

To avoid such issues, a snapshot of the flags has to be taken prior to
using them. Some places already use READ_ONCE() for that, others do not.

Convert them all to the new flag accessor helpers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20211117163050.53986-12-mark.rutland@arm.com
---
 arch/x86/kernel/process.c | 8 ++++----
 arch/x86/kernel/process.h | 4 ++--
 arch/x86/mm/tlb.c         | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 04143a6..5d48103 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -365,7 +365,7 @@ void arch_setup_new_exec(void)
 		clear_thread_flag(TIF_SSBD);
 		task_clear_spec_ssb_disable(current);
 		task_clear_spec_ssb_noexec(current);
-		speculation_ctrl_update(task_thread_info(current)->flags);
+		speculation_ctrl_update(read_thread_flags());
 	}
 }
 
@@ -617,7 +617,7 @@ static unsigned long speculation_ctrl_update_tif(struct task_struct *tsk)
 			clear_tsk_thread_flag(tsk, TIF_SPEC_IB);
 	}
 	/* Return the updated threadinfo flags*/
-	return task_thread_info(tsk)->flags;
+	return read_task_thread_flags(tsk);
 }
 
 void speculation_ctrl_update(unsigned long tif)
@@ -653,8 +653,8 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 {
 	unsigned long tifp, tifn;
 
-	tifn = READ_ONCE(task_thread_info(next_p)->flags);
-	tifp = READ_ONCE(task_thread_info(prev_p)->flags);
+	tifn = read_task_thread_flags(next_p);
+	tifp = read_task_thread_flags(prev_p);
 
 	switch_to_bitmap(tifp);
 
diff --git a/arch/x86/kernel/process.h b/arch/x86/kernel/process.h
index 1d0797b..76b547b 100644
--- a/arch/x86/kernel/process.h
+++ b/arch/x86/kernel/process.h
@@ -13,8 +13,8 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p);
 static inline void switch_to_extra(struct task_struct *prev,
 				   struct task_struct *next)
 {
-	unsigned long next_tif = task_thread_info(next)->flags;
-	unsigned long prev_tif = task_thread_info(prev)->flags;
+	unsigned long next_tif = read_task_thread_flags(next);
+	unsigned long prev_tif = read_task_thread_flags(prev);
 
 	if (IS_ENABLED(CONFIG_SMP)) {
 		/*
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 59ba296..92bb03b 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -361,7 +361,7 @@ static void l1d_flush_evaluate(unsigned long prev_mm, unsigned long next_mm,
 
 static unsigned long mm_mangle_tif_spec_bits(struct task_struct *next)
 {
-	unsigned long next_tif = task_thread_info(next)->flags;
+	unsigned long next_tif = read_task_thread_flags(next);
 	unsigned long spec_bits = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_SPEC_MASK;
 
 	/*
