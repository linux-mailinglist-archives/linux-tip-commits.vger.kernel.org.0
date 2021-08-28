Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C833FA658
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Aug 2021 17:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbhH1PEw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 28 Aug 2021 11:04:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43528 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhH1PEw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 28 Aug 2021 11:04:52 -0400
Date:   Sat, 28 Aug 2021 15:03:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630163041;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=y60azyjuAZmiS76cGq2J2xGYR5fnA2UXsW3Y5Tf6ncY=;
        b=Ayw5jdb4FXQ3e7XwMz8kPPk5Vw82ZoU4Gb2PFFu06iWLPxKxbbFNNnpQTO8L4ajAooefYy
        A9nlwmK26z7QiCwqu3LfN9tnGWW2Hd5S5qVZ6Lg4lT+BEFgLI5SCv+/1KKmc5qmqjIKaH9
        5wjADoEKW3Z1bfBK7yWKkMzXOt7rOJLv90SITOXM9tDKMJ7ML2Is2tyCidqBdlwzEmeGLD
        j7006kIsveE9IRQOnkx6RMqQuLxyp7DUbvz7mc9Z/qo3U0RlrtibVmMsBvpN8EXYenWzaB
        uX273Ya6EnoekoaQHMJLfN+sA2No6io/2I+mxxDy511uiVLwfm+yNeOByMTIrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630163041;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=y60azyjuAZmiS76cGq2J2xGYR5fnA2UXsW3Y5Tf6ncY=;
        b=4Afi/yGj8Q6BM4Qce8lPZ0pBzimuabJS/7S5aFv1oLLqr/qawnNyQgjaRhtSlm2azwOq/N
        ojtMxV1JPYWp5TBQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Make clocksource watchdog test safe
 for slow-HZ systems
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <163016303985.25758.12035166832598494364.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d25a025201ed98f4b93775e0999a3f2135702106
Gitweb:        https://git.kernel.org/tip/d25a025201ed98f4b93775e0999a3f2135702106
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 12 Aug 2021 09:31:28 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 28 Aug 2021 17:01:32 +02:00

clocksource: Make clocksource watchdog test safe for slow-HZ systems

The clocksource watchdog test sets a local JIFFIES_SHIFT macro and assumes
that HZ is >= 100. For smaller HZ values this shift value is too large and
causes undefined behaviour.

Move the HZ-based definitions of JIFFIES_SHIFT from kernel/time/jiffies.c
to kernel/time/tick-internal.h so the clocksource watchdog test can utilize
them, which makes it work correctly with all HZ values.

[ tglx: Resolved conflicts and massaged changelog ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/20210812000133.GA402890@paulmck-ThinkPad-P17-Gen-1/
---
 kernel/time/clocksource-wdtest.c |  5 ++---
 kernel/time/jiffies.c            | 21 +--------------------
 kernel/time/tick-internal.h      | 20 ++++++++++++++++++++
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtest.c
index 01df123..df922f4 100644
--- a/kernel/time/clocksource-wdtest.c
+++ b/kernel/time/clocksource-wdtest.c
@@ -19,6 +19,8 @@
 #include <linux/prandom.h>
 #include <linux/cpu.h>
 
+#include "tick-internal.h"
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@kernel.org>");
 
@@ -34,9 +36,6 @@ static u64 wdtest_jiffies_read(struct clocksource *cs)
 	return (u64)jiffies;
 }
 
-/* Assume HZ > 100. */
-#define JIFFIES_SHIFT	8
-
 static struct clocksource clocksource_wdtest_jiffies = {
 	.name			= "wdtest-jiffies",
 	.rating			= 1, /* lowest valid rating*/
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index 01935aa..bc4db9e 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -10,28 +10,9 @@
 #include <linux/init.h>
 
 #include "timekeeping.h"
+#include "tick-internal.h"
 
 
-/* Since jiffies uses a simple TICK_NSEC multiplier
- * conversion, the .shift value could be zero. However
- * this would make NTP adjustments impossible as they are
- * in units of 1/2^.shift. Thus we use JIFFIES_SHIFT to
- * shift both the nominator and denominator the same
- * amount, and give ntp adjustments in units of 1/2^8
- *
- * The value 8 is somewhat carefully chosen, as anything
- * larger can result in overflows. TICK_NSEC grows as HZ
- * shrinks, so values greater than 8 overflow 32bits when
- * HZ=100.
- */
-#if HZ < 34
-#define JIFFIES_SHIFT	6
-#elif HZ < 67
-#define JIFFIES_SHIFT	7
-#else
-#define JIFFIES_SHIFT	8
-#endif
-
 static u64 jiffies_read(struct clocksource *cs)
 {
 	return (u64) jiffies;
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 3548f08..649f2b4 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -177,3 +177,23 @@ void clock_was_set(unsigned int bases);
 void clock_was_set_delayed(void);
 
 void hrtimers_resume_local(void);
+
+/* Since jiffies uses a simple TICK_NSEC multiplier
+ * conversion, the .shift value could be zero. However
+ * this would make NTP adjustments impossible as they are
+ * in units of 1/2^.shift. Thus we use JIFFIES_SHIFT to
+ * shift both the nominator and denominator the same
+ * amount, and give ntp adjustments in units of 1/2^8
+ *
+ * The value 8 is somewhat carefully chosen, as anything
+ * larger can result in overflows. TICK_NSEC grows as HZ
+ * shrinks, so values greater than 8 overflow 32bits when
+ * HZ=100.
+ */
+#if HZ < 34
+#define JIFFIES_SHIFT	6
+#elif HZ < 67
+#define JIFFIES_SHIFT	7
+#else
+#define JIFFIES_SHIFT	8
+#endif
