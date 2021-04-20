Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0F53656BC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhDTKsU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:48:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52070 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbhDTKrx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:53 -0400
Date:   Tue, 20 Apr 2021 10:47:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OKt4dO1PrfmwHLYjivxpxatLVxjYOaj8pKl+mLomVCA=;
        b=RDKrE/ATMJaWPIMYGXaz5tfOUlMpBbrmgehHUIPMXbI2puCpaF1CtPlgpxyW2cGUXO6BeR
        UG8a1KEJVgYLfgtqDD48tl9B6NTu4lLKgHbXg78cwY05/QE89Bf9oUe4vpRXfsXIk0Pp5k
        XaMnSmy1C0tisZm/M0kFrSCux+6wydQ3rlSUaaPQge4l19Me5YWxF9H/vTuJVVsrnITPBc
        RUSudogomOXxkt7hHl/F5a4ijq+qbTVYeaL8LO98Aj+hFEXRIJjdv+7VYl3OF7EZPKmNCi
        x1loTr1xhCGT9FM+CSPU+M90p06ZSuDb70wueQECMomJjFSCrCwjkG0aFz97yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OKt4dO1PrfmwHLYjivxpxatLVxjYOaj8pKl+mLomVCA=;
        b=taCg2p+B8FcJfoIHCYxTDmWSzVdmlTPHwSXYkMh7QTHTe99j2+TdW/mRCWS1zL3P/tbVdY
        R+asxN6IO8IEsyCg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Support asm jump tables
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <460cf4dc675d64e1124146562cabd2c05aa322e8.1614182415.git.jpoimboe@redhat.com>
References: <460cf4dc675d64e1124146562cabd2c05aa322e8.1614182415.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <161891562491.29796.16863206875923055144.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     99033461e685b48549ec77608b4bda75ddf772ce
Gitweb:        https://git.kernel.org/tip/99033461e685b48549ec77608b4bda75ddf772ce
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Wed, 24 Feb 2021 10:29:14 -06:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Mon, 19 Apr 2021 12:36:32 -05:00

objtool: Support asm jump tables

Objtool detection of asm jump tables would normally just work, except
for the fact that asm retpolines use alternatives.  Objtool thinks the
alternative code path (a jump to the retpoline) is a sibling call.

Don't treat alternative indirect branches as sibling calls when the
original instruction has a jump table.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Link: https://lore.kernel.org/r/460cf4dc675d64e1124146562cabd2c05aa322e8.1614182415.git.jpoimboe@redhat.com
---
 tools/objtool/check.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a0f762a..46621e8 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -108,6 +108,18 @@ static struct instruction *prev_insn_same_sym(struct objtool_file *file,
 	for (insn = next_insn_same_sec(file, insn); insn;		\
 	     insn = next_insn_same_sec(file, insn))
 
+static bool is_jump_table_jump(struct instruction *insn)
+{
+	struct alt_group *alt_group = insn->alt_group;
+
+	if (insn->jump_table)
+		return true;
+
+	/* Retpoline alternative for a jump table? */
+	return alt_group && alt_group->orig_group &&
+	       alt_group->orig_group->first_insn->jump_table;
+}
+
 static bool is_sibling_call(struct instruction *insn)
 {
 	/*
@@ -120,7 +132,7 @@ static bool is_sibling_call(struct instruction *insn)
 
 	/* An indirect jump is either a sibling call or a jump to a table. */
 	if (insn->type == INSN_JUMP_DYNAMIC)
-		return list_empty(&insn->alts);
+		return !is_jump_table_jump(insn);
 
 	/* add_jump_destinations() sets insn->call_dest for sibling calls. */
 	return (is_static_jump(insn) && insn->call_dest);
