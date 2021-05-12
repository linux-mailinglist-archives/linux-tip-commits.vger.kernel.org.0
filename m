Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5547137BA64
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhELK3j (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50476 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbhELK3f (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:35 -0400
Date:   Wed, 12 May 2021 10:28:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815306;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wGvgT+y+ZQqOwssbbN1YHN7vTzouCdnrNu0MhbD9q6g=;
        b=NaSCpkGWeQFo8gjByzcD228DuTYN2F/SW+fS0ryJ1CnFRvGBBkipqQzeL2kNnjkipPsxBc
        7zIkS2W414J+k4tQ7n9UA+5Swbfv88W2UCW5ldAL497I6mpmZ454V2U5F3mHCWQZPMJZSo
        ZR8WgDBepa6xQWuWSxNvy0SMI8bA2PIk6AV0Iofog677hpwFh5BdydfWgnXXaHW3AjubBG
        mGXNe9GW/DHu0pF7NXfpbUsvwLE+ZALfgVICDrp3B1jWedBgzl4qqlyFMWC6/w9TKRyWz8
        rPMsWzI69QoYwpHiYysUkM60mYgAkNx3Lkn8gpA8ai5kB50dNW6zs5bc9IiVBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815306;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wGvgT+y+ZQqOwssbbN1YHN7vTzouCdnrNu0MhbD9q6g=;
        b=jC3lBS/8JG1sqdaB9vmjlLlNEZwZv4gLyUkGNcAXpcYHH6HW97+ZrTwwSrQzuRsig8o2QP
        Wp+daYOqPdp0quAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Allow sched_core_put() from atomic context
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Don Hiatt <dhiatt@digitalocean.com>,
        Hongyu Ning <hongyu.ning@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422123308.377455632@infradead.org>
References: <20210422123308.377455632@infradead.org>
MIME-Version: 1.0
Message-ID: <162081530576.29796.15435912336745931501.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     875feb41fd20f6bd6054c9e79a5bcd9da6d8d2b2
Gitweb:        https://git.kernel.org/tip/875feb41fd20f6bd6054c9e79a5bcd9da6d8d2b2
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 29 Mar 2021 10:08:58 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:27 +02:00

sched: Allow sched_core_put() from atomic context

Stuff the meat of sched_core_put() into a work such that we can use
sched_core_put() from atomic context.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Don Hiatt <dhiatt@digitalocean.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210422123308.377455632@infradead.org
---
 kernel/sched/core.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 42c1c88..85147be 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -102,7 +102,7 @@ DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
  */
 
 static DEFINE_MUTEX(sched_core_mutex);
-static int sched_core_count;
+static atomic_t sched_core_count;
 static struct cpumask sched_core_mask;
 
 static void __sched_core_flip(bool enabled)
@@ -170,18 +170,39 @@ static void __sched_core_disable(void)
 
 void sched_core_get(void)
 {
+	if (atomic_inc_not_zero(&sched_core_count))
+		return;
+
 	mutex_lock(&sched_core_mutex);
-	if (!sched_core_count++)
+	if (!atomic_read(&sched_core_count))
 		__sched_core_enable();
+
+	smp_mb__before_atomic();
+	atomic_inc(&sched_core_count);
 	mutex_unlock(&sched_core_mutex);
 }
 
-void sched_core_put(void)
+static void __sched_core_put(struct work_struct *work)
 {
-	mutex_lock(&sched_core_mutex);
-	if (!--sched_core_count)
+	if (atomic_dec_and_mutex_lock(&sched_core_count, &sched_core_mutex)) {
 		__sched_core_disable();
-	mutex_unlock(&sched_core_mutex);
+		mutex_unlock(&sched_core_mutex);
+	}
+}
+
+void sched_core_put(void)
+{
+	static DECLARE_WORK(_work, __sched_core_put);
+
+	/*
+	 * "There can be only one"
+	 *
+	 * Either this is the last one, or we don't actually need to do any
+	 * 'work'. If it is the last *again*, we rely on
+	 * WORK_STRUCT_PENDING_BIT.
+	 */
+	if (!atomic_add_unless(&sched_core_count, -1, 1))
+		schedule_work(&_work);
 }
 
 #endif /* CONFIG_SCHED_CORE */
