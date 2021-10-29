Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E01843F867
	for <lists+linux-tip-commits@lfdr.de>; Fri, 29 Oct 2021 10:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhJ2IFf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 29 Oct 2021 04:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbhJ2IF3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 29 Oct 2021 04:05:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC7EC061570;
        Fri, 29 Oct 2021 01:03:01 -0700 (PDT)
Date:   Fri, 29 Oct 2021 08:02:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635494580;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=frPN6S8Z9/jNFGBwkYKQCrX6eHRqdWDN5HvK2S4HyD0=;
        b=wWc5ECP1OBRQc8ycYguySQfXyx73K4TW0qArPwIcW/FTO6nTSOZzXXU5cCQ+bJ/d3HZ7eR
        6J16v3LYYVZ450LdPxMGcWGsKFEhpv5G808TH/d4bp1EnTAv4UdSvMTGGaBXikVEbMTTZH
        qpNwx/8WhEbuA1nyEtTd/BLgRVIDwPMnKS+Y/rxidI19KTWgobV6VK8MCNcqXqaNVlciXo
        LYTvguhshLIs68V3QY8XivIobZDJYuZ7nBXDotJ1wKGAR8hmta6ykwcsF/TIhRmrJRIY0S
        2TLmPNZ9fyFnzPOh2X+G0+NRAAs6wO0GM3eCqPevT7iqDFOq6hLMf9t6XE3XSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635494580;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=frPN6S8Z9/jNFGBwkYKQCrX6eHRqdWDN5HvK2S4HyD0=;
        b=Z90oN6APn8YxzYbeX502EWLh/ngoPIq5TkNlTB7ksWVRvFpbRHkxF0H4cIcb1E7qrK9l4I
        ikg3053je17I+UBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/alternative: Handle Jcc __x86_indirect_thunk_\reg
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211026120310.296470217@infradead.org>
References: <20211026120310.296470217@infradead.org>
MIME-Version: 1.0
Message-ID: <163549457910.626.10715211618290814624.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     2f0cbb2a8e5bbf101e9de118fc0eb168111a5e1e
Gitweb:        https://git.kernel.org/tip/2f0cbb2a8e5bbf101e9de118fc0eb168111a5e1e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 26 Oct 2021 14:01:43 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 28 Oct 2021 23:25:28 +02:00

x86/alternative: Handle Jcc __x86_indirect_thunk_\reg

Handle the rare cases where the compiler (clang) does an indirect
conditional tail-call using:

  Jcc __x86_indirect_thunk_\reg

For the !RETPOLINE case this can be rewritten to fit the original (6
byte) instruction like:

  Jncc.d8	1f
  JMP		*%\reg
  NOP
1:

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/r/20211026120310.296470217@infradead.org
---
 arch/x86/kernel/alternative.c | 40 ++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 5df4034..1dea2f6 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -393,7 +393,8 @@ static int emit_indirect(int op, int reg, u8 *bytes)
 static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 {
 	retpoline_thunk_t *target;
-	int reg, i = 0;
+	int reg, ret, i = 0;
+	u8 op, cc;
 
 	target = addr + insn->length + insn->immediate.value;
 	reg = target - __x86_indirect_thunk_array;
@@ -407,9 +408,36 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
 		return -1;
 
-	i = emit_indirect(insn->opcode.bytes[0], reg, bytes);
-	if (i < 0)
-		return i;
+	op = insn->opcode.bytes[0];
+
+	/*
+	 * Convert:
+	 *
+	 *   Jcc.d32 __x86_indirect_thunk_\reg
+	 *
+	 * into:
+	 *
+	 *   Jncc.d8 1f
+	 *   JMP *%\reg
+	 *   NOP
+	 * 1:
+	 */
+	/* Jcc.d32 second opcode byte is in the range: 0x80-0x8f */
+	if (op == 0x0f && (insn->opcode.bytes[1] & 0xf0) == 0x80) {
+		cc = insn->opcode.bytes[1] & 0xf;
+		cc ^= 1; /* invert condition */
+
+		bytes[i++] = 0x70 + cc;        /* Jcc.d8 */
+		bytes[i++] = insn->length - 2; /* sizeof(Jcc.d8) == 2 */
+
+		/* Continue as if: JMP.d32 __x86_indirect_thunk_\reg */
+		op = JMP32_INSN_OPCODE;
+	}
+
+	ret = emit_indirect(op, reg, bytes + i);
+	if (ret < 0)
+		return ret;
+	i += ret;
 
 	for (; i < insn->length;)
 		bytes[i++] = BYTES_NOP1;
@@ -443,6 +471,10 @@ void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
 		case JMP32_INSN_OPCODE:
 			break;
 
+		case 0x0f: /* escape */
+			if (op2 >= 0x80 && op2 <= 0x8f)
+				break;
+			fallthrough;
 		default:
 			WARN_ON_ONCE(1);
 			continue;
