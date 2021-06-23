Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2E13B1B32
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jun 2021 15:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhFWNem (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 09:34:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37604 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhFWNeh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 09:34:37 -0400
Date:   Wed, 23 Jun 2021 13:32:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624455134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5rRyPDoyzf7pWCwJUID6RT7A29wPFDd0o+KqNzKqwnI=;
        b=0U4TL1DdrIjv7h7BIx79HuufXMaHvdLVmq3OeSObIu2xmyJJLkvu3MnzkMcszAGp3DJEEK
        h9T78aC5dNXo2xVZEkPD9ed2LJ3mQUNQ1VFhRTw7U9i9QIiNYIaNBFH8PrHp2l5uVdeqTn
        tKupNcL2LgFLin2aUoB5tUWZrfrhS7dTFjuUnPxAJfByRdY7hHtuJzGV/exHs+cMCU2qR9
        bJAuiPm2rj533FuDeUTFg/VwyaSDwmMPH7eaTY+J8/5U37aoOWGDAIRoND3ZuO5t21OIc1
        wCUW+EvWnut9Z/60mKICQDlVglV02v/gdNJq4etlVTcN0+1nxvKHkEtc4xPRrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624455134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5rRyPDoyzf7pWCwJUID6RT7A29wPFDd0o+KqNzKqwnI=;
        b=YY4kVe4O0PAb53364p3kijv4tH05jX300NpEFLA5WaDKJ6yMUVAD56OITLNcHn2uMwvv13
        gZG5I53krOTS8LDQ==
From:   "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Add defines for GHCB version 2 MSR protocol requests
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <YNLXQIZ5e1wjkshG@8bytes.org>
References: <YNLXQIZ5e1wjkshG@8bytes.org>
MIME-Version: 1.0
Message-ID: <162445513402.395.15234934774265504366.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     310f134ed41fcaa03eff302b1e69f1ce1ee21841
Gitweb:        https://git.kernel.org/tip/310f134ed41fcaa03eff302b1e69f1ce1ee21841
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Wed, 23 Jun 2021 08:40:00 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 11:25:17 +02:00

x86/sev: Add defines for GHCB version 2 MSR protocol requests

Add the necessary defines for supporting the GHCB version 2 protocol.
This includes defines for:

	- MSR-based AP hlt request/response
	- Hypervisor Feature request/response

This is the bare minimum of requests that need to be supported by a GHCB
version 2 implementation. There are more requests in the specification,
but those depend on Secure Nested Paging support being available.

These defines are shared between SEV host and guest support.

  [ bp: Fold in https://lkml.kernel.org/r/20210622144825.27588-2-joro@8bytes.org too.
        Simplify the brewing macro maze into readability. ]

Co-developed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/YNLXQIZ5e1wjkshG@8bytes.org
---
 arch/x86/include/asm/sev-common.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index 629c3df..2cef6c5 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -9,8 +9,13 @@
 #define __ASM_X86_SEV_COMMON_H
 
 #define GHCB_MSR_INFO_POS		0
-#define GHCB_MSR_INFO_MASK		(BIT_ULL(12) - 1)
+#define GHCB_DATA_LOW			12
+#define GHCB_MSR_INFO_MASK		(BIT_ULL(GHCB_DATA_LOW) - 1)
 
+#define GHCB_DATA(v)			\
+	(((unsigned long)(v) & ~GHCB_MSR_INFO_MASK) >> GHCB_DATA_LOW)
+
+/* SEV Information Request/Response */
 #define GHCB_MSR_SEV_INFO_RESP		0x001
 #define GHCB_MSR_SEV_INFO_REQ		0x002
 #define GHCB_MSR_VER_MAX_POS		48
@@ -28,6 +33,7 @@
 #define GHCB_MSR_PROTO_MAX(v)		(((v) >> GHCB_MSR_VER_MAX_POS) & GHCB_MSR_VER_MAX_MASK)
 #define GHCB_MSR_PROTO_MIN(v)		(((v) >> GHCB_MSR_VER_MIN_POS) & GHCB_MSR_VER_MIN_MASK)
 
+/* CPUID Request/Response */
 #define GHCB_MSR_CPUID_REQ		0x004
 #define GHCB_MSR_CPUID_RESP		0x005
 #define GHCB_MSR_CPUID_FUNC_POS		32
@@ -45,6 +51,14 @@
 		(((unsigned long)reg & GHCB_MSR_CPUID_REG_MASK) << GHCB_MSR_CPUID_REG_POS) | \
 		(((unsigned long)fn) << GHCB_MSR_CPUID_FUNC_POS))
 
+/* AP Reset Hold */
+#define GHCB_MSR_AP_RESET_HOLD_REQ		0x006
+#define GHCB_MSR_AP_RESET_HOLD_RESP		0x007
+
+/* GHCB Hypervisor Feature Request/Response */
+#define GHCB_MSR_HV_FT_REQ			0x080
+#define GHCB_MSR_HV_FT_RESP			0x081
+
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
 #define GHCB_MSR_TERM_REASON_SET_MASK	0xf
