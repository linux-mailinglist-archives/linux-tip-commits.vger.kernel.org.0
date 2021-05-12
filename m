Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E901D37BDFA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 15:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhELNU7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 09:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhELNU6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 09:20:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C823C061574;
        Wed, 12 May 2021 06:19:50 -0700 (PDT)
Date:   Wed, 12 May 2021 13:19:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620825588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9gU+RP/lnQppvNCgK8p0xEMHn8SaE0tuCjrsNkvAogg=;
        b=zm3J0jxe9dkr5Ac2SjCbDZTjsE29akU+IxZuisU/4WBX1ugqoAg80bdZdWiC8mAglywYZ0
        qrlPi48eLHGdGjPkAW3Eq5pUYWf1vHiHbzgGf9+NXseax1JjWlr8XmAdFWUhzqpCoFEG94
        aOxmK5euQV1UhgJdxqIoB9iMZAoNvESrmFQ29lAfOrrdowWTPFbtqcSsOxciw7kx63lNhZ
        sY+YSeACz+rhrilFelx/wVrD57hobYBZML1C2bc/HnTLFnlln8AJzT1qgj7mwqUAnYWQ6t
        Dj8bqDmywEucM/b5NXYqV4zHyti+9KozQpKtOiWcz7vP8Qzg7L3ueT0WvcpUAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620825588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9gU+RP/lnQppvNCgK8p0xEMHn8SaE0tuCjrsNkvAogg=;
        b=IZ1ou4xj/6FFLvyxEjV8di/djwtIOHKeq/yAfF9PC6EhdP+DFvHicPh8Y8D4ymxzSH3rDM
        gfZiWn6IvumCNTCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Provide stats for jump_labels
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210506194158.153101906@infradead.org>
References: <20210506194158.153101906@infradead.org>
MIME-Version: 1.0
Message-ID: <162082558766.29796.6186809502677667620.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     e2d9494beff21a26438eb611c260b8a6c2dc4dbf
Gitweb:        https://git.kernel.org/tip/e2d9494beff21a26438eb611c260b8a6c2dc4dbf
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 06 May 2021 21:34:04 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 14:54:56 +02:00

objtool: Provide stats for jump_labels

Add objtool --stats to count the jump_label sites it encounters.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210506194158.153101906@infradead.org
---
 tools/objtool/check.c                   | 22 ++++++++++++++++++++--
 tools/objtool/include/objtool/objtool.h |  3 +++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 98cf87f..2c6a93e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1225,8 +1225,15 @@ static int handle_jump_alt(struct objtool_file *file,
 			   struct instruction *orig_insn,
 			   struct instruction **new_insn)
 {
-	if (orig_insn->type == INSN_NOP)
+	if (orig_insn->type == INSN_NOP) {
+do_nop:
+		if (orig_insn->len == 2)
+			file->jl_nop_short++;
+		else
+			file->jl_nop_long++;
+
 		return 0;
+	}
 
 	if (orig_insn->type != INSN_JUMP_UNCONDITIONAL) {
 		WARN_FUNC("unsupported instruction at jump label",
@@ -1245,9 +1252,14 @@ static int handle_jump_alt(struct objtool_file *file,
 			       orig_insn->offset, orig_insn->len,
 			       arch_nop_insn(orig_insn->len));
 		orig_insn->type = INSN_NOP;
-		return 0;
+		goto do_nop;
 	}
 
+	if (orig_insn->len == 2)
+		file->jl_short++;
+	else
+		file->jl_long++;
+
 	*new_insn = list_next_entry(orig_insn, list);
 	return 0;
 }
@@ -1328,6 +1340,12 @@ static int add_special_section_alts(struct objtool_file *file)
 		free(special_alt);
 	}
 
+	if (stats) {
+		printf("jl\\\tNOP\tJMP\n");
+		printf("short:\t%ld\t%ld\n", file->jl_nop_short, file->jl_short);
+		printf("long:\t%ld\t%ld\n", file->jl_nop_long, file->jl_long);
+	}
+
 out:
 	return ret;
 }
diff --git a/tools/objtool/include/objtool/objtool.h b/tools/objtool/include/objtool/objtool.h
index e4084af..24fa836 100644
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -22,6 +22,9 @@ struct objtool_file {
 	struct list_head static_call_list;
 	struct list_head mcount_loc_list;
 	bool ignore_unreachables, c_file, hints, rodata;
+
+	unsigned long jl_short, jl_long;
+	unsigned long jl_nop_short, jl_nop_long;
 };
 
 struct objtool_file *objtool_open_read(const char *_objname);
