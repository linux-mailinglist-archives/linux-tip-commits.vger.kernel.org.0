Return-Path: <linux-tip-commits+bounces-4605-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7B0A77507
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 09:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672981889C85
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 07:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE6D1EB1A6;
	Tue,  1 Apr 2025 07:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ePjVapIP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S/YzRrDe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3B11EA7CB;
	Tue,  1 Apr 2025 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743491725; cv=none; b=CEyvR0xSkFrPSWfLcWRjMd7gYD1HrptfOQqkdu67mGZIHx1BhlMkY5xTIZUT7XfW3ROZ/qaY6xaQ4nG80d/xM2tDBbdCW8FKTouT1ODVpcj7DI6r70Te/bXDUs0IWWd6mQlveHa5gm4ojwuO4YBKLQI4n1uCEiHcwQ+ePbkr4JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743491725; c=relaxed/simple;
	bh=6CH0t4GKWiSWj9rpuSu4se5Ry0ZMNSutbiaZgyCj61s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MR7948SbuW1uJNEtyc1cjodrV7oT9r0X1sdYuJ1QKgNuzKIXdqoLM4NGhVwgbf9F1kG3ebtqYmy1qhIkXBqNoIaX5oN1PjBKPp+VEbwOg7Z9LNutkwDdYipmPe2b419MN1wNaiBM1sOoNH8U+x6Gg/U7jDiBUfH4W1ZKAjtbjcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ePjVapIP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S/YzRrDe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Apr 2025 07:15:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743491721;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbglLAZ6jjxInThczPoFshd6Acs0KiHomd+eBFpDi/8=;
	b=ePjVapIP+g3KZYYtS1kwsxbmbxFVwL+GRFV3zgPJ89IM4MD3o3r+Eww6iNeBEXwuH99B4F
	VnS0mDHBcnFg9A6m0JkQhG7N8o0rWBTM3tqC2F71lUNUgjQosX953ZWPZFTjBYsgq7VJvh
	DbqH/ZKwnAzxY9oy742w2zyFcg7JQGkGruu9FGSzPX4ZskVYHUtorMD5WGvfyznTOlKuPu
	O/Xu8Eyp+dI0eVNp7t2TOmgiKZe+2y/oLVyJfWwUuFlZwZEh/gLNaSSH+PStWbyypDWCL7
	liut5i8mizfEX7Z8e/60f5/VvAfiSWEIVcudbpHJG/TiOTDDyGGxjlq9fBnd0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743491721;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbglLAZ6jjxInThczPoFshd6Acs0KiHomd+eBFpDi/8=;
	b=S/YzRrDeiZU1MCYi+vG+TBd12ttCfJaJWei1tAyoJzxcxSo11qEa/RxJd134KY8VnaulHh
	SBM7O+Q6OI6bQAAQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/urgent] objtool: Ignore end-of-section jumps for KCOV/GCOV
Cc: Randy Dunlap <rdunlap@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <08fbe7d7e1e20612206f1df253077b94f178d93e.1743481539.git.jpoimboe@kernel.org>
References:
 <08fbe7d7e1e20612206f1df253077b94f178d93e.1743481539.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174349172118.14745.4583453326563185652.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     0d7597749f5a3ac67851d3836635d084df15fb66
Gitweb:        https://git.kernel.org/tip/0d7597749f5a3ac67851d3836635d084df15fb66
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 31 Mar 2025 21:26:37 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 09:07:12 +02:00

objtool: Ignore end-of-section jumps for KCOV/GCOV

When KCOV or GCOV is enabled, dead code can be left behind, in which
case objtool silences unreachable and undefined behavior (fallthrough)
warnings.

Fallthrough warnings, and their variant "end of section" warnings, were
silenced with the following commit:

  6b023c784204 ("objtool: Silence more KCOV warnings")

Another variant of a fallthrough warning is a jump to the end of a
function.  If that function happens to be at the end of a section, the
jump destination doesn't actually exist.

Normally that would be a fatal objtool error, but for KCOV/GCOV it's
just another undefined behavior fallthrough.  Silence it like the
others.

Fixes the following warning:

  drivers/iommu/dma-iommu.o: warning: objtool: iommu_dma_sw_msi+0x92: can't find jump dest instruction at .text+0x54d5

Fixes: 6b023c784204 ("objtool: Silence more KCOV warnings")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/08fbe7d7e1e20612206f1df253077b94f178d93e.1743481539.git.jpoimboe@kernel.org
Closes: https://lore.kernel.org/314f8809-cd59-479b-97d7-49356bf1c8d1@infradead.org/
---
 tools/objtool/check.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index fff9d7a..e6c4eef 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1488,6 +1488,8 @@ static int add_jump_destinations(struct objtool_file *file)
 	int ret;
 
 	for_each_insn(file, insn) {
+		struct symbol *func = insn_func(insn);
+
 		if (insn->jump_dest) {
 			/*
 			 * handle_group_alt() may have previously set
@@ -1513,7 +1515,7 @@ static int add_jump_destinations(struct objtool_file *file)
 		} else if (reloc->sym->return_thunk) {
 			add_return_call(file, insn, true);
 			continue;
-		} else if (insn_func(insn)) {
+		} else if (func) {
 			/*
 			 * External sibling call or internal sibling call with
 			 * STT_FUNC reloc.
@@ -1548,6 +1550,15 @@ static int add_jump_destinations(struct objtool_file *file)
 				continue;
 			}
 
+			/*
+			 * GCOV/KCOV dead code can jump to the end of the
+			 * function/section.
+			 */
+			if (file->ignore_unreachables && func &&
+			    dest_sec == insn->sec &&
+			    dest_off == func->offset + func->len)
+				continue;
+
 			WARN_INSN(insn, "can't find jump dest instruction at %s+0x%lx",
 				  dest_sec->name, dest_off);
 			return -1;
@@ -1574,8 +1585,7 @@ static int add_jump_destinations(struct objtool_file *file)
 		/*
 		 * Cross-function jump.
 		 */
-		if (insn_func(insn) && insn_func(jump_dest) &&
-		    insn_func(insn) != insn_func(jump_dest)) {
+		if (func && insn_func(jump_dest) && func != insn_func(jump_dest)) {
 
 			/*
 			 * For GCC 8+, create parent/child links for any cold
@@ -1592,10 +1602,10 @@ static int add_jump_destinations(struct objtool_file *file)
 			 * case where the parent function's only reference to a
 			 * subfunction is through a jump table.
 			 */
-			if (!strstr(insn_func(insn)->name, ".cold") &&
+			if (!strstr(func->name, ".cold") &&
 			    strstr(insn_func(jump_dest)->name, ".cold")) {
-				insn_func(insn)->cfunc = insn_func(jump_dest);
-				insn_func(jump_dest)->pfunc = insn_func(insn);
+				func->cfunc = insn_func(jump_dest);
+				insn_func(jump_dest)->pfunc = func;
 			}
 		}
 

