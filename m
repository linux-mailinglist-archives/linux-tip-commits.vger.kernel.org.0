Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3061288F63
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 19:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389972AbgJIRBb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 13:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389948AbgJIRB1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 13:01:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D792C0613D5;
        Fri,  9 Oct 2020 10:01:27 -0700 (PDT)
Date:   Fri, 09 Oct 2020 17:01:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602262885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YgofgssIpxJD+MJd9wmuA+oG6UILiKSR8ZUcMt4MrNk=;
        b=canY2c/UmMDSdDS+10F/QLhpBy8iQlHo77YuH23ZMJIEJNthv+u2BUQRgCesS0Ipdz+c99
        du0Cx3pniak5JUTR2Pb9SB8MqyWd/GtxiaQpvNeoVqwjBJs9KxbHk6/EDE8PdsfGztbuYa
        etBJP5Fymh1pprx4OGAW+Mv5dsjCKI1HuMk9iB4loM+DNUOxO1vv33N9nNO0TIufwgriVE
        rvXrSjCgPxKcgCakQyHu1dVBKxskwArwTYHN/4u7jr47x6tBOTo6GIjkDKUCxwr6SWLLIQ
        0sGGYFFCSIPDxnB8xnQnW1zRZOkvTX+VTKn/b17vgp+yFLgbaPM9JuhwHA/Stg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602262885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YgofgssIpxJD+MJd9wmuA+oG6UILiKSR8ZUcMt4MrNk=;
        b=u7cL2Yo1ew+fmu7IEy9LlcP/E23rgiSN520/fT/EvzZCJ8/n5CMmt1Gp/wIOzJA3mpCru9
        38XQlUGnz0i8DNBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] ARM: Cleanup PREEMPT_COUNT leftovers
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160226288496.7002.1274806219589199865.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     87f3bae4f141fd3d690e13bf09a6abb773c717a7
Gitweb:        https://git.kernel.org/tip/87f3bae4f141fd3d690e13bf09a6abb773c717a7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Sep 2020 19:31:57 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 28 Sep 2020 16:03:21 -07:00

ARM: Cleanup PREEMPT_COUNT leftovers

CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
removed. Cleanup the leftovers before doing so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/arm/include/asm/assembler.h   | 11 -----------
 arch/arm/kernel/iwmmxt.S           |  2 --
 arch/arm/mach-ep93xx/crunch-bits.S |  2 --
 3 files changed, 15 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index feac2c8..fce52ee 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -212,7 +212,6 @@
 /*
  * Increment/decrement the preempt count.
  */
-#ifdef CONFIG_PREEMPT_COUNT
 	.macro	inc_preempt_count, ti, tmp
 	ldr	\tmp, [\ti, #TI_PREEMPT]	@ get preempt count
 	add	\tmp, \tmp, #1			@ increment it
@@ -229,16 +228,6 @@
 	get_thread_info \ti
 	dec_preempt_count \ti, \tmp
 	.endm
-#else
-	.macro	inc_preempt_count, ti, tmp
-	.endm
-
-	.macro	dec_preempt_count, ti, tmp
-	.endm
-
-	.macro	dec_preempt_count_ti, ti, tmp
-	.endm
-#endif
 
 #define USERL(l, x...)				\
 9999:	x;					\
diff --git a/arch/arm/kernel/iwmmxt.S b/arch/arm/kernel/iwmmxt.S
index 0dcae78..1f845be 100644
--- a/arch/arm/kernel/iwmmxt.S
+++ b/arch/arm/kernel/iwmmxt.S
@@ -94,9 +94,7 @@ ENTRY(iwmmxt_task_enable)
 	mov	r2, r2				@ cpwait
 	bl	concan_save
 
-#ifdef CONFIG_PREEMPT_COUNT
 	get_thread_info r10
-#endif
 4:	dec_preempt_count r10, r3
 	ret	r9				@ normal exit from exception
 
diff --git a/arch/arm/mach-ep93xx/crunch-bits.S b/arch/arm/mach-ep93xx/crunch-bits.S
index fb2dbf7..0aabcf4 100644
--- a/arch/arm/mach-ep93xx/crunch-bits.S
+++ b/arch/arm/mach-ep93xx/crunch-bits.S
@@ -191,9 +191,7 @@ crunch_load:
 	cfldr64		mvdx15, [r0, #CRUNCH_MVDX15]
 
 1:
-#ifdef CONFIG_PREEMPT_COUNT
 	get_thread_info r10
-#endif
 2:	dec_preempt_count r10, r3
 	ret	lr
 
