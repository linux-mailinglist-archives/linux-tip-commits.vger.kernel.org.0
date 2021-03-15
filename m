Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B452933C05A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Mar 2021 16:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhCOPsT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Mar 2021 11:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbhCOPrz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Mar 2021 11:47:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812E0C06175F;
        Mon, 15 Mar 2021 08:47:50 -0700 (PDT)
Date:   Mon, 15 Mar 2021 15:47:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615823264;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nnoNSIniyqNZsV5sM1JWvnOBNGc0hfSeKOURPnMeMGY=;
        b=RNHUoq3MnSho3LyQtW7fJVom/F0sJyRm9ZZhtfOCFRARQ2/ROGyjxp2kBvdxbD/ZOtYLlf
        ne6Bs+8ky+zGaWk4Fkh/2D9Wbt/AzpXA79Ffq/1wHBGQ014Jd1wucjC7kyG7lhtZx4U0g8
        MgT72m78syhwgTxtbHIdYXtn3qsMlDomYpT1efeUqYRn2LIdqupr+VrNCQBAy4rlnY8nAY
        Z+w/ocU8JBdEv8fJCtuLOuDx6znytK7TA8DfMYss/ekFW1RvxtzfHceEk2wqYHyK9tkmfT
        rnGB0fGPCuKkUEDiu04Hi1DHOIr6kgwtUJCsxMHiuXRMVWi2fVcTWxzSw1OV0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615823264;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nnoNSIniyqNZsV5sM1JWvnOBNGc0hfSeKOURPnMeMGY=;
        b=YUH5t5VKZzDc1NQqcXurW0CwKRZpOo71Yzg0I9kMYvlgZkXQCZGG5jL3H1JNTdN4F9DO2x
        40q6cZQy+LRw0xDQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/insn: Make insn_complete() static
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210304174237.31945-22-bp@alien8.de>
References: <20210304174237.31945-22-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161582326380.398.6522700070343190068.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     f935178b5c1c32ff803b15892a8ba85a1280cb01
Gitweb:        https://git.kernel.org/tip/f935178b5c1c32ff803b15892a8ba85a1280cb01
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 23 Nov 2020 23:19:03 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Mar 2021 13:03:46 +01:00

x86/insn: Make insn_complete() static

... and move it above the only place it is used.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210304174237.31945-22-bp@alien8.de
---
 arch/x86/include/asm/insn.h       | 7 -------
 arch/x86/lib/insn.c               | 7 +++++++
 tools/arch/x86/include/asm/insn.h | 7 -------
 tools/arch/x86/lib/insn.c         | 7 +++++++
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index 5eb3753..f03b6ca 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -178,13 +178,6 @@ static inline int insn_has_emulate_prefix(struct insn *insn)
 	return !!insn->emulate_prefix_size;
 }
 
-/* Ensure this instruction is decoded completely */
-static inline int insn_complete(struct insn *insn)
-{
-	return insn->opcode.got && insn->modrm.got && insn->sib.got &&
-		insn->displacement.got && insn->immediate.got;
-}
-
 static inline insn_byte_t insn_vex_m_bits(struct insn *insn)
 {
 	if (insn->vex_prefix.nbytes == 2)	/* 2 bytes VEX */
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index bb58004..058f19b 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -714,6 +714,13 @@ int insn_get_length(struct insn *insn)
 	return 0;
 }
 
+/* Ensure this instruction is decoded completely */
+static inline int insn_complete(struct insn *insn)
+{
+	return insn->opcode.got && insn->modrm.got && insn->sib.got &&
+		insn->displacement.got && insn->immediate.got;
+}
+
 /**
  * insn_decode() - Decode an x86 instruction
  * @insn:	&struct insn to be initialized
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index 5aae785..c9f3eee 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -178,13 +178,6 @@ static inline int insn_has_emulate_prefix(struct insn *insn)
 	return !!insn->emulate_prefix_size;
 }
 
-/* Ensure this instruction is decoded completely */
-static inline int insn_complete(struct insn *insn)
-{
-	return insn->opcode.got && insn->modrm.got && insn->sib.got &&
-		insn->displacement.got && insn->immediate.got;
-}
-
 static inline insn_byte_t insn_vex_m_bits(struct insn *insn)
 {
 	if (insn->vex_prefix.nbytes == 2)	/* 2 bytes VEX */
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index be2b057..cd4dedd 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -714,6 +714,13 @@ int insn_get_length(struct insn *insn)
 	return 0;
 }
 
+/* Ensure this instruction is decoded completely */
+static inline int insn_complete(struct insn *insn)
+{
+	return insn->opcode.got && insn->modrm.got && insn->sib.got &&
+		insn->displacement.got && insn->immediate.got;
+}
+
 /**
  * insn_decode() - Decode an x86 instruction
  * @insn:	&struct insn to be initialized
