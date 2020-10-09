Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D912B288210
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbgJIGYg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgJIGYg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:24:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD00CC0613D2;
        Thu,  8 Oct 2020 23:24:35 -0700 (PDT)
Date:   Fri, 09 Oct 2020 06:24:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602224673;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1nkbLu7hQZ47JlPjVe6Bgcpd1J54qsyfyMf79/3PLsI=;
        b=JTj/NsO7xxQO1aqOjkanzrVgb90b2Je3tuYw4qlaKZ4BGGOlNZqLJRhGOMX/Awzywk0C9k
        R/mOY3KhvlyLbSqMAo0bt3oTKAIj+A8tmIQfgGtHFyeE7rZ7VSFD9b99uqq8zlRdKZ1iy6
        dGBiT07ydu979tm6othBvn/1LL9WtqFuNDrCARxPF+DrYLY7eItoiUwznd/HHEt8dz4gEY
        y/QpBLCGNvhw+a8jfzUwPs/r1SjQsrgnk9q3N4qY7TvbNU9+2GDuqZkD4syUo/nwyqAiS5
        3leE8oTcD1oHrDWcGaCScYIvCHMWBElWfGTewCYrk4QIHe7WudeRKMMgRKCnaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602224673;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1nkbLu7hQZ47JlPjVe6Bgcpd1J54qsyfyMf79/3PLsI=;
        b=wFH6lRtAO9ntx89saG0yT5qnZjRJL4MBLsLbLnQKU+DwQKl74p4dVB+vCShFLjuhMX9DzL
        8OjryeU/0FP0OyBw==
From:   "tip-bot2 for Kajol Jain" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Fix task_function_call() error handling
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Barret Rhoden <brho@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200827064732.20860-1-kjain@linux.ibm.com>
References: <20200827064732.20860-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <160222467221.7002.13972544073695390160.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     6d6b8b9f4fceab7266ca03d194f60ec72bd4b654
Gitweb:        https://git.kernel.org/tip/6d6b8b9f4fceab7266ca03d194f60ec72bd4b654
Author:        Kajol Jain <kjain@linux.ibm.com>
AuthorDate:    Thu, 27 Aug 2020 12:17:32 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 09 Oct 2020 08:18:33 +02:00

perf: Fix task_function_call() error handling

The error handling introduced by commit:

  2ed6edd33a21 ("perf: Add cond_resched() to task_function_call()")

looses any return value from smp_call_function_single() that is not
{0, -EINVAL}. This is a problem because it will return -EXNIO when the
target CPU is offline. Worse, in that case it'll turn into an infinite
loop.

Fixes: 2ed6edd33a21 ("perf: Add cond_resched() to task_function_call()")
Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Barret Rhoden <brho@google.com>
Tested-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Link: https://lkml.kernel.org/r/20200827064732.20860-1-kjain@linux.ibm.com
---
 kernel/events/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7ed5248..e8bf922 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -99,7 +99,7 @@ static void remote_function(void *data)
  * retry due to any failures in smp_call_function_single(), such as if the
  * task_cpu() goes offline concurrently.
  *
- * returns @func return value or -ESRCH when the process isn't running
+ * returns @func return value or -ESRCH or -ENXIO when the process isn't running
  */
 static int
 task_function_call(struct task_struct *p, remote_function_f func, void *info)
@@ -115,7 +115,8 @@ task_function_call(struct task_struct *p, remote_function_f func, void *info)
 	for (;;) {
 		ret = smp_call_function_single(task_cpu(p), remote_function,
 					       &data, 1);
-		ret = !ret ? data.ret : -EAGAIN;
+		if (!ret)
+			ret = data.ret;
 
 		if (ret != -EAGAIN)
 			break;
