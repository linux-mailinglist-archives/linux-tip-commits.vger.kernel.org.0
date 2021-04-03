Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BA435339A
	for <lists+linux-tip-commits@lfdr.de>; Sat,  3 Apr 2021 13:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbhDCLLI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 3 Apr 2021 07:11:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42364 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236652AbhDCLLD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 3 Apr 2021 07:11:03 -0400
Date:   Sat, 03 Apr 2021 11:10:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617448259;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LqETLAFmFWvR40o+Ds5JrMR7cgx/7wTer8jJtz0nBpo=;
        b=UngKXdnizdSsJ4SfkKX85zZQ6gTPJu+OrUlZPUUVwf/A7Kp5S5HHbM1ZFk0S1Vr2VWdj2L
        0liqcxtorBEmy1R8lTnNyjyFm+0n+B0+bbdXoA/pPjl9AVLm7iCCBLi/clqEcEZlkmfrHI
        nvwtBoPc6k+3hcPo5KZMybpvGZElRvJyouETEpdds/09lugh/hhr2pf8EoVt6VP7wd5xOa
        Y6dG11b+NG3XWKNiIZt8jbQqmeB3SHvYxaIHKLS4gtF0J6ydpVICC5wrKhq8+G0HNC41zd
        KNz0FdqyoRsFjdVrf6Fzvc60nTcbTM1KDBVMNeqE6b8A1965CqGP4x+QV0EXfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617448259;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LqETLAFmFWvR40o+Ds5JrMR7cgx/7wTer8jJtz0nBpo=;
        b=o2idPfNR2DOnb0/0Crk1s5yUp20DslSYejyXu9ffZ8eWNHsmybeH/Q61CjOFDyy3bqwk8v
        dldVhtPbcKSt3XDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Correctly handle retpoline thunk calls
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326151259.567568238@infradead.org>
References: <20210326151259.567568238@infradead.org>
MIME-Version: 1.0
Message-ID: <161744825935.29796.15831819438789568534.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     bcb1b6ff39da7e8a6a986eb08126fba2b5e13c32
Gitweb:        https://git.kernel.org/tip/bcb1b6ff39da7e8a6a986eb08126fba2b5e13c32
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Mar 2021 16:12:03 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 Apr 2021 12:42:54 +02:00

objtool: Correctly handle retpoline thunk calls

Just like JMP handling, convert a direct CALL to a retpoline thunk
into a retpoline safe indirect CALL.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
 
