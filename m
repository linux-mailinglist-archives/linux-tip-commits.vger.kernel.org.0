Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76E633C058
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Mar 2021 16:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhCOPsU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Mar 2021 11:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhCOPrz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Mar 2021 11:47:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888D1C061762;
        Mon, 15 Mar 2021 08:47:50 -0700 (PDT)
Date:   Mon, 15 Mar 2021 15:47:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615823265;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wZ8AfWzi+AYTs6e6i+IHXlh6A9LPwt/Kl5DHvBYAfD8=;
        b=wKOOxIKabOQtYrTy1YmNWbuGZgdyq+8ED6d7cF5DvK70v9W+yom+9/CA53cSscbhbz+InI
        zY8KGhaaFXzPlodPOACwd6l24JYp+Qqyczmv2ZzdeJefwDb+gXpxDLWczdYcX/OxJJN11l
        bOaHlnLuYvME47mi8S76B3W75UqrcdiXtuwdSTIPiiJA9+lTZjjIg2NdbLZM/mASihNmk2
        Qhsx8i6ssIu5UrQ+Pu63V0/x2atwQpeaKndgL4v8xy7GJubWc25vHgkTMH+675HTvfBFfx
        i5Gu11tede+czHXkr6vNicaK9bgE0t3LrccWKu/+Y6ujQghRg0ojI/7PMEPJBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615823265;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wZ8AfWzi+AYTs6e6i+IHXlh6A9LPwt/Kl5DHvBYAfD8=;
        b=bAy0mD3BGVkPcfZFSHiIYrdOCwHQJOfMgHrDgP+uaKnNGmtgYnWCga3aploaL9r+YOtODE
        X17d+YBzkWVx2fAg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] tools/objtool: Convert to insn_decode()
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210304174237.31945-18-bp@alien8.de>
References: <20210304174237.31945-18-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161582326501.398.15990602451576196663.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     c7e41b099be40112d53daccef8553e99e455e0d6
Gitweb:        https://git.kernel.org/tip/c7e41b099be40112d53daccef8553e99e455e0d6
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Fri, 20 Nov 2020 17:37:06 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Mar 2021 12:10:41 +01:00

tools/objtool: Convert to insn_decode()

Simplify code, no functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210304174237.31945-18-bp@alien8.de
---
 tools/objtool/arch/x86/decode.c |  9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 549813c..8380d0b 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -90,7 +90,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			    struct list_head *ops_list)
 {
 	struct insn insn;
-	int x86_64, sign;
+	int x86_64, sign, ret;
 	unsigned char op1, op2, rex = 0, rex_b = 0, rex_r = 0, rex_w = 0,
 		      rex_x = 0, modrm = 0, modrm_mod = 0, modrm_rm = 0,
 		      modrm_reg = 0, sib = 0;
@@ -101,10 +101,9 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 	if (x86_64 == -1)
 		return -1;
 
-	insn_init(&insn, sec->data->d_buf + offset, maxlen, x86_64);
-	insn_get_length(&insn);
-
-	if (!insn_complete(&insn)) {
+	ret = insn_decode(&insn, sec->data->d_buf + offset, maxlen,
+			  x86_64 ? INSN_MODE_64 : INSN_MODE_32);
+	if (ret < 0) {
 		WARN("can't decode instruction at %s:0x%lx", sec->name, offset);
 		return -1;
 	}
