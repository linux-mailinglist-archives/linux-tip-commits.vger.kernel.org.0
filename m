Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7573D8B3A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jul 2021 11:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbhG1J6M (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 28 Jul 2021 05:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235837AbhG1J6M (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 28 Jul 2021 05:58:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8857C061764;
        Wed, 28 Jul 2021 02:58:10 -0700 (PDT)
Date:   Wed, 28 Jul 2021 09:58:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627466289;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eOPYEM7Xmg7GkuS+KfLdvPAJppxPxQI6hz+UepjRxK4=;
        b=Eh7R9wWiBIm3+77pckLIdjNqqYNfCOh0ex4YD8t/XZIe1j/9sodzMzxlUNfzjpDnY984KU
        CEWmmGeqMqOzA1D/56/yv0qkTjnsmWOiEyugENECRDCLLBKUfP7MaLEKk3AFsyFivcs29R
        c7GKe8w95sdZpAM7Cgg/7r2sHqLlv7o3TVbI+zjo0imv/faCHql5baAaZlkLCjNggNYQLo
        n/K2jSecejHyVyWjUv//UzjXpH6G70VaGa3z/QPL5k4dV33FyanL/usxK+9Oew9hpK8yBo
        S2tkQ1yEug6T949YD9gWtOu0A620s0WDtmO6Eitm83wiA4OE2QxvuKwqneKfSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627466289;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eOPYEM7Xmg7GkuS+KfLdvPAJppxPxQI6hz+UepjRxK4=;
        b=+liBEPjaYAHdtGhmpA/k6PsopFdvBZnR9G4dPSxVDGiv5BDF9jtw7vItq/9bMOp+EFsndE
        PkbYgKaPUsvJiRDg==
From:   "tip-bot2 for Balbir Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/process: Make room for TIF_SPEC_L1D_FLUSH
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Balbir Singh <sblbir@amazon.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210108121056.21940-1-sblbir@amazon.com>
References: <20210108121056.21940-1-sblbir@amazon.com>
MIME-Version: 1.0
Message-ID: <162746628816.395.429557028719175747.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     8aacd1eab53ec853c2d29cdc9b64e9dc87d2a519
Gitweb:        https://git.kernel.org/tip/8aacd1eab53ec853c2d29cdc9b64e9dc87d2a519
Author:        Balbir Singh <sblbir@amazon.com>
AuthorDate:    Mon, 26 Apr 2021 22:09:43 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Jul 2021 11:42:24 +02:00

x86/process: Make room for TIF_SPEC_L1D_FLUSH

The upcoming support for paranoid L1D flush in switch_mm() requires that
TIF_SPEC_IB and the new TIF_SPEC_L1D_FLUSH are two consecutive bits in
thread_info::flags.

Move TIF_SPEC_FORCE_UPDATE to a spare bit to make room for the new one.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210108121056.21940-1-sblbir@amazon.com
---
 arch/x86/include/asm/thread_info.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index de406d9..d9afd35 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -81,7 +81,6 @@ struct thread_info {
 #define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
 #define TIF_SSBD		5	/* Speculative store bypass disable */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
-#define TIF_SPEC_FORCE_UPDATE	10	/* Force speculation MSR update in context switch */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
 #define TIF_UPROBE		12	/* breakpointed or singlestepping */
 #define TIF_PATCH_PENDING	13	/* pending live patching update */
@@ -93,6 +92,7 @@ struct thread_info {
 #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
 #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
+#define TIF_SPEC_FORCE_UPDATE	23	/* Force speculation MSR update in context switch */
 #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
 #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
@@ -104,7 +104,6 @@ struct thread_info {
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_SSBD		(1 << TIF_SSBD)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
-#define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
@@ -115,6 +114,7 @@ struct thread_info {
 #define _TIF_SLD		(1 << TIF_SLD)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
+#define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
 #define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
