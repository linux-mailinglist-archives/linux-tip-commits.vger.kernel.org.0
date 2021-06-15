Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB9A3A7C74
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Jun 2021 12:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhFOKyH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 15 Jun 2021 06:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbhFOKyF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 15 Jun 2021 06:54:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8ABC061574;
        Tue, 15 Jun 2021 03:52:01 -0700 (PDT)
Date:   Tue, 15 Jun 2021 10:51:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623754316;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DHegQvt3cfTnKJX3SVNaRFA4QjL5I7lSJOFQNJlyBqU=;
        b=jv35iWtIfZhIFhsfKohLOZY3Qyw8SeaWpzCRs5/O5oeL3gsAWRagkGvawaqlWceQudw37a
        O2aXQD3boVkWvLvyQV1N5Xky+6rRsfiufNYKcDEsaKdpZfU0EcPy5vfg7jfdJKeV73Meeo
        BcDRqydPR15BkgW6yulMrhIOAkATrEg+4ycezzlwGkDK7G9TWcPJZ/fkLUtxtdXsUC4rRL
        OrjTHLgWyOx/206+lfVpI1VAC+ICQSE/YJZg35uO8HQ4RMSJjE+MIfEbC49TXPgYz2vkTH
        ybvDW/QR7TMUHozb+LevZBjcBTKpN31nW11Fnr/VTmreyKZSwh4/XfArnOuXjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623754316;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DHegQvt3cfTnKJX3SVNaRFA4QjL5I7lSJOFQNJlyBqU=;
        b=qhgNffPF+w1ZYuJmaOXEa5ygkzFcTVsx0PyDg8uUnF7V/Vn9J8bcvkUFJij7aKROw1Sg9I
        t7ygeglkgBlwIVCA==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Propagate #GP if getting linear instruction
 address failed
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210614135327.9921-7-joro@8bytes.org>
References: <20210614135327.9921-7-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <162375431608.19906.8487681008973797088.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     07570cef5e5c3fcec40f82a9075abb4c1da63319
Gitweb:        https://git.kernel.org/tip/07570cef5e5c3fcec40f82a9075abb4c1da63319
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 14 Jun 2021 15:53:27 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 15 Jun 2021 11:55:26 +02:00

x86/sev: Propagate #GP if getting linear instruction address failed

When an instruction is fetched from user-space, segmentation needs to
be taken into account. This means that getting the linear address of an
instruction can fail. Hardware would raise a #GP exception in that case,
but the #VC exception handler would emulate it as a page-fault.

The insn_fetch_from_user*() functions now provide the relevant
information in case of a failure. Use that and propagate a #GP when the
linear address of an instruction to fetch could not be calculated.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210614135327.9921-7-joro@8bytes.org
---
 arch/x86/kernel/sev.c |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a1eeaa7..8178db0 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -261,11 +261,18 @@ static enum es_result __vc_decode_user_insn(struct es_em_ctxt *ctxt)
 	int insn_bytes;
 
 	insn_bytes = insn_fetch_from_user_inatomic(ctxt->regs, buffer);
-	if (insn_bytes <= 0) {
+	if (insn_bytes == 0) {
+		/* Nothing could be copied */
 		ctxt->fi.vector     = X86_TRAP_PF;
 		ctxt->fi.error_code = X86_PF_INSTR | X86_PF_USER;
 		ctxt->fi.cr2        = ctxt->regs->ip;
 		return ES_EXCEPTION;
+	} else if (insn_bytes == -EINVAL) {
+		/* Effective RIP could not be calculated */
+		ctxt->fi.vector     = X86_TRAP_GP;
+		ctxt->fi.error_code = 0;
+		ctxt->fi.cr2        = 0;
+		return ES_EXCEPTION;
 	}
 
 	if (!insn_decode_from_regs(&ctxt->insn, ctxt->regs, buffer, insn_bytes))
