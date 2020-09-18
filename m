Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B33226F78C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 09:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgIRH6j (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 03:58:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60802 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgIRH6i (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 03:58:38 -0400
X-Greylist: delayed 965 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 03:58:37 EDT
Date:   Fri, 18 Sep 2020 07:58:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600415915;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6LLjp1mmtmCHoDBnz9zJN6eBUiV1sAtqeXKLMzLHqFE=;
        b=tl2YN5MEsTD8TmHoQnqj5F07foXDvXBS2erGHQVQ5a1W/I+Y0h8l4gHPCAR8NjsOPFuGQ1
        Wu8Uiau751+N5CBK0Hd8KoT039eSBMy3fe4/b2m6+hYpo23B5bCNIg6EQBAhZkfbvXp0x3
        2by65AvrPgoPfDhtNMfqEp8FiI9U3saQ+DIK5hRprf7znI4kgJDQUUC8H+nZi4ip5j3zD3
        ceCfcq5nYfJPqChHzTmAW0nRc7/+TaXP2SDh0xAptegAajjtWhZA0XkfJRmdDKzP41LJ0R
        Hl8EJ1c73ncd88UVLA3UrRn1X6fvVJLbaThcl/eYRoY3LtDvLxQB3BiX+0DGdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600415915;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6LLjp1mmtmCHoDBnz9zJN6eBUiV1sAtqeXKLMzLHqFE=;
        b=w+5QkGoTDr+mTEVYcBhMCrPqt1LFM36IxubYeE/KU2EsYZfgfXqGN9Hx1B7fUrFMXemliu
        RSWFQMRzV4KL1bCA==
From:   "tip-bot2 for Krish Sadhukhan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mm/pat: Don't flush cache if hardware enforces
 cache coherency across encryption domnains
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200917212038.5090-3-krish.sadhukhan@oracle.com>
References: <20200917212038.5090-3-krish.sadhukhan@oracle.com>
MIME-Version: 1.0
Message-ID: <160041591456.15536.6246100576112066354.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     789521fca70ec8cb98f7257b880405e46f8a47a1
Gitweb:        https://git.kernel.org/tip/789521fca70ec8cb98f7257b880405e46f8a47a1
Author:        Krish Sadhukhan <krish.sadhukhan@oracle.com>
AuthorDate:    Thu, 17 Sep 2020 21:20:37 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Sep 2020 09:48:22 +02:00

x86/mm/pat: Don't flush cache if hardware enforces cache coherency across encryption domnains

In some hardware implementations, coherency between the encrypted and
unencrypted mappings of the same physical page is enforced. In such a
system, it is not required for software to flush the page from all CPU
caches in the system prior to changing the value of the C-bit for the
page. So check that bit before flushing the cache.

 [ bp: Massage commit message. ]

Suggested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200917212038.5090-3-krish.sadhukhan@oracle.com
---
 arch/x86/mm/pat/set_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index d1b2a88..40baa90 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1999,7 +1999,7 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	/*
 	 * Before changing the encryption attribute, we need to flush caches.
 	 */
-	cpa_flush(&cpa, 1);
+	cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
 
 	ret = __change_page_attr_set_clr(&cpa, 1);
 
