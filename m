Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A9B30BBB7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Feb 2021 11:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhBBKEj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Feb 2021 05:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbhBBKEf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Feb 2021 05:04:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5921C061573;
        Tue,  2 Feb 2021 02:03:54 -0800 (PST)
Date:   Tue, 02 Feb 2021 10:03:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612260232;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PE2cfmMlV5aawwN90xn1cTPXLaoUHu1IVXLU1QpHFvw=;
        b=XbcgkNFpleJbgBMs1slny4ZP9KF0/KWAJH7lthMdpoW7gGBGU649/ZqYfrcsE3JYhR0Sfw
        QWvNlgzle52tIngwaTkjGn8xGca55DpuRpa27YQIXcFQSVPsX9EFsq7plal2lKipcy3iEK
        FCxCZpdt9K4s7uo0tFESpb5VKviYwh8XuzBysgj8b/u9eKPbMeJQ9WJRxZlGC+Gn5kOtEB
        1MbLftxVCMPYRmNC6g8NPwLYkMRdYp6mJ3zhEjR9r7pUrXoJ1T8fddwqU9JMkZyf0/bXvW
        dk1BIfFG+yljgPvDyWDezX9Z2nRHSw+W514ylwGntMS+EkZvKj0JkZhgzb49Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612260232;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PE2cfmMlV5aawwN90xn1cTPXLaoUHu1IVXLU1QpHFvw=;
        b=uzWvMvj96WvJkCDPO9P54kvBNXFKrxNrGefTKdsAfyziD++IuvRg8eadNY1zqs1BLGage4
        j//ebf3U+1MEhDBA==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Update task_prio() function header
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210128131040.296856-4-dietmar.eggemann@arm.com>
References: <20210128131040.296856-4-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <161226023181.23325.926021119673352308.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     075a28439d0c8eb6d3c799e1eed24bb9bc7750cd
Gitweb:        https://git.kernel.org/tip/075a28439d0c8eb6d3c799e1eed24bb9bc7750cd
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Thu, 28 Jan 2021 14:10:40 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Feb 2021 15:31:39 +01:00

sched/core: Update task_prio() function header

The description of the RT offset and the values for 'normal' tasks needs
update. Moreover there are DL tasks now.
task_prio() has to stay like it is to guarantee compatibility with the
/proc/<pid>/stat priority field:

  # cat /proc/<pid>/stat | awk '{ print $18; }'

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210128131040.296856-4-dietmar.eggemann@arm.com
---
 kernel/sched/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 625ec1e..be3a956 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5602,8 +5602,12 @@ SYSCALL_DEFINE1(nice, int, increment)
  * @p: the task in question.
  *
  * Return: The priority value as seen by users in /proc.
- * RT tasks are offset by -200. Normal tasks are centered
- * around 0, value goes from -16 to +15.
+ *
+ * sched policy         return value   kernel prio    user prio/nice
+ *
+ * normal, batch, idle     [0 ... 39]  [100 ... 139]          0/[-20 ... 19]
+ * fifo, rr             [-2 ... -100]     [98 ... 0]  [1 ... 99]
+ * deadline                     -101             -1           0
  */
 int task_prio(const struct task_struct *p)
 {
