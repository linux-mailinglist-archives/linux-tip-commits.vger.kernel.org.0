Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B8B27E0AD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Sep 2020 07:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgI3Fx6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Sep 2020 01:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI3Fx6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Sep 2020 01:53:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E531BC0613D0;
        Tue, 29 Sep 2020 22:53:57 -0700 (PDT)
Date:   Wed, 30 Sep 2020 05:53:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601445236;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ahOeeP86f9uCecyeGSSDKdJGjFyi4/gaNssHNrm6fao=;
        b=l7UCZZpiXkzDBvrMFw6YDjBwI4mKJBu9bDlBMdIbTFRPEioM2dytZZt3bUvpXqpl72o2Ea
        kK7xoFBpreaCBaEb9/fbP6nrH8IBVoEb+amyasjKoQUbm4gKaLf8yV2QK8xLKuU0Ay11t1
        Fc6QPtv3veyv2Q7ZGlgq0wM/DjBWub0DUGXheQHxpefvEHOct040LoXMZxcMmZXjuFimpv
        h8rtRVh1Bcy6BFS5K02QOfnZrhKOQDtifoFchwJpA9MnTToiHbVAWxlSarzL7suzJka0P+
        Q5aktmdqTRe6qVPgoAKIZU58T6IzOBPHhF4g5w+hSgA90ZwqKoQtPj5PnnwS9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601445236;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ahOeeP86f9uCecyeGSSDKdJGjFyi4/gaNssHNrm6fao=;
        b=NzIpyM0eS5Rc/Jm9jDslaw9EImDsePvwVfDm8v4yGDAmJAQ5SVe5cX6gS3IQPe+S1RnQvC
        XrbFLarMTVYviLBg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Add Skylake quirk for patrol scrub reported errors
Cc:     Youquan Song <youquan.song@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200930021313.31810-2-tony.luck@intel.com>
References: <20200930021313.31810-2-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <160144523568.7002.16245539195068602874.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     fd258dc4442c5c1c069c6b5b42bfe7d10cddda95
Gitweb:        https://git.kernel.org/tip/fd258dc4442c5c1c069c6b5b42bfe7d10cddda95
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Tue, 29 Sep 2020 19:13:12 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 30 Sep 2020 07:43:56 +02:00

x86/mce: Add Skylake quirk for patrol scrub reported errors

The patrol scrubber in Skylake and Cascade Lake systems can be configured
to report uncorrected errors using a special signature in the machine
check bank and to signal using CMCI instead of machine check.

Update the severity calculation mechanism to allow specifying the model,
minimum stepping and range of machine check bank numbers.

Add a new rule to detect the special signature (on model 0x55, stepping
>=4 in any of the memory controller banks).

 [ bp: Rewrite it.
   aegl: Productize it. ]

Suggested-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Co-developed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200930021313.31810-2-tony.luck@intel.com
---
 arch/x86/kernel/cpu/mce/severity.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index e1da619..567ce09 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -9,9 +9,11 @@
 #include <linux/seq_file.h>
 #include <linux/init.h>
 #include <linux/debugfs.h>
-#include <asm/mce.h>
 #include <linux/uaccess.h>
 
+#include <asm/mce.h>
+#include <asm/intel-family.h>
+
 #include "internal.h"
 
 /*
@@ -40,9 +42,14 @@ static struct severity {
 	unsigned char context;
 	unsigned char excp;
 	unsigned char covered;
+	unsigned char cpu_model;
+	unsigned char cpu_minstepping;
+	unsigned char bank_lo, bank_hi;
 	char *msg;
 } severities[] = {
 #define MCESEV(s, m, c...) { .sev = MCE_ ## s ## _SEVERITY, .msg = m, ## c }
+#define BANK_RANGE(l, h) .bank_lo = l, .bank_hi = h
+#define MODEL_STEPPING(m, s) .cpu_model = m, .cpu_minstepping = s
 #define  KERNEL		.context = IN_KERNEL
 #define  USER		.context = IN_USER
 #define  KERNEL_RECOV	.context = IN_KERNEL_RECOV
@@ -97,7 +104,6 @@ static struct severity {
 		KEEP, "Corrected error",
 		NOSER, BITCLR(MCI_STATUS_UC)
 		),
-
 	/*
 	 * known AO MCACODs reported via MCE or CMC:
 	 *
@@ -113,6 +119,18 @@ static struct severity {
 		AO, "Action optional: last level cache writeback error",
 		SER, MASK(MCI_UC_AR|MCACOD, MCI_STATUS_UC|MCACOD_L3WB)
 		),
+	/*
+	 * Quirk for Skylake/Cascade Lake. Patrol scrubber may be configured
+	 * to report uncorrected errors using CMCI with a special signature.
+	 * UC=0, MSCOD=0x0010, MCACOD=binary(000X 0000 1100 XXXX) reported
+	 * in one of the memory controller banks.
+	 * Set severity to "AO" for same action as normal patrol scrub error.
+	 */
+	MCESEV(
+		AO, "Uncorrected Patrol Scrub Error",
+		SER, MASK(MCI_STATUS_UC|MCI_ADDR|0xffffeff0, MCI_ADDR|0x001000c0),
+		MODEL_STEPPING(INTEL_FAM6_SKYLAKE_X, 4), BANK_RANGE(13, 18)
+	),
 
 	/* ignore OVER for UCNA */
 	MCESEV(
@@ -324,6 +342,12 @@ static int mce_severity_intel(struct mce *m, int tolerant, char **msg, bool is_e
 			continue;
 		if (s->excp && excp != s->excp)
 			continue;
+		if (s->cpu_model && boot_cpu_data.x86_model != s->cpu_model)
+			continue;
+		if (s->cpu_minstepping && boot_cpu_data.x86_stepping < s->cpu_minstepping)
+			continue;
+		if (s->bank_lo && (m->bank < s->bank_lo || m->bank > s->bank_hi))
+			continue;
 		if (msg)
 			*msg = s->msg;
 		s->covered = 1;
