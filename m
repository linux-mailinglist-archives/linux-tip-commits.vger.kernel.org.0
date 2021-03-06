Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109A832FA37
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhCFLs4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:48:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34610 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhCFLso (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:48:44 -0500
Date:   Sat, 06 Mar 2021 11:48:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615031322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/LdogScL+bX/3+f6164wx2Vqik5S0Qa5Ed8g6jdNnFE=;
        b=3deH5McDQiHB8+SLXWFP930LYdEfJEdecsx6KAkkAGmFWEtcLrGacrHLPu2r7Ac/HkN6D9
        Krk3o9yiIyrhCGZd9QXv2hGkmHKBbeE0s9D5NDJGkKxW+CSS6dEBoky1FG5X3YQgf0Kg6r
        PJdbKWDDojxZ3jVfmuZF0mvPa95OC8oPBYpohp+TWAPx1WlIxJo2CG7LBCdfXPKBOmq37Q
        f/jRTDn1O6Ais7Mr7ZNI5WE1YpkbIOm96MnhZC5Uiaqu93BrCv0iG6pxYvLOikGPAxXjl6
        A5NK3ytbW3yz0p5dX00yWISaTLoJvTVB3F1dAySnVoY3D5BYtbPFdjoEJntJYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615031322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/LdogScL+bX/3+f6164wx2Vqik5S0Qa5Ed8g6jdNnFE=;
        b=h7yrpLGGHlp9/zrTJlONG4JiZlRfkZkBI9DtIP8XJPAMl/OwT76cVA+ewvmhVzVLjgEVP+
        t1A30eY4Lq1OkHCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool,x86: Renumber CFI_reg
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210211173627.033720313@infradead.org>
References: <20210211173627.033720313@infradead.org>
MIME-Version: 1.0
Message-ID: <161503132190.398.9639978732374718770.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     d473b18b2ef62563fb874f9cae6e123f99129e3f
Gitweb:        https://git.kernel.org/tip/d473b18b2ef62563fb874f9cae6e123f99129e3f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 09 Feb 2021 20:18:21 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:44:22 +01:00

objtool,x86: Renumber CFI_reg

Make them match the instruction encoding numbering.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lkml.kernel.org/r/20210211173627.033720313@infradead.org
---
 tools/objtool/arch/x86/include/arch/cfi_regs.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/arch/x86/include/arch/cfi_regs.h b/tools/objtool/arch/x86/include/arch/cfi_regs.h
index 79bc517..0579d22 100644
--- a/tools/objtool/arch/x86/include/arch/cfi_regs.h
+++ b/tools/objtool/arch/x86/include/arch/cfi_regs.h
@@ -4,13 +4,13 @@
 #define _OBJTOOL_CFI_REGS_H
 
 #define CFI_AX			0
-#define CFI_DX			1
-#define CFI_CX			2
+#define CFI_CX			1
+#define CFI_DX			2
 #define CFI_BX			3
-#define CFI_SI			4
-#define CFI_DI			5
-#define CFI_BP			6
-#define CFI_SP			7
+#define CFI_SP			4
+#define CFI_BP			5
+#define CFI_SI			6
+#define CFI_DI			7
 #define CFI_R8			8
 #define CFI_R9			9
 #define CFI_R10			10
