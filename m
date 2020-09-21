Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DB6272EB1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 21 Sep 2020 18:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgIUQv3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 21 Sep 2020 12:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbgIUQvP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 21 Sep 2020 12:51:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E447BC061755;
        Mon, 21 Sep 2020 09:51:14 -0700 (PDT)
Date:   Mon, 21 Sep 2020 16:51:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600707072;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=C2GlnFeJ0LiK1ia1kxKqqVxYfsx8c/lMY9sFrRjq6lA=;
        b=gjMKwrnLuJGqxhMjgXXZhIB7rwB1nFhPVgU2wRcZYGEpEjIE7KjGfH9VOErMGhlXFV6S6o
        9VW6t+5Smmrz4GSzd/BSYGgMjV+vIT7bqWJluprW9cqBQAXEcbN3/pMUKfzP2Iy2kG9GNr
        b8EOIVisHHxvmK623oED5ZN5tQtXd39aAlkeTMCtZbhUiwBY9pTYX61ogD87gt/No4KZcK
        Wdr0IgXj7jxv6yaAN4151XFPLZ+ZM6JFo2IfUFUZhT2Yt0PTebSJgxHFkN2t/F8+65feJc
        oKznRFtsXm57GUOsePbHlXS1UfNcrfuKAp5koLqE6CfhJGTPtk/A6vBCV0RpcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600707072;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=C2GlnFeJ0LiK1ia1kxKqqVxYfsx8c/lMY9sFrRjq6lA=;
        b=QpNpPNi5r5HDn/7QTXdSTrgvdw6pfmMotGIBzkukR6N6pXYtG5szd3Fdz8spXfSBaoEPY/
        cSBzFm0lt+y2P5Cw==
From:   "tip-bot2 for Julien Thierry" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Handle calling non-function symbols in
 other sections
Cc:     Julien Thierry <jthierry@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160070707185.15536.1912560199478281609.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     2b232a22d8225df419a92ca69ddeeb4e5fe902f7
Gitweb:        https://git.kernel.org/tip/2b232a22d8225df419a92ca69ddeeb4e5fe902f7
Author:        Julien Thierry <jthierry@redhat.com>
AuthorDate:    Tue, 15 Sep 2020 08:53:18 +01:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Mon, 21 Sep 2020 10:17:36 -05:00

objtool: Handle calling non-function symbols in other sections

Relocation for a call destination could point to a symbol that has
type STT_NOTYPE.

Lookup such a symbol when no function is available.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index cd7c669..a4796e3 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -815,6 +815,17 @@ static void remove_insn_ops(struct instruction *insn)
 	}
 }
 
+static struct symbol *find_call_destination(struct section *sec, unsigned long offset)
+{
+	struct symbol *call_dest;
+
+	call_dest = find_func_by_offset(sec, offset);
+	if (!call_dest)
+		call_dest = find_symbol_by_offset(sec, offset);
+
+	return call_dest;
+}
+
 /*
  * Find the destination instructions for all calls.
  */
@@ -832,9 +843,7 @@ static int add_call_destinations(struct objtool_file *file)
 					       insn->offset, insn->len);
 		if (!reloc) {
 			dest_off = arch_jump_destination(insn);
-			insn->call_dest = find_func_by_offset(insn->sec, dest_off);
-			if (!insn->call_dest)
-				insn->call_dest = find_symbol_by_offset(insn->sec, dest_off);
+			insn->call_dest = find_call_destination(insn->sec, dest_off);
 
 			if (insn->ignore)
 				continue;
@@ -852,8 +861,8 @@ static int add_call_destinations(struct objtool_file *file)
 
 		} else if (reloc->sym->type == STT_SECTION) {
 			dest_off = arch_dest_reloc_offset(reloc->addend);
-			insn->call_dest = find_func_by_offset(reloc->sym->sec,
-							      dest_off);
+			insn->call_dest = find_call_destination(reloc->sym->sec,
+								dest_off);
 			if (!insn->call_dest) {
 				WARN_FUNC("can't find call dest symbol at %s+0x%lx",
 					  insn->sec, insn->offset,
