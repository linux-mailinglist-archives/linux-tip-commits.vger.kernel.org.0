Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0972A2F2E19
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Jan 2021 12:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbhALLgm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 Jan 2021 06:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730028AbhALLgm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 Jan 2021 06:36:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC723C061786;
        Tue, 12 Jan 2021 03:36:01 -0800 (PST)
Date:   Tue, 12 Jan 2021 11:35:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610451360;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a5sjhOmifIrT2Py3V1i0s3HcR5HfPZJwj/KHXhMNUJI=;
        b=qNyGfdZpuksBJie/gUlDBuKKlm9cn/SRUm7PZrK+DH3pxpjmG5gc6GRc6F6D+0NaOTGMZX
        4KRGDdFXwIRLi/LN/4YLuHKUNaEjL4H9uPUyAbLkQy3KgM+UeyY4Gk1VjaAxqOIQgtjE+x
        5qHolfy0zWRCixu0GTbBqBfTyv0hRgfid/oTB9d0JbTgLgbP1CxlzofT4Me35xMYtgujWJ
        jztSeJ838pWf+8y+L1GHmCGgtyQARvmsU8maf1H88IQiZ5tfy2Sa2RyBc/oKIG+9Qotli3
        Gs/50XbgOqkfnkOpIFG4GZYyTYLMPljPjDbyDlVGoBU6JgOEtB/G659lx9rMRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610451360;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a5sjhOmifIrT2Py3V1i0s3HcR5HfPZJwj/KHXhMNUJI=;
        b=zcVQmoUjNplPtfsLUYh9vKUfP48DDhUxL/bDcFcXDojtZi5rUat1D4vOhMr+wpxkNn2Sy/
        V0RtwKjaJg7irjDg==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] selftests/x86: Use __builtin_ia32_read/writeeflags
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <aee4b1cdfc56083eb779ce927b7d3459aad2af76.1604346818.git.luto@kernel.org>
References: <aee4b1cdfc56083eb779ce927b7d3459aad2af76.1604346818.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <161045135928.414.3841470312504984374.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     9297e602adf8d5587d83941c48e4dbae46c8df5f
Gitweb:        https://git.kernel.org/tip/9297e602adf8d5587d83941c48e4dbae46c8df5f
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Mon, 02 Nov 2020 11:54:02 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 12 Jan 2021 12:31:28 +01:00

selftests/x86: Use __builtin_ia32_read/writeeflags

The asm to read and write EFLAGS from userspace is horrible.  The
compiler builtins are now available on all supported compilers, so
use them instead.

(The compiler builtins are also unnecessarily ugly, but that's a
 more manageable level of ugliness.)

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/aee4b1cdfc56083eb779ce927b7d3459aad2af76.1604346818.git.luto@kernel.org
---
 tools/testing/selftests/x86/helpers.h | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/x86/helpers.h b/tools/testing/selftests/x86/helpers.h
index f5ff2a2..4ef42c4 100644
--- a/tools/testing/selftests/x86/helpers.h
+++ b/tools/testing/selftests/x86/helpers.h
@@ -6,36 +6,20 @@
 
 static inline unsigned long get_eflags(void)
 {
-	unsigned long eflags;
-
-	asm volatile (
 #ifdef __x86_64__
-		"subq $128, %%rsp\n\t"
-		"pushfq\n\t"
-		"popq %0\n\t"
-		"addq $128, %%rsp"
+	return __builtin_ia32_readeflags_u64();
 #else
-		"pushfl\n\t"
-		"popl %0"
+	return __builtin_ia32_readeflags_u32();
 #endif
-		: "=r" (eflags) :: "memory");
-
-	return eflags;
 }
 
 static inline void set_eflags(unsigned long eflags)
 {
-	asm volatile (
 #ifdef __x86_64__
-		"subq $128, %%rsp\n\t"
-		"pushq %0\n\t"
-		"popfq\n\t"
-		"addq $128, %%rsp"
+	__builtin_ia32_writeeflags_u64(eflags);
 #else
-		"pushl %0\n\t"
-		"popfl"
+	__builtin_ia32_writeeflags_u32(eflags);
 #endif
-		:: "r" (eflags) : "flags", "memory");
 }
 
 #endif /* __SELFTESTS_X86_HELPERS_H */
