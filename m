Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C1D45F5D2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 26 Nov 2021 21:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240985AbhKZU2W (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 26 Nov 2021 15:28:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33310 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239629AbhKZU0N (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 26 Nov 2021 15:26:13 -0500
Date:   Fri, 26 Nov 2021 20:22:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637958179;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BZAYR7VfJq+dG/i2fB5+NX2xGd1XhV+TanPGPdmjyIc=;
        b=WTAdHCv/bhtpKbaEXWmV4+s97QjVYRI0yg5UfPioxKIrd/eHtgLEM5peZduv1FZrsRt6Vb
        ZlSKzFfSqj+AuYBpN8B4GNw2QJc/SRrbXy7HTHPXM8NA1mMKhlkhKwOjqoEcvi76ZoGC66
        FkkLh3zUygZGTBlgOdKu2OTnPlxMuqHHkyvoekr9iKKF3wCNHHLccr9mXlgwVqBzWO5xgY
        htEEnCgOqdbO3VVYlYV5/oBnei0yDOAGY8xKQucJdmzuqceFCwI+0uUBPKtyOPKOaaLdPO
        GO0UX+g/K6jMI3nE2iWeb3zbTXCql35X3QHrWwtkoCDkrX6ZAgQLDGrjTZRHAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637958179;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BZAYR7VfJq+dG/i2fB5+NX2xGd1XhV+TanPGPdmjyIc=;
        b=nc+B88pfdH9SK7GudiP+PEB0W/swEqWB0nwVG4s1jTK5QG+Izvcvd1ZUl4cyZCc4jqG1qk
        uVYgl++ndgdhQABA==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] alpha: Snapshot thread flags
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Richard Henderson <rth@twiddle.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211117163050.53986-5-mark.rutland@arm.com>
References: <20211117163050.53986-5-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <163795817839.11128.17610058298334871379.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     b8cdd8873327b967fe088ffab84c1f9456ef1767
Gitweb:        https://git.kernel.org/tip/b8cdd8873327b967fe088ffab84c1f9456ef1767
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 17 Nov 2021 16:30:42 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 26 Nov 2021 21:20:13 +01:00

alpha: Snapshot thread flags

Some thread flags can be set remotely, and so even when IRQs are
disabled, the flags can change under our feet. Generally this is
unlikely to cause a problem in practice, but it is somewhat unsound, and
KCSAN will legitimately warn that there is a data race.

To avoid such issues, a snapshot of the flags has to be taken prior to
using them. Some places already use READ_ONCE() for that, others do not.

Convert them all to the new flag accessor helpers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Link: https://lore.kernel.org/r/20211117163050.53986-5-mark.rutland@arm.com
---
 arch/alpha/kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/signal.c b/arch/alpha/kernel/signal.c
index bc077ba..d8ed71d 100644
--- a/arch/alpha/kernel/signal.c
+++ b/arch/alpha/kernel/signal.c
@@ -535,6 +535,6 @@ do_work_pending(struct pt_regs *regs, unsigned long thread_flags,
 			}
 		}
 		local_irq_disable();
-		thread_flags = current_thread_info()->flags;
+		thread_flags = read_thread_flags();
 	} while (thread_flags & _TIF_WORK_MASK);
 }
