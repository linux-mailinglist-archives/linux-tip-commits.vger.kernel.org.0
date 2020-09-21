Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01658272EAC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 21 Sep 2020 18:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbgIUQvP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 21 Sep 2020 12:51:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52704 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbgIUQvP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 21 Sep 2020 12:51:15 -0400
Date:   Mon, 21 Sep 2020 16:51:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600707072;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gVfzDlgm3AjlhLPfD/PKu06jc0A49KijvnhM+NCvAtE=;
        b=lA42DkUts5sGVQjJ9hli9afXyjP6AyShGvDFmxY40yI4uiUF3LiwsJcyWADUvyglJxqYBX
        O1T/ZPkNVUWWT+sSW7rg99p96PXYVBCVzAHAp4BDQWkXiIJ8t4259X3KDTi9uhzd/9/Hyz
        aGw/OuKO+tMHNDylVyjKLmJnlP53pu2ZXT1oOZ8yfzLKtq4EvZOAsfRHfRTIc7NStD3kLn
        luEVfHherWJz9nL5855uRU1xG8/dNTvopVkynFgDtgEdEbcTIDP+eoP07ASK5/FrbAEOm0
        j+VfVI30IKO2zCGzswLXCZUSW7OCBcQkdhOL/Kc4TQJpwG1wAbdmSRQytJrVjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600707072;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gVfzDlgm3AjlhLPfD/PKu06jc0A49KijvnhM+NCvAtE=;
        b=rPGj3exW2Dhoz0IZpgLvk7sfYpVIILlwL7wmucTl7btJpa8QgCxx0KH1xHV8x1xQu3N3D7
        vlOPZwa/+j/uIPDg==
From:   "tip-bot2 for Ilie Halip" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Ignore unreachable trap after call to
 noreturn functions
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Rong Chen <rong.a.chen@intel.com>,
        Marco Elver <elver@google.com>,
        Philip Li <philip.li@intel.com>,
        Borislav Petkov <bp@alien8.de>, kasan-dev@googlegroups.com,
        x86@kernel.org, clang-built-linux@googlegroups.com,
        kbuild test robot <lkp@intel.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <CAKwvOdmptEpi8fiOyWUo=AiZJiX+Z+VHJOM2buLPrWsMTwLnyw@mail.gmail.com>
References: <CAKwvOdmptEpi8fiOyWUo=AiZJiX+Z+VHJOM2buLPrWsMTwLnyw@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <160070707105.15536.14094674309505985856.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     14db1f0a93331d0958e90da522c429ff0890d2d6
Gitweb:        https://git.kernel.org/tip/14db1f0a93331d0958e90da522c429ff0890d2d6
Author:        Ilie Halip <ilie.halip@gmail.com>
AuthorDate:    Sat, 19 Sep 2020 09:41:18 +03:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Mon, 21 Sep 2020 10:20:10 -05:00

objtool: Ignore unreachable trap after call to noreturn functions

With CONFIG_UBSAN_TRAP enabled, the compiler may insert a trap
instruction after a call to a noreturn function. In this case, objtool
warns that the UD2 instruction is unreachable.

This is a behavior seen with Clang, from the oldest version capable of
building the mainline x64_64 kernel (9.0), to the latest experimental
version (12.0).

Objtool silences similar warnings (trap after dead end instructions), so
so expand that check to include dead end functions.

Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Rong Chen <rong.a.chen@intel.com>
Cc: Marco Elver <elver@google.com>
Cc: Philip Li <philip.li@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: kasan-dev@googlegroups.com
Cc: x86@kernel.org
Cc: clang-built-linux@googlegroups.com
BugLink: https://github.com/ClangBuiltLinux/linux/issues/1148
Link: https://lore.kernel.org/lkml/CAKwvOdmptEpi8fiOyWUo=AiZJiX+Z+VHJOM2buLPrWsMTwLnyw@mail.gmail.com
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a4796e3..2df9f76 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2638,9 +2638,10 @@ static bool is_ubsan_insn(struct instruction *insn)
 			"__ubsan_handle_builtin_unreachable"));
 }
 
-static bool ignore_unreachable_insn(struct instruction *insn)
+static bool ignore_unreachable_insn(struct objtool_file *file, struct instruction *insn)
 {
 	int i;
+	struct instruction *prev_insn;
 
 	if (insn->ignore || insn->type == INSN_NOP)
 		return true;
@@ -2668,8 +2669,11 @@ static bool ignore_unreachable_insn(struct instruction *insn)
 	 * __builtin_unreachable().  The BUG() macro has an unreachable() after
 	 * the UD2, which causes GCC's undefined trap logic to emit another UD2
 	 * (or occasionally a JMP to UD2).
+	 *
+	 * It may also insert a UD2 after calling a __noreturn function.
 	 */
-	if (list_prev_entry(insn, list)->dead_end &&
+	prev_insn = list_prev_entry(insn, list);
+	if ((prev_insn->dead_end || dead_end_function(file, prev_insn->call_dest)) &&
 	    (insn->type == INSN_BUG ||
 	     (insn->type == INSN_JUMP_UNCONDITIONAL &&
 	      insn->jump_dest && insn->jump_dest->type == INSN_BUG)))
@@ -2796,7 +2800,7 @@ static int validate_reachable_instructions(struct objtool_file *file)
 		return 0;
 
 	for_each_insn(file, insn) {
-		if (insn->visited || ignore_unreachable_insn(insn))
+		if (insn->visited || ignore_unreachable_insn(file, insn))
 			continue;
 
 		WARN_FUNC("unreachable instruction", insn->sec, insn->offset);
