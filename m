Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378AC351D28
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Apr 2021 20:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbhDAS1T (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 1 Apr 2021 14:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbhDASVG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 1 Apr 2021 14:21:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD9CC00F7E0;
        Thu,  1 Apr 2021 08:09:00 -0700 (PDT)
Date:   Thu, 01 Apr 2021 15:08:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617289738;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QOevEyW1EXdcT3e3X1S7oHVITdqRVDZCgtzrQZ4YR+M=;
        b=BVHxFGBTqqpdqzVHhyVEe/w+f+XCDcSIOCXY4W8o/Osl2JSELv4d/sOGdgWNkEdRWsAOco
        zipmcJNxhYQFGzAx3iTKAyX9+M6RBBG+h6ZIEKD8rXMC6BvhA/zYtQuxs7j9yOv3Vru9ZV
        w1JybiaMKUtbGt3edSNhm7AkKD0tHWaG68tST7dumoeCGQ9fJP9egvuAdGEC4jaIssttRZ
        IQzMrGSEKc8cMZaEMGWwXIKiWtatd6DY/oSccMD7IjJXbenEc8gWAGYGxXn/tRiybzD6mp
        5I+TkuREDzjdNhBsQ2zfQuwNwz4cmI9LvhhLajxOuVvysUnFyt4jc35uMAC6BA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617289738;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QOevEyW1EXdcT3e3X1S7oHVITdqRVDZCgtzrQZ4YR+M=;
        b=lhZFyVbSk3B8Oy0RGPgXsU6whDYd50J681GBasuIR2a9K0pu1euhFJaNzz99ZHlpwejSc8
        Pc1bX9R3DxBoQ7BQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Fix static_call list generation
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Miroslav Benes <mbenes@suse.cz>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210326151259.691529901@infradead.org>
References: <20210326151259.691529901@infradead.org>
MIME-Version: 1.0
Message-ID: <161728973737.29796.8108336872337258798.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     b62b63571e4be0ce31984ce83b04853f2cba678b
Gitweb:        https://git.kernel.org/tip/b62b63571e4be0ce31984ce83b04853f2cba678b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Mar 2021 16:12:05 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 01 Apr 2021 11:43:16 +02:00

objtool: Fix static_call list generation

Currently, objtool generates tail call entries in add_jump_destination()
but waits until validate_branch() to generate the regular call entries.
Move these to add_call_destination() for consistency.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
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
