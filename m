Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A6322EC71
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Jul 2020 14:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgG0MqW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 27 Jul 2020 08:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgG0MqV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 27 Jul 2020 08:46:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CED7C0619D4;
        Mon, 27 Jul 2020 05:46:21 -0700 (PDT)
Date:   Mon, 27 Jul 2020 12:46:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595853978;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QZzf0Y5OlKqG8QnOTH3draMXdDU5Mf5X5YeyQDDR0Hk=;
        b=UmvAtUiVOMtCoacfNOdp9sLGDH3NlbEjy4ofiyZxkQ1ZQM9gNvygBDOxsngxYMC0Nt49Rj
        Ing+Jobj6M/BzlTLTMMvKwHfDm6uaDzT63efmaQAihH2/hpKi/5Yw8y3PXJyfcoCwTqPYW
        R9nq557PY3M20oZCB//Ly8bn8jVRoMLU9EtWoDqKYWW70EZfpN7q224MX81Tf8LVZeBawi
        1C81BL5EB7GduguxaQduyNgu7KmbmmuyVG5+NFF6i78aYnzNDBbMG9M3bUeBc+o5/9mCqY
        LqvwdxSMUlyO719i1sckTG+G/E9Tqhu25LdrO4QKywZyh0pH6m5dGidIKwztZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595853978;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QZzf0Y5OlKqG8QnOTH3draMXdDU5Mf5X5YeyQDDR0Hk=;
        b=AZHH73AfzVjuRyhNM97WugvCE6bJNDoLZ3rwU4fEydnf+jLc5hi5jilpNJ8ehcK9ZwkXrQ
        WghAFjmJLGb96AAg==
From:   "tip-bot2 for Ricardo Neri" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpufeatures: Add enumeration for SERIALIZE instruction
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200727043132.15082-2-ricardo.neri-calderon@linux.intel.com>
References: <20200727043132.15082-2-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159585397753.4006.8130122591623473226.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     85b23fbc7d88f8c6e3951721802d7845bc39663d
Gitweb:        https://git.kernel.org/tip/85b23fbc7d88f8c6e3951721802d7845bc39663d
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Sun, 26 Jul 2020 21:31:29 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 27 Jul 2020 12:42:06 +02:00

x86/cpufeatures: Add enumeration for SERIALIZE instruction

The Intel architecture defines a set of Serializing Instructions (a
detailed definition can be found in Vol.3 Section 8.3 of the Intel "main"
manual, SDM). However, these instructions do more than what is required,
have side effects and/or may be rather invasive. Furthermore, some of
these instructions are only available in kernel mode or may cause VMExits.
Thus, software using these instructions only to serialize execution (as
defined in the manual) must handle the undesired side effects.

As indicated in the name, SERIALIZE is a new Intel architecture
Serializing Instruction. Crucially, it does not have any of the mentioned
side effects. Also, it does not cause VMExit and can be used in user mode.

This new instruction is currently documented in the latest "extensions"
manual (ISE). It will appear in the "main" manual in the future.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20200727043132.15082-2-ricardo.neri-calderon@linux.intel.com
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 02dabc9..adf45cf 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -365,6 +365,7 @@
 #define X86_FEATURE_SRBDS_CTRL		(18*32+ 9) /* "" SRBDS mitigation MSR available */
 #define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
 #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
+#define X86_FEATURE_SERIALIZE		(18*32+14) /* SERIALIZE instruction */
 #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
