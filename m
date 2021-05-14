Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6EF3803E9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 May 2021 09:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhENHDB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 14 May 2021 03:03:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34744 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhENHDB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 14 May 2021 03:03:01 -0400
Date:   Fri, 14 May 2021 07:01:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620975709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dgXcNQjJ2i0lE402yPaaMpRitE68ZHLdNWvu/FwCCXw=;
        b=T4Qnheyiayq4+rQ+vZWkPp/lRE8uVZg0FUJZubCh37I4KbtsYrM6E6Rz5sqIe5fd30QOH3
        B0OtAF7j71v+dEojW6kC1IlJ/GMw2SrAvCXKqDgvp1IiB1zCLo2Vl07csIdXBCPXx4ctjS
        w5up4k2HEwrxTND8XvZ+nDX8hT9o1EYTwzbZy6q6v/y5AuDvXVj5dxP8+32ijLF+6LDImk
        bhcROQCl9ke6sRT5wcn3zrz2YyFQNbunpA10bI/K/epxYY6aYGJQ7IylCWG/xLs8AVvTST
        /k3+22EQbYeF8+SxUHYbE0AF9i5ANxCBOLDONtCxXUaJZedHoTC5lGgJGC1ZgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620975709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dgXcNQjJ2i0lE402yPaaMpRitE68ZHLdNWvu/FwCCXw=;
        b=69EkBhUSv3Np7YSAgL/LG4y0Z069mZt+egWVlru0jbFRgatkScEUCnsVTgRTV+Aglu5gib
        iIT3lNKwBk+EW6AQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Reflow handle_jump_alt()
Cc:     Miroslav Benes <mbenes@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <rL@hirez.programming.kicks-ass.net>
References: <rL@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <162097570882.29796.6187655256814953470.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     48001d26c19f02c33795829ec9fc71a0d8d42413
Gitweb:        https://git.kernel.org/tip/48001d26c19f02c33795829ec9fc71a0d8d42413
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 13 May 2021 16:15:50 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 14 May 2021 09:00:10 +02:00

objtool: Reflow handle_jump_alt()

Miroslav figured the code flow in handle_jump_alt() was sub-optimal
with that goto. Reflow the code to make it clearer.

Reported-by: Miroslav Benes <mbenes@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/YJ00lgslY+IpA/rL@hirez.programming.kicks-ass.net
---
 tools/objtool/check.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2c6a93e..e5947fb 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1225,17 +1225,9 @@ static int handle_jump_alt(struct objtool_file *file,
 			   struct instruction *orig_insn,
 			   struct instruction **new_insn)
 {
-	if (orig_insn->type == INSN_NOP) {
-do_nop:
-		if (orig_insn->len == 2)
-			file->jl_nop_short++;
-		else
-			file->jl_nop_long++;
+	if (orig_insn->type != INSN_JUMP_UNCONDITIONAL &&
+	    orig_insn->type != INSN_NOP) {
 
-		return 0;
-	}
-
-	if (orig_insn->type != INSN_JUMP_UNCONDITIONAL) {
 		WARN_FUNC("unsupported instruction at jump label",
 			  orig_insn->sec, orig_insn->offset);
 		return -1;
@@ -1252,7 +1244,15 @@ do_nop:
 			       orig_insn->offset, orig_insn->len,
 			       arch_nop_insn(orig_insn->len));
 		orig_insn->type = INSN_NOP;
-		goto do_nop;
+	}
+
+	if (orig_insn->type == INSN_NOP) {
+		if (orig_insn->len == 2)
+			file->jl_nop_short++;
+		else
+			file->jl_nop_long++;
+
+		return 0;
 	}
 
 	if (orig_insn->len == 2)
