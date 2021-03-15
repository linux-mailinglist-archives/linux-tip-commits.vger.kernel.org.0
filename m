Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3601233C055
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Mar 2021 16:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhCOPsT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Mar 2021 11:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbhCOPrz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Mar 2021 11:47:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9619EC061764;
        Mon, 15 Mar 2021 08:47:50 -0700 (PDT)
Date:   Mon, 15 Mar 2021 15:47:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615823264;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JuqiaMODEFFciZaGye9DmlBc7q+pJBxKBaIYnbaymZU=;
        b=ZuWHvNysKINlK1nzNAFS2uhsxMk1cVNFfOm5eN3j/CGbRAfAoNinGZSBsdK/JSK3wrxnUl
        2qMEpQ4RvfizHoC4VbLqvPcm9aL9f2q64gOIaoforMbGBPxQIHJXM6QyVbLMYkg12eVl88
        bj2IXnDwStg5/So+cN4y0vI5kgUIQic8Z1sFn8T0WpcN725vNe4oj/11dRzPDD7X0B6Rmx
        pg2PpP6P33dZo/dSsV6lsitTTp2B4xCAZbG5DZarugQDxIZzLbnjarOu2bxiNFiIANwoqz
        Lq8gruhoqPePpDPs4MQho9dgWbCwhSB5SfddELZ+bBcQzeTWEkCXiuwinslbsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615823264;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JuqiaMODEFFciZaGye9DmlBc7q+pJBxKBaIYnbaymZU=;
        b=IXIcVan+5MrwUdaDBNKfu54dt6krzq4+en/wP4JTj+xTOwjo7RmJBQwehN/V1beKmGkdEn
        GJHFaLXjGjULAXCw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/insn: Remove kernel_insn_init()
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210304174237.31945-21-bp@alien8.de>
References: <20210304174237.31945-21-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161582326416.398.15532993905756587311.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     404b639e510b36136ef15b08ca8a022845ed87db
Gitweb:        https://git.kernel.org/tip/404b639e510b36136ef15b08ca8a022845ed87db
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Sun, 22 Nov 2020 18:12:37 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Mar 2021 12:58:36 +01:00

x86/insn: Remove kernel_insn_init()

Now that it is not needed anymore, drop it.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210304174237.31945-21-bp@alien8.de
---
 arch/x86/include/asm/insn.h       | 11 -----------
 tools/arch/x86/include/asm/insn.h | 11 -----------
 2 files changed, 22 deletions(-)

diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index de9fe76..5eb3753 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -159,17 +159,6 @@ static inline void insn_get_attribute(struct insn *insn)
 /* Instruction uses RIP-relative addressing */
 extern int insn_rip_relative(struct insn *insn);
 
-/* Init insn for kernel text */
-static inline void kernel_insn_init(struct insn *insn,
-				    const void *kaddr, int buf_len)
-{
-#ifdef CONFIG_X86_64
-	insn_init(insn, kaddr, buf_len, 1);
-#else /* CONFIG_X86_32 */
-	insn_init(insn, kaddr, buf_len, 0);
-#endif
-}
-
 static inline int insn_is_avx(struct insn *insn)
 {
 	if (!insn->prefixes.got)
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index 2fe19b1..5aae785 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -159,17 +159,6 @@ static inline void insn_get_attribute(struct insn *insn)
 /* Instruction uses RIP-relative addressing */
 extern int insn_rip_relative(struct insn *insn);
 
-/* Init insn for kernel text */
-static inline void kernel_insn_init(struct insn *insn,
-				    const void *kaddr, int buf_len)
-{
-#ifdef CONFIG_X86_64
-	insn_init(insn, kaddr, buf_len, 1);
-#else /* CONFIG_X86_32 */
-	insn_init(insn, kaddr, buf_len, 0);
-#endif
-}
-
 static inline int insn_is_avx(struct insn *insn)
 {
 	if (!insn->prefixes.got)
