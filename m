Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A3C43F871
	for <lists+linux-tip-commits@lfdr.de>; Fri, 29 Oct 2021 10:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhJ2IFk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 29 Oct 2021 04:05:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53288 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbhJ2IFe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 29 Oct 2021 04:05:34 -0400
Date:   Fri, 29 Oct 2021 08:03:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635494585;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L8zZv+pPVtV53vtlRO0B8lPEfEDPQtJQwJ6xbZTg54Y=;
        b=I+lblP6rZR3C0K7wKNZvjed+Gw1dxx8Z5NGUmIwdviV2StVaeEK5PUijqqFJJeIfn2WYzR
        S7POeAgrIvyJ818ozBbkLVzTmTQ5ZeleX1URkwlLCE94XPOx5YH+zY8Y2eP+p4YyfE5NOv
        Tacs9jpt/Dz6UeuMHsdd1IG8V2CSFjEarP6ZVw8lTxELRqeuFiiTXQOlLEw/1oHEhxDXJE
        wfJirn7jBDJf3UOlJnozJ6DL9WoEoKs1e8B8n2UsKkqyxt7vxnkw/gpnIa8kq2SpZ8jMlr
        4+M5WmcUalJ/LK1V8fnRKFbazxC5TpxrT0QuSERe6L81iAyThD059kvJEf/1bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635494585;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L8zZv+pPVtV53vtlRO0B8lPEfEDPQtJQwJ6xbZTg54Y=;
        b=fgLxVrCQOftL3Qr1X0xywq6Wnjqhp/7uqzXGlkac1W/amteAVKSVzsMu1ZSvHFlqw0Hva9
        NddtujlbWEQITYBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Shrink struct instruction
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211026120309.785456706@infradead.org>
References: <20211026120309.785456706@infradead.org>
MIME-Version: 1.0
Message-ID: <163549458492.626.12056659638124309839.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     c509331b41b7365e17396c246e8c5797bccc8074
Gitweb:        https://git.kernel.org/tip/c509331b41b7365e17396c246e8c5797bccc8074
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 26 Oct 2021 14:01:35 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 28 Oct 2021 23:25:25 +02:00

objtool: Shrink struct instruction

Any one instruction can only ever call a single function, therefore
insn->mcount_loc_node is superfluous and can use insn->call_node.

This shrinks struct instruction, which is by far the most numerous
structure objtool creates.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/r/20211026120309.785456706@infradead.org
---
 tools/objtool/check.c                 | 6 +++---
 tools/objtool/include/objtool/check.h | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8ab6f24..ce3c25f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -701,7 +701,7 @@ static int create_mcount_loc_sections(struct objtool_file *file)
 		return 0;
 
 	idx = 0;
-	list_for_each_entry(insn, &file->mcount_loc_list, mcount_loc_node)
+	list_for_each_entry(insn, &file->mcount_loc_list, call_node)
 		idx++;
 
 	sec = elf_create_section(file->elf, "__mcount_loc", 0, sizeof(unsigned long), idx);
@@ -709,7 +709,7 @@ static int create_mcount_loc_sections(struct objtool_file *file)
 		return -1;
 
 	idx = 0;
-	list_for_each_entry(insn, &file->mcount_loc_list, mcount_loc_node) {
+	list_for_each_entry(insn, &file->mcount_loc_list, call_node) {
 
 		loc = (unsigned long *)sec->data->d_buf + idx;
 		memset(loc, 0, sizeof(unsigned long));
@@ -1051,7 +1051,7 @@ static void annotate_call_site(struct objtool_file *file,
 
 		insn->type = INSN_NOP;
 
-		list_add_tail(&insn->mcount_loc_node, &file->mcount_loc_list);
+		list_add_tail(&insn->call_node, &file->mcount_loc_list);
 		return;
 	}
 }
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index 07e99c2..6cfff07 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -40,7 +40,6 @@ struct instruction {
 	struct list_head list;
 	struct hlist_node hash;
 	struct list_head call_node;
-	struct list_head mcount_loc_node;
 	struct section *sec;
 	unsigned long offset;
 	unsigned int len;
