Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7703170DB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 21:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhBJUCO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 15:02:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33938 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbhBJUCJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 15:02:09 -0500
Date:   Wed, 10 Feb 2021 20:01:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612987284;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YUV5iawYKwc//7V+/jWC9tsW6XF6QkHni4nokw1Bi1k=;
        b=x6hYj65uGwI/KLkL5rYthEot4A065M9nLkGAESI9pi9nfA0lURev9C7pXr2slAwAEGfGyF
        MwFgaC1r3kM2BOa8/EmAioYUlBrG3+bI0iEeEWtFpPDG0nN9Xx+yyJmAFMVkTvCOXerk12
        F8pkN86ZXFh9eAfTr5HKDl8L699+Lx7DUSRzmHzki1Mg4hCsjVU6j5la8sDNwgRlwm32yv
        uzmegiwkydoxEuaWmKbxvroePmrR6nkLBU/WR4XO90fmYSfSqrR2FTJWP+LBj4HQYXtTM7
        YUf2zPjePqGfjEvm734SRsM6lxODooJPtp24MCmX34gZiZj/v+jT4k9+x+5gkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612987284;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YUV5iawYKwc//7V+/jWC9tsW6XF6QkHni4nokw1Bi1k=;
        b=GONTXU1HOBRRiMmbKD1X76Av6KgtmNehPOfJp+62O6NHzAfXXRg44t6ejbe7UVQ96zTh0m
        y9q5tsaKbY0nrYCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/unwind/orc: Change REG_SP_INDIRECT
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161298728406.23325.17194681043408058054.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     87ccc826bf1c9e5ab4c2f649b404e02c63e47622
Gitweb:        https://git.kernel.org/tip/87ccc826bf1c9e5ab4c2f649b404e02c63e47622
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 03 Feb 2021 12:02:21 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 10 Feb 2021 20:53:51 +01:00

x86/unwind/orc: Change REG_SP_INDIRECT

Currently REG_SP_INDIRECT is unused but means (%rsp + offset),
change it to mean (%rsp) + offset.

The reason is that we're going to swizzle stack in the middle of a C
function with non-trivial stack footprint. This means that when the
unwinder finds the ToS, it needs to dereference it (%rsp) and then add
the offset to the next frame, resulting in: (%rsp) + offset

This is somewhat unfortunate, since REG_BP_INDIRECT is used (by DRAP)
and thus needs to retain the current (%rbp + offset).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/unwind_orc.c | 5 ++++-
 tools/objtool/orc_dump.c     | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 73f8001..2a1d47f 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -471,7 +471,7 @@ bool unwind_next_frame(struct unwind_state *state)
 		break;
 
 	case ORC_REG_SP_INDIRECT:
-		sp = state->sp + orc->sp_offset;
+		sp = state->sp;
 		indirect = true;
 		break;
 
@@ -521,6 +521,9 @@ bool unwind_next_frame(struct unwind_state *state)
 	if (indirect) {
 		if (!deref_stack_reg(state, sp, &sp))
 			goto err;
+
+		if (orc->sp_reg == ORC_REG_SP_INDIRECT)
+			sp += orc->sp_offset;
 	}
 
 	/* Find IP, SP and possibly regs: */
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
index c53fae9..f5a8508 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -55,7 +55,7 @@ static void print_reg(unsigned int reg, int offset)
 	if (reg == ORC_REG_BP_INDIRECT)
 		printf("(bp%+d)", offset);
 	else if (reg == ORC_REG_SP_INDIRECT)
-		printf("(sp%+d)", offset);
+		printf("(sp)%+d", offset);
 	else if (reg == ORC_REG_UNDEFINED)
 		printf("(und)");
 	else
