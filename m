Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E853E2B03
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Aug 2021 14:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343802AbhHFM6J (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Aug 2021 08:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243960AbhHFM6J (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Aug 2021 08:58:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88628C061798;
        Fri,  6 Aug 2021 05:57:53 -0700 (PDT)
Date:   Fri, 06 Aug 2021 12:57:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628254672;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zLmoCtuxV+Lii3mCV0aOv5+5Nq5IdIoATPJEBauKObc=;
        b=e2Ww5NqKh+r/TAq4j6IJy7paDdfsEwPxQ99UDMsytngJ5WCkiqOLXSLavHKrSaaF+Amo9K
        m+e8BPrax/jXP+8VyvcfFcR6lGQID4zZtbVkESbXFWbPLFZoa4QLlq+Dpcmg6o7ocnr+ba
        lfl3OzAWcD1WtZ0ERCu111/H4ZOMsy66hbKS3BO9aGGEeNJI3ttK37Sf8MyiYxS7+4LI60
        qauJo6BWiR3aNocPRrjqhW6NiPeqljwvqOx3OgNYyF8xDaUkCP/Cwi/IVbLHBihu1+FUW6
        eVo4n0VhW7h6BfCPHlH9ymylcriV90cYNR681ho0lcvn/XJu9PuMsGgnA/0BLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628254672;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zLmoCtuxV+Lii3mCV0aOv5+5Nq5IdIoATPJEBauKObc=;
        b=CRSZDWf3pibpwZC0oTKaOLnZAH7b/xT98LzKiEC6SpYtJAFdO1Ru7SFCv9A8tCGXbEqcLA
        UGZavwV3hz6dQNBA==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Fix missing clock update in
 migrate_task_rq_dl()
Cc:     Bruno Goncalves <bgoncalv@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210804135925.3734605-1-dietmar.eggemann@arm.com>
References: <20210804135925.3734605-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <162825467136.395.14681444510230102458.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b4da13aa28d4fd0071247b7b41c579ee8a86c81a
Gitweb:        https://git.kernel.org/tip/b4da13aa28d4fd0071247b7b41c579ee8a86c81a
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Wed, 04 Aug 2021 15:59:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 06 Aug 2021 14:25:24 +02:00

sched/deadline: Fix missing clock update in migrate_task_rq_dl()

A missing clock update is causing the following warning:

rq->clock_update_flags < RQCF_ACT_SKIP
WARNING: CPU: 112 PID: 2041 at kernel/sched/sched.h:1453
sub_running_bw.isra.0+0x190/0x1a0
...
CPU: 112 PID: 2041 Comm: sugov:112 Tainted: G W 5.14.0-rc1 #1
Hardware name: WIWYNN Mt.Jade Server System
B81.030Z1.0007/Mt.Jade Motherboard, BIOS 1.6.20210526 (SCP:
1.06.20210526) 2021/05/26
...
Call trace:
  sub_running_bw.isra.0+0x190/0x1a0
  migrate_task_rq_dl+0xf8/0x1e0
  set_task_cpu+0xa8/0x1f0
  try_to_wake_up+0x150/0x3d4
  wake_up_q+0x64/0xc0
  __up_write+0xd0/0x1c0
  up_write+0x4c/0x2b0
  cppc_set_perf+0x120/0x2d0
  cppc_cpufreq_set_target+0xe0/0x1a4 [cppc_cpufreq]
  __cpufreq_driver_target+0x74/0x140
  sugov_work+0x64/0x80
  kthread_worker_fn+0xe0/0x230
  kthread+0x138/0x140
  ret_from_fork+0x10/0x18

The task causing this is the `cppc_fie` DL task introduced by
commit 1eb5dde674f5 ("cpufreq: CPPC: Add support for frequency
invariance").

With CONFIG_ACPI_CPPC_CPUFREQ_FIE=y and schedutil cpufreq governor on
slow-switching system (like on this Ampere Altra WIWYNN Mt. Jade Arm
Server):

DL task `curr=sugov:112` lets `p=cppc_fie` migrate and since the latter
is in `non_contending` state, migrate_task_rq_dl() calls

  sub_running_bw()->__sub_running_bw()->cpufreq_update_util()->
  rq_clock()->assert_clock_updated()

on p.

Fix this by updating the clock for a non_contending task in
migrate_task_rq_dl() before calling sub_running_bw().

Reported-by: Bruno Goncalves <bgoncalv@redhat.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/20210804135925.3734605-1-dietmar.eggemann@arm.com
---
 kernel/sched/deadline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5cafc64..e943146 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1733,6 +1733,7 @@ static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused
 	 */
 	raw_spin_rq_lock(rq);
 	if (p->dl.dl_non_contending) {
+		update_rq_clock(rq);
 		sub_running_bw(&p->dl, &rq->dl);
 		p->dl.dl_non_contending = 0;
 		/*
