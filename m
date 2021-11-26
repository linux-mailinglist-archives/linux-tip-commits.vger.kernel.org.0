Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F8C45F5D4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 26 Nov 2021 21:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbhKZU2X (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 26 Nov 2021 15:28:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33332 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239641AbhKZU0P (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 26 Nov 2021 15:26:15 -0500
Date:   Fri, 26 Nov 2021 20:22:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637958180;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=axSOpe8EE8QnL7jk+cQHQnzerAFdmiq3XSzIY4+3ieI=;
        b=tYJPDhNTXv0niDBMQVlz1K28VVq9GAv+DaEnEyNPK/HT1sShwpG3Opt/cCvpRjMhhRoXXz
        OmGfZdjqPKH1iLzf6n7IfsbQV7eknUPTrhAHBZ4rmEhn+EQCZigsyJTzQPFiBqGKLCG1p0
        zxstau12o/a3+e01HuGapJ2mEOMXnhyqS5GQCUW63tYDso+NsZin/bO/bsPHHwgmCts847
        vQfRhPlcjsBCR/4+ItUl24YYMfo4IRCsjTT96PG3aWzWG1iZ6fQkF8tUMT5lM7VrI5jFfP
        q1Sc4tia2YOJIcLz8qjZs5vPx1JeUIoenmLoDXSjd7pjEmQziMGpq8jbUM8qeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637958180;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=axSOpe8EE8QnL7jk+cQHQnzerAFdmiq3XSzIY4+3ieI=;
        b=RfCWrCNxJqpfUVf1kDxwBAKA1rfEFNJpRzETvbM/CUC+sN3Y64gTsGSjWVBuLQ1AAOWhFk
        uOc+J6hvo7esv3Aw==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Snapshot thread flags
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211117163050.53986-3-mark.rutland@arm.com>
References: <20211117163050.53986-3-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <163795817992.11128.13208010629553686739.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     f6af43531342c55c34a851bd455508edc29f6e06
Gitweb:        https://git.kernel.org/tip/f6af43531342c55c34a851bd455508edc29f6e06
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 17 Nov 2021 16:30:40 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 26 Nov 2021 21:20:13 +01:00

entry: Snapshot thread flags

Some thread flags can be set remotely, and so even when IRQs are
disabled, the flags can change under our feet. Generally this is
unlikely to cause a problem in practice, but it is somewhat unsound, and
KCSAN will legitimately warn that there is a data race.

To avoid such issues, a snapshot of the flags has to be taken prior to
using them. Some places already use READ_ONCE() for that, others do not.

Convert them all to the new flag accessor helpers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20211117163050.53986-3-mark.rutland@arm.com
---
 include/linux/entry-kvm.h | 2 +-
 kernel/entry/common.c     | 4 ++--
 kernel/entry/kvm.c        | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
index 0d7865a..07c878d 100644
--- a/include/linux/entry-kvm.h
+++ b/include/linux/entry-kvm.h
@@ -75,7 +75,7 @@ static inline void xfer_to_guest_mode_prepare(void)
  */
 static inline bool __xfer_to_guest_mode_work_pending(void)
 {
-	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
+	unsigned long ti_work = read_thread_flags();
 
 	return !!(ti_work & XFER_TO_GUEST_MODE_WORK);
 }
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index d5a61d5..bad7136 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -187,7 +187,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 		/* Check if any of the above work has queued a deferred wakeup */
 		tick_nohz_user_enter_prepare();
 
-		ti_work = READ_ONCE(current_thread_info()->flags);
+		ti_work = read_thread_flags();
 	}
 
 	/* Return the latest work state for arch_exit_to_user_mode() */
@@ -196,7 +196,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 
 static void exit_to_user_mode_prepare(struct pt_regs *regs)
 {
-	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
+	unsigned long ti_work = read_thread_flags();
 
 	lockdep_assert_irqs_disabled();
 
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index 49972ee..96d476e 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -26,7 +26,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 		if (ret)
 			return ret;
 
-		ti_work = READ_ONCE(current_thread_info()->flags);
+		ti_work = read_thread_flags();
 	} while (ti_work & XFER_TO_GUEST_MODE_WORK || need_resched());
 	return 0;
 }
@@ -43,7 +43,7 @@ int xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu)
 	 * disabled in the inner loop before going into guest mode. No need
 	 * to disable interrupts here.
 	 */
-	ti_work = READ_ONCE(current_thread_info()->flags);
+	ti_work = read_thread_flags();
 	if (!(ti_work & XFER_TO_GUEST_MODE_WORK))
 		return 0;
 
