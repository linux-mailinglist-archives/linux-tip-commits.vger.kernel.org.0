Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B280433B58
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Oct 2021 17:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhJSP5Y (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 19 Oct 2021 11:57:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46670 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbhJSP5Y (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 19 Oct 2021 11:57:24 -0400
Date:   Tue, 19 Oct 2021 15:55:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634658910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q0wqg1WilDcG0CM6ZfrCSL8XOk8AkPZ5CMcgBwCraMc=;
        b=ZlrL1J/uALw2eZcOqBhTaweZ3K+HZm+zVCgHFvnB9ve6S//rauRyq2udlX6sf346nGsUeC
        Pa1kibaK4094jS6asUw/NS1Kmw5Yd7GjSHj7rRmfDZr5j0K7ZwV4fy39CIMUVsQgS6mzAI
        QF5AwsAX3r77Op6iFsvhBenvz8tyu7A4chASNHGL7ywb0/ySYpPrE0dC0YtGe4EwjuRMu5
        jiBP/KALUMdUQfXmd7zauVKo96miCRte12/xIbH7pGXAYiR4IGJVpcFQJxROpkhaATGDcN
        5toKA2osaVdz/kztZEPSJR9NUfZKrDed2pu2O5U+dJe9HmfZKTetMqxYKcRWmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634658910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q0wqg1WilDcG0CM6ZfrCSL8XOk8AkPZ5CMcgBwCraMc=;
        b=Bw0/pR8X+Aa9790hHlcIEaT+/gilHZEKw2sAHxqjDELWPeaXQz26ZNkEXoX8ETnyky2tPQ
        Hq2iIncofEr2mHAQ==
From:   "tip-bot2 for Woody Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/scs: Reset the shadow stack when idle_task_exit
Cc:     Woody Lin <woodylin@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211012083521.973587-1-woodylin@google.com>
References: <20211012083521.973587-1-woodylin@google.com>
MIME-Version: 1.0
Message-ID: <163465890918.25758.12684036916050863511.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     63acd42c0d4942f74710b11c38602fb14dea7320
Gitweb:        https://git.kernel.org/tip/63acd42c0d4942f74710b11c38602fb14dea7320
Author:        Woody Lin <woodylin@google.com>
AuthorDate:    Tue, 12 Oct 2021 16:35:21 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Oct 2021 17:46:11 +02:00

sched/scs: Reset the shadow stack when idle_task_exit

Commit f1a0a376ca0c ("sched/core: Initialize the idle task with
preemption disabled") removed the init_idle() call from
idle_thread_get(). This was the sole call-path on hotplug that resets
the Shadow Call Stack (scs) Stack Pointer (sp).

Not resetting the scs-sp leads to scs overflow after enough hotplug
cycles. Therefore add an explicit scs_task_reset() to the hotplug code
to make sure the scs-sp does get reset on hotplug.

Fixes: f1a0a376ca0c ("sched/core: Initialize the idle task with preemption disabled")
Signed-off-by: Woody Lin <woodylin@google.com>
[peterz: Changelog]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lore.kernel.org/r/20211012083521.973587-1-woodylin@google.com
---
 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1bba412..f21714e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8795,6 +8795,7 @@ void idle_task_exit(void)
 		finish_arch_post_lock_switch();
 	}
 
+	scs_task_reset(current);
 	/* finish_cpu(), as ran on the BP, will clean up the active_mm state */
 }
 
