Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C481233C06B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Mar 2021 16:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhCOPs3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Mar 2021 11:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbhCOPsB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Mar 2021 11:48:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8BFC061765;
        Mon, 15 Mar 2021 08:47:52 -0700 (PDT)
Date:   Mon, 15 Mar 2021 15:47:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615823267;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=guzRItwyWcHRLBPtEPCja/wD92p04AFv+96ND4D15LM=;
        b=27rureEOGSL+kimwdVrS7axQeSJCOn76GoXrx3MkVYt7ub6vdLa07U0IreRKGuVO7LZK9X
        BaPFd6nDOcbBHRlQYo+XKUbRz2SRk/aHld9QcXLIwM2hR3skqLM2E+tJOBBLKkhsnEQuyB
        PKxNhL8u1/Wlk/LWkxyYNSqeG4NpRP7ZxTyHqw6l5VtVBD2Y5T2s1y+CvYIu5NJ8ZIWadM
        j2uXPKcb56QztMXGIJj+3Ay+y7owWedwbO8THr+IXbEi89K4nruzxUUPQClPH6unCRzJqQ
        DKNvtvAk7gAMnOsxZ/OCkaMtvy4h103IU97g15kZm/9nW24cD6WJGLrUzvfFDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615823267;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=guzRItwyWcHRLBPtEPCja/wD92p04AFv+96ND4D15LM=;
        b=eVUjXSInHR5lwtqfleJ8D/syGN+qHVK4OyUh2UmI4fkz6P5jUEQh+ERiQ5R5OR3xp5WbX/
        s370qxFuzP5JIvCQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/sev-es: Convert to insn_decode()
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210304174237.31945-14-bp@alien8.de>
References: <20210304174237.31945-14-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161582326641.398.12722564634275936219.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     5e32c64bb6912bdddc05216655dd37e848b717af
Gitweb:        https://git.kernel.org/tip/5e32c64bb6912bdddc05216655dd37e848b717af
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 16 Nov 2020 18:21:23 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Mar 2021 11:46:40 +01:00

x86/sev-es: Convert to insn_decode()

Simplify code, no functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210304174237.31945-14-bp@alien8.de
---
 arch/x86/kernel/sev-es.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 043dc2f..75c7df3 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -254,7 +254,6 @@ static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
 static enum es_result __vc_decode_user_insn(struct es_em_ctxt *ctxt)
 {
 	char buffer[MAX_INSN_SIZE];
-	enum es_result ret;
 	int res;
 
 	res = insn_fetch_from_user_inatomic(ctxt->regs, buffer);
@@ -268,16 +267,16 @@ static enum es_result __vc_decode_user_insn(struct es_em_ctxt *ctxt)
 	if (!insn_decode_from_regs(&ctxt->insn, ctxt->regs, buffer, res))
 		return ES_DECODE_FAILED;
 
-	ret = ctxt->insn.immediate.got ? ES_OK : ES_DECODE_FAILED;
-
-	return ret;
+	if (ctxt->insn.immediate.got)
+		return ES_OK;
+	else
+		return ES_DECODE_FAILED;
 }
 
 static enum es_result __vc_decode_kern_insn(struct es_em_ctxt *ctxt)
 {
 	char buffer[MAX_INSN_SIZE];
-	enum es_result ret;
-	int res;
+	int res, ret;
 
 	res = vc_fetch_insn_kernel(ctxt, buffer);
 	if (res) {
@@ -287,12 +286,11 @@ static enum es_result __vc_decode_kern_insn(struct es_em_ctxt *ctxt)
 		return ES_EXCEPTION;
 	}
 
-	insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE, 1);
-	insn_get_length(&ctxt->insn);
-
-	ret = ctxt->insn.immediate.got ? ES_OK : ES_DECODE_FAILED;
-
-	return ret;
+	ret = insn_decode(&ctxt->insn, buffer, MAX_INSN_SIZE, INSN_MODE_64);
+	if (ret < 0)
+		return ES_DECODE_FAILED;
+	else
+		return ES_OK;
 }
 
 static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
