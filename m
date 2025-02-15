Return-Path: <linux-tip-commits+bounces-3372-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE5EA36D7E
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 11:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56873B0204
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 10:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A251ACECC;
	Sat, 15 Feb 2025 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="exH7nfmg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bkufi79K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4539D1A304A;
	Sat, 15 Feb 2025 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739617002; cv=none; b=R5vIZIQ4rT7BcYRLAYnLbIh7d3TQkxmFrpNMaNwAq3cxCB9KjU5X5i/KS90GDpF6Z3Xvw2KY+rSREZheM66ozn7I0lF26Wm+qIIAWQNRDlV6HiM5B/izHZOueLeY3qCR47hm9hoEXwAQ3XbG0N55FPb9vye+NBdVtF9D5DRI4VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739617002; c=relaxed/simple;
	bh=fDE0CaNxx4a1SnLfXk6gwz3WldVbJxq6Z1NFeZE0YeI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aElHKWAbhoAL9fRa0FmQAcSdBbWifBPGohbzDC35iqIx/o+1gg5Qbr70qQg/CUjGIuTf4MN+BE9Buf2890qrRx+o2Y+/na6/Z+aSojEfuESuiNdH8we5DpZ7eD0ydqoSaNpn+Q9bCMIO8Z6gIgwboYi3FM/QlxGjegj6es5rP1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=exH7nfmg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bkufi79K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 15 Feb 2025 10:56:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739616998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KbZb+TapRp1OJBJ14D0UW7vAhl0TyCTMV0ZOR0I2Cz4=;
	b=exH7nfmgg0xBlB8/Sjw6D8xcuEqHxWCG9zwqrIaX3xk7Kig/67dkncB9jNjnOEq7WeFuTN
	w3dOhSUUrRWFX/VljEpc+GluPEb4pkoOPClKXnsUX2d4oevpsKjxUA/RowFx2oZwnvnMrs
	Mo/eYMOIsVh53bcxyaOEvtoeG/yzQTQRD06+7YVHhLf7fcW2QnNYSqJUcrygJqNT934x0L
	aa5uMphBPJXiCvHAysTj5urTLyyIsfORWdfR+1aCWB0THQIJycNDKhy+XBShW7ZWeAYHa9
	MJ7uLUyB1P9PI2rskS4BjKcqoYCY8sWK5G1h+AB3aNAS6YDiUC8JCp36yJijcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739616998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KbZb+TapRp1OJBJ14D0UW7vAhl0TyCTMV0ZOR0I2Cz4=;
	b=Bkufi79K2jBTF9F4xOaogOXRwW3TEPoYzMBxUw5cHL7yHvBXqdZ2bPdmv2fcuw+8SgmEER
	+ovRvVWLmV4EZhDg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/alternative: Simplify callthunk patching
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250207122546.617187089@infradead.org>
References: <20250207122546.617187089@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173961699799.10177.2391674818298498916.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     ab9fea59487d8b5149a323e2092b7c0f53994dd5
Gitweb:        https://git.kernel.org/tip/ab9fea59487d8b5149a323e2092b7c0f53994dd5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 07 Feb 2025 13:15:35 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Feb 2025 10:32:06 +01:00

x86/alternative: Simplify callthunk patching

Now that paravirt call patching is implemented using alternatives, it
is possible to avoid having to patch the alternative sites by
including the altinstr_replacement calls in the call_sites list.

This means we're now stacking relative adjustments like so:

  callthunks_patch_builtin_calls():
    patches all function calls to target: func() -> func()-10
    since the CALL accounting lives in the CALL_PADDING.

    This explicitly includes .altinstr_replacement

  alt_replace_call():
    patches: x86_BUG() -> target()

    this patching is done in a relative manner, and will preserve
    the above adjustment, meaning that with calldepth patching it
    will do: x86_BUG()-10 -> target()-10

  apply_relocation():
    does code relocation, and adjusts all RIP-relative instructions
    to the new location, also in a relative manner.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lore.kernel.org/r/20250207122546.617187089@infradead.org
---
 arch/x86/include/asm/alternative.h |  1 -
 arch/x86/kernel/alternative.c      |  8 ++++----
 arch/x86/kernel/callthunks.c       | 13 -------------
 arch/x86/kernel/module.c           | 17 ++++++-----------
 tools/objtool/arch/x86/decode.c    |  1 +
 tools/objtool/check.c              | 12 ++----------
 6 files changed, 13 insertions(+), 39 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index a214166..853fbcf 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -100,7 +100,6 @@ struct module;
 
 struct callthunk_sites {
 	s32				*call_start, *call_end;
-	struct alt_instr		*alt_start, *alt_end;
 };
 
 #ifdef CONFIG_CALL_THUNKS
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index e914a65..fda11df 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1705,14 +1705,14 @@ void __init alternative_instructions(void)
 	apply_retpolines(__retpoline_sites, __retpoline_sites_end);
 	apply_returns(__return_sites, __return_sites_end);
 
