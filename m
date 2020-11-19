Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C1F2B8F98
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Nov 2020 11:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgKSJzX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Nov 2020 04:55:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60910 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgKSJzK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Nov 2020 04:55:10 -0500
Date:   Thu, 19 Nov 2020 09:55:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605779709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u9v696cGAY4eDuX87FMXYCmOqTFx/CJeO0D+77++Lw0=;
        b=rW6HUx27xXUQoI+wHM9ydIa5JnLW5frr7vgYwPlKO/tjOilk/acRaDNP0Ads8Ohgp4cJc+
        GxC8v1+9WQLAE9wFbZZEEdygzSngMwSx1T3UIfpCm5bsz7YmDBedBEKQmmUnd2nZgkX0+L
        p7xcguHJ+n4Cxp6Ju16GHA3Nnijm5YeDCJNfPklaTpa5EKX/STl7xsG7MrqjXkO3QP7HXW
        VR7Cn4mVF/NAlfYc8kqmCp2OlpSJw7kX3xAZ1IpszcstkROsBBJAROS0sEh+W9mcsNzfQ0
        A/ed4nqJzZeGWMNPg8HYxa068VSZV/VLtH65NW6hBXzlobkl/Rst9a8saNVXcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605779709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u9v696cGAY4eDuX87FMXYCmOqTFx/CJeO0D+77++Lw0=;
        b=IgYsbqEKpPfKBRjd8WQluBNA9p6S5Hr9JaetbnO5Yn3w5DIzwnJlURKBoRCW60Ex9CVBor
        PAE2MV78Xg7vdAAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/sched: Optimize tick_do_update_jiffies64() further
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201117132006.565663056@linutronix.de>
References: <20201117132006.565663056@linutronix.de>
MIME-Version: 1.0
Message-ID: <160577970843.11244.18100749792311035688.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     7a35bf2a6a871cd0252cd371d741e7d070b53af9
Gitweb:        https://git.kernel.org/tip/7a35bf2a6a871cd0252cd371d741e7d070b53af9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 17 Nov 2020 14:19:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 19 Nov 2020 10:48:29 +01:00

tick/sched: Optimize tick_do_update_jiffies64() further

Now that it's clear that there is always one tick to account, simplify the
calculations some more.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201117132006.565663056@linutronix.de

---
 kernel/time/tick-sched.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index ca9191c..306adeb 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -55,7 +55,7 @@ static ktime_t last_jiffies_update;
  */
 static void tick_do_update_jiffies64(ktime_t now)
 {
-	unsigned long ticks = 0;
+	unsigned long ticks = 1;
 	ktime_t delta;
 
 	/*
@@ -93,20 +93,21 @@ static void tick_do_update_jiffies64(ktime_t now)
 
 	write_seqcount_begin(&jiffies_seq);
 
-	last_jiffies_update = ktime_add(last_jiffies_update, tick_period);
-
 	delta = ktime_sub(now, tick_next_period);
 	if (unlikely(delta >= tick_period)) {
 		/* Slow path for long idle sleep times */
 		s64 incr = ktime_to_ns(tick_period);
 
-		ticks = ktime_divns(delta, incr);
+		ticks += ktime_divns(delta, incr);
 
 		last_jiffies_update = ktime_add_ns(last_jiffies_update,
 						   incr * ticks);
+	} else {
+		last_jiffies_update = ktime_add(last_jiffies_update,
+						tick_period);
 	}
 
-	do_timer(++ticks);
+	do_timer(ticks);
 
 	/*
 	 * Keep the tick_next_period variable up to date.  WRITE_ONCE()
