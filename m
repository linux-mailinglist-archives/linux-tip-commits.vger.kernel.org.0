Return-Path: <linux-tip-commits+bounces-4466-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A99A6EBC4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8993D16D5D2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AC72580D5;
	Tue, 25 Mar 2025 08:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HB7IG2oD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c6OzyDsE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C35925743E;
	Tue, 25 Mar 2025 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891714; cv=none; b=tcrYAn1vToEDBX+L2UMHcehtei1lxvWY26Cms4km/pxtgf8NxGUakjOq6000WjBQ4kOtNvQRumBGI3VVw8qMcs/pH/snflriu/pC8EejTmbNE0CYzwyWHE5osPifk3ZRQC9hAwQ7Wl+1NtyWCjDgmVxryyMFe7+ngyNKN4pyEKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891714; c=relaxed/simple;
	bh=HMHKKhxbHkT74qaSJ/2EQbHMFK31T+JYdwQXFALm0+A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VnWY7kaa5fRA7e0TIe4uLQRgazaQSv62Z5Xv08GceiFxl58V8HnSlOmcBS3uuxvfetooSgCkWdKE+NHWTB9nXxqaIb0LoSkNIK3WCLZIkNBdvBwjRB2CKsjIbmLilkESaksLodoW9JSrn5mX87j26VKsCumfIYTqE8pQ4D3ngnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HB7IG2oD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c6OzyDsE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:35:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742891710;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w65NSURQPqlLPTKxR/K2kyZiY2P7rh2rmzQaKoqFUHk=;
	b=HB7IG2oDTrN/r47fgDys28SLpIU3J5dNAGrB85bWHY3oRovl8Z6AnWYtS/qeevS8JWSX6X
	ILF757LY4A6C6Yqs2m8d/VAxxM7j+kjyHlEJexLwrfySdZCvSt0sd6Lwkw0+f3HxLHYhtf
	HrNdzmzapZPdfUQWyzKp/VPqKDLQBAOJOtjtxcUpc5OrFfHlvftQety0EJv8L6aZFp3L8R
	A8ISUb4Xt1K8+hO3v/jRH+2J7PKW57kh0NktwOjvUbVo3ZKAeb7wxntrecQVnczcqSJRpz
	mZ5XA/D0oKV4q8Cpig6kabMRP2VZ7PPzo6NcbXYVBMQj3QqhlP/Ub2RdVTKpow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742891710;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w65NSURQPqlLPTKxR/K2kyZiY2P7rh2rmzQaKoqFUHk=;
	b=c6OzyDsEeWZumFMlbaGq+0PbWVSubEtY7y/TixSlBAFUUw+0b7NeUdEKG9JbDHARiwv1uO
	6PczuO7+wVKRW6BQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Ignore entire functions rather than
 instructions
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <4af13376567f83331a9372ae2bb25e11a3d0f055.1742852846.git.jpoimboe@kernel.org>
References:
 <4af13376567f83331a9372ae2bb25e11a3d0f055.1742852846.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289171028.14745.16603362410029596951.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     c84301d706c5456b1460439b2987a0f0b6362a82
Gitweb:        https://git.kernel.org/tip/c84301d706c5456b1460439b2987a0f0b6362a82
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 14:55:53 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:20:25 +01:00

objtool: Ignore entire functions rather than instructions

STACK_FRAME_NON_STANDARD applies to functions.  Use a function-specific
ignore attribute in preparation for getting rid of insn->ignore.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/4af13376567f83331a9372ae2bb25e11a3d0f055.1742852846.git.jpoimboe@kernel.org
---
 tools/objtool/check.c               | 35 ++++++++++++++--------------
 tools/objtool/include/objtool/elf.h |  1 +-
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index dae17ed..f465020 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -981,7 +981,6 @@ static int create_direct_call_sections(struct objtool_file *file)
  */
 static void add_ignores(struct objtool_file *file)
 {
-	struct instruction *insn;
 	struct section *rsec;
 	struct symbol *func;
 	struct reloc *reloc;
@@ -1008,8 +1007,7 @@ static void add_ignores(struct objtool_file *file)
 			continue;
 		}
 
-		func_for_each_insn(file, func, insn)
-			insn->ignore = true;
+		func->ignore = true;
 	}
 }
 
