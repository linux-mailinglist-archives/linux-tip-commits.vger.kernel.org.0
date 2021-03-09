Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50D1332EDD
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Mar 2021 20:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhCITSN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 9 Mar 2021 14:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhCITSB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 9 Mar 2021 14:18:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9409C06174A;
        Tue,  9 Mar 2021 11:18:00 -0800 (PST)
Date:   Tue, 09 Mar 2021 19:17:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615317477;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oEQRIx4Tp61Rw9DpX02YB5M4wS7iCoRRmKL6avj3b4Q=;
        b=LCtdNgIjD2lHd2Qk0FES3WqwXLY1E3v+1w+egh3WS0Pt4XZlU/LhvcxgKKdT9ot0HZE+DI
        xM1TqiGh5gXiD1q5RMtvzkjVyh3taZD2r/H3QX4GVmk4mudksBsjLYcAlaGsbd0+tiurUU
        VXJwkrQG6GzyqNcMoBov3Qqj9HpsxfgSsduEWhzap64twi2i+L+kWLcK+7fF+kRi8Hy44F
        LhQj80ri+ILUuBZTWWSSZWCr0Se252I7ke8U5iGoE4v2Hnnhvxtk5yVsqiQLvgOlEfktoq
        51wwDIH/pcw4JHLFOcpZMczmXcbCHKKkyH/IFU4r3OnBAnd/6mGNHwquDszCYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615317477;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oEQRIx4Tp61Rw9DpX02YB5M4wS7iCoRRmKL6avj3b4Q=;
        b=U6gbdytwlWVkeCtqOXou3Oemsx5S1dlXdMGdNcMMgsbDgpZ2N1+/bzNFYef7hEn5iFm7jP
        PBh2Dg5h7qmwKVDA==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternative: Drop unused feature
 parameter from ALTINSTR_REPLACEMENT()
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210309134813.23912-4-jgross@suse.com>
References: <20210309134813.23912-4-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <161531747613.398.15873261570688926312.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     db16e07269c2b4346e4332e43f04e447ef14fd2f
Gitweb:        https://git.kernel.org/tip/db16e07269c2b4346e4332e43f04e447ef14fd2f
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Tue, 09 Mar 2021 14:48:04 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 09 Mar 2021 20:08:28 +01:00

x86/alternative: Drop unused feature parameter from ALTINSTR_REPLACEMENT()

The macro ALTINSTR_REPLACEMENT() doesn't make use of the feature
parameter, so drop it.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210309134813.23912-4-jgross@suse.com
---
 arch/x86/include/asm/alternative.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 13adca3..5753fb2 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -150,7 +150,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	" .byte " alt_rlen(num) "\n"			/* replacement len */ \
 	" .byte " alt_pad_len "\n"			/* pad len */
 
-#define ALTINSTR_REPLACEMENT(newinstr, feature, num)	/* replacement */	\
+#define ALTINSTR_REPLACEMENT(newinstr, num)		/* replacement */	\
 	"# ALT: replacement " #num "\n"						\
 	b_replacement(num)":\n\t" newinstr "\n" e_replacement(num) ":\n"
 
@@ -161,7 +161,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	ALTINSTR_ENTRY(feature, 1)					\
 	".popsection\n"							\
 	".pushsection .altinstr_replacement, \"ax\"\n"			\
-	ALTINSTR_REPLACEMENT(newinstr, feature, 1)			\
+	ALTINSTR_REPLACEMENT(newinstr, 1)				\
 	".popsection\n"
 
 #define ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2)\
@@ -171,8 +171,8 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	ALTINSTR_ENTRY(feature2, 2)					\
 	".popsection\n"							\
 	".pushsection .altinstr_replacement, \"ax\"\n"			\
-	ALTINSTR_REPLACEMENT(newinstr1, feature1, 1)			\
-	ALTINSTR_REPLACEMENT(newinstr2, feature2, 2)			\
+	ALTINSTR_REPLACEMENT(newinstr1, 1)				\
+	ALTINSTR_REPLACEMENT(newinstr2, 2)				\
 	".popsection\n"
 
 #define ALTERNATIVE_3(oldinsn, newinsn1, feat1, newinsn2, feat2, newinsn3, feat3) \
@@ -183,9 +183,9 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	ALTINSTR_ENTRY(feat3, 3)						\
 	".popsection\n"								\
 	".pushsection .altinstr_replacement, \"ax\"\n"				\
-	ALTINSTR_REPLACEMENT(newinsn1, feat1, 1)				\
-	ALTINSTR_REPLACEMENT(newinsn2, feat2, 2)				\
-	ALTINSTR_REPLACEMENT(newinsn3, feat3, 3)				\
+	ALTINSTR_REPLACEMENT(newinsn1, 1)					\
+	ALTINSTR_REPLACEMENT(newinsn2, 2)					\
+	ALTINSTR_REPLACEMENT(newinsn3, 3)					\
 	".popsection\n"
 
 /*
