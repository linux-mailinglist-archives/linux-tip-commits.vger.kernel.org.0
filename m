Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A257533C05E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Mar 2021 16:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhCOPsV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Mar 2021 11:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbhCOPsB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Mar 2021 11:48:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923D5C0613DF;
        Mon, 15 Mar 2021 08:47:53 -0700 (PDT)
Date:   Mon, 15 Mar 2021 15:47:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615823269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Iy0EXFAOKCEIJt0bqlzzIHdW6J20TYlKyqis8i6oJw=;
        b=Mu2+CRPZL/HGJpyxDsrt7E0iw5cvjcvsLBjPWWXGACHJ1NpOX41ahEa1uoZIUVBxfjsiE0
        CbVg7ULU/itF/efVQqv1w4ptxhlr+HIe+k0eZyfz+xcCFh71ZfH2/9lk4GLNLKzQ9c20v4
        VKljEgwIIH+HP1bNe6w7XZXyDSoSPwrpC9l5d44l/YwCVZZQigqLbyffoEuOhP1hBRPrvS
        91i5LqjlLaAyMKxtd3p/wPYSu8JQnqFIPtS4Ms0Yp5ZeW5Ka9ODoE0zzZNAVYrDtlC+LdZ
        YoxhNt+YtqKvM5m0aDJbLsPXtrZc6pNmTEVfniKUjXKkAMkARui7C8pAmGxrhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615823269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Iy0EXFAOKCEIJt0bqlzzIHdW6J20TYlKyqis8i6oJw=;
        b=ojUDfgrLLh8C+XMvtHZmgRpQP7nnjJomv5lmGeZo1zdOZc6ygfYummUx047x9o9wBhmKpk
        M/dhzV2TyLJjw8AA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/insn-eval: Handle return values from the decoder
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210304174237.31945-6-bp@alien8.de>
References: <20210304174237.31945-6-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161582326863.398.12655944025614758313.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     6e8c83d2a3afbfd5ee019ec720b75a42df515caa
Gitweb:        https://git.kernel.org/tip/6e8c83d2a3afbfd5ee019ec720b75a42df515caa
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 19 Nov 2020 19:20:18 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Mar 2021 11:12:15 +01:00

x86/insn-eval: Handle return values from the decoder

Now that the different instruction-inspecting functions return a value,
test that and return early from callers if error has been encountered.

While at it, do not call insn_get_modrm() when calling
insn_get_displacement() because latter will make sure to call
insn_get_modrm() if ModRM hasn't been parsed yet.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210304174237.31945-6-bp@alien8.de
---
 arch/x86/lib/insn-eval.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 422a592..321a157 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -924,10 +924,11 @@ static int get_seg_base_limit(struct insn *insn, struct pt_regs *regs,
 static int get_eff_addr_reg(struct insn *insn, struct pt_regs *regs,
 			    int *regoff, long *eff_addr)
 {
-	insn_get_modrm(insn);
+	int ret;
 
-	if (!insn->modrm.nbytes)
-		return -EINVAL;
+	ret = insn_get_modrm(insn);
+	if (ret)
+		return ret;
 
 	if (X86_MODRM_MOD(insn->modrm.value) != 3)
 		return -EINVAL;
@@ -973,14 +974,14 @@ static int get_eff_addr_modrm(struct insn *insn, struct pt_regs *regs,
 			      int *regoff, long *eff_addr)
 {
 	long tmp;
+	int ret;
 
 	if (insn->addr_bytes != 8 && insn->addr_bytes != 4)
 		return -EINVAL;
 
-	insn_get_modrm(insn);
-
-	if (!insn->modrm.nbytes)
-		return -EINVAL;
+	ret = insn_get_modrm(insn);
+	if (ret)
+		return ret;
 
 	if (X86_MODRM_MOD(insn->modrm.value) > 2)
 		return -EINVAL;
@@ -1102,18 +1103,21 @@ static int get_eff_addr_modrm_16(struct insn *insn, struct pt_regs *regs,
  * @base_offset will have a register, as an offset from the base of pt_regs,
  * that can be used to resolve the associated segment.
  *
- * -EINVAL on error.
+ * Negative value on error.
  */
 static int get_eff_addr_sib(struct insn *insn, struct pt_regs *regs,
 			    int *base_offset, long *eff_addr)
 {
 	long base, indx;
 	int indx_offset;
+	int ret;
 
 	if (insn->addr_bytes != 8 && insn->addr_bytes != 4)
 		return -EINVAL;
 
-	insn_get_modrm(insn);
+	ret = insn_get_modrm(insn);
+	if (ret)
+		return ret;
 
 	if (!insn->modrm.nbytes)
 		return -EINVAL;
@@ -1121,7 +1125,9 @@ static int get_eff_addr_sib(struct insn *insn, struct pt_regs *regs,
 	if (X86_MODRM_MOD(insn->modrm.value) > 2)
 		return -EINVAL;
 
-	insn_get_sib(insn);
+	ret = insn_get_sib(insn);
+	if (ret)
+		return ret;
 
 	if (!insn->sib.nbytes)
 		return -EINVAL;
@@ -1190,8 +1196,8 @@ static void __user *get_addr_ref_16(struct insn *insn, struct pt_regs *regs)
 	short eff_addr;
 	long tmp;
 
-	insn_get_modrm(insn);
-	insn_get_displacement(insn);
+	if (insn_get_displacement(insn))
+		goto out;
 
 	if (insn->addr_bytes != 2)
 		goto out;
@@ -1525,7 +1531,9 @@ bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
 	insn->addr_bytes = INSN_CODE_SEG_ADDR_SZ(seg_defs);
 	insn->opnd_bytes = INSN_CODE_SEG_OPND_SZ(seg_defs);
 
-	insn_get_length(insn);
+	if (insn_get_length(insn))
+		return false;
+
 	if (buf_size < insn->length)
 		return false;
 
