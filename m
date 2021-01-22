Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF606300498
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Jan 2021 14:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbhAVNyo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Jan 2021 08:54:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54304 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbhAVNyn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Jan 2021 08:54:43 -0500
Date:   Fri, 22 Jan 2021 13:53:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611323640;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RnxhB8ONGz0zpdWFDHgiUNcqqyRyHOR1I0JMIRvOpVE=;
        b=feH4g8w59hKzp0IDOApIV17Gq2aLyeIxNod+bID09iVGlt2O3tWLDFPnU6fhDcL0l6ax4p
        UGJI+qkbvsaCTxNVnS6fqZc+j5vEh61YRfDlF3CCWlr1vBwuQSshO48YiFsakSAT01tXFT
        Gsh+ujhk3RZFnno2BYluOnTr/T5g/6ANxbloS8Y33Afk/bE0b9aeCACOa74xnFUkGren2z
        fhU2oWWT4nm/sNxWFtsVgh8S4Hz5wIE83YTpXUIL/bnSWOO9xkGjnesuvImrDG7dmVSd/p
        Xb5RNRsesZIybUta7AY3gP5rLDlWzdR9iACpWY854ZSPpfdUS6saXGvzaetK6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611323640;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RnxhB8ONGz0zpdWFDHgiUNcqqyRyHOR1I0JMIRvOpVE=;
        b=x+pt40GlFZ3BmmHtkKrblZVn0vRwls39Ij/xVVwwgclD+YDBcSOSkkQFx93vNrlBc4sEiJ
        h2vVW6CDLYW7KZAw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Don't fail on missing symbol table
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161132363950.414.18137582178365260536.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     1d489151e9f9d1647110277ff77282fe4d96d09b
Gitweb:        https://git.kernel.org/tip/1d489151e9f9d1647110277ff77282fe4d96d09b
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Thu, 14 Jan 2021 16:14:01 -06:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Thu, 21 Jan 2021 15:49:58 -06:00

objtool: Don't fail on missing symbol table

Thanks to a recent binutils change which doesn't generate unused
symbols, it's now possible for thunk_64.o be completely empty without
CONFIG_PREEMPTION: no text, no data, no symbols.

We could edit the Makefile to only build that file when
CONFIG_PREEMPTION is enabled, but that will likely create confusion
if/when the thunks end up getting used by some other code again.

Just ignore it and move on.

Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1254
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/elf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index f9682db..d8421e1 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -380,8 +380,11 @@ static int read_symbols(struct elf *elf)
 
 	symtab = find_section_by_name(elf, ".symtab");
 	if (!symtab) {
-		WARN("missing symbol table");
-		return -1;
+		/*
+		 * A missing symbol table is actually possible if it's an empty
+		 * .o file.  This can happen for thunk_64.o.
+		 */
+		return 0;
 	}
 
 	symtab_shndx = find_section_by_name(elf, ".symtab_shndx");
