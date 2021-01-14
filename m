Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019512F5FC9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Jan 2021 12:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbhANLX5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Jan 2021 06:23:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58758 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbhANLX4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Jan 2021 06:23:56 -0500
Date:   Thu, 14 Jan 2021 11:23:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610623394;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=p6FYStTCWqnPDXI9RuPZqKmDipdL8KRPc5oQI4gz6jc=;
        b=xK5t1fQPBUQ99gSp9ztDl+kElXUkrJIId0y46Df9ZB2cvGtzQ+DwJlZH4JCvvabNsqr1X2
        YCVPkXYfSWHizfsm3/dJFJE9EoaAbVR63waXadEpQSu4sGrXkygG3LzEnv8ddNaMK+AEki
        1i2Kcw4LIfZfZ8Bs/f2i+1C+WtuSwQCCwhMduE/NW7IiwIH+0LT1sprUF9zDZPvFilF3gl
        TmiJPRE3endwhfcZ/eH4oeY91N42OC/o3FeUtsobPgjXomjWjPWKRARjI83PS2hJUYBrW5
        E41KuXSwUzDjrSkOxuiVAZXeQiITKqsuahVyjOtlCovmYn8IWI+xzVvgrMDlDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610623394;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=p6FYStTCWqnPDXI9RuPZqKmDipdL8KRPc5oQI4gz6jc=;
        b=wYkD2KLY6Gu97wqliVbZiUxoBNIoRs2L4lDV+1MnMB/e31eKLcFk/vuxTad7cC/Mg4Iyp5
        Q2KHe99hX4spPACQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Don't add empty symbols to the rbtree
Cc:     Arnd Bergmann <arnd@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161062339286.414.9465161232363489241.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     a2e38dffcd93541914aba52b30c6a52acca35201
Gitweb:        https://git.kernel.org/tip/a2e38dffcd93541914aba52b30c6a52acca35201
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Tue, 05 Jan 2021 18:04:20 -06:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Wed, 13 Jan 2021 16:56:37 -06:00

objtool: Don't add empty symbols to the rbtree

Building with the Clang assembler shows the following warning:

  arch/x86/kernel/ftrace_64.o: warning: objtool: missing symbol for insn at offset 0x16

The Clang assembler strips section symbols.  That ends up giving
objtool's find_func_containing() much more test coverage than normal.
Turns out, find_func_containing() doesn't work so well for overlapping
symbols:

     2: 000000000000000e     0 NOTYPE  LOCAL  DEFAULT    2 fgraph_trace
     3: 000000000000000f     0 NOTYPE  LOCAL  DEFAULT    2 trace
     4: 0000000000000000   165 FUNC    GLOBAL DEFAULT    2 __fentry__
     5: 000000000000000e     0 NOTYPE  GLOBAL DEFAULT    2 ftrace_stub

The zero-length NOTYPE symbols are inside __fentry__(), confusing the
rbtree search for any __fentry__() offset coming after a NOTYPE.

Try to avoid this problem by not adding zero-length symbols to the
rbtree.  They're rare and aren't needed in the rbtree anyway.

One caveat, this actually might not end up being the right fix.
Non-empty overlapping symbols, if they exist, could have the same
problem.  But that would need bigger changes, let's see if we can get
away with the easy fix for now.

Reported-by: Arnd Bergmann <arnd@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/elf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index be89c74..f9682db 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -448,6 +448,13 @@ static int read_symbols(struct elf *elf)
 		list_add(&sym->list, entry);
 		elf_hash_add(elf->symbol_hash, &sym->hash, sym->idx);
 		elf_hash_add(elf->symbol_name_hash, &sym->name_hash, str_hash(sym->name));
+
+		/*
+		 * Don't store empty STT_NOTYPE symbols in the rbtree.  They
+		 * can exist within a function, confusing the sorting.
+		 */
+		if (!sym->len)
+			rb_erase(&sym->node, &sym->sec->symbol_tree);
 	}
 
 	if (stats)
