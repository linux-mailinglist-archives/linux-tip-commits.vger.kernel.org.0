Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0578139A0EC
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jun 2021 14:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhFCMcp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Jun 2021 08:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhFCMcp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Jun 2021 08:32:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9D6C06175F;
        Thu,  3 Jun 2021 05:31:00 -0700 (PDT)
Date:   Thu, 03 Jun 2021 12:30:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622723456;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1BsNI20+MZK5coL/UFoj1BiGfxgXH5bhCmtTvq7Ak6s=;
        b=Qdly8bUJauaWm+CTW2JMXnQFiqp4CRh74Fa5HhTrtaNaF6xTZ4RU3n0/oopVuC+GAS11cu
        X1JJ0W3UV/Wy8oa7St0TbStE7JFlk/4/Bl7nNRhm+FeksYwXNONL9YjFOLul5vQABzJdhn
        ORnHoLRi8YyxsB2sD64n7wmvs2AAEFfVWlLOK0FRIhrm5OYM+OUkoiOcUGBi+ZTwdWIXeV
        JvJ0IuufUXoZ6o0pc0roaMF5IDuGzrOpnffTjDOEcN0yMaZGlgKtUx0//fuNABR5YPy0h2
        kWqW12zuwj8SsS8jbpvvhxdfCJqfBqbjlObPSKXv1j/0C3b657Wv+HpWPqy6lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622723456;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1BsNI20+MZK5coL/UFoj1BiGfxgXH5bhCmtTvq7Ak6s=;
        b=HZfTD96XF5j0y2AreQnrDosPa+Ce8tpAyY0N0mfK+vMJpkxXfgBtDdwyZ1O/dj5p2zn7tQ
        W8l5Rz72QUgTN8DQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/alternative: Align insn bytes vertically
Cc:     Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210601193713.16190-1-bp@alien8.de>
References: <20210601193713.16190-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <162272345374.29796.18139341467575813707.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     7ee0e638a526b2d1f09c714f86d82dfd7628f322
Gitweb:        https://git.kernel.org/tip/7ee0e638a526b2d1f09c714f86d82dfd7628f322
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Tue, 01 Jun 2021 21:30:56 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 03 Jun 2021 14:24:44 +02:00

x86/alternative: Align insn bytes vertically

For easier inspection which bytes have changed.

For example:

  feat: 7*32+12, old: (__x86_indirect_thunk_r10+0x0/0x20 (ffffffff81c02480) len: 17), repl: (ffffffff897813aa, len: 17)
  ffffffff81c02480:   old_insn: 41 ff e2 90 90 90 90 90 90 90 90 90 90 90 90 90 90
  ffffffff897813aa:   rpl_insn: e8 07 00 00 00 f3 90 0f ae e8 eb f9 4c 89 14 24 c3
  ffffffff81c02480: final_insn: e8 07 00 00 00 f3 90 0f ae e8 eb f9 4c 89 14 24 c3

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210601193713.16190-1-bp@alien8.de
---
 arch/x86/kernel/alternative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 75c752b..227c4a8 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -273,8 +273,8 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 			instr, instr, a->instrlen,
 			replacement, a->replacementlen);
 
-		DUMP_BYTES(instr, a->instrlen, "%px: old_insn: ", instr);
-		DUMP_BYTES(replacement, a->replacementlen, "%px: rpl_insn: ", replacement);
+		DUMP_BYTES(instr, a->instrlen, "%px:   old_insn: ", instr);
+		DUMP_BYTES(replacement, a->replacementlen, "%px:   rpl_insn: ", replacement);
 
 		memcpy(insn_buff, replacement, a->replacementlen);
 		insn_buff_sz = a->replacementlen;
