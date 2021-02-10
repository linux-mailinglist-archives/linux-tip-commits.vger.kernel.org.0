Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CC431688F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 15:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhBJOA3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 09:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhBJOAZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 09:00:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CE6C061788;
        Wed, 10 Feb 2021 05:59:28 -0800 (PST)
Date:   Wed, 10 Feb 2021 13:59:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612965566;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5jAdhnlW0nGE7VLL8H6UNIFgCTpB00SbcsNVapYSPNw=;
        b=GpCMnoN+AKP1P6wOZpxIBpM8T997wGK1JKYmA159DXh5G7pOqN1fETfUTwJUFzynDxdJsB
        +xfNT1Uk7Nm8NAfjNhRjupERkLSDmDUlcbpMX1dw0B817jO66MF+r3VA3WYWm3jrMawu66
        XB6isg0kvH4SB9igaLOIfqhtQ5Dqfgx/5svdFhl++0n6meVTikvYHyGaapAhfoLUKwFlK6
        Frv7rQTAd52ilLyDrSRtoY7HuD5ihH2MDKlPiFrObIN+2dREe2IGI7X9vvM8FnBcMPkawz
        XmewVPxy3nxKvvKwbrow1L4B9n18x4A0tKCgB4yy1XSpEyC1gE071xhX4NO0cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612965566;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5jAdhnlW0nGE7VLL8H6UNIFgCTpB00SbcsNVapYSPNw=;
        b=LuRr+sG0xchAqK/fThdxAgOeVnfRM/0XNAnd7CwP1xws9bCpHVqs91+MCYcwfasfVx6Bsz
        UA2U/B9YkHqRKZBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Noinstr annotate warn_bogus_irq_restore()
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YCKyYg53mMp4E7YI@hirez.programming.kicks-ass.net>
References: <YCKyYg53mMp4E7YI@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <161296556600.23325.14185228723423902592.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c8cc7e853192d520ab6a5957f5081034103587ae
Gitweb:        https://git.kernel.org/tip/c8cc7e853192d520ab6a5957f5081034103587ae
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 09 Feb 2021 09:30:03 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 10 Feb 2021 14:44:39 +01:00

lockdep: Noinstr annotate warn_bogus_irq_restore()

  vmlinux.o: warning: objtool: lock_is_held_type()+0x107: call to warn_bogus_irq_restore() leaves .noinstr.text section

As per the general rule that WARNs are allowed to violate noinstr to
get out, annotate it away.

Fixes: 997acaf6b4b5 ("lockdep: report broken irq restoration")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Link: https://lkml.kernel.org/r/YCKyYg53mMp4E7YI@hirez.programming.kicks-ass.net
---
 kernel/locking/irqflag-debug.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/irqflag-debug.c b/kernel/locking/irqflag-debug.c
index 9603d20..810b503 100644
--- a/kernel/locking/irqflag-debug.c
+++ b/kernel/locking/irqflag-debug.c
@@ -4,8 +4,10 @@
 #include <linux/export.h>
 #include <linux/irqflags.h>
 
-void warn_bogus_irq_restore(void)
+noinstr void warn_bogus_irq_restore(void)
 {
+	instrumentation_begin();
 	WARN_ONCE(1, "raw_local_irq_restore() called with IRQs enabled\n");
+	instrumentation_end();
 }
 EXPORT_SYMBOL(warn_bogus_irq_restore);
