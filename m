Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493C77884A4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Aug 2023 12:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjHYKT6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 25 Aug 2023 06:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244415AbjHYKTv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 25 Aug 2023 06:19:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4220211C;
        Fri, 25 Aug 2023 03:19:29 -0700 (PDT)
Date:   Fri, 25 Aug 2023 10:19:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692958767;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hr1SssnPEa4iYwTLG97d5vWv2jhX8t6E1Y344CYBrVI=;
        b=KQM2eBcPGzXfuX69E6zfSF3Dre4uQnuneRbmceULElyXwe/MopvjCHn5GbFjC+GMmoxX79
        EYrtHHpURNGy4HAJzVTJSg/P24pnE5S+Eujc8DpozFAUjHyDzMnf5a1VD+bUUSSXN6Nk2o
        +vu04aJ6jMk4qRHYKNIxMUnAf7U+uGPgM/Gk5v9zcLRyMVQAwryXX49QEgtkAJ2/9xWnwT
        wxx7N3E1vKt84pAdpkSMwANoTIyhPw+E5BEhmcubNPC8srmgdrhnoeZmt9K7LCSqJqo3iG
        fUoPzYoh5lh/BwI3rtNjKP1BdnX4ENSu2bcZQHQSUM4eeafBpOBeYV9/B+B3OQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692958767;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hr1SssnPEa4iYwTLG97d5vWv2jhX8t6E1Y344CYBrVI=;
        b=t6EoZyTwX5k+sLM5ne4N2K0f5FdxZfp8ejmzS+VD2zFUumAu43tVqqDZ8UdYGLcjH8Rqzn
        P1vfVgFXSS9uqqAg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/nospec: Refactor UNTRAIN_RET[_*]
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <d9ad341e6ce84ccdbd3924615f4a47b3d7b19942.1692919072.git.jpoimboe@kernel.org>
References: <d9ad341e6ce84ccdbd3924615f4a47b3d7b19942.1692919072.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169295876725.27769.5836178064728809837.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     e94280f458d27cf0ef1afc29557e841f03ec7476
Gitweb:        https://git.kernel.org/tip/e94280f458d27cf0ef1afc29557e841f03ec7476
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 25 Aug 2023 00:01:53 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Aug 2023 11:22:02 +02:00

x86/nospec: Refactor UNTRAIN_RET[_*]

Factor out the UNTRAIN_RET[_*] common bits into a helper macro.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/d9ad341e6ce84ccdbd3924615f4a47b3d7b19942.1692919072.git.jpoimboe@kernel.org
---
 arch/x86/include/asm/nospec-branch.h | 31 ++++++++-------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 51e3f1a..dcc7847 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -288,35 +288,24 @@
  * As such, this must be placed after every *SWITCH_TO_KERNEL_CR3 at a point
  * where we have a stack but before any RET instruction.
  */
-.macro UNTRAIN_RET
+.macro __UNTRAIN_RET ibpb_feature, call_depth_insns
 #if defined(CONFIG_RETHUNK) || defined(CONFIG_CPU_IBPB_ENTRY)
 	VALIDATE_UNRET_END
 	ALTERNATIVE_3 "",						\
 		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
-		      "call entry_ibpb", X86_FEATURE_ENTRY_IBPB,	\
-		     __stringify(RESET_CALL_DEPTH), X86_FEATURE_CALL_DEPTH
+		      "call entry_ibpb", \ibpb_feature,			\
+		     __stringify(\call_depth_insns), X86_FEATURE_CALL_DEPTH
 #endif
 .endm
 
-.macro UNTRAIN_RET_VM
-#if defined(CONFIG_RETHUNK) || defined(CONFIG_CPU_IBPB_ENTRY)
-	VALIDATE_UNRET_END
-	ALTERNATIVE_3 "",						\
-		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
-		      "call entry_ibpb", X86_FEATURE_IBPB_ON_VMEXIT,	\
-		      __stringify(RESET_CALL_DEPTH), X86_FEATURE_CALL_DEPTH
-#endif
-.endm
+#define UNTRAIN_RET \
+	__UNTRAIN_RET X86_FEATURE_ENTRY_IBPB, __stringify(RESET_CALL_DEPTH)
 
-.macro UNTRAIN_RET_FROM_CALL
-#if defined(CONFIG_RETHUNK) || defined(CONFIG_CPU_IBPB_ENTRY)
-	VALIDATE_UNRET_END
-	ALTERNATIVE_3 "",						\
-		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
-		      "call entry_ibpb", X86_FEATURE_ENTRY_IBPB,	\
-		      __stringify(RESET_CALL_DEPTH_FROM_CALL), X86_FEATURE_CALL_DEPTH
-#endif
-.endm
+#define UNTRAIN_RET_VM \
+	__UNTRAIN_RET X86_FEATURE_IBPB_ON_VMEXIT, __stringify(RESET_CALL_DEPTH)
+
+#define UNTRAIN_RET_FROM_CALL \
+	__UNTRAIN_RET X86_FEATURE_ENTRY_IBPB, __stringify(RESET_CALL_DEPTH_FROM_CALL)
 
 
 .macro CALL_DEPTH_ACCOUNT
