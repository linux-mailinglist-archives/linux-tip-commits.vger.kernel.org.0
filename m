Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66B433F075
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 13:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhCQMie (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 08:38:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49662 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhCQMiU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 08:38:20 -0400
Date:   Wed, 17 Mar 2021 12:38:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615984699;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fi8t/0lj0pL/6d5yEo5GjAalAaAhwfw1Db/jSwlCssc=;
        b=LhHPGbVGBxvHuP6jr5kHqGTokES5uoYo0+p7H7mz8WTz/SnFIE0OAqsb013CkYolhJ3icN
        Y144zJUglOwdJ0yuhzun6oIWaYrc4F55yEA//S3Fud/ItWVHclR98Pl5EcP0hgEUEqmLsZ
        LvjQLYg8Ru6i6ghwKiK8ezFS4JqVq/vZehAiveK+hLw9i0dvjUM0vzDt+uX8i7J3zsSKy8
        nEGw3Z3oARLZP/CG4JQlg9K7g1hoCCelO40+Uv3ahDELWwezmVZNXmMrGF+JXjRRxrg6+g
        Ws841V1AzBJ/gISWJEK+RNl8232KtFRB4Fez/Rf4HEP/FmhL/i6n1EvvwJsl1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615984699;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fi8t/0lj0pL/6d5yEo5GjAalAaAhwfw1Db/jSwlCssc=;
        b=L4qbr2zNCcqTbljrGDtnRVuHJdM8DfNdNZ4CsuWoVlGU7Vds6KOvCpCyWJbneXzwHAsM+a
        X/oawweFaL2mElBw==
From:   "tip-bot2 for Dirk Behme" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] softirq: s/BUG/WARN_ONCE/ on tasklet SCHED state not set
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210317102012.32399-1-erosca@de.adit-jv.com>
References: <20210317102012.32399-1-erosca@de.adit-jv.com>
MIME-Version: 1.0
Message-ID: <161598469824.398.13339224451166671005.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     6b2c339df90788ce6aeecee78d6494f262929206
Gitweb:        https://git.kernel.org/tip/6b2c339df90788ce6aeecee78d6494f262929206
Author:        Dirk Behme <dirk.behme@de.bosch.com>
AuthorDate:    Wed, 17 Mar 2021 11:20:12 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Mar 2021 12:59:35 +01:00

softirq: s/BUG/WARN_ONCE/ on tasklet SCHED state not set

Replace BUG() with WARN_ONCE() on wrong tasklet state, in order to:

 - increase the verbosity / aid in debugging
 - avoid fatal/unrecoverable state

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210317102012.32399-1-erosca@de.adit-jv.com
---
 kernel/softirq.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 8b44ab9..8d56bbf 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -531,6 +531,18 @@ void __tasklet_hi_schedule(struct tasklet_struct *t)
 }
 EXPORT_SYMBOL(__tasklet_hi_schedule);
 
+static bool tasklet_should_run(struct tasklet_struct *t)
+{
+	if (test_and_clear_bit(TASKLET_STATE_SCHED, &t->state))
+		return true;
+
+	WARN_ONCE(1, "tasklet SCHED state not set: %s %pS\n",
+		  t->use_callback ? "callback" : "func",
+		  t->use_callback ? (void *)t->callback : (void *)t->func);
+
+	return false;
+}
+
 static void tasklet_action_common(struct softirq_action *a,
 				  struct tasklet_head *tl_head,
 				  unsigned int softirq_nr)
@@ -550,13 +562,12 @@ static void tasklet_action_common(struct softirq_action *a,
 
 		if (tasklet_trylock(t)) {
 			if (!atomic_read(&t->count)) {
-				if (!test_and_clear_bit(TASKLET_STATE_SCHED,
-							&t->state))
-					BUG();
-				if (t->use_callback)
-					t->callback(t);
-				else
-					t->func(t->data);
+				if (tasklet_should_run(t)) {
+					if (t->use_callback)
+						t->callback(t);
+					else
+						t->func(t->data);
+				}
 				tasklet_unlock(t);
 				continue;
 			}
