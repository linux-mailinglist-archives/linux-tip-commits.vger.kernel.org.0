Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1284A433A34
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Oct 2021 17:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbhJSPZS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 19 Oct 2021 11:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbhJSPZS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 19 Oct 2021 11:25:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55740C06161C;
        Tue, 19 Oct 2021 08:23:05 -0700 (PDT)
Date:   Tue, 19 Oct 2021 15:23:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634656983;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8oIhw1V+D9EWudXItX59MZmRyRriR+/LqVGZE2btCEk=;
        b=KDp7Ot57iWyu9oJP8p2yUF3XhhbdtxeVcHu4vdhfdZnwA4TcQZzO1DLTGxhM1uDOmOwL7P
        +VeFYiOfsDLUaRCAhgYsJdwNfYfxVd+P4f2zGbYFqKZt2kXXusNzpStRBXKi7tUQZ1xNmO
        ZPo3lXRlPy/b7/Qa1+YVX4eNSi6jqgCA9h/q7ZdlXhBB0XoM9veh5uE09BTbFq2LdXDftf
        xw36QHEAhh3L7jNWZ8fthEg7rGxhcCAdVQ0RFjJLViUlXzleyIiRoU6KSVkuVwq+5QK2EC
        +RlND0/j5cSey03MhA+3gqydI3XKPzy3y2ciHHRedeWNzYF5/ottk5IMsyAGxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634656983;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8oIhw1V+D9EWudXItX59MZmRyRriR+/LqVGZE2btCEk=;
        b=JIZf0/YMxkJBwFI2r/+7QriKKyGmbqHVueO0reofx3ZaBmd4oUyDIG75FSAM5/4aQJF/S0
        RtnxQDkP7WFTa8AA==
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
Message-ID: <163465698182.25758.5265949885721821003.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     45dfb89b8f96643268449c25d7025b17de46717c
Gitweb:        https://git.kernel.org/tip/45dfb89b8f96643268449c25d7025b17de46717c
Author:        Woody Lin <woodylin@google.com>
AuthorDate:    Tue, 12 Oct 2021 16:35:21 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 18 Oct 2021 16:58:41 +02:00

sched/scs: Reset the shadow stack when idle_task_exit

There was a 'init_idle' that resets scs sp to base, but is removed by
f1a0a376ca0c. Without the resetting, the hot-plugging implemented by
cpu_psci_cpu_boot will use the previous scs sp as new base when starting
up a CPU core, so the usage on scs page is being stacked up until
overflow.

This only happens on idle task since __cpu_up is using idle task as the
main thread to start up a CPU core, so the overflow can be fixed by
resetting scs sp to base in 'idle_task_exit'.

Fixes: f1a0a376ca0c ("sched/core: Initialize the idle task with preemption disabled")
Signed-off-by: Woody Lin <woodylin@google.com>
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
 