-	apply_alternatives(__alt_instructions, __alt_instructions_end);
-
 	/*
-	 * Now all calls are established. Apply the call thunks if
-	 * required.
+	 * Adjust all CALL instructions to point to func()-10, including
+	 * those in .altinstr_replacement.
 	 */
 	callthunks_patch_builtin_calls();
 
+	apply_alternatives(__alt_instructions, __alt_instructions_end);
+
 	/*
 	 * Seal all functions that do not have their address taken.
 	 */
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index 8418a89..25ae542 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -240,21 +240,10 @@ patch_call_sites(s32 *start, s32 *end, const struct core_text *ct)
 }
 
 static __init_or_module void
-patch_alt_call_sites(struct alt_instr *start, struct alt_instr *end,
-		     const struct core_text *ct)
-{
-	struct alt_instr *a;
-
-	for (a = start; a < end; a++)
-		patch_call((void *)&a->instr_offset + a->instr_offset, ct);
-}
-
-static __init_or_module void
 callthunks_setup(struct callthunk_sites *cs, const struct core_text *ct)
 {
 	prdbg("Patching call sites %s\n", ct->name);
 	patch_call_sites(cs->call_start, cs->call_end, ct);
-	patch_alt_call_sites(cs->alt_start, cs->alt_end, ct);
 	prdbg("Patching call sites done%s\n", ct->name);
 }
 
@@ -263,8 +252,6 @@ void __init callthunks_patch_builtin_calls(void)
 	struct callthunk_sites cs = {
 		.call_start	= __call_sites,
 		.call_end	= __call_sites_end,
-		.alt_start	= __alt_instructions,
-		.alt_end	= __alt_instructions_end
 	};
 
 	if (!cpu_feature_enabled(X86_FEATURE_CALL_DEPTH))
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 837450b..cb9d295 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -275,12 +275,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 		void *rseg = (void *)returns->sh_addr;
 		apply_returns(rseg, rseg + returns->sh_size);
 	}
-	if (alt) {
-		/* patch .altinstructions */
-		void *aseg = (void *)alt->sh_addr;
-		apply_alternatives(aseg, aseg + alt->sh_size);
-	}
-	if (calls || alt) {
+	if (calls) {
 		struct callthunk_sites cs = {};
 
 		if (calls) {
@@ -288,13 +283,13 @@ int module_finalize(const Elf_Ehdr *hdr,
 			cs.call_end = (void *)calls->sh_addr + calls->sh_size;
 		}
 
-		if (alt) {
-			cs.alt_start = (void *)alt->sh_addr;
-			cs.alt_end = (void *)alt->sh_addr + alt->sh_size;
-		}
-
 		callthunks_patch_module_calls(&cs, me);
 	}
+	if (alt) {
+		/* patch .altinstructions */
+		void *aseg = (void *)alt->sh_addr;
+		apply_alternatives(aseg, aseg + alt->sh_size);
+	}
 	if (ibt_endbr) {
 		void *iseg = (void *)ibt_endbr->sh_addr;
 		apply_seal_endbr(iseg, iseg + ibt_endbr->sh_size);
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index fe1362c..181aa60 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -850,5 +850,6 @@ bool arch_is_rethunk(struct symbol *sym)
 bool arch_is_embedded_insn(struct symbol *sym)
 {
 	return !strcmp(sym->name, "retbleed_return_thunk") ||
+	       !strcmp(sym->name, "srso_alias_safe_ret") ||
 	       !strcmp(sym->name, "srso_safe_ret");
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 753dbc4..26f2c1b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1283,15 +1283,6 @@ static void annotate_call_site(struct objtool_file *file,
 	if (!sym)
 		sym = reloc->sym;
 
-	/*
-	 * Alternative replacement code is just template code which is
-	 * sometimes copied to the original instruction. For now, don't
-	 * annotate it. (In the future we might consider annotating the
-	 * original instruction if/when it ever makes sense to do so.)
-	 */
-	if (!strcmp(insn->sec->name, ".altinstr_replacement"))
-		return;
-
 	if (sym->static_call_tramp) {
 		list_add_tail(&insn->call_node, &file->static_call_list);
 		return;
@@ -1349,7 +1340,8 @@ static void annotate_call_site(struct objtool_file *file,
 		return;
 	}
 
-	if (insn->type == INSN_CALL && !insn->sec->init)
+	if (insn->type == INSN_CALL && !insn->sec->init &&
+	    !insn->_call_dest->embedded_insn)
 		list_add_tail(&insn->call_node, &file->call_list);
 
 	if (!sibling && dead_end_function(file, sym))

