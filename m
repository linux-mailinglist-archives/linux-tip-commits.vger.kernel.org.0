Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC98D4535E4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Nov 2021 16:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238343AbhKPPga (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 16 Nov 2021 10:36:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53386 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238313AbhKPPgR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 16 Nov 2021 10:36:17 -0500
Date:   Tue, 16 Nov 2021 15:33:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637076797;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N1d5jng9Q6/Lg7RwFYfi6ZewoMPsD8NiDTgSlWiaxfk=;
        b=BiUbjUrB+7I8bWMTIsXa4CDYt8V0005/3LPpyED+ywV6rc51gbIe6XWwhtxaO5nNjygarT
        X98QkqHpSd8pz3jTxjLPu3U64hxQdmcdWFzGMu8/XTKdZ2Hi7MXIwpuvb2RxjEoB6MwIy1
        ATbtbZytXDbXwYNlGaz54vMU6PLmzgRCt9M9MVlWfRG8v66P3z8rHtRI2fZFGF2psGN8xv
        ScmTncFxR8W6onL4wKHcL8NifrFtjzElJT9/87+EHJ4yHlsym2anMFMu/xJTgJ0daY37Ls
        j7yEVAqf5ywygzK2zKxpee64beK0u6rigWr/drJj8mTg9a5iN/k+WCbXinIDpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637076797;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N1d5jng9Q6/Lg7RwFYfi6ZewoMPsD8NiDTgSlWiaxfk=;
        b=A9WS6m1FMLWtV9Xc0qtIMBtC0MjpYcyu1+DcTnUhaQ3CeRNCEJDDf7CONafAKrSJlQpmtL
        jyS6br1W7dGNuJCA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Get rid of excessive use of defines
Cc:     Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211110220731.2396491-6-brijesh.singh@amd.com>
References: <20211110220731.2396491-6-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <163707679650.414.3276636579408769233.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     dbc4c70e3cdfe204a67dd66bed78709ee3000ec0
Gitweb:        https://git.kernel.org/tip/dbc4c70e3cdfe204a67dd66bed78709ee3000ec0
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 10 Nov 2021 16:06:51 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Nov 2021 20:53:40 +01:00

x86/sev: Get rid of excessive use of defines

Remove all the defines of masks and bit positions for the GHCB MSR
protocol and use comments instead which correspond directly to the spec
so that following those can be a lot easier and straightforward with the
spec opened in parallel to the code.

Aligh vertically while at it.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211110220731.2396491-6-brijesh.singh@amd.com
---
 arch/x86/include/asm/sev-common.h | 51 ++++++++++++++++--------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 855b0ec..aac44c3 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -18,20 +18,19 @@
 /* SEV Information Request/Response */
 #define GHCB_MSR_SEV_INFO_RESP		0x001
 #define GHCB_MSR_SEV_INFO_REQ		0x002
-#define GHCB_MSR_VER_MAX_POS		48
-#define GHCB_MSR_VER_MAX_MASK		0xffff
-#define GHCB_MSR_VER_MIN_POS		32
-#define GHCB_MSR_VER_MIN_MASK		0xffff
-#define GHCB_MSR_CBIT_POS		24
-#define GHCB_MSR_CBIT_MASK		0xff
-#define GHCB_MSR_SEV_INFO(_max, _min, _cbit)				\
-	((((_max) & GHCB_MSR_VER_MAX_MASK) << GHCB_MSR_VER_MAX_POS) |	\
-	 (((_min) & GHCB_MSR_VER_MIN_MASK) << GHCB_MSR_VER_MIN_POS) |	\
-	 (((_cbit) & GHCB_MSR_CBIT_MASK) << GHCB_MSR_CBIT_POS) |	\
+
+#define GHCB_MSR_SEV_INFO(_max, _min, _cbit)	\
+	/* GHCBData[63:48] */			\
+	((((_max) & 0xffff) << 48) |		\
+	 /* GHCBData[47:32] */			\
+	 (((_min) & 0xffff) << 32) |		\
+	 /* GHCBData[31:24] */			\
+	 (((_cbit) & 0xff)  << 24) |		\
 	 GHCB_MSR_SEV_INFO_RESP)
+
 #define GHCB_MSR_INFO(v)		((v) & 0xfffUL)
-#define GHCB_MSR_PROTO_MAX(v)		(((v) >> GHCB_MSR_VER_MAX_POS) & GHCB_MSR_VER_MAX_MASK)
-#define GHCB_MSR_PROTO_MIN(v)		(((v) >> GHCB_MSR_VER_MIN_POS) & GHCB_MSR_VER_MIN_MASK)
+#define GHCB_MSR_PROTO_MAX(v)		(((v) >> 48) & 0xffff)
+#define GHCB_MSR_PROTO_MIN(v)		(((v) >> 32) & 0xffff)
 
 /* CPUID Request/Response */
 #define GHCB_MSR_CPUID_REQ		0x004
@@ -46,27 +45,33 @@
 #define GHCB_CPUID_REQ_EBX		1
 #define GHCB_CPUID_REQ_ECX		2
 #define GHCB_CPUID_REQ_EDX		3
-#define GHCB_CPUID_REQ(fn, reg)		\
-		(GHCB_MSR_CPUID_REQ | \
-		(((unsigned long)reg & GHCB_MSR_CPUID_REG_MASK) << GHCB_MSR_CPUID_REG_POS) | \
-		(((unsigned long)fn) << GHCB_MSR_CPUID_FUNC_POS))
+#define GHCB_CPUID_REQ(fn, reg)				\
+	/* GHCBData[11:0] */				\
+	(GHCB_MSR_CPUID_REQ |				\
+	/* GHCBData[31:12] */				\
+	(((unsigned long)(reg) & 0x3) << 30) |		\
+	/* GHCBData[63:32] */				\
+	(((unsigned long)fn) << 32))
 
 /* AP Reset Hold */
-#define GHCB_MSR_AP_RESET_HOLD_REQ		0x006
-#define GHCB_MSR_AP_RESET_HOLD_RESP		0x007
+#define GHCB_MSR_AP_RESET_HOLD_REQ	0x006
+#define GHCB_MSR_AP_RESET_HOLD_RESP	0x007
 
 /* GHCB Hypervisor Feature Request/Response */
-#define GHCB_MSR_HV_FT_REQ			0x080
-#define GHCB_MSR_HV_FT_RESP			0x081
+#define GHCB_MSR_HV_FT_REQ		0x080
+#define GHCB_MSR_HV_FT_RESP		0x081
 
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
 #define GHCB_MSR_TERM_REASON_SET_MASK	0xf
 #define GHCB_MSR_TERM_REASON_POS	16
 #define GHCB_MSR_TERM_REASON_MASK	0xff
-#define GHCB_SEV_TERM_REASON(reason_set, reason_val)						  \
-	(((((u64)reason_set) &  GHCB_MSR_TERM_REASON_SET_MASK) << GHCB_MSR_TERM_REASON_SET_POS) | \
-	((((u64)reason_val) & GHCB_MSR_TERM_REASON_MASK) << GHCB_MSR_TERM_REASON_POS))
+
+#define GHCB_SEV_TERM_REASON(reason_set, reason_val)	\
+	/* GHCBData[15:12] */				\
+	(((((u64)reason_set) &  0xf) << 12) |		\
+	 /* GHCBData[23:16] */				\
+	((((u64)reason_val) & 0xff) << 16))
 
 #define GHCB_SEV_ES_GEN_REQ		0
 #define GHCB_SEV_ES_PROT_UNSUPPORTED	1
