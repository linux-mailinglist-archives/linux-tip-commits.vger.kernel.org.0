Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49819288F74
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 19:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390058AbgJIRCG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 13:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389742AbgJIRB1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 13:01:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AC2C0613D2;
        Fri,  9 Oct 2020 10:01:26 -0700 (PDT)
Date:   Fri, 09 Oct 2020 17:01:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602262885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=puCn/UtJYWxNuVq662+OniL9CqCjFEfaF9WMM5crHRo=;
        b=uC/NGtQ1QXtMpDbM0gPISrmsc4DYMOpWprY1BKWXzSoFZHfxOa85tiqJeQIHbiKXHumZHu
        6xsjXDKJ7aq61kRgL+jXAx0LvlQqO9kr2nnqnBL7RSLf7BVoYQozHI5Wm0uOgLmADR4G56
        FwtUusOnlikqyfenFlTZFrL2ySJih7Jrw75br0eobuPV5hz4DZBp4qOtCQTfngPtp6tonB
        1RXHhQTir1PDRd4VJf9EQ9deWkhxFczGeYyBA4UVmH2f0Hh4NDP2nAoIAlieiDGV7oYykr
        vMHALCDjABNWfGPTYeYQBahdlZp6QYXhpcTd1ebsN5xcUuLwYH2VLuXybeGs2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602262885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=puCn/UtJYWxNuVq662+OniL9CqCjFEfaF9WMM5crHRo=;
        b=960VCbyhNVjBcc61fhGknINbWoHtcC0ghv8wDBm+4vuTaOCuVCaTNh4ECNTJAMynddiIx6
        j+B+5AkP0U2YTyBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] xtensa: Cleanup PREEMPT_COUNT leftovers
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160226288442.7002.6957761201817998290.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     68e10f9fe712edbc69be2a1e2914ea6e31a9283f
Gitweb:        https://git.kernel.org/tip/68e10f9fe712edbc69be2a1e2914ea6e31a9283f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Sep 2020 19:33:53 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 28 Sep 2020 16:03:22 -07:00

xtensa: Cleanup PREEMPT_COUNT leftovers

CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
removed. Cleanup the leftovers before doing so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/xtensa/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index 703cf62..5a27dd3 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -819,7 +819,7 @@ ENTRY(debug_exception)
 	 * preemption if we have HW breakpoints to preserve DEBUGCAUSE.DBNUM
 	 * meaning.
 	 */
-#if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_HAVE_HW_BREAKPOINT)
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
 	GET_THREAD_INFO(a2, a1)
 	l32i	a3, a2, TI_PRE_COUNT
 	addi	a3, a3, 1
