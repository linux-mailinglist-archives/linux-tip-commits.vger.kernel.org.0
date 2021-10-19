Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F2443372D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Oct 2021 15:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbhJSNil (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 19 Oct 2021 09:38:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45840 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbhJSNik (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 19 Oct 2021 09:38:40 -0400
Date:   Tue, 19 Oct 2021 13:36:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634650585;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ddMplWsx5Jnv3cNbAH/TPxYeco5WlIjAVBoZfAiLe7s=;
        b=DMk3Nz83OnUtWembeKAdGitVg478FyURRez2Kpku0ODa9dtLP+/Isi9/LeHw6LHbrIZwb5
        5UYdEYxMa8Rxid/Zr0FM4TmJiTcKFNKJ+wG1jrbsR2c5XRICFOw9nF7kMaXeUggeu2KYo6
        knnNE48k+VsnGrbJq+T2cG0Kn96wA1CZtaX7nSzG3qulu0wIif/hU9BdeiffC+mKEerzY5
        HVCURmU0aD8+U/I61e42qN4fKchnOK4QfebRjet1Xy5mv3ED6yB4WJzWDK9HdZmhEBChMT
        N8Ik050bHmrOph3C65EUeSo7oNKCe0429QLmK5jlTn/eB3nhAHHW2VEOqBvbMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634650585;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ddMplWsx5Jnv3cNbAH/TPxYeco5WlIjAVBoZfAiLe7s=;
        b=SUXncjcu03fipAPS/n+zK+qz4tZOvOA+4oPKuG4/cM5FCQQ/4/Y/ZGfxw2clLI+5yDd91p
        cdAmvrlfSdlCRwCQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Carve out HV call's return value verification
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YVbYWz%2B8J7iMTJjc@zn.tnic>
References: <YVbYWz%2B8J7iMTJjc@zn.tnic>
MIME-Version: 1.0
Message-ID: <163465058466.25758.6018389976856003730.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     c688bd5dc94ee2677f820e4a566fbe98018847ff
Gitweb:        https://git.kernel.org/tip/c688bd5dc94ee2677f820e4a566fbe98018847ff
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Fri, 01 Oct 2021 11:41:05 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 19 Oct 2021 13:54:47 +02:00

x86/sev: Carve out HV call's return value verification

Carve out the verification of the HV call return value into a separate
helper and make it more readable.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/YVbYWz%2B8J7iMTJjc@zn.tnic
---
 arch/x86/kernel/sev-shared.c | 53 +++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index bf1033a..4579c38 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -94,25 +94,15 @@ static void vc_finish_insn(struct es_em_ctxt *ctxt)
 	ctxt->regs->ip += ctxt->insn.length;
 }
 
-static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
-					  struct es_em_ctxt *ctxt,
-					  u64 exit_code, u64 exit_info_1,
-					  u64 exit_info_2)
+static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 {
-	enum es_result ret;
+	u32 ret;
 
-	/* Fill in protocol and format specifiers */
-	ghcb->protocol_version = GHCB_PROTOCOL_MAX;
-	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
+	ret = ghcb->save.sw_exit_info_1 & GENMASK_ULL(31, 0);
+	if (!ret)
+		return ES_OK;
 
-	ghcb_set_sw_exit_code(ghcb, exit_code);
-	ghcb_set_sw_exit_info_1(ghcb, exit_info_1);
-	ghcb_set_sw_exit_info_2(ghcb, exit_info_2);
-
-	sev_es_wr_ghcb_msr(__pa(ghcb));
-	VMGEXIT();
-
-	if ((ghcb->save.sw_exit_info_1 & 0xffffffff) == 1) {
+	if (ret == 1) {
 		u64 info = ghcb->save.sw_exit_info_2;
 		unsigned long v;
 
@@ -124,19 +114,34 @@ static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
 		    ((v == X86_TRAP_GP) || (v == X86_TRAP_UD)) &&
 		    ((info & SVM_EVTINJ_TYPE_MASK) == SVM_EVTINJ_TYPE_EXEPT)) {
 			ctxt->fi.vector = v;
+
 			if (info & SVM_EVTINJ_VALID_ERR)
 				ctxt->fi.error_code = info >> 32;
-			ret = ES_EXCEPTION;
-		} else {
-			ret = ES_VMM_ERROR;
+
+			return ES_EXCEPTION;
 		}
-	} else if (ghcb->save.sw_exit_info_1 & 0xffffffff) {
-		ret = ES_VMM_ERROR;
-	} else {
-		ret = ES_OK;
 	}
 
-	return ret;
+	return ES_VMM_ERROR;
+}
+
+static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
+					  struct es_em_ctxt *ctxt,
+					  u64 exit_code, u64 exit_info_1,
+					  u64 exit_info_2)
+{
+	/* Fill in protocol and format specifiers */
+	ghcb->protocol_version = GHCB_PROTOCOL_MAX;
+	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
+
+	ghcb_set_sw_exit_code(ghcb, exit_code);
+	ghcb_set_sw_exit_info_1(ghcb, exit_info_1);
+	ghcb_set_sw_exit_info_2(ghcb, exit_info_2);
+
+	sev_es_wr_ghcb_msr(__pa(ghcb));
+	VMGEXIT();
+
+	return verify_exception_info(ghcb, ctxt);
 }
 
 /*
