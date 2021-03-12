Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAC6338BFF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Mar 2021 12:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhCLLyu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Mar 2021 06:54:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46938 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhCLLyl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Mar 2021 06:54:41 -0500
Date:   Fri, 12 Mar 2021 11:54:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615550080;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aqoy2wqd9H59lOXIfBKrBZfYJ0BhQNbGN6htvHHhw5E=;
        b=boGAVBF87+aKLOKCjeKg58Dy5UyBL71du2Ou1NpVGmgfcZ/Z4kDTsvAisv3AkAV4iMjrZk
        57GIzQX7zF0UDiEr58qtCdqV9U3WKk9p+MvMrvvpB5VGgKSka/fhDYJct0nAd1/zGVwUmZ
        WKeYSttRbUL+QnXVgb13W79pp0wf+RFRuY4q27tZeNjrR8qqKI0wkJBa4PaHKdGZN4tmxC
        dcUJNb+3ldnHaHJ/2bIlJj/0dB/1OKzedXfNwpxPLwFHd0zgaynXqbkbG8HV6H8E4n1epi
        /lzY7Nvy4q+AXZYSF5ZyYw6q2xwayxue9QR0GIWGgFUtsRYApk1n4IhHzI+sqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615550080;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aqoy2wqd9H59lOXIfBKrBZfYJ0BhQNbGN6htvHHhw5E=;
        b=InU0pIm4qgTRrQG33tISrIFH/Ksp7CJ0/qpxvqpLoZ6nhsMNpbTBM7O16ppjMJF0FH35S6
        mExU9QzqZ0/jz6Dw==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternative: Support ALTERNATIVE_TERNARY
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210311142319.4723-7-jgross@suse.com>
References: <20210311142319.4723-7-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <161555007955.398.3142025851742016504.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     e208b3c4a9748b2c17aa09ba663b5096ccf82dce
Gitweb:        https://git.kernel.org/tip/e208b3c4a9748b2c17aa09ba663b5096ccf82dce
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Thu, 11 Mar 2021 15:23:11 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 11 Mar 2021 16:57:31 +01:00

x86/alternative: Support ALTERNATIVE_TERNARY

Add ALTERNATIVE_TERNARY support for replacing an initial instruction
with either of two instructions depending on a feature:

  ALTERNATIVE_TERNARY "default_instr", FEATURE_NR,
                      "feature_on_instr", "feature_off_instr"

which will start with "default_instr" and at patch time will,
depending on FEATURE_NR being set or not, patch that with either
"feature_on_instr" or "feature_off_instr".

 [ bp: Add comment ontop. ]

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210311142319.4723-7-jgross@suse.com
---
 arch/x86/include/asm/alternative.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 649e56f..17b3609 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -179,6 +179,11 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	ALTINSTR_REPLACEMENT(newinstr2, 2)				\
 	".popsection\n"
 
+/* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
+#define ALTERNATIVE_TERNARY(oldinstr, feature, newinstr_yes, newinstr_no) \
+	ALTERNATIVE_2(oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
+		      newinstr_yes, feature)
+
 #define ALTERNATIVE_3(oldinsn, newinsn1, feat1, newinsn2, feat2, newinsn3, feat3) \
 	OLDINSTR_3(oldinsn, 1, 2, 3)						\
 	".pushsection .altinstructions,\"a\"\n"					\
@@ -210,6 +215,9 @@ static inline int alternatives_text_reserved(void *start, void *end)
 #define alternative_2(oldinstr, newinstr1, feature1, newinstr2, feature2) \
 	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2) ::: "memory")
 
+#define alternative_ternary(oldinstr, feature, newinstr_yes, newinstr_no) \
+	asm_inline volatile(ALTERNATIVE_TERNARY(oldinstr, feature, newinstr_yes, newinstr_no) ::: "memory")
+
 /*
  * Alternative inline assembly with input.
  *
@@ -380,6 +388,11 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	.popsection
 .endm
 
+/* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
+#define ALTERNATIVE_TERNARY(oldinstr, feature, newinstr_yes, newinstr_no) \
+	ALTERNATIVE_2 oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
+	newinstr_yes, feature
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_ALTERNATIVE_H */
