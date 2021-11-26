Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE8745F5E2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 26 Nov 2021 21:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243830AbhKZU3W (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 26 Nov 2021 15:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbhKZU1W (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 26 Nov 2021 15:27:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920D1C06175D;
        Fri, 26 Nov 2021 12:22:57 -0800 (PST)
Date:   Fri, 26 Nov 2021 20:22:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637958176;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fVBYh1qUmPe5lTdhTdOr1mhFNvYWAK8W4vGjKSIG364=;
        b=LRrqhu5Jtt/D/ts+jz6XDBS94TZKs2nja05bLNDtHAIGUatJ0FAiN2oqyc+CPqaRG4jMNJ
        ojJAyICfPgd+LUBKw27CNp+TJDw9cu+oxEbD9khK2kLpgYhgIFn096E755JoVwS3ZXfCV3
        ySJ6QPJ/gExiZsYsqrapbVegiZgdUQUd7cm1FbCMdRHlLbU6un2iSC7vylYDYHU2/NYTA2
        rss0EnHsTgLTmQuKjpMETmJdYMlYN1908CbQt0Iwm0Xh4xkOYFh1HV4xDIpWIEwgLGg6Gd
        7ArHMo7mqmQjcKZHomI03Wn5Z7nHIfgnC1/KaLXcBikNSqHWprSlkAGvg+SNhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637958176;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fVBYh1qUmPe5lTdhTdOr1mhFNvYWAK8W4vGjKSIG364=;
        b=bMJRUp+qaKlVVLwheBvMGBlWz5ocx7qTCHwviBZOQynapKW0xusMQlr+X1JIcM4I8SJ8U0
        tY6d/ptxSCPdYdDA==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] openrisc: Snapshot thread flags
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stafford Horne <shorne@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211117163050.53986-9-mark.rutland@arm.com>
References: <20211117163050.53986-9-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <163795817522.11128.15271812032660159571.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     b67c4b87d2a6893dd6bddc8b0400715cafc30cd5
Gitweb:        https://git.kernel.org/tip/b67c4b87d2a6893dd6bddc8b0400715cafc30cd5
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 17 Nov 2021 16:30:46 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 26 Nov 2021 21:20:13 +01:00

openrisc: Snapshot thread flags

Some thread flags can be set remotely, and so even when IRQs are
disabled, the flags can change under our feet. Generally this is
unlikely to cause a problem in practice, but it is somewhat unsound, and
KCSAN will legitimately warn that there is a data race.

To avoid such issues, a snapshot of the flags has to be taken prior to
using them. Some places already use READ_ONCE() for that, others do not.

Convert them all to the new flag accessor helpers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Stafford Horne <shorne@gmail.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Link: https://lore.kernel.org/r/20211117163050.53986-9-mark.rutland@arm.com
---
 arch/openrisc/kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
index 99516c9..92c5b70 100644
--- a/arch/openrisc/kernel/signal.c
+++ b/arch/openrisc/kernel/signal.c
@@ -313,7 +313,7 @@ do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
 			}
 		}
 		local_irq_disable();
-		thread_flags = current_thread_info()->flags;
+		thread_flags = read_thread_flags();
 	} while (thread_flags & _TIF_WORK_MASK);
 	return 0;
 }
