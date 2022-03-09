Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA2B4D29D0
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Mar 2022 08:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiCIH4l (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Mar 2022 02:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiCIH42 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Mar 2022 02:56:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4FE165C18;
        Tue,  8 Mar 2022 23:55:08 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:55:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AZGTylkZAhZzNF4wpe36GCvyfUNNZZsQtsAXyO2whyo=;
        b=mqT1mPefyzUDBXTt+BY7mHfavotieTXqgy0Z9VKjLjEbWfjyx8K3cHfrPW76oKJkK/MVck
        rRRapv5S/+zxP1ppf60n+7UX2Vx4lQvtC1TXr5pb7aJOI4GQ29XbuIaet93W/nBLlX/rB5
        USOyec9ic9AdpcPA+nDs+jIwcTLhCBu5yTVka4uHzGRfSchmbIczMp/s8ylzzlE2jWOCxQ
        XnkP6k7+DuH4O85y8su0dk79YJENSA83MRItErfvsXHUDaGp9UjjakylH1MdcmTWeMzrcB
        oRE9awewmECyVIxZAJtoZhbpasa4kIj68r35g/vVKeJLicEf/YFucW3HG4xU9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AZGTylkZAhZzNF4wpe36GCvyfUNNZZsQtsAXyO2whyo=;
        b=uzSd/WIu+J1Jal+dqCuOzmbo54lA52yf2ixnn+hQEj+k8usM+/v977ro7KAcNESRBgIZUs
        FFRc426qTG2KSZAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/linkage: Add ENDBR to SYM_FUNC_START*()
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154317.992708941@infradead.org>
References: <20220308154317.992708941@infradead.org>
MIME-Version: 1.0
Message-ID: <164681250587.16921.1614693055243927648.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     1d295d6e83f8ce357cafe11a86dab1deecb13963
Gitweb:        https://git.kernel.org/tip/1d295d6e83f8ce357cafe11a86dab1deecb13963
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:25 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 23:53:30 +01:00

x86/linkage: Add ENDBR to SYM_FUNC_START*()

Ensure the ASM functions have ENDBR on for IBT builds, this follows
the ARM64 example. Unlike ARM64, we'll likely end up overwriting them
with poison.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154317.992708941@infradead.org
---
 arch/x86/include/asm/linkage.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index 0309079..85865f1 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_LINKAGE_H
 
 #include <linux/stringify.h>
+#include <asm/ibt.h>
 
 #undef notrace
 #define notrace __attribute__((no_instrument_function))
@@ -34,5 +35,35 @@
 
 #endif /* __ASSEMBLY__ */
 
+/* SYM_FUNC_START -- use for global functions */
+#define SYM_FUNC_START(name)				\
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
+	ENDBR
+
+/* SYM_FUNC_START_NOALIGN -- use for global functions, w/o alignment */
+#define SYM_FUNC_START_NOALIGN(name)			\
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)	\
+	ENDBR
+
+/* SYM_FUNC_START_LOCAL -- use for local functions */
+#define SYM_FUNC_START_LOCAL(name)			\
+	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)	\
+	ENDBR
+
+/* SYM_FUNC_START_LOCAL_NOALIGN -- use for local functions, w/o alignment */
+#define SYM_FUNC_START_LOCAL_NOALIGN(name)		\
+	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)	\
+	ENDBR
+
+/* SYM_FUNC_START_WEAK -- use for weak functions */
+#define SYM_FUNC_START_WEAK(name)			\
+	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN)	\
+	ENDBR
+
+/* SYM_FUNC_START_WEAK_NOALIGN -- use for weak functions, w/o alignment */
+#define SYM_FUNC_START_WEAK_NOALIGN(name)		\
+	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)		\
+	ENDBR
+
 #endif /* _ASM_X86_LINKAGE_H */
 
