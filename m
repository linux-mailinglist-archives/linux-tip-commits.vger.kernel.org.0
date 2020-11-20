Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8E32BAA37
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Nov 2020 13:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgKTMeR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 20 Nov 2020 07:34:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40342 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728106AbgKTMeL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 20 Nov 2020 07:34:11 -0500
Date:   Fri, 20 Nov 2020 12:34:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605875650;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/rgETGRt4SJs2ltxwrihKxj//pxN6G6zufCAp7MZWoI=;
        b=OeltTjT/QdWwaKq3Dqt7rZbAustP3qddmkFTXU46fL/fkLxuXbuXmvl641LrQw4t96lsiq
        s/7GWp40HTn5KmBm9QJQnIQ5ITjzee67OrhWNbRDQuVtjTWkZEMkhg4+uskCmKeim3kKkj
        3+tAHLAux/xfGCiZheN/6S+xPGX78lwxWKkjXbNMY8AdMcc3nV5BEFduDKsyHTxZ9Y7Fl7
        jnvJQPcXfGWKiVRrPtPn6aRirnbR2iqgWIZX/bC9Wtp4/4HLYn4nxeBh4RrOmee6ZSAGS7
        d72Oq3xLgdA0rnwHSoLx3Vgzjq2Pk3szCA4Emlf1KYtJhkqc+/3+t3+/PHhLMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605875650;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/rgETGRt4SJs2ltxwrihKxj//pxN6G6zufCAp7MZWoI=;
        b=6lqiz6zrgLrYgyd8E2COTOPC6v6B0HOyJ972E/BBzRUK06I2mVPr9Vfch/ASKJJdNIH4UG
        +ZLmfrTTlc8RtcAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix migration_cpu_stop() WARN
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160587564920.11244.15431426465426576849.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1293771e4353c148d5f6908fb32d1c1cfd653e47
Gitweb:        https://git.kernel.org/tip/1293771e4353c148d5f6908fb32d1c1cfd653e47
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 17 Nov 2020 12:14:51 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 19 Nov 2020 11:25:45 +01:00

sched: Fix migration_cpu_stop() WARN

Oleksandr reported hitting the WARN in the 'task_rq(p) != rq' branch
of migration_cpu_stop(). Valentin noted that using cpu_of(rq) in that
case is just plain wrong to begin with, since per the earlier branch
that isn't the actual CPU of the task.

Replace both instances of is_cpu_allowed() by a direct p->cpus_mask
test using task_cpu().

Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Debugged-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4d1fd4b..28d541a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1911,7 +1911,7 @@ static int migration_cpu_stop(void *data)
 			 * and we should be valid again. Nothing to do.
 			 */
 			if (!pending) {
-				WARN_ON_ONCE(!is_cpu_allowed(p, cpu_of(rq)));
+				WARN_ON_ONCE(!cpumask_test_cpu(task_cpu(p), &p->cpus_mask));
 				goto out;
 			}
 
@@ -1950,7 +1950,7 @@ static int migration_cpu_stop(void *data)
 		 * valid again. Nothing to do.
 		 */
 		if (!pending) {
-			WARN_ON_ONCE(!is_cpu_allowed(p, cpu_of(rq)));
+			WARN_ON_ONCE(!cpumask_test_cpu(task_cpu(p), &p->cpus_mask));
 			goto out;
 		}
 
