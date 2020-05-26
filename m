Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7FE1B5025
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Apr 2020 00:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgDVWYt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 22 Apr 2020 18:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgDVWYs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 22 Apr 2020 18:24:48 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A20C03C1AB;
        Wed, 22 Apr 2020 15:24:48 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRNnF-0001L7-Lg; Thu, 23 Apr 2020 00:24:34 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DAC941C04D1;
        Thu, 23 Apr 2020 00:24:31 +0200 (CEST)
Date:   Wed, 22 Apr 2020 22:24:31 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Use sec_offset_hash() for insn_hash
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200416115119.227240432@infradead.org>
References: <20200416115119.227240432@infradead.org>
MIME-Version: 1.0
Message-ID: <158759427148.28353.5265734487162014139.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     e499ccee47c429be75dee8a94d8f289aa133e3a0
Gitweb:        https://git.kernel.org/tip/e499ccee47c429be75dee8a94d8f289aa133e3a0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 16 Mar 2020 15:47:27 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Apr 2020 23:10:07 +02:00

objtool: Use sec_offset_hash() for insn_hash

In preparation for find_insn_containing(), change insn_hash to use
sec_offset_hash().

This actually reduces runtime; probably because mixing in the section
index reduces the collisions due to text sections all starting their
instructions at offset 0.

Runtime on vmlinux.o from 3.1 to 2.5 seconds.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200416115119.227240432@infradead.org
---
 tools/objtool/check.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 39d1d4f..584f221 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -34,9 +34,10 @@ struct instruction *find_insn(struct objtool_file *file,
 {
 	struct instruction *insn;
 
-	hash_for_each_possible(file->insn_hash, insn, hash, offset)
+	hash_for_each_possible(file->insn_hash, insn, hash, sec_offset_hash(sec, offset)) {
 		if (insn->sec == sec && insn->offset == offset)
 			return insn;
+	}
 
 	return NULL;
 }
@@ -282,7 +283,7 @@ static int decode_instructions(struct objtool_file *file)
 			if (ret)
 				goto err;
 
-			hash_add(file->insn_hash, &insn->hash, insn->offset);
+			hash_add(file->insn_hash, &insn->hash, sec_offset_hash(sec, insn->offset));
 			list_add_tail(&insn->list, &file->insn_list);
 			nr_insns++;
 		}
