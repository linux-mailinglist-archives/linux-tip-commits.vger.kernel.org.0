Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACD2424A0A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Oct 2021 00:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239650AbhJFWsR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 6 Oct 2021 18:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239608AbhJFWsP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 6 Oct 2021 18:48:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6C6C061746;
        Wed,  6 Oct 2021 15:46:22 -0700 (PDT)
Date:   Wed, 06 Oct 2021 22:46:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633560380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oixso5RL9657SL4WXSVV1J70icaXywvrPWVEpFwy9D8=;
        b=d9fFZYxDO0tfqmzAiiDGAfvOZaRxNyTGtUndcS3iIRMuTbkpN6EPOQIdtvKFhNEfB5/oqk
        9fuDhPKJ1iXraoL6aNSP5cc8BkpA7jePhfBsfOcKFX6qZRPNFr/BQQlP0DVUjP1dB6SFtS
        R5oXHKb3yGZxEJp3CpFH+7Lu4ATR8JjKC+4/hIi4vI6HlTtAilpRJBRoiJ3ZwODHpRcRwZ
        7n2ChYNPRZliGlfcUQ5CVCo3LqDdCeyZ+pyE/ZUHuBeh5+ScUy1qIyWS3d8Y7VchRHWHRY
        By5z5Hp1KKRwY1uK3e9N36/XHWscdCkuLWNouiO3m99e6acNeFqMVZs9vjsdkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633560380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oixso5RL9657SL4WXSVV1J70icaXywvrPWVEpFwy9D8=;
        b=W7zTEmycnka+D+I/6URiCGqFbr+y/3l/1i9RfeK4vyx3vmYO2BZd4bTqV48MdIiYMU1zhc
        SlyyhAIOkxApbkDQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Remove reloc symbol type checks in
 get_alt_entry()
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <feadbc3dfb3440d973580fad8d3db873cbfe1694.1633367242.git.jpoimboe@redhat.com>
References: <feadbc3dfb3440d973580fad8d3db873cbfe1694.1633367242.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <163356037893.25758.13715919577098019589.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     4d8b35968bbf9e42b6b202eedb510e2c82ad8b38
Gitweb:        https://git.kernel.org/tip/4d8b35968bbf9e42b6b202eedb510e2c82ad8b38
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 04 Oct 2021 10:07:50 -07:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Tue, 05 Oct 2021 12:03:20 -07:00

objtool: Remove reloc symbol type checks in get_alt_entry()

Converting a special section's relocation reference to a symbol is
straightforward.  No need for objtool to complain that it doesn't know
how to handle it.  Just handle it.

This fixes the following warning:

  arch/x86/kvm/emulate.o: warning: objtool: __ex_table+0x4: don't know how to handle reloc symbol type: kvm_fastop_exception

Fixes: 24ff65257375 ("objtool: Teach get_alt_entry() about more relocation types")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/feadbc3dfb3440d973580fad8d3db873cbfe1694.1633367242.git.jpoimboe@redhat.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: linux-kernel@vger.kernel.org
---
 tools/objtool/special.c | 36 +++++++-----------------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index f1428e3..83d5f96 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -58,22 +58,11 @@ void __weak arch_handle_alternative(unsigned short feature, struct special_alt *
 {
 }
 
-static bool reloc2sec_off(struct reloc *reloc, struct section **sec, unsigned long *off)
+static void reloc_to_sec_off(struct reloc *reloc, struct section **sec,
+			     unsigned long *off)
 {
-	switch (reloc->sym->type) {
-	case STT_FUNC:
-		*sec = reloc->sym->sec;
-		*off = reloc->sym->offset + reloc->addend;
-		return true;
-
-	case STT_SECTION:
-		*sec = reloc->sym->sec;
-		*off = reloc->addend;
-		return true;
-
-	default:
-		return false;
-	}
+	*sec = reloc->sym->sec;
+	*off = reloc->sym->offset + reloc->addend;
 }
 
 static int get_alt_entry(struct elf *elf, struct special_entry *entry,
@@ -109,13 +98,8 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 		WARN_FUNC("can't find orig reloc", sec, offset + entry->orig);
 		return -1;
 	}
-	if (!reloc2sec_off(orig_reloc, &alt->orig_sec, &alt->orig_off)) {
-		WARN_FUNC("don't know how to handle reloc symbol type %d: %s",
-			   sec, offset + entry->orig,
-			   orig_reloc->sym->type,
-			   orig_reloc->sym->name);
-		return -1;
-	}
+
+	reloc_to_sec_off(orig_reloc, &alt->orig_sec, &alt->orig_off);
 
 	if (!entry->group || alt->new_len) {
 		new_reloc = find_reloc_by_dest(elf, sec, offset + entry->new);
@@ -133,13 +117,7 @@ static int get_alt_entry(struct elf *elf, struct special_entry *entry,
 		if (arch_is_retpoline(new_reloc->sym))
 			return 1;
 
-		if (!reloc2sec_off(new_reloc, &alt->new_sec, &alt->new_off)) {
-			WARN_FUNC("don't know how to handle reloc symbol type %d: %s",
-				  sec, offset + entry->new,
-				  new_reloc->sym->type,
-				  new_reloc->sym->name);
-			return -1;
-		}
+		reloc_to_sec_off(new_reloc, &alt->new_sec, &alt->new_off);
 
 		/* _ASM_EXTABLE_EX hack */
 		if (alt->new_off >= 0x7ffffff0)
