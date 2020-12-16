Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1425A2DBF01
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Dec 2020 11:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgLPKvU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Dec 2020 05:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgLPKvS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Dec 2020 05:51:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481AEC061794;
        Wed, 16 Dec 2020 02:50:38 -0800 (PST)
Date:   Wed, 16 Dec 2020 10:50:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608115836;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AY+Fj1Bjq6SN60xnYJyYj+p3/+Tyb7HqF/AeRoXYqAU=;
        b=Vad0Q1nTfKwMEB+RJKinn2EOxaiNBfaOunEWNxmZSSpO/xq2cRpixjU7L7KX9SnPoYI2Kd
        5fi7Lo+dVBkzZISzQ9oCUYOVUruXMLSEzlVkpfmwdcOAEhsSL2e7yVtrFiDj/YjTsxItlj
        hPUXHBG+rm5JDxYJpu8qXz6CLn04hvgui0NTAFC5ygTgI78XupJ2wTj2s9BVubC8H1UNhW
        kzFSnr5wogqT6cOiox4mGpxzvWMDwsdbig6826UG0rRJqYQ0aDSd3n/VLnT5IKT7Q6UiW5
        LdyTfvcUL2Z8tgHQLdICMdaeXZGt+21Dsr2xBLVC1z0NlDY0yKyx0hsb2iiBZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608115836;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AY+Fj1Bjq6SN60xnYJyYj+p3/+Tyb7HqF/AeRoXYqAU=;
        b=tjOjnSh+pMZGkQU954NCBcOZPpq0js9rBHI+mdBv+nuu8hshUpZp2/dNrbW4Gpr2vL+3RQ
        j6ueMXCzWoOxr2Cw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] tick: Remove pointless cpu valid check in hotplug code
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201206212002.582579516@linutronix.de>
References: <20201206212002.582579516@linutronix.de>
MIME-Version: 1.0
Message-ID: <160811583546.3364.13065818044324545339.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     f12ad423c4af877b2e4b5a80928b95195fccab04
Gitweb:        https://git.kernel.org/tip/f12ad423c4af877b2e4b5a80928b95195fccab04
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 06 Dec 2020 22:12:54 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Dec 2020 11:26:27 +01:00

tick: Remove pointless cpu valid check in hotplug code

tick_handover_do_timer() which is invoked when a CPU is unplugged has a
check for cpumask_first(cpu_online_mask) when it tries to hand over the
tick update duty.

Checking the result of cpumask_first() there is pointless because if the
online mask is empty at this point, then this would be the last CPU in the
system going offline, which is impossible. There is always at least one CPU
remaining. If online mask would be really empty then the timer duty would
be the least of the resulting problems.

Remove the well meant check simply because it is pointless and confusing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20201206212002.582579516@linutronix.de

---
 kernel/time/tick-common.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index a03764d..9d3a225 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -407,17 +407,13 @@ EXPORT_SYMBOL_GPL(tick_broadcast_oneshot_control);
 /*
  * Transfer the do_timer job away from a dying cpu.
  *
- * Called with interrupts disabled. Not locking required. If
+ * Called with interrupts disabled. No locking required. If
  * tick_do_timer_cpu is owned by this cpu, nothing can change it.
  */
 void tick_handover_do_timer(void)
 {
-	if (tick_do_timer_cpu == smp_processor_id()) {
-		int cpu = cpumask_first(cpu_online_mask);
-
-		tick_do_timer_cpu = (cpu < nr_cpu_ids) ? cpu :
-			TICK_DO_TIMER_NONE;
-	}
+	if (tick_do_timer_cpu == smp_processor_id())
+		tick_do_timer_cpu = cpumask_first(cpu_online_mask);
 }
 
 /*
