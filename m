Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65A43E7D01
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 18:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbhHJQCl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 12:02:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44420 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbhHJQCj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 12:02:39 -0400
Date:   Tue, 10 Aug 2021 16:02:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628611336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5mANIcYKHEMI7WG90FRbdwp2aLOWx7M3IGTk1FA9SRs=;
        b=LvORq15RgJzjxLxvcs0XJPz43Ge6stfX+uXRrCs9HW2xpwoQoUZKigo+kObl6/Kd9Pf8M/
        FQQMWwB8ENVKm7M9+cZ/k15PTdeyYR+dBS4p5p+KxaWwUrTDTaTjMJqPkQGxALzSrMHH3z
        UaVDfeJGtJsd1gzeCYEFGEDaRH6IKs2UekVgXNvRfjNhfo7G5ItryB/gvesy49/CZT0j3A
        RWiAtLkfA+pJuR1t9B2IQnIjsVVkbC/gJZF5qi8v6bWI+HM+5KPy380IOT/pCf10nNqSrd
        TpQeBAuNSu08rxYctJTiMxJ+XAFmXsMVtfvWLQMMjZ5JzawmwKg0IW4iTQveaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628611336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5mANIcYKHEMI7WG90FRbdwp2aLOWx7M3IGTk1FA9SRs=;
        b=Wc+B4VmufXzfNQQq12J+vvqQ71Q6IT5iv6gk83XBmdl2xacCJsE3Pye/s1bQN+G/yVj9sa
        X/zYdic061MEO4DA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timerfd: Provide timerfd_resume()
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210713135158.395287410@linutronix.de>
References: <20210713135158.395287410@linutronix.de>
MIME-Version: 1.0
Message-ID: <162861133556.395.15546123456255340363.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     66f7b0c8aadd2785fc29f2c71477ebc16f4e38cc
Gitweb:        https://git.kernel.org/tip/66f7b0c8aadd2785fc29f2c71477ebc16f4e38cc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Jul 2021 15:39:50 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 17:57:22 +02:00

timerfd: Provide timerfd_resume()

Resuming timekeeping is a clock-was-set event and uses the clock-was-set
notification mechanism. This is in the way of making the clock-was-set
update for hrtimers selective so unnecessary IPIs are avoided when a CPU
base does not have timers queued which are affected by the clock setting.

Provide a seperate timerfd_resume() interface so the resume logic and the
clock-was-set mechanism can be distangled in the core code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210713135158.395287410@linutronix.de

---
 fs/timerfd.c            | 16 ++++++++++++++++
 include/linux/hrtimer.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index c5509d2..e9c96a0 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -115,6 +115,22 @@ void timerfd_clock_was_set(void)
 	rcu_read_unlock();
 }
 
+static void timerfd_resume_work(struct work_struct *work)
+{
+	timerfd_clock_was_set();
+}
+
+static DECLARE_WORK(timerfd_work, timerfd_resume_work);
+
+/*
+ * Invoked from timekeeping_resume(). Defer the actual update to work so
+ * timerfd_clock_was_set() runs in task context.
+ */
+void timerfd_resume(void)
+{
+	schedule_work(&timerfd_work);
+}
+
 static void __timerfd_remove_cancel(struct timerfd_ctx *ctx)
 {
 	if (ctx->might_cancel) {
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 77295af..253c6e2 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -349,8 +349,10 @@ hrtimer_expires_remaining_adjusted(const struct hrtimer *timer)
 
 #ifdef CONFIG_TIMERFD
 extern void timerfd_clock_was_set(void);
+extern void timerfd_resume(void);
 #else
 static inline void timerfd_clock_was_set(void) { }
+static inline void timerfd_resume(void) { }
 #endif
 extern void hrtimers_resume(void);
 
