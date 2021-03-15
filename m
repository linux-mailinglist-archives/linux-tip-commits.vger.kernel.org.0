Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED9933C060
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Mar 2021 16:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbhCOPs0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Mar 2021 11:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbhCOPsB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Mar 2021 11:48:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13527C0613D9;
        Mon, 15 Mar 2021 08:47:52 -0700 (PDT)
Date:   Mon, 15 Mar 2021 15:47:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615823267;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i8CW/eaeh9X8zI5tZAZ5BXXY7XmfswsTPqJk8k9FeUo=;
        b=NHtqV2gtpT3e29KyOnm+yzk4RLFjbTgWPaI6/D+msJFwGO+Hrc22tAuD3f+dI7i85+HFTx
        SK7EuIC08Fz2H/zSuttsx1MkDYyFVtmSEVJoZNYlAluK3NzqClI1CFxkXhosTSZDZH+Bk5
        glDEeISQO772LkpkkQXLDymfSOLEdj8Lr9n60aBAjs8PVprrWdgFEj01+GP2SbjT9rTXJz
        229JFXT+uC/o3cP8p95cGAEVDRXrkTF4sIcwE8QttNwM1kpM+EkYWPuz3pzRxucd8R2gGt
        oqrrxavUoHKSYHe2fI9WKghnAh4EzwHLxmLbzv+G3vmbqvVVflp1ugdxUkx/7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615823267;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i8CW/eaeh9X8zI5tZAZ5BXXY7XmfswsTPqJk8k9FeUo=;
        b=Zw/MIlf/l6cgZLSsWhHM/H2VicyMNLPfzwkNDKg5Xl8DERdFmMlZdj+RY8q9t5XzVO71q7
        l1pPeVxoJvnl0xBw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/sev-es: Split vc_decode_insn()
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210304174237.31945-13-bp@alien8.de>
References: <20210304174237.31945-13-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161582326678.398.15597396870157940621.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     99e4b0de4d663e247f068bb5e014593b624a4ef0
Gitweb:        https://git.kernel.org/tip/99e4b0de4d663e247f068bb5e014593b624a4ef0
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Tue, 23 Feb 2021 11:28:02 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Mar 2021 11:40:05 +01:00

x86/sev-es: Split vc_decode_insn()

Split it into two helpers - a user- and a kernel-mode one for
readability. Yes, the original function body is not that convoluted but
splitting it makes following through that code trivial than having to
pay attention to each little difference when in user or in kernel mode.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210304174237.31945-13-bp@alien8.de
---
 arch/x86/kernel/sev-es.c | 59 +++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index a28922f..043dc2f 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -251,41 +251,58 @@ static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
 	return copy_from_kernel_nofault(buffer, (unsigned char *)ctxt->regs->ip, MAX_INSN_SIZE);
 }
 
-static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
+static enum es_result __vc_decode_user_insn(struct es_em_ctxt *ctxt)
 {
 	char buffer[MAX_INSN_SIZE];
 	enum es_result ret;
 	int res;
 
-	if (user_mode(ctxt->regs)) {
-		res = insn_fetch_from_user_inatomic(ctxt->regs, buffer);
-		if (!res) {
-			ctxt->fi.vector     = X86_TRAP_PF;
-			ctxt->fi.error_code = X86_PF_INSTR | X86_PF_USER;
-			ctxt->fi.cr2        = ctxt->regs->ip;
-			return ES_EXCEPTION;
-		}
+	res = insn_fetch_from_user_inatomic(ctxt->regs, buffer);
+	if (!res) {
+		ctxt->fi.vector     = X86_TRAP_PF;
+		ctxt->fi.error_code = X86_PF_INSTR | X86_PF_USER;
+		ctxt->fi.cr2        = ctxt->regs->ip;
+		return ES_EXCEPTION;
+	}
 
-		if (!insn_decode_from_regs(&ctxt->insn, ctxt->regs, buffer, res))
-			return ES_DECODE_FAILED;
-	} else {
-		res = vc_fetch_insn_kernel(ctxt, buffer);
-		if (res) {
-			ctxt->fi.vector     = X86_TRAP_PF;
-			ctxt->fi.error_code = X86_PF_INSTR;
-			ctxt->fi.cr2        = ctxt->regs->ip;
-			return ES_EXCEPTION;
-		}
+	if (!insn_decode_from_regs(&ctxt->insn, ctxt->regs, buffer, res))
+		return ES_DECODE_FAILED;
+
+	ret = ctxt->insn.immediate.got ? ES_OK : ES_DECODE_FAILED;
+
+	return ret;
+}
 
-		insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE, 1);
-		insn_get_length(&ctxt->insn);
+static enum es_result __vc_decode_kern_insn(struct es_em_ctxt *ctxt)
+{
+	char buffer[MAX_INSN_SIZE];
+	enum es_result ret;
+	int res;
+
+	res = vc_fetch_insn_kernel(ctxt, buffer);
+	if (res) {
+		ctxt->fi.vector     = X86_TRAP_PF;
+		ctxt->fi.error_code = X86_PF_INSTR;
+		ctxt->fi.cr2        = ctxt->regs->ip;
+		return ES_EXCEPTION;
 	}
 
+	insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE, 1);
+	insn_get_length(&ctxt->insn);
+
 	ret = ctxt->insn.immediate.got ? ES_OK : ES_DECODE_FAILED;
 
 	return ret;
 }
 
+static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
+{
+	if (user_mode(ctxt->regs))
+		return __vc_decode_user_insn(ctxt);
+	else
+		return __vc_decode_kern_insn(ctxt);
+}
+
 static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
 				   char *dst, char *buf, size_t size)
 {
