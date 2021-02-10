Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D14316894
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 15:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhBJOAn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 09:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhBJOAa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 09:00:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645C8C06178B;
        Wed, 10 Feb 2021 05:59:32 -0800 (PST)
Date:   Wed, 10 Feb 2021 13:59:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612965571;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SXxaxPVmthlLPYH94L3qiYzVbFKur4bVfH0likKjx/I=;
        b=sLK9N5civ3FNz/7ptJJWBIR6pfEzvSKguZo6TxTc4KjSbw6nieBPrWOciP1lUGWoJAF9pm
        P5O+TQXALUDrOlySBRpoBB3BedMjBrxUof/a2rABBu3vLNPJOsd9ljIj1RGJzhUVSgMbNF
        l88Qp5/iOTx9YKaIqu1ATX5CgoYv3dz3LN4smZr1QGHZANZ1jAgmlnvaFYTlEFLG9a3zIj
        9VQPI+np9B45l5FbjO9nVLKCP89L+Jf2DhPDaoneWqdAvy0ZXX4p+ko9Vk+pP1gwv1BQ+3
        757Yp4Kys3V7JtEkgxjtwRmIm1L/fIDm9Lk7MGUTln2klVmOefvgkmVvUMQUkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612965571;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SXxaxPVmthlLPYH94L3qiYzVbFKur4bVfH0likKjx/I=;
        b=cdMAdKlEGCgKacrNwSem3GP6inD1R6GeKhx4Y2VZZRQYyTJKXwDOjufEdBXDFko5S0ZVfb
        u6IYn+yMWt6bQpAw==
From:   "tip-bot2 for Zhang Rui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Add msr mask support
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210204161816.12649-1-rui.zhang@intel.com>
References: <20210204161816.12649-1-rui.zhang@intel.com>
MIME-Version: 1.0
Message-ID: <161296557037.23325.12133894476994706739.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ffb20c2e52e8709b5fc9951e8863e31efb1f2cba
Gitweb:        https://git.kernel.org/tip/ffb20c2e52e8709b5fc9951e8863e31efb1f2cba
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Fri, 05 Feb 2021 00:18:14 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 10 Feb 2021 14:44:54 +01:00

perf/x86/rapl: Add msr mask support

In some cases, when probing a perf MSR, we're probing certain bits of the
MSR instead of the whole register, thus only these bits should be checked.

For example, for RAPL ENERGY_STATUS MSR, only the lower 32 bits represents
the energy counter, and the higher 32bits are reserved.

Introduce a new mask field in struct perf_msr to allow probing certain
bits of a MSR.

This change is transparent to the current perf_msr_probe() users.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/20210204161816.12649-1-rui.zhang@intel.com
---
 arch/x86/events/probe.c | 7 ++++++-
 arch/x86/events/probe.h | 7 ++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/probe.c b/arch/x86/events/probe.c
index 136a1e8..600bf8d 100644
--- a/arch/x86/events/probe.c
+++ b/arch/x86/events/probe.c
@@ -28,6 +28,7 @@ perf_msr_probe(struct perf_msr *msr, int cnt, bool zero, void *data)
 	for (bit = 0; bit < cnt; bit++) {
 		if (!msr[bit].no_check) {
 			struct attribute_group *grp = msr[bit].grp;
+			u64 mask;
 
 			/* skip entry with no group */
 			if (!grp)
@@ -44,8 +45,12 @@ perf_msr_probe(struct perf_msr *msr, int cnt, bool zero, void *data)
 			/* Virt sucks; you cannot tell if a R/O MSR is present :/ */
 			if (rdmsrl_safe(msr[bit].msr, &val))
 				continue;
+
+			mask = msr[bit].mask;
+			if (!mask)
+				mask = ~0ULL;
 			/* Disable zero counters if requested. */
-			if (!zero && !val)
+			if (!zero && !(val & mask))
 				continue;
 
 			grp->is_visible = NULL;
diff --git a/arch/x86/events/probe.h b/arch/x86/events/probe.h
index 4c8e0af..261b9bd 100644
--- a/arch/x86/events/probe.h
+++ b/arch/x86/events/probe.h
@@ -4,10 +4,11 @@
 #include <linux/sysfs.h>
 
 struct perf_msr {
-	u64			  msr;
-	struct attribute_group	 *grp;
+	u64			msr;
+	struct attribute_group	*grp;
 	bool			(*test)(int idx, void *data);
-	bool			  no_check;
+	bool			no_check;
+	u64			mask;
 };
 
 unsigned long
