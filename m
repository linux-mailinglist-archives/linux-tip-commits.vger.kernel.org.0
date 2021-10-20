Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C415F434C6E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhJTNrI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:47:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53014 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhJTNq4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:46:56 -0400
Date:   Wed, 20 Oct 2021 13:44:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634737481;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pwkQsJD94FYeMugZQnvlBYCPTvu9wQ94vNIGshthPho=;
        b=YokL07OtTsTavRHqQywqqOPhHBK7iSedxy3jG1A5ITliWekFb09/PvgVrOub0zkXkauJgR
        +dLXH1li8VtyliXVQUi9wO+S1ihQGnSGb1LjJa4lqJZLlkAx8Ualxf0a91lqqjD5EwI0EJ
        SMZ2ZJ3KjoX1gcnAXlkQu0jfzb/Z6VQg1DnXhMhoz8W3hJxmv428PN6sQEhCA79xjl8pUK
        k2UipMtJ/LPBsTafsMjxp26M5zPhnKPCU5g8r5G1VCkSdNdxoVB433U5wlOYpTcn0XBrLO
        ItVGbYN4FM/5KrItuUxBzBwuDbiC/JujT14IwH/tFX12UgZPk1Qpfs5C5tHvyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634737481;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pwkQsJD94FYeMugZQnvlBYCPTvu9wQ94vNIGshthPho=;
        b=NOuyfk3LnF5eNbvRW7+jQtMw+IRVlgL1B5z98YoAO3ruliO/c+LoORfAr7avQwJA28CdN9
        z/rOUIuttIwA7fCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Provide and use for_each_xfeature()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211015011538.958107505@linutronix.de>
References: <20211015011538.958107505@linutronix.de>
MIME-Version: 1.0
Message-ID: <163473748028.25758.17286138378994955130.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     ffd3e504c9e0de8b85755f3c7eabbbdd984cfeed
Gitweb:        https://git.kernel.org/tip/ffd3e504c9e0de8b85755f3c7eabbbdd984cfeed
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 03:16:09 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 15:27:26 +02:00

x86/fpu/xstate: Provide and use for_each_xfeature()

These loops evaluating xfeature bits are really hard to read. Create an
iterator and use for_each_set_bit_from() inside which already does the right
thing.

No functional changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211015011538.958107505@linutronix.de
---
 arch/x86/kernel/fpu/xstate.c | 56 ++++++++++++++---------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 259951d..a2bdc0c 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -4,6 +4,7 @@
  *
  * Author: Suresh Siddha <suresh.b.siddha@intel.com>
  */
+#include <linux/bitops.h>
 #include <linux/compat.h>
 #include <linux/cpu.h>
 #include <linux/mman.h>
@@ -20,6 +21,10 @@
 
 #include "xstate.h"
 
+#define for_each_extended_xfeature(bit, mask)				\
+	(bit) = FIRST_EXTENDED_XFEATURE;				\
+	for_each_set_bit_from(bit, (unsigned long *)&(mask), 8 * sizeof(mask))
+
 /*
  * Although we spell it out in here, the Processor Trace
  * xfeature is completely unused.  We use other mechanisms
@@ -184,10 +189,7 @@ static void __init setup_xstate_features(void)
 	xstate_sizes[XFEATURE_SSE]	= sizeof_field(struct fxregs_state,
 						       xmm_space);
 
-	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
-		if (!xfeature_enabled(i))
-			continue;
-
+	for_each_extended_xfeature(i, xfeatures_mask_all) {
 		cpuid_count(XSTATE_CPUID, i, &eax, &ebx, &ecx, &edx);
 
 		xstate_sizes[i] = eax;
@@ -291,20 +293,15 @@ static void __init setup_xstate_comp_offsets(void)
 	xstate_comp_offsets[XFEATURE_SSE] = offsetof(struct fxregs_state,
 						     xmm_space);
 
-	if (!boot_cpu_has(X86_FEATURE_XSAVES)) {
-		for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
-			if (xfeature_enabled(i))
-				xstate_comp_offsets[i] = xstate_offsets[i];
-		}
+	if (!cpu_feature_enabled(X86_FEATURE_XSAVES)) {
+		for_each_extended_xfeature(i, xfeatures_mask_all)
+			xstate_comp_offsets[i] = xstate_offsets[i];
 		return;
 	}
 
 	next_offset = FXSAVE_SIZE + XSAVE_HDR_SIZE;
 
-	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
-		if (!xfeature_enabled(i))
-			continue;
-
+	for_each_extended_xfeature(i, xfeatures_mask_all) {
 		if (xfeature_is_aligned(i))
 			next_offset = ALIGN(next_offset, 64);
 
@@ -328,8 +325,8 @@ static void __init setup_supervisor_only_offsets(void)
 
 	next_offset = FXSAVE_SIZE + XSAVE_HDR_SIZE;
 
-	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
-		if (!xfeature_enabled(i) || !xfeature_is_supervisor(i))
+	for_each_extended_xfeature(i, xfeatures_mask_all) {
+		if (!xfeature_is_supervisor(i))
 			continue;
 
 		if (xfeature_is_aligned(i))
@@ -347,9 +344,7 @@ static void __init print_xstate_offset_size(void)
 {
 	int i;
 
-	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
-		if (!xfeature_enabled(i))
-			continue;
+	for_each_extended_xfeature(i, xfeatures_mask_all) {
 		pr_info("x86/fpu: xstate_offset[%d]: %4d, xstate_sizes[%d]: %4d\n",
 			 i, xstate_comp_offsets[i], i, xstate_sizes[i]);
 	}
@@ -554,10 +549,7 @@ static void do_extra_xstate_size_checks(void)
 	int paranoid_xstate_size = FXSAVE_SIZE + XSAVE_HDR_SIZE;
 	int i;
 
-	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
-		if (!xfeature_enabled(i))
-			continue;
-
+	for_each_extended_xfeature(i, xfeatures_mask_all) {
 		check_xstate_against_struct(i);
 		/*
 		 * Supervisor state components can be managed only by
@@ -586,7 +578,6 @@ static void do_extra_xstate_size_checks(void)
 	XSTATE_WARN_ON(paranoid_xstate_size != fpu_kernel_xstate_size);
 }
 
-
 /*
  * Get total size of enabled xstates in XCR0 | IA32_XSS.
  *
@@ -969,6 +960,7 @@ void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
 	struct xregs_state *xinit = &init_fpstate.xsave;
 	struct xstate_header header;
 	unsigned int zerofrom;
+	u64 mask;
 	int i;
 
 	memset(&header, 0, sizeof(header));
@@ -1022,17 +1014,15 @@ void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
 
 	zerofrom = offsetof(struct xregs_state, extended_state_area);
 
-	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
-		/*
-		 * The ptrace buffer is in non-compacted XSAVE format.
-		 * In non-compacted format disabled features still occupy
-		 * state space, but there is no state to copy from in the
-		 * compacted init_fpstate. The gap tracking will zero this
-		 * later.
-		 */
-		if (!(xfeatures_mask_uabi() & BIT_ULL(i)))
-			continue;
+	/*
+	 * The ptrace buffer is in non-compacted XSAVE format.  In
+	 * non-compacted format disabled features still occupy state space,
+	 * but there is no state to copy from in the compacted
+	 * init_fpstate. The gap tracking will zero these states.
+	 */
+	mask = xfeatures_mask_uabi();
 
+	for_each_extended_xfeature(i, mask) {
 		/*
 		 * If there was a feature or alignment gap, zero the space
 		 * in the destination buffer.
