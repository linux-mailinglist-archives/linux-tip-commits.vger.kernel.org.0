Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E812C218447
	for <lists+linux-tip-commits@lfdr.de>; Wed,  8 Jul 2020 11:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgGHJwR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 8 Jul 2020 05:52:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48176 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgGHJv6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 8 Jul 2020 05:51:58 -0400
Date:   Wed, 08 Jul 2020 09:51:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594201916;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZYBwRaqcxgn+XMoGe3mL1BKkwzTwL8McDCTncXMpY4Y=;
        b=tI22gLbF2Jb8QflLTiD78wkFexT+0SwmX6jQ9PzKK7q+GS8lS6FOYbh0BaazAXZkFjQkmZ
        EW9vVZd4u+6sbTeT12a7DuCRLrmBChxnhTM2IgofxB5WIZdlGDNJAwWc99vmKRgqupzvP5
        o+82zoxem68ck5uFisou5dfnZ9nw+0PwIBSZDepV0+Omtwq3sHYLIUbN8qIQT5Pjwy7Ofc
        h01zh3Y1fmGkxQ61oKbvopwxIjCqJ0qmsWOVfR1DlymSJA7AAiE6rmQfmTSMAqd6ERjm3t
        uAJb5wKfty9svsRVeVWq8E+s4f4gJE5jlmIIFfb055znmq1Vd0P5k0Zs340fjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594201916;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZYBwRaqcxgn+XMoGe3mL1BKkwzTwL8McDCTncXMpY4Y=;
        b=sovHU6CWDTn3adq0atjjPoIgNyQrQtf6cZcrzhfpH8HqKlVh1LNW6YEElg5cyHXKkdK29e
        ctaZ1VVCI79PRHCw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/cpufeatures: Add Architectural LBRs feature bit
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1593780569-62993-2-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159420191583.4006.10876391642907607745.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     bd657aa3dd8514e62486ce7f90b5e484c18d684d
Gitweb:        https://git.kernel.org/tip/bd657aa3dd8514e62486ce7f90b5e484c18d684d
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 03 Jul 2020 05:49:07 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:38:51 +02:00

x86/cpufeatures: Add Architectural LBRs feature bit

CPUID.(EAX=07H, ECX=0):EDX[19] indicates whether an Intel CPU supports
Architectural LBRs.

The "X86_FEATURE_..., word 18" is already mirrored from CPUID
"0x00000007:0 (EDX)". Add X86_FEATURE_ARCH_LBR under the "word 18"
section.

The feature will appear as "arch_lbr" in /proc/cpuinfo.

The Architectural Last Branch Records (LBR) feature enables recording
of software path history by logging taken branches and other control
flows. The feature will be supported in the perf_events subsystem.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Link: https://lkml.kernel.org/r/1593780569-62993-2-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 02dabc9..72ba4c5 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -366,6 +366,7 @@
 #define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
 #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
 #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
+#define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_FLUSH_L1D		(18*32+28) /* Flush L1D cache */
