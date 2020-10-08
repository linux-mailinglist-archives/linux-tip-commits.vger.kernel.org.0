Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA68028752E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Oct 2020 15:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgJHNT7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 8 Oct 2020 09:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgJHNT7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 8 Oct 2020 09:19:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1D4C061755;
        Thu,  8 Oct 2020 06:19:58 -0700 (PDT)
Date:   Thu, 08 Oct 2020 13:19:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602163197;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EG9ZlchHlc+2jUhtfi09OQdoBZEh71inrCFmLU+JAzE=;
        b=i2At+S4uFkZJDPPqOsm7GM7DRF476QnWN/Jd7L5X0K50UqzSQWfz/7cio32LBIqJ8ta++4
        4l0rEwTwVX1Eav/IDWARNdrrSq7LGYx2obtANp1UQ51grkv5ia8LdqrGBOMh02LL7Dqis2
        yxqh8YvkdCubgndmHAicHlxMXcWSvdcq+INjzTuZqayXZwmNmazA+29bJqkmUXD1PCu0gD
        5PijDDbK2et9OvpMt+6MRWpjR6MzTONRO6nDY3U341ObrVpC/fUy3ERtAEE6vo7Px1JZld
        7rYhkmCoMFZ39jGbn1qtt5tuZ/ORO2O615Al0d9TXxwySg8s6XHwMUAWRpQ+PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602163197;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EG9ZlchHlc+2jUhtfi09OQdoBZEh71inrCFmLU+JAzE=;
        b=j7zZ2t91H7FTYNZw7ojG6SB3mbIZgH9D9lByDkHtXPZKScLBFXi4UwfWcHX/w4joyTFL69
        pc/swEywfy3cxOAg==
From:   "tip-bot2 for Kajol Jain" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Fix task_function_call() error handling
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Barret Rhoden <brho@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200827064732.20860-1-kjain@linux.ibm.com>
References: <20200827064732.20860-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <160216319621.7002.17454541069760802602.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     84ad70320241566e028ada955c694ab92f3351e3
Gitweb:        https://git.kernel.org/tip/84ad70320241566e028ada955c694ab92f3351e3
Author:        Kajol Jain <kjain@linux.ibm.com>
AuthorDate:    Thu, 27 Aug 2020 12:17:32 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 08 Oct 2020 15:16:29 +02:00

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
Reviewed-by: Barret Rhoden <brho@google.com>
Tested-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Link: https://lkml.kernel.org/r/20200827064732.20860-1-kjain@linux.ibm.com
---
 kernel/events/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 45edb85..85a6e7f 100644
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
