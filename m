Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11C131DA21
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Feb 2021 14:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhBQNSi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Feb 2021 08:18:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45252 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbhBQNSS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Feb 2021 08:18:18 -0500
Date:   Wed, 17 Feb 2021 13:17:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613567856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qpAC4avhCQfBak38YIGESeWZ1qr62c8rol0Lyq8c7Ec=;
        b=WT+FUuU5niNSlyV4nveaJLrH22u2gknpCp5MMiKmZRC0jwpG8u8V9USBDPP9se7AijBGjd
        1GSeNqHAI4Pxzpo9SicuteQFUCBhahrA4vBOXYAUgBhfr+33An8m+HZTdIDI+/NvrWnQX+
        O0sBmvyer8Oxdd32EoGqizxlChVNv2XzyZ9xt1pFSMmvRl4PQwjA94PTdAJ3XaqPiTs6vy
        Msxj+UUZjGuMqTQk+JIUA0HRtZ/8x7fmTDQVQwe/4SMce0EMUGQC5Pwvcx690UVqSom2oH
        C05/Z8a2E14/6ZV+ehoFGEk9oD3sOh+4zIjUiDCqHEdzJRM7Efsm34E+b5Ohcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613567856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qpAC4avhCQfBak38YIGESeWZ1qr62c8rol0Lyq8c7Ec=;
        b=rdhe5X9rzYq1IWMnuZmygKDGx9GnGeRjT946CRxsvmXAwhzl/uENEoKj4ZjQt/fEsjdwaC
        EKlQ1P2BQSyv51AA==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Update task_prio() function header
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210128131040.296856-4-dietmar.eggemann@arm.com>
References: <20210128131040.296856-4-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <161356785604.20312.11097939924109968883.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c541bb7835a306cdbbe8abbdf4e4df507e0ca27a
Gitweb:        https://git.kernel.org/tip/c541bb7835a306cdbbe8abbdf4e4df507e0ca27a
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Thu, 28 Jan 2021 14:10:40 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Feb 2021 14:08:30 +01:00

sched/core: Update task_prio() function header

The description of the RT offset and the values for 'normal' tasks needs
update. Moreover there are DL tasks now.
task_prio() has to stay like it is to guarantee compatibility with the
/proc/<pid>/stat priority field:

  # cat /proc/<pid>/stat | awk '{ print $18; }'

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20210128131040.296856-4-dietmar.eggemann@arm.com
---
 kernel/sched/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f0b0b67..4afbdd2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5616,8 +5616,12 @@ SYSCALL_DEFINE1(nice, int, increment)
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
