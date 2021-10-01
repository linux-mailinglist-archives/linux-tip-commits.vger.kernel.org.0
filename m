Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC0841ED13
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Oct 2021 14:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354345AbhJAMMa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 Oct 2021 08:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354322AbhJAMM3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 Oct 2021 08:12:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF4BC06177B;
        Fri,  1 Oct 2021 05:10:45 -0700 (PDT)
Date:   Fri, 01 Oct 2021 12:10:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633090244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2DoAPpnW6nze+QbMQRuvKt4Utwv1lG5GthgalZwKw+I=;
        b=JtK0uIOt9ObRc8H8dtH+piweNJ0IDIcAPOgQqbLTeNUfsQSRFg9NJtTUaLylE+wu0/d4P0
        Efh2ZkyJjm2Cg30OG7Oz1CE3wZC4N9BXbCA/mhPfF7j4SQc7K5YBoJCQOodqrFUqTKOn9O
        FG84WtXAmubXiQsgeZ3NiFqnDTP6HPHtFZj2rXg0XqmLdHN5WJxWkxoR4Uy2AOrcgOX2ks
        iWXtFkuflDWjrxJECwT1mcAdEEpfMnyiz1SOa9xfDAWXBufL1bKQ4yI5AgliwRQsX3ea7J
        I3wgo6BPAfD8VbnLi3Rj3GoNE+211KZ6+zNI6Lp2Ad9l3hhL3AcXS4jEglY2mA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633090244;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2DoAPpnW6nze+QbMQRuvKt4Utwv1lG5GthgalZwKw+I=;
        b=L99MPhdkY2hp/Yqv+bbfvsfYK5/ODfadrNoxDF9+u4VTvfOehtsDB2FBk5ZKeji7I1Zoz8
        +HZpBCuJII8GxWCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Teach get_alt_entry() about more
 relocation types
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Borislav Petkov <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YVWUvknIEVNkPvnP@hirez.programming.kicks-ass.net>
References: <YVWUvknIEVNkPvnP@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <163309024344.25758.12284143323900056369.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     24ff652573754fe4c03213ebd26b17e86842feb3
Gitweb:        https://git.kernel.org/tip/24ff652573754fe4c03213ebd26b17e86842feb3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 30 Sep 2021 12:43:10 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 Oct 2021 13:57:47 +02:00

objtool: Teach get_alt_entry() about more relocation types

Occasionally objtool encounters symbol (as opposed to section)
relocations in .altinstructions. Typically they are the alternatives
written by elf_add_alternative() as encountered on a noinstr
validation run on vmlinux after having already ran objtool on the
individual .o files.

Basically this is the counterpart of commit 44f6a7c0755d ("objtool:
Fix seg fault with Clang non-section symbols"), because when these new
assemblers (binutils now also does this) strip the section symbols,
elf_add_reloc_to_insn() is forced to emit symbol based relocations.

As such, teach get_alt_entry() about different relocation types.

Fixes: 9bc0bb50727c ("objtool/x86: Rewrite retpoline thunk calls")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/YVWUvknIEVNkPvnP@hirez.programming.kicks-ass.net
---
 tools/objtool/special.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index bc925cf..f58ecc5 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -58,6 +58,24 @@ void __weak arch_handle_alternative(unsigned short feature, struct special_alt *
 {
 }
 
+static bool reloc2sec_off(struct reloc *reloc, struct section **sec, unsigned long *off)
+{
+	switch (reloc->sym->type) {
+	case STT_FUNC:
+		*sec = reloc->sym->sec;
+		*off = reloc->sym->offset + reloc->addend;
+		return true;
+
+	case STT_SECTION:
+		*sec = reloc->sym->sec;
+		*off = reloc->addend;
+		return true;
+
+	default:
+		return false;
+	}
+}
+
 static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 			 struct section *sec, int idx,
 			 struct special_alt *alt)
@@ -91,15 +109,12 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 		WARN_FUNC("can't find orig reloc", sec, offset + entry->orig);
 		return -1;
 	}
-	if (orig_reloc->sym->type != STT_SECTION) {
-		WARN_FUNC("don't know how to handle non-section reloc symbol %s",
+	if (!reloc2sec_off(orig_reloc, &alt->orig_sec, &alt->orig_off)) {
+		WARN_FUNC("don't know how to handle reloc symbol type: %s",
 			   sec, offset + entry->orig, orig_reloc->sym->name);
 		return -1;
 	}
 
-	alt->orig_sec = orig_reloc->sym->sec;
-	alt->orig_off = orig_reloc->addend;
-
 	if (!entry->group || alt->new_len) {
 		new_reloc = find_reloc_by_dest(elf, sec, offset + entry->new);
 		if (!new_reloc) {
@@ -116,8 +131,11 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 		if (arch_is_retpoline(new_reloc->sym))
 			return 1;
 
-		alt->new_sec = new_reloc->sym->sec;
-		alt->new_off = (unsigned int)new_reloc->addend;
+		if (!reloc2sec_off(new_reloc, &alt->new_sec, &alt->new_off)) {
+			WARN_FUNC("don't know how to handle reloc symbol type: %s",
+				  sec, offset + entry->new, new_reloc->sym->name);
+			return -1;
+		}
 
 		/* _ASM_EXTABLE_EX hack */
 		if (alt->new_off >= 0x7ffffff0)
