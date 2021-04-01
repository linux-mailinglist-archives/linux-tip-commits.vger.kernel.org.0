Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEB93518B8
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Apr 2021 19:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbhDARrU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 1 Apr 2021 13:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbhDARoZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 1 Apr 2021 13:44:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC86FC00F7E3;
        Thu,  1 Apr 2021 08:09:00 -0700 (PDT)
Date:   Thu, 01 Apr 2021 15:08:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617289738;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4kgCcLri86FhOF+2Y2TFFFyOIxk3MfNp8ZWrrRHBOvU=;
        b=dJUnRosGMaHDoe9VnF+moAkfmHj/XyogWIyWuxMOoocGnT2qnEmVGForJe+47nGsayxQqr
        RDxA7EDI3nTp+En+lEti6z5cZlQ1JYGbB0UlsyxH8mEEuiYoTFp07NaUEwrjAnPez7sm0t
        lmrhuq8OTwdny5WgTXyw/vg6eCIbfVC7Pi5FCkZ0vDMPHKudVQeL35OvApIxhXbMxLRXM9
        lXpu4tY89EmAlLnyN9avOrR+zlCJ9PEWpZzae8YoiXJhMuwZyB043xrsuIoAf5j0ph8NvN
        h0nulKbwwvwyOb/SSwseJBG4gegqb9WtO8V90Tqsi8fN+JP5MsXwaSh2IjqM4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617289738;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4kgCcLri86FhOF+2Y2TFFFyOIxk3MfNp8ZWrrRHBOvU=;
        b=/Oqm0HhbN1Wiygq3pr2itAyMbFe/J/Mbm+Ln+Ahlb5RiuNutHw2JuTIQHSIY04pNRlG66K
        sjldbv/XA/awA0Bg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Correctly handle retpoline thunk calls
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Miroslav Benes <mbenes@suse.cz>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210326151259.567568238@infradead.org>
References: <20210326151259.567568238@infradead.org>
MIME-Version: 1.0
Message-ID: <161728973821.29796.14241839144918537341.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     db9d1dd670d7f3f146c654f289f20968af6a12de
Gitweb:        https://git.kernel.org/tip/db9d1dd670d7f3f146c654f289f20968af6a12de
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Mar 2021 16:12:03 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 01 Apr 2021 11:34:01 +02:00

objtool: Correctly handle retpoline thunk calls

Just like JMP handling, convert a direct CALL to a retpoline thunk
into a retpoline safe indirect CALL.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/20210326151259.567568238@infradead.org
---
 tools/objtool/check.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d45f018..519af4b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1025,6 +1025,18 @@ static int add_call_destinations(struct objtool_file *file)
 					  dest_off);
 				return -1;
 			}
+
+		} else if (!strncmp(reloc->sym->name, "__x86_indirect_thunk_", 21)) {
+			/*
+			 * Retpoline calls are really dynamic calls in
+			 * disguise, so convert them accordingly.
+			 */
+			insn->type = INSN_CALL_DYNAMIC;
+			insn->retpoline_safe = true;
+
+			remove_insn_ops(insn);
+			continue;
+
 		} else
 			insn->call_dest = reloc->sym;
 
