Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99AA3928AB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 May 2021 09:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbhE0Hj7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 27 May 2021 03:39:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32820 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbhE0Hj5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 27 May 2021 03:39:57 -0400
Date:   Thu, 27 May 2021 07:38:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622101103;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z9RHu/TVguwKufADl0xfayBPXpCbqgRQUSAW1S9GnJs=;
        b=dEQUG2BZ3kn7zygKmmOx6kh+AOXyhWk6vPNtWvD6mzHZKvv47Cj+fS8iBUJq+MtYMXYbda
        7UeMc2ocgUS2rFIdE5ZsTXddlHYwvdBREdzpGDWZIjATVG15S7KV6hMAZVu06xPD0PUA5y
        vXL9+dPmwDa1yCqufEDnL9EXVLB522cLiYg7Pto3l8QwKtvgojZYkWSY85z4rKK5IG75+R
        bjrAapH+4Iti6Ta95Dm43h6XhtPylbFowrSVEpwK56EO+EZSZXj2CaaUMrXHCQ7uQ3V8ql
        ktFdEQ9qktfAMwhxh7sdHItWrNu7w2yHFUdjmibg1xJzL0TfNCzhkiLkPLTyuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622101103;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z9RHu/TVguwKufADl0xfayBPXpCbqgRQUSAW1S9GnJs=;
        b=cCJSvusWlln19X/xWyUcq/xP6bOlvJlv28+SOXjeQnguvbjDHJFA0fQF3kT+sNYkZSSi8z
        uie3psG5fEGRXPAQ==
From:   "tip-bot2 for Haocheng Xie" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Fix DocBook warnings
Cc:     Haocheng Xie <xiehaocheng.cn@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210527031947.1801-3-xiehaocheng.cn@gmail.com>
References: <20210527031947.1801-3-xiehaocheng.cn@gmail.com>
MIME-Version: 1.0
Message-ID: <162210110256.29796.12436737004212589384.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a1ddf5249f2c50f2e6e5efe604f01a01d5c23ef5
Gitweb:        https://git.kernel.org/tip/a1ddf5249f2c50f2e6e5efe604f01a01d5c23ef5
Author:        Haocheng Xie <xiehaocheng.cn@gmail.com>
AuthorDate:    Thu, 27 May 2021 11:19:46 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 May 2021 09:35:21 +02:00

perf/core: Fix DocBook warnings

Fix the following W=1 kernel build warning(s):

  kernel/events/core.c:143: warning: Function parameter or member 'cpu' not described in 'cpu_function_call'
  kernel/events/core.c:11924: warning: Function parameter or member 'flags' not described in 'sys_perf_event_open'
  kernel/events/core.c:12382: warning: Function parameter or member 'overflow_handler' not described in 'perf_event_create_kernel_counter'
  kernel/events/core.c:12382: warning: Function parameter or member 'context' not described in 'perf_event_create_kernel_counter'

Signed-off-by: Haocheng Xie <xiehaocheng.cn@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210527031947.1801-3-xiehaocheng.cn@gmail.com
---
 kernel/events/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4c6b320..6c964de 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -132,6 +132,7 @@ task_function_call(struct task_struct *p, remote_function_f func, void *info)
 
 /**
  * cpu_function_call - call a function on the cpu
+ * @cpu:	target cpu to queue this function
  * @func:	the function to be called
  * @info:	the function call argument
  *
@@ -11924,6 +11925,7 @@ again:
  * @pid:		target pid
  * @cpu:		target cpu
  * @group_fd:		group leader event fd
+ * @flags:		perf event open flags
  */
 SYSCALL_DEFINE5(perf_event_open,
 		struct perf_event_attr __user *, attr_uptr,
@@ -12380,6 +12382,8 @@ err_fd:
  * @attr: attributes of the counter to create
  * @cpu: cpu in which the counter is bound
  * @task: task to profile (NULL for percpu)
+ * @overflow_handler: callback to trigger when we hit the event
+ * @context: context data could be used in overflow_handler callback
  */
 struct perf_event *
 perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
