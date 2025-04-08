Return-Path: <linux-tip-commits+bounces-4747-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8D0A7F769
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 10:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505933BD92E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 08:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57ABB2641C6;
	Tue,  8 Apr 2025 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bchkyKa1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Q2D+QLy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC71263C84;
	Tue,  8 Apr 2025 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744099945; cv=none; b=eoZWbU2r6fIxrXbjgieTU5xtSUJmA+8DU6RRMhVD+yleckBIOU13/FYhvFceifaT9jI+FEceH0vU+JAea7FSfTbz+wJxhTwcpD0KkSDQuFh5k3P8xOw1IUN8pKHYnqZ+Qe5KjN9YNrlCE8OGTl+Ydn2VhFqpjEj9LNRyWWW2RQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744099945; c=relaxed/simple;
	bh=h8aI2Y8fUwwLxz/2w3b4MvsL/5tJSv+J0mdS6aJ0dyE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=evlAhpdbs/Poxxmm5xMthFymAN4LAP1Q7ivu1XmntSotHW9w6tOzsJN7fTgd3BqNChDZIr6pP1fEVZzEcxweKMAWkSpIuXuGD4URUEDj8iORW0uHeUGNKMQKffktlsr34H2NUaACrZVc7/9nfTrKz+u8StV8LRXoMAM8yCgaUzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bchkyKa1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4Q2D+QLy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 08:12:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744099940;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68V8Cb5oCNWnawDb5Rws6adwhdRm3py7A4RhAeujZRg=;
	b=bchkyKa1iHWnFT/dnPRaCebHuB1VL+lfqTg4jpTJOgftxngRd8oC/4XbN5gHcdo6mjbqFC
	aVZkNA5elGbioUMWrX5/mtFTorq/tT24H7jnXstkJliXYG/ZtR8u2RT86X4bqi7LQFyFIR
	3p4twrA+DNXDa6cT/L8X5RUmritvKs62LMyURaRo4jDJrj2559lrCtzzrQ/DjFaleSfQsj
	0ikhi4/PoFR24m/vIUoQd2JKp4y9ticTCMFCZdWB5FqSKh5qXMs8QbWMDhs+EAhvRxK9Z5
	o6z1UiJ9bwYQQl1jENPwBS9+xNWnEUPkKXJsiWgaGH1i1jxsI/irNULxk8Akaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744099940;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68V8Cb5oCNWnawDb5Rws6adwhdRm3py7A4RhAeujZRg=;
	b=4Q2D+QLyz08TUyFerC21W/cfnySB/tOMvKuBVD9x0BPfZV7sUlhRnUIJAQBBt9kXPxzqpM
	HyOsG4N0iStevtDQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Split INSN_CONTEXT_SWITCH into
 INSN_SYSCALL and INSN_SYSRET
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <19a76c74d2c051d3bc9a775823cafc65ad267a7a.1744095216.git.jpoimboe@kernel.org>
References:
 <19a76c74d2c051d3bc9a775823cafc65ad267a7a.1744095216.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174409994003.31282.6822281238641305385.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     fe1042b1ef79e4d5df33d5c0f0ce936493714eec
Gitweb:        https://git.kernel.org/tip/fe1042b1ef79e4d5df33d5c0f0ce936493714eec
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 08 Apr 2025 00:02:14 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 08 Apr 2025 09:14:11 +02:00

objtool: Split INSN_CONTEXT_SWITCH into INSN_SYSCALL and INSN_SYSRET

INSN_CONTEXT_SWITCH is ambiguous.  It can represent both call semantics
(SYSCALL, SYSENTER) and return semantics (SYSRET, IRET, RETS, RETU).
Those differ significantly: calls preserve control flow whereas returns
terminate it.

Objtool uses an arbitrary rule for INSN_CONTEXT_SWITCH that almost works
by accident: if in a function, keep going; otherwise stop.  It should
instead be based on the semantics of the underlying instruction.

In preparation for improving that, split INSN_CONTEXT_SWITCH into
INSN_SYCALL and INSN_SYSRET.

No functional change.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/19a76c74d2c051d3bc9a775823cafc65ad267a7a.1744095216.git.jpoimboe@kernel.org
---
 tools/objtool/arch/x86/decode.c      | 18 +++++++++++-------
 tools/objtool/check.c                |  6 ++++--
 tools/objtool/include/objtool/arch.h |  3 ++-
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 33d861c..3ce7b54 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -522,7 +522,7 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 			case INAT_PFX_REPNE:
 				if (modrm == 0xca)
 					/* eretu/erets */
-					insn->type = INSN_CONTEXT_SWITCH;
+					insn->type = INSN_SYSRET;
 				break;
 			default:
 				if (modrm == 0xca)
@@ -535,11 +535,15 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 
 			insn->type = INSN_JUMP_CONDITIONAL;
 
-		} else if (op2 == 0x05 || op2 == 0x07 || op2 == 0x34 ||
-			   op2 == 0x35) {
+		} else if (op2 == 0x05 || op2 == 0x34) {
 
-			/* sysenter, sysret */
-			insn->type = INSN_CONTEXT_SWITCH;
+			/* syscall, sysenter */
+			insn->type = INSN_SYSCALL;
+
+		} else if (op2 == 0x07 || op2 == 0x35) {
+
+			/* sysret, sysexit */
+			insn->type = INSN_SYSRET;
 
 		} else if (op2 == 0x0b || op2 == 0xb9) {
 
@@ -676,7 +680,7 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 
 	case 0xca: /* retf */
 	case 0xcb: /* retf */
-		insn->type = INSN_CONTEXT_SWITCH;
+		insn->type = INSN_SYSRET;
 		break;
 
 	case 0xe0: /* loopne */
@@ -721,7 +725,7 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 		} else if (modrm_reg == 5) {
 
 			/* jmpf */
-			insn->type = INSN_CONTEXT_SWITCH;
+			insn->type = INSN_SYSRET;
 
 		} else if (modrm_reg == 6) {
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c81b070..2c703b9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3684,7 +3684,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 			break;
 
-		case INSN_CONTEXT_SWITCH:
+		case INSN_SYSCALL:
+		case INSN_SYSRET:
 			if (func) {
 				if (!next_insn || !next_insn->hint) {
 					WARN_INSN(insn, "unsupported instruction in callable function");
@@ -3886,7 +3887,8 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 			WARN_INSN(insn, "RET before UNTRAIN");
 			return 1;
 
-		case INSN_CONTEXT_SWITCH:
+		case INSN_SYSCALL:
+		case INSN_SYSRET:
 			if (insn_func(insn))
 				break;
 			return 0;
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 089a1ac..01ef6f4 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -19,7 +19,8 @@ enum insn_type {
 	INSN_CALL,
 	INSN_CALL_DYNAMIC,
 	INSN_RETURN,
-	INSN_CONTEXT_SWITCH,
+	INSN_SYSCALL,
+	INSN_SYSRET,
 	INSN_BUG,
 	INSN_NOP,
 	INSN_STAC,

