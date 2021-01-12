Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4625B2F3CDB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Jan 2021 01:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436921AbhALVhV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 Jan 2021 16:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436757AbhALUMy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 Jan 2021 15:12:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5370DC061794;
        Tue, 12 Jan 2021 12:12:14 -0800 (PST)
Date:   Tue, 12 Jan 2021 20:12:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610482332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ETyXcgssXC9uxZX6T+4ywf8izJp6yhE6z33Z+yFiUtE=;
        b=ia+aSSCBt81m0PziEqfKelO0NkvTqwCSQRYHgqaDJgpBss40KsGpwMaKJftS8tHZt4ON1U
        SHAU09CRWjUco8Ylqd8jCz8GvgIKldSMaq+zrUAv2LF2qmHJ1kARINqR3UCYhY9WVsYnyb
        I9YeZpJGZAlG0l1AB7cY7533V9Q/GiOdN0LmCP/pEEwa6XJ08hzkxs138oxnPjbBdqE+nf
        HekIaa06QWue592/GGV0be2K/W5iOUN8K4olv0Ek5lDRKO3y6/33Bi0DmuZNN1IJJzUNOU
        BkoGW3xsPwZKOQ9Ks+t6Ihgi+90EHDPpJChA2y9aKdnRggUAUYWAD3OCENFHRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610482332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ETyXcgssXC9uxZX6T+4ywf8izJp6yhE6z33Z+yFiUtE=;
        b=0rc445f+Z/tWd5tzVGPiIEK6Pi2ZtBBAoNWvE+D2QwJ3gTl7kPQLTTpQ8hSakmrvzaXuok
        G6n6eKkiKnXyrxAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sev: Fix nonistr violation
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210106144017.532902065@infradead.org>
References: <20210106144017.532902065@infradead.org>
MIME-Version: 1.0
Message-ID: <161048233053.414.11570561156026341098.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a1d5c98aac33a5a0004ecf88905dcc261c52f988
Gitweb:        https://git.kernel.org/tip/a1d5c98aac33a5a0004ecf88905dcc261c52f988
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 06 Jan 2021 15:36:21 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Jan 2021 21:10:58 +01:00

x86/sev: Fix nonistr violation

When the compiler fails to inline, it violates nonisntr:

  vmlinux.o: warning: objtool: __sev_es_nmi_complete()+0xc7: call to sev_es_wr_ghcb_msr() leaves .noinstr.text section

Fixes: 4ca68e023b11 ("x86/sev-es: Handle NMI State")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210106144017.532902065@infradead.org

---
 arch/x86/kernel/sev-es.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index ab31c34..84c1821 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -225,7 +225,7 @@ static inline u64 sev_es_rd_ghcb_msr(void)
 	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
 }
 
-static inline void sev_es_wr_ghcb_msr(u64 val)
+static __always_inline void sev_es_wr_ghcb_msr(u64 val)
 {
 	u32 low, high;
 
