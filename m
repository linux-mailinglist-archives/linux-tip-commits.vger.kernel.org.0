Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2240A3E5A90
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 14:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbhHJM7B (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 08:59:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43236 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241035AbhHJM7B (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 08:59:01 -0400
Date:   Tue, 10 Aug 2021 12:58:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628600303;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4EiWzanSld/kJ4ba5CeQbfPqGFZhTVRU9UOedcxPpoc=;
        b=1TILZbVBOy+8QJQedLR8mbHXQiG8Bacoshy0PPfnwKA+mUilkBaFG/gmnv0JD7ET2TBzhB
        o/OeSJRCcaAeXrSwcQGWtmlRCFjGqvTxMKRUp0nOpWCFawTy8ZqC8PFfdgb7oMPRHg6rfy
        1Lkq9GoUf4Zhq/FMyU0u6qEzcPC4jUUmhxzrjwoqL1YK6mnQNe6WGLLJoOkeizVLio6baO
        iufhxgt95u67X62B0jgxsRWWbL2RSCbiECJwyVgpZpZ/ELF7ZNLLA2/EnM07WGwVRySHXL
        Z1UDkHhGwonkct7PlIrLYM1/7SvqrZ+oEd7qunsO2Tr+n4GKWsAudoLNU7Pkhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628600303;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4EiWzanSld/kJ4ba5CeQbfPqGFZhTVRU9UOedcxPpoc=;
        b=vtwrAf5GIaPktM2iNTPvdyRa3biwfOq+atP/HJugbjKEQM25N+k0qbd2DzsT94zrehMbqo
        0GChNKlgp7Rk2zDw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Replace deprecated CPU-hotplug functions.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210803141621.780504-35-bigeasy@linutronix.de>
References: <20210803141621.780504-35-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <162860030244.395.6059107149833459178.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     698429f9d0e54ce3964151adff886ee5fc59714b
Gitweb:        https://git.kernel.org/tip/698429f9d0e54ce3964151adff886ee5fc59714b
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 03 Aug 2021 16:16:17 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 14:53:58 +02:00

clocksource: Replace deprecated CPU-hotplug functions.

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210803141621.780504-35-bigeasy@linutronix.de

---
 kernel/time/clocksource.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index b89c76e..b8a14d2 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -306,12 +306,12 @@ void clocksource_verify_percpu(struct clocksource *cs)
 		return;
 	cpumask_clear(&cpus_ahead);
 	cpumask_clear(&cpus_behind);
-	get_online_cpus();
+	cpus_read_lock();
 	preempt_disable();
 	clocksource_verify_choose_cpus();
 	if (cpumask_weight(&cpus_chosen) == 0) {
 		preempt_enable();
-		put_online_cpus();
+		cpus_read_unlock();
 		pr_warn("Not enough CPUs to check clocksource '%s'.\n", cs->name);
 		return;
 	}
@@ -337,7 +337,7 @@ void clocksource_verify_percpu(struct clocksource *cs)
 			cs_nsec_min = cs_nsec;
 	}
 	preempt_enable();
-	put_online_cpus();
+	cpus_read_unlock();
 	if (!cpumask_empty(&cpus_ahead))
 		pr_warn("        CPUs %*pbl ahead of CPU %d for clocksource %s.\n",
 			cpumask_pr_args(&cpus_ahead), testcpu, cs->name);
