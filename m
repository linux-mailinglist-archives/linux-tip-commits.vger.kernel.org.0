Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18E243F865
	for <lists+linux-tip-commits@lfdr.de>; Fri, 29 Oct 2021 10:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhJ2IFe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 29 Oct 2021 04:05:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53178 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbhJ2IF2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 29 Oct 2021 04:05:28 -0400
Date:   Fri, 29 Oct 2021 08:02:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635494579;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uLeh9TP9SLUAJM6fvLJub3qOOv3Fr9xrniACVIpgmUE=;
        b=TP1sS9jXVDd4dIFHic3cSnl/S8RJ5DzWboiZIdu6wRMUm5HfeqSMSd8AFLhXcyRZeJMtQj
        8Emqjy9RNA566P0mtxQD3V0j4IkdrtaqlpdBFPcqydueqxHZXhcJmrENEEP6uC8uFKz8RV
        NeurFZYUqPdyTi38hRoAK4oDW38nbfm7nTcR9MbnMF0tbcibPqNvL7WTMEWOr+w/9GWsoF
        8BNfQRDPRPsoJjhs3xX/Abap1cc3UlWxQKOav0yptaEBuMPdHl9ZTXp6yMPrfOy5pslJoD
        pdK2r+fobdl15yRqERkVJz18FsNVFNk7C1T/MgXVonfdLse3Ju7UXmtf+4cIJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635494579;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uLeh9TP9SLUAJM6fvLJub3qOOv3Fr9xrniACVIpgmUE=;
        b=/KNXJH8hT92qpzdTTU0lskXXbr6j9Xk1OwAKkcN2XtQyFI5C0HGtIHR1vbRmgrrbq803lO
        CsqHg5fkKEyL5RDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/alternative: Try inline spectre_v2=retpoline,amd
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211026120310.359986601@infradead.org>
References: <20211026120310.359986601@infradead.org>
MIME-Version: 1.0
Message-ID: <163549457837.626.9609170982531434821.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     bbe2df3f6b6da7848398d55b1311d58a16ec21e4
Gitweb:        https://git.kernel.org/tip/bbe2df3f6b6da7848398d55b1311d58a16ec21e4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 26 Oct 2021 14:01:44 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 28 Oct 2021 23:25:28 +02:00

x86/alternative: Try inline spectre_v2=retpoline,amd

Try and replace retpoline thunk calls with:

  LFENCE
  CALL    *%\reg

for spectre_v2=retpoline,amd.

Specifically, the sequence above is 5 bytes for the low 8 registers,
but 6 bytes for the high 8 registers. This means that unless the
compilers prefix stuff the call with higher registers this replacement
will fail.

Luckily GCC strongly favours RAX for the indirect calls and most (95%+
for defconfig-x86_64) will be converted. OTOH clang strongly favours
R11 and almost nothing gets converted.

Note: it will also generate a correct replacement for the Jcc.d32
case, except unless the compilers start to prefix stuff that, it'll
never fit. Specifically:

  Jncc.d8 1f
  LFENCE
  JMP     *%\reg
1:

is 7-8 bytes long, where the original instruction in unpadded form is
only 6 bytes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/r/20211026120310.359986601@infradead.org
---
 arch/x86/kernel/alternative.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 1dea2f6..c89824c 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -389,6 +389,7 @@ static int emit_indirect(int op, int reg, u8 *bytes)
  *
  *   CALL *%\reg
  *
+ * It also tries to inline spectre_v2=retpoline,amd when size permits.
  */
 static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 {
@@ -405,7 +406,8 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 	/* If anyone ever does: CALL/JMP *%rsp, we're in deep trouble. */
 	BUG_ON(reg == 4);
 
-	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
+	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE) &&
+	    !cpu_feature_enabled(X86_FEATURE_RETPOLINE_AMD))
 		return -1;
 
 	op = insn->opcode.bytes[0];
@@ -418,8 +420,9 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 	 * into:
 	 *
 	 *   Jncc.d8 1f
+	 *   [ LFENCE ]
 	 *   JMP *%\reg
-	 *   NOP
+	 *   [ NOP ]
 	 * 1:
 	 */
 	/* Jcc.d32 second opcode byte is in the range: 0x80-0x8f */
@@ -434,6 +437,15 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 		op = JMP32_INSN_OPCODE;
 	}
 
+	/*
+	 * For RETPOLINE_AMD: prepend the indirect CALL/JMP with an LFENCE.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_AMD)) {
+		bytes[i++] = 0x0f;
+		bytes[i++] = 0xae;
+		bytes[i++] = 0xe8; /* LFENCE */
+	}
+
 	ret = emit_indirect(op, reg, bytes + i);
 	if (ret < 0)
 		return ret;
