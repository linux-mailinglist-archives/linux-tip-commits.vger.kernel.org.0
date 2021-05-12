Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A2537BDF9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 15:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhELNU6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 09:20:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51694 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbhELNU5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 09:20:57 -0400
Date:   Wed, 12 May 2021 13:19:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620825588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r9agY4BSWr+/5Lkd3pVf9WcTIaJywNy5cQ8OBpZPUww=;
        b=bwh5PRRXmqzr8G9yjANMVGcNTIvQUoTf+J4Ds8Ne2zMtCpXpCBUM0qIBcW2BMMnzATul0J
        QI3s3qTkpw/1SVpDV9Vm+R2XW4/GTvI9mjP9ImKl9wQM9OK9okBdhxwPaWP2NClnPkprwf
        +7zlcV7GuAOGw+EXxIYSTHebrgv7VA4GC14RXtkN4PwbYnsVtuODIotsUJK/dOkIWIjyF6
        IBLETI63CUYsu9Ejp4XDMc2TYLI5CjL/YCcWmcwXKdmwPfoCYApfjXiUMPZ5DchGakqo/W
        zY1ifpo1El2fMtjWHIqLsk4hxvGwmIflbeX8/UWw98Og6Zc/1k5/7CnmpQbn3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620825588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r9agY4BSWr+/5Lkd3pVf9WcTIaJywNy5cQ8OBpZPUww=;
        b=uQFyCA6BwX6bEDOQ+qdnEbokyAUIxFYCNf+1kjQldlj+z/DRyixU0GaeB4cZxvQ/VzaGCd
        WWug0BSaN9mCkUCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Rewrite jump_label instructions
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210506194158.091028792@infradead.org>
References: <20210506194158.091028792@infradead.org>
MIME-Version: 1.0
Message-ID: <162082558817.29796.3667347480291581926.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     6d37b83c5d79ef5996cc49c3e3ac3d8ecd8c7050
Gitweb:        https://git.kernel.org/tip/6d37b83c5d79ef5996cc49c3e3ac3d8ecd8c7050
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 06 May 2021 21:34:03 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 14:54:56 +02:00

objtool: Rewrite jump_label instructions

When a jump_entry::key has bit1 set, rewrite the instruction to be a
NOP. This allows the compiler/assembler to emit JMP (and thus decide
on which encoding to use).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210506194158.091028792@infradead.org
---
 tools/objtool/check.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 9ed1a4c..98cf87f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1234,6 +1234,20 @@ static int handle_jump_alt(struct objtool_file *file,
 		return -1;
 	}
 
+	if (special_alt->key_addend & 2) {
+		struct reloc *reloc = insn_reloc(file, orig_insn);
+
+		if (reloc) {
+			reloc->type = R_NONE;
+			elf_write_reloc(file->elf, reloc);
+		}
+		elf_write_insn(file->elf, orig_insn->sec,
+			       orig_insn->offset, orig_insn->len,
+			       arch_nop_insn(orig_insn->len));
+		orig_insn->type = INSN_NOP;
+		return 0;
+	}
+
 	*new_insn = list_next_entry(orig_insn, list);
 	return 0;
 }
