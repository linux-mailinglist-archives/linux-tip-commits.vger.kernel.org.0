Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A5B43F86B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 29 Oct 2021 10:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhJ2IFh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 29 Oct 2021 04:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbhJ2IFc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 29 Oct 2021 04:05:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADC3C061570;
        Fri, 29 Oct 2021 01:03:04 -0700 (PDT)
Date:   Fri, 29 Oct 2021 08:03:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635494582;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fMn0lIfu7ExqL6TcSyTlTNKauZcx9yo6gsIE7KtRDM4=;
        b=FdxcNayMukNr8ZdHesbO4MiEfe/5DVj88GrHj9VRR8p9KNX5J2JQBzId/OfsZkiEYiftBq
        WWc3H4tvggKyoBQSK8N6uZfSM6PkdPGt2w9HNNWey8C0S9cH190OJfgpvBwgONg1iZRpgr
        pkp+zznWJ6azxXgzkltnGTtTC3XpHNLk2+5ot+cSpJ7PJ3MwlcFK7BzbLfJob8dd1a7P/v
        sxEse7Qjkc3OQd5JDZZiZUjL6Y7/tkliCxIoVElKSIL312aJJeIZAPRJ6L0Unsg3f01Iva
        HbXz3U7zOaKZkC4/L6eqdUQz9EHbV1QVZ1wDecQh94ceaYFX8LTC4mjyGQv5Jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635494582;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fMn0lIfu7ExqL6TcSyTlTNKauZcx9yo6gsIE7KtRDM4=;
        b=N8F9bfSHuLWdtC+niyeZjM77W1oP6MCcH1FNsc3nmAPoiVpCOdrdCKsl0oVfTXOXM/SaN4
        P6JvoWpd+hHhhsDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/asm: Fixup odd GEN-for-each-reg.h usage
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211026120310.041792350@infradead.org>
References: <20211026120310.041792350@infradead.org>
MIME-Version: 1.0
Message-ID: <163549458198.626.9967495456724467298.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     b6d3d9944bd7c9e8c06994ead3c9952f673f2a66
Gitweb:        https://git.kernel.org/tip/b6d3d9944bd7c9e8c06994ead3c9952f673f2a66
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 26 Oct 2021 14:01:39 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 28 Oct 2021 23:25:26 +02:00

x86/asm: Fixup odd GEN-for-each-reg.h usage

Currently GEN-for-each-reg.h usage leaves GEN defined, relying on any
subsequent usage to start with #undef, which is rude.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/r/20211026120310.041792350@infradead.org
---
 arch/x86/include/asm/asm-prototypes.h | 2 +-
 arch/x86/lib/retpoline.S              | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index a28c5ca..a2bed09 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -19,9 +19,9 @@ extern void cmpxchg8b_emu(void);
 
 #ifdef CONFIG_RETPOLINE
 
-#undef GEN
 #define GEN(reg) \
 	extern asmlinkage void __x86_indirect_thunk_ ## reg (void);
 #include <asm/GEN-for-each-reg.h>
+#undef GEN
 
 #endif /* CONFIG_RETPOLINE */
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index a91e0dc..4c910fa 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -55,10 +55,10 @@ SYM_FUNC_END(__x86_indirect_thunk_\reg)
 #define __EXPORT_THUNK(sym)	_ASM_NOKPROBE(sym); EXPORT_SYMBOL(sym)
 #define EXPORT_THUNK(reg)	__EXPORT_THUNK(__x86_indirect_thunk_ ## reg)
 
-#undef GEN
 #define GEN(reg) THUNK reg
 #include <asm/GEN-for-each-reg.h>
-
 #undef GEN
+
 #define GEN(reg) EXPORT_THUNK(reg)
 #include <asm/GEN-for-each-reg.h>
+#undef GEN
