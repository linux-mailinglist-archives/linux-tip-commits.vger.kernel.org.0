Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583B43E7D00
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 18:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbhHJQCk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 12:02:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44426 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbhHJQCi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 12:02:38 -0400
Date:   Tue, 10 Aug 2021 16:02:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628611334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/hzfYtvSHXQ05N9381i25gonerJ8Aymi+Bj8lsluI2E=;
        b=C3JVYE4HQqOQg4Ej3XDPD2/NLQkVSqkRd3+EUv4Rq0rozHim3ExfcY4WrQWrIJQsGdvVDb
        a3FpgBwtKrmMVDON4omuCldzYSC7e0LNgJBrv04Cd2eUmEeoSHSGUCaj8fOheFjYFBfNJh
        Qm6Dycsl5fG5B1EWzH1OQvfGkWr77fMy5z6lSMnmTNxUMNq+26FLYOxk87+yi/p8YprBn4
        K424AEPwtHFLZSWPP53De63LXR/xLpDhtKZ0zcb9PDdymEPUyDIrKP2dDOPTMpI1oUZO74
        +06+aiXfN+jrfS7leiEUAqf/NysjWah44avxDszijS3OVUnGXS9kPt+r/mcWCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628611334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/hzfYtvSHXQ05N9381i25gonerJ8Aymi+Bj8lsluI2E=;
        b=JSsUEzw9XX5xzrDoXqUSYMCMcdNSDNs5AgGFPbgetKXSAN77Mztmrwz5Xv3hH7F1FCGo15
        d/6P5ofKMZUTdsAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time/timekeeping: Avoid invoking clock_was_set() twice
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210713135158.580966888@linutronix.de>
References: <20210713135158.580966888@linutronix.de>
MIME-Version: 1.0
Message-ID: <162861133417.395.13239597740292468571.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1b267793f4fd9a089ea8558f3b6698186b9a3214
Gitweb:        https://git.kernel.org/tip/1b267793f4fd9a089ea8558f3b6698186b9a3214
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Jul 2021 15:39:52 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 17:57:23 +02:00

time/timekeeping: Avoid invoking clock_was_set() twice

do_adjtimex() might end up scheduling a delayed clock_was_set() via
timekeeping_advance() and then invoke clock_was_set() directly which is
pointless.

Make timekeeping_advance() return whether an invocation of clock_was_set()
is required and handle it at the call sites which allows do_adjtimex() to
issue a single direct call if required.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210713135158.580966888@linutronix.de

---
 kernel/time/timekeeping.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index c8a9b9e..19ed58e 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2127,7 +2127,7 @@ static u64 logarithmic_accumulation(struct timekeeper *tk, u64 offset,
  * timekeeping_advance - Updates the timekeeper to the current time and
  * current NTP tick length
  */
-static void timekeeping_advance(enum timekeeping_adv_mode mode)
+static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 {
 	struct timekeeper *real_tk = &tk_core.timekeeper;
 	struct timekeeper *tk = &shadow_timekeeper;
@@ -2198,9 +2198,8 @@ static void timekeeping_advance(enum timekeeping_adv_mode mode)
 	write_seqcount_end(&tk_core.seq);
 out:
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
-	if (clock_set)
-		/* Have to call _delayed version, since in irq context*/
-		clock_was_set_delayed();
+
+	return !!clock_set;
 }
 
 /**
@@ -2209,7 +2208,8 @@ out:
  */
 void update_wall_time(void)
 {
-	timekeeping_advance(TK_ADV_TICK);
+	if (timekeeping_advance(TK_ADV_TICK))
+		clock_was_set_delayed();
 }
 
 /**
@@ -2389,8 +2389,9 @@ int do_adjtimex(struct __kernel_timex *txc)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	struct audit_ntp_data ad;
-	unsigned long flags;
+	bool clock_set = false;
 	struct timespec64 ts;
+	unsigned long flags;
 	s32 orig_tai, tai;
 	int ret;
 
@@ -2425,6 +2426,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 	if (tai != orig_tai) {
 		__timekeeping_set_tai_offset(tk, tai);
 		timekeeping_update(tk, TK_MIRROR | TK_CLOCK_WAS_SET);
+		clock_set = true;
 	}
 	tk_update_leap_state(tk);
 
@@ -2435,9 +2437,9 @@ int do_adjtimex(struct __kernel_timex *txc)
 
 	/* Update the multiplier immediately if frequency was set directly */
 	if (txc->modes & (ADJ_FREQUENCY | ADJ_TICK))
-		timekeeping_advance(TK_ADV_FREQ);
+		clock_set |= timekeeping_advance(TK_ADV_FREQ);
 
-	if (tai != orig_tai)
+	if (clock_set)
 		clock_was_set();
 
 	ntp_notify_cmos_timer();
