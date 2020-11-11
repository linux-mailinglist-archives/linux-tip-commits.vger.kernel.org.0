Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096F02AEB3E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 09:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgKKIXP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 03:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgKKIXP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B84C0613D4;
        Wed, 11 Nov 2020 00:23:14 -0800 (PST)
Date:   Wed, 11 Nov 2020 08:23:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605082993;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XU+gleAYcn3WwretVB2aloEPfUJvBNk5G6KecgtW9y4=;
        b=d3nzjeHd0RIwksvFWqKsq1DnoB+xIJ26dLI/zaeqd6vpa62dSv7dEZXNfLtqyQ364QU0Un
        rEkgF/TxECY6KvrYYyYePxacFK1EpKT6uogO+dVXCFUTBYnSgn9qb+UZkRkuEmKIuyrQ2G
        TpaF0nARC3hFG1mrrV5wxA1b4sItbWRPGN48geOnVuQIBoj2KcD7+Tr/I7y1+WyELw2cSY
        e/N+6Qb7KXkmEzGpV+cXMd6NvQh1oc4BGq8NzgVSuTR61cjfEwNcrhp4wM7DzgtLk3fO41
        GD0gUaRQdisU0RB6v9fU3M4kE2FXGdt27dHvMSG0xheZU7ljaF/WzBtws+TIgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605082993;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XU+gleAYcn3WwretVB2aloEPfUJvBNk5G6KecgtW9y4=;
        b=eRuUHjBLqjqgh4ns4vFhY11/dZOdCkstk47nwj4+9kDfXtPukdlfMpTWpb8RnRotq6htYI
        6C1XM9oevgtVUPCg==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Dissociate wakeup decisions from SD flag value
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201102184514.2733-4-valentin.schneider@arm.com>
References: <20201102184514.2733-4-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <160508299244.11244.13469668836199256597.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     dc824eb898534cd8e34582874dae3bb7cf2fa008
Gitweb:        https://git.kernel.org/tip/dc824eb898534cd8e34582874dae3bb7cf2fa008
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 02 Nov 2020 18:45:14 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Nov 2020 18:39:06 +01:00

sched/fair: Dissociate wakeup decisions from SD flag value

The CFS wakeup code will only ever go through EAS / its fast path on
"regular" wakeups (i.e. not on forks or execs). These are currently gated
by a check against 'sd_flag', which would be SD_BALANCE_WAKE at wakeup.

However, we now have a flag that explicitly tells us whether a wakeup is a
"regular" one, so hinge those conditions on that flag instead.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201102184514.2733-4-valentin.schneider@arm.com
---
 kernel/sched/fair.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b1596fa..6691e28 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6705,7 +6705,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	/* SD_flags and WF_flags share the first nibble */
 	int sd_flag = wake_flags & 0xF;
 
-	if (sd_flag & SD_BALANCE_WAKE) {
+	if (wake_flags & WF_TTWU) {
 		record_wakee(p);
 
 		if (sched_energy_enabled()) {
@@ -6742,9 +6742,8 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	if (unlikely(sd)) {
 		/* Slow path */
 		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
-	} else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
+	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
 		/* Fast path */
-
 		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
 
 		if (want_affine)
