Return-Path: <linux-tip-commits+bounces-2278-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF59972BC6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 10:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4031C23E25
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 08:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8D319408D;
	Tue, 10 Sep 2024 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FyNMLXej";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oaizCBe2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCCF192D60;
	Tue, 10 Sep 2024 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955774; cv=none; b=GMwGTVdWEINgdER8gBNAxLAEiA6iso7I3Z95qhyp0rMjWmIEOivkYYO7nOSN5rNAFgEJXg93pH82YZ/8wCuZZ0m1He6kXvBYnMQMDHR3CTCsuRnBbQtq6yQ3xDcfWRiT6hUpemJvknTcYH25BfFY3Jm55OhMnxC35rYmoUwXAOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955774; c=relaxed/simple;
	bh=z22C9uIORlVMBPpciNL8kzYw7JEwojnLJgzsv+J8DSk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=OFBluRsyp58JB36v7nNhwD19gU55MbwFybf7Dg7Ak5expJGcarc8cvAVUpYVIWZZQeG2zLeQzQDLP7YubSlBSkEZDHaDYOqtm1d0Y/VHLkGCZeE/Ijy088LTsDVEEOOLw+OZScfRrvj40JDovMs0MLAWV2ahOVSStUXrOiyKTDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FyNMLXej; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oaizCBe2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Sep 2024 08:09:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725955764;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=guDf9yJzRbqzc6KKaYls37WnmSUS1xaDIoHD4mWFdtY=;
	b=FyNMLXejgH2gkFeSEQPmIJ2RI6DanzjjWoSzOh3BeajrBx+l/USMoRPjPiEvB8ejhRK0W5
	P9POx0VCWpIS6otrGM1UseA6nLdt5DCNrSdmtMgpA3Gw5GMm3U4WC1mGzsaEPk+4Dp3PiH
	eGkfjYo04pa23pXE8hQUivOKxo4wPDhnhyhIrdLIHyNVSquk5GNXzbq6o5OEDVtQWjHroY
	OSRr2/hEw+xg+9Cpn74bqP8LYPrraveFK/f8npNfCWV7DdbfmiCUixMohnBnotZyRZ0dzO
	hohAZH++VQUqcc2rbGnXVXTtEF4dJAW7iR4I5L0o8xQhl69vN6HHVUdxhSBtaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725955764;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=guDf9yJzRbqzc6KKaYls37WnmSUS1xaDIoHD4mWFdtY=;
	b=oaizCBe2OF50iDfrlkQoRFrzOp578R0x1VuYlUANNnqSq4L6kwQHYsGnM0YNXvtJ4ed2OE
	HUZCDwReYJfzPuBQ==
From: "tip-bot2 for Chen Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] kthread: Fix task state in kthread worker if being frozen
Cc: Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Chen Yu <yu.c.chen@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172595576391.2215.16353437152626918372.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6b9ccbc033cf179956a37fef3ee415bdc3029d2f
Gitweb:        https://git.kernel.org/tip/6b9ccbc033cf179956a37fef3ee415bdc3029d2f
Author:        Chen Yu <yu.c.chen@intel.com>
AuthorDate:    Tue, 27 Aug 2024 19:23:08 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Sep 2024 09:51:14 +02:00

kthread: Fix task state in kthread worker if being frozen

When analyzing a kernel waring message, Peter pointed out that there is a race
condition when the kworker is being frozen and falls into try_to_freeze() with
TASK_INTERRUPTIBLE, which could trigger a might_sleep() warning in try_to_freeze().
Although the root cause is not related to freeze()[1], it is still worthy to fix
this issue ahead.

One possible race scenario:

        CPU 0                                           CPU 1
        -----                                           -----

        // kthread_worker_fn
        set_current_state(TASK_INTERRUPTIBLE);
                                                       suspend_freeze_processes()
                                                         freeze_processes
                                                           static_branch_inc(&freezer_active);
                                                         freeze_kernel_threads
                                                           pm_nosig_freezing = true;
        if (work) { //false
          __set_current_state(TASK_RUNNING);

        } else if (!freezing(current)) //false, been frozen

                      freezing():
                      if (static_branch_unlikely(&freezer_active))
                        if (pm_nosig_freezing)
                          return true;
          schedule()
	}

        // state is still TASK_INTERRUPTIBLE
        try_to_freeze()
          might_sleep() <--- warning

Fix this by explicitly set the TASK_RUNNING before entering
try_to_freeze().

Fixes: b56c0d8937e6 ("kthread: implement kthread_worker")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/Zs2ZoAcUsZMX2B%2FI@chenyu5-mobl2/ [1]
---
 kernel/kthread.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index f7be976..db4ceb0 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -845,8 +845,16 @@ repeat:
 		 * event only cares about the address.
 		 */
 		trace_sched_kthread_work_execute_end(work, func);
-	} else if (!freezing(current))
+	} else if (!freezing(current)) {
 		schedule();
+	} else {
+		/*
+		 * Handle the case where the current remains
+		 * TASK_INTERRUPTIBLE. try_to_freeze() expects
+		 * the current to be TASK_RUNNING.
+		 */
+		__set_current_state(TASK_RUNNING);
+	}
 
 	try_to_freeze();
 	cond_resched();

