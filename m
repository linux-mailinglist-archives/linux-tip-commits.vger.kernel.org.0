Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADD2353397
	for <lists+linux-tip-commits@lfdr.de>; Sat,  3 Apr 2021 13:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236709AbhDCLLH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 3 Apr 2021 07:11:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42400 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236641AbhDCLLC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 3 Apr 2021 07:11:02 -0400
Date:   Sat, 03 Apr 2021 11:10:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617448259;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oxFAtnvBCiM/mFIqepK0Yk08TE8AoPIGn7hmT57VEP4=;
        b=qqqfMTm4bWDNQhYFpk3xDdWoxMKRLWve+3RpLgd8XKPqAehFenecQYo2DWn5V0Sy57CMPZ
        CtR8M5sSPW3BJbht8+zJR68DU5vKQQsxw2d4GZc0hVWNNDhyqvVpEZM5auWDFCZ8cj3c5s
        49Zpa+QunfRdyqAYgjk9+mChnsnOnDSgCU32yBe293OiLEE+p4IaUBknnyfo/PwTUCBuQm
        3Lg3/kg3n+Ivk+bwQTfqrKfucTHo64Ib8cRmcMQDufemRcKnvg3NMdyPSzzL8Mn1G0ffht
        Yc1+EHfEcUpvIFLcluYyp9XbLBuTVjnKSXLRkw+4gnhgAjAsUp6K+Q+vv3Hvug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617448259;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oxFAtnvBCiM/mFIqepK0Yk08TE8AoPIGn7hmT57VEP4=;
        b=B0fi2Lx1Te0rrkamvuVTZ3/c5FEAl9QO/miJmXXkQ6yUrYV0QftSuvvg2fNGaP9wDTDDkk
        NuD0HkP5LZfZvUDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Fix static_call list generation
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326151259.691529901@infradead.org>
References: <20210326151259.691529901@infradead.org>
MIME-Version: 1.0
Message-ID: <161744825864.29796.8660314891007052369.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     a958c4fea768d2c378c89032ab41d38da2a24422
Gitweb:        https://git.kernel.org/tip/a958c4fea768d2c378c89032ab41d38da2a24422
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Mar 2021 16:12:05 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 Apr 2021 12:43:19 +02:00

objtool: Fix static_call list generation

Currently, objtool generates tail call entries in add_jump_destination()
but waits until validate_branch() to generate the regular call entries.
Move these to add_call_destination() for consistency.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/20210326151259.691529901@infradead.org
---
 tools/objtool/check.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6fbc001..8618d03 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1045,6 +1045,11 @@ static int add_call_destinations(struct objtool_file *file)
 		} else
 			insn->call_dest = reloc->sym;
 
+		if (insn->call_dest && insn->call_dest->static_call_tramp) {
+			list_add_tail(&insn->static_call_node,
+				      &file->static_call_list);
+		}
+
 		/*
 		 * Many compilers cannot disable KCOV with a function attribute
 		 * so they need a little help, NOP out any KCOV calls from noinstr
@@ -1788,6 +1793,9 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	/*
+	 * Must be before add_{jump_call}_destination.
+	 */
 	ret = read_static_call_tramps(file);
 	if (ret)
 		return ret;
@@ -1800,6 +1808,10 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	/*
+	 * Must be before add_call_destination(); it changes INSN_CALL to
+	 * INSN_JUMP.
+	 */
 	ret = read_intra_function_calls(file);
 	if (ret)
 		return ret;
@@ -2762,11 +2774,6 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			if (dead_end_function(file, insn->call_dest))
 				return 0;
 
-			if (insn->type == INSN_CALL && insn->call_dest->static_call_tramp) {
-				list_add_tail(&insn->static_call_node,
-					      &file->static_call_list);
-			}
-
 			break;
 
 		case INSN_JUMP_CONDITIONAL:
