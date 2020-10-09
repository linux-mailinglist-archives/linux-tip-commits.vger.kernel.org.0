Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D0A288282
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732314AbgJIGhi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:37:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55554 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731989AbgJIGfe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:34 -0400
Date:   Fri, 09 Oct 2020 06:35:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9NGi3lo2WNaSvl+69fEGlcXvMQQ0+8vJ0Fy7KDPq36g=;
        b=mEH3RDloaH+zkO+NAhbKs9erllsdX7UuTd8kB/uHY8aZeyw7woNBGMGLaBiW4GvhS+G28N
        Bhti7ZwG47IYifh8OeP9iaos0RSVW1NuHqYYvoUMLK9ImX6SQ+CX/72YDkZ/CYER6Afp5q
        V1MOSRgegi7yg9rAFSLmOzpk+b5NrgUHqDq746EDRve7bIYd3QiZCPVl/o9pmc49waStbJ
        ETKxMBGSDOCjbvMuRSoWfleI6MnN6aEFfBbNp55nssjvEDjpVgCGjYKCHQqk1V+6doThWn
        2JcsveM+cySBwN48rDu7EpjJfpdIWXjR4jys4vy1Wh7XWVQ0r6U8LuJsnJCvxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9NGi3lo2WNaSvl+69fEGlcXvMQQ0+8vJ0Fy7KDPq36g=;
        b=i25wD6cEACHNiVM4vtAYqog8kzwihJMO1QkPvAu4qrX0OFcEatzgncdEJAgZ7/MtzqFkSs
        1T1kQyjjAgnz3RCQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] tick-sched: Clarify "NOHZ: local_softirq_pending" warning
Cc:     Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222533152.7002.4472002575038406164.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     bca37119c57bdc2c68c84b313a5118005e8693cf
Gitweb:        https://git.kernel.org/tip/bca37119c57bdc2c68c84b313a5118005e8693cf
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 26 Jun 2020 13:39:41 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:38:32 -07:00

tick-sched: Clarify "NOHZ: local_softirq_pending" warning

Currently, can_stop_idle_tick() prints "NOHZ: local_softirq_pending HH"
(where "HH" is the hexadecimal softirq vector number) when one or more
non-RCU softirq handlers are still enabled when checking to stop the
scheduler-tick interrupt.  This message is not as enlightening as one
might hope, so this commit changes it to "NOHZ tick-stop error: Non-RCU
local softirq work is pending, handler #HH".

Reported-by: Andy Lutomirski <luto@kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/time/tick-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index f0199a4..81632cd 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -927,7 +927,7 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 
 		if (ratelimit < 10 &&
 		    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
-			pr_warn("NOHZ: local_softirq_pending %02x\n",
+			pr_warn("NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #%02x!!!\n",
 				(unsigned int) local_softirq_pending());
 			ratelimit++;
 		}