@@ -1612,6 +1610,7 @@ static int add_call_destinations(struct objtool_file *file)
 	struct reloc *reloc;
 
 	for_each_insn(file, insn) {
+		struct symbol *func = insn_func(insn);
 		if (insn->type != INSN_CALL)
 			continue;
 
@@ -1622,7 +1621,7 @@ static int add_call_destinations(struct objtool_file *file)
 
 			add_call_dest(file, insn, dest, false);
 
-			if (insn->ignore)
+			if (func && func->ignore)
 				continue;
 
 			if (!insn_call_dest(insn)) {
@@ -1630,7 +1629,7 @@ static int add_call_destinations(struct objtool_file *file)
 				return -1;
 			}
 
-			if (insn_func(insn) && insn_call_dest(insn)->type != STT_FUNC) {
+			if (func && insn_call_dest(insn)->type != STT_FUNC) {
 				WARN_INSN(insn, "unsupported call to non-function");
 				return -1;
 			}
@@ -3470,6 +3469,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 	u8 visited;
 	int ret;
 
+	if (func && func->ignore)
+		return 0;
+
 	sec = insn->sec;
 
 	while (1) {
@@ -3715,7 +3717,7 @@ static int validate_unwind_hint(struct objtool_file *file,
 				  struct instruction *insn,
 				  struct insn_state *state)
 {
-	if (insn->hint && !insn->visited && !insn->ignore) {
+	if (insn->hint && !insn->visited) {
 		int ret = validate_branch(file, insn_func(insn), insn, *state);
 		if (ret)
 			BT_INSN(insn, "<=== (hint)");
@@ -3929,10 +3931,11 @@ static bool is_ubsan_insn(struct instruction *insn)
 
 static bool ignore_unreachable_insn(struct objtool_file *file, struct instruction *insn)
 {
-	int i;
+	struct symbol *func = insn_func(insn);
 	struct instruction *prev_insn;
+	int i;
 
-	if (insn->ignore || insn->type == INSN_NOP || insn->type == INSN_TRAP)
+	if (insn->ignore || insn->type == INSN_NOP || insn->type == INSN_TRAP || (func && func->ignore))
 		return true;
 
 	/*
@@ -3951,7 +3954,7 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 	 * In this case we'll find a piece of code (whole function) that is not
 	 * covered by a !section symbol. Ignore them.
 	 */
-	if (opts.link && !insn_func(insn)) {
+	if (opts.link && !func) {
 		int size = find_symbol_hole_containing(insn->sec, insn->offset);
 		unsigned long end = insn->offset + size;
 
@@ -3977,19 +3980,17 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 			 */
 			if (insn->jump_dest && insn_func(insn->jump_dest) &&
 			    strstr(insn_func(insn->jump_dest)->name, ".cold")) {
-				struct instruction *dest = insn->jump_dest;
-				func_for_each_insn(file, insn_func(dest), dest)
-					dest->ignore = true;
+				insn_func(insn->jump_dest)->ignore = true;
 			}
 		}
 
 		return false;
 	}
 
-	if (!insn_func(insn))
+	if (!func)
 		return false;
 
-	if (insn_func(insn)->static_call_tramp)
+	if (func->static_call_tramp)
 		return true;
 
 	/*
@@ -4020,7 +4021,7 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 
 		if (insn->type == INSN_JUMP_UNCONDITIONAL) {
 			if (insn->jump_dest &&
-			    insn_func(insn->jump_dest) == insn_func(insn)) {
+			    insn_func(insn->jump_dest) == func) {
 				insn = insn->jump_dest;
 				continue;
 			}
@@ -4028,7 +4029,7 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 			break;
 		}
 
-		if (insn->offset + insn->len >= insn_func(insn)->offset + insn_func(insn)->len)
+		if (insn->offset + insn->len >= func->offset + func->len)
 			break;
 
 		insn = next_insn_same_sec(file, insn);
@@ -4120,7 +4121,7 @@ static int validate_symbol(struct objtool_file *file, struct section *sec,
 		return 0;
 
 	insn = find_insn(file, sec, sym->offset);
-	if (!insn || insn->ignore || insn->visited)
+	if (!insn || insn->visited)
 		return 0;
 
 	state->uaccess = sym->uaccess_safe;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 4edc957..eba0439 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -68,6 +68,7 @@ struct symbol {
 	u8 embedded_insn     : 1;
 	u8 local_label       : 1;
 	u8 frame_pointer     : 1;
+	u8 ignore	     : 1;
 	u8 warnings	     : 2;
 	struct list_head pv_target;
 	struct reloc *relocs;

