Return-Path: <linux-tip-commits+bounces-6341-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F75B33C87
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79D184E149C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9492DCF5F;
	Mon, 25 Aug 2025 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HBwXUoc4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0kjcAKYF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283702DAFA7;
	Mon, 25 Aug 2025 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117471; cv=none; b=uvEJAoNXr9UTAxqSPdppB8RM+nqcI7cTyTeCL3Gc7weytL2R29g7ZVeLJgVWoFIo3nFLrUWA/71q67CGA5uE860ufiDoUpLa+alrnOFaIxsATsSX6j2kgJC/P0cMfW/xickfZRvC/lC/X5XNmlrgHHCRPccGdcPlFVF+dL9gMVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117471; c=relaxed/simple;
	bh=JNMNDgdBLc6xmUBbyoPbud6yRHtkYiCX2uBFUvJrIoE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LXtn8UEUfk1AJPs8AjMV69+0OTkX+ajFe3bxlPRgbpShK9NticbmqNjzlsp7HBg6QryWvtioXdrlz8UkOx8HsKhB4PGVqKQSGaoc4Q1vWCLeOTwrAWUvh8OE0HZj8r36wKLmxTwKMbKfuz+71pYpZpGq30MRkRxiBb4OGhhycw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HBwXUoc4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0kjcAKYF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:24:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117468;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X6IaIIZte06+MYdVi1cC90fG9QgeFqNJNT6Pe1qdQfI=;
	b=HBwXUoc4JI5kLFrX+2ULA741l7zoW48QM953tp5z0S7qRtxpCmPgWS68njX0w3BE6qGykr
	f6pDRK19Cfz6uTpPCZUAnyE4zaKK0Bg8WsLpGvJRIJ9ciCuoG6Nmi5Ohs2suWfTrwIWwi5
	hxIFWj/+cmFCiAAsaJVWGKCUwn1YPNhC4s09qM3CZezK6Y8Lv++c06Qvxu0jT4ZXpmGvEj
	p0WYJUpPrn14aaPB44+xUMWdiLKK2JdxI1tsof2mpH2xfSa6TGKpNy4HM/+6Qv4g6Ifqoo
	jQw/+mubms8YZO2wAzZ3Nxu63Q6DSzUv8F6rFxprTvM59YyuptNqrA70icvsKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117468;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X6IaIIZte06+MYdVi1cC90fG9QgeFqNJNT6Pe1qdQfI=;
	b=0kjcAKYFiEGRjN7o77nPC8Pt0s+lrR6Dmpt024gjlBjAvw6HU9x5T+VgB5+bwbQUt8PtcG
	N95HS0z2FIM/PvAQ==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Add PERF_CAP_PEBS_TIMING_INFO flag
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, Yi Lai <yi1.lai@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250820023032.17128-5-dapeng1.mi@linux.intel.com>
References: <20250820023032.17128-5-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611746727.1420.11937605567314310541.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0c5caea762de31a85cbcce65d978cec83449f699
Gitweb:        https://git.kernel.org/tip/0c5caea762de31a85cbcce65d978cec8344=
9f699
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 20 Aug 2025 10:30:29 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:27 +02:00

perf/x86: Add PERF_CAP_PEBS_TIMING_INFO flag

IA32_PERF_CAPABILITIES.PEBS_TIMING_INFO[bit 17] is introduced to
indicate whether timed PEBS is supported. Timed PEBS adds a new "retired
latency" field in basic info group to show the timing info. Please find
detailed information about timed PEBS in section 8.4.1 "Timed Processor
Event Based Sampling" of "Intel Architecture Instruction Set Extensions
and Future Features".

This patch adds PERF_CAP_PEBS_TIMING_INFO flag and KVM module leverages
this flag to expose timed PEBS feature to guest.

Moreover, opportunistically refine the indents and make the macros
share consistent indents.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Link: https://lore.kernel.org/r/20250820023032.17128-5-dapeng1.mi@linux.intel=
.com
---
 arch/x86/include/asm/msr-index.h       | 14 ++++++++------
 tools/arch/x86/include/asm/msr-index.h | 14 ++++++++------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-inde=
x.h
index b65c3ba..f627196 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -315,12 +315,14 @@
 #define PERF_CAP_PT_IDX			16
=20
 #define MSR_PEBS_LD_LAT_THRESHOLD	0x000003f6
-#define PERF_CAP_PEBS_TRAP             BIT_ULL(6)
-#define PERF_CAP_ARCH_REG              BIT_ULL(7)
-#define PERF_CAP_PEBS_FORMAT           0xf00
-#define PERF_CAP_PEBS_BASELINE         BIT_ULL(14)
-#define PERF_CAP_PEBS_MASK	(PERF_CAP_PEBS_TRAP | PERF_CAP_ARCH_REG | \
-				 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE)
+#define PERF_CAP_PEBS_TRAP		BIT_ULL(6)
+#define PERF_CAP_ARCH_REG		BIT_ULL(7)
+#define PERF_CAP_PEBS_FORMAT		0xf00
+#define PERF_CAP_PEBS_BASELINE		BIT_ULL(14)
+#define PERF_CAP_PEBS_TIMING_INFO	BIT_ULL(17)
+#define PERF_CAP_PEBS_MASK		(PERF_CAP_PEBS_TRAP | PERF_CAP_ARCH_REG | \
+					 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE | \
+					 PERF_CAP_PEBS_TIMING_INFO)
=20
 #define MSR_IA32_RTIT_CTL		0x00000570
 #define RTIT_CTL_TRACEEN		BIT(0)
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/=
asm/msr-index.h
index 5cfb5d7..daebfd9 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -315,12 +315,14 @@
 #define PERF_CAP_PT_IDX			16
=20
 #define MSR_PEBS_LD_LAT_THRESHOLD	0x000003f6
-#define PERF_CAP_PEBS_TRAP             BIT_ULL(6)
-#define PERF_CAP_ARCH_REG              BIT_ULL(7)
-#define PERF_CAP_PEBS_FORMAT           0xf00
-#define PERF_CAP_PEBS_BASELINE         BIT_ULL(14)
-#define PERF_CAP_PEBS_MASK	(PERF_CAP_PEBS_TRAP | PERF_CAP_ARCH_REG | \
-				 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE)
+#define PERF_CAP_PEBS_TRAP		BIT_ULL(6)
+#define PERF_CAP_ARCH_REG		BIT_ULL(7)
+#define PERF_CAP_PEBS_FORMAT		0xf00
+#define PERF_CAP_PEBS_BASELINE		BIT_ULL(14)
+#define PERF_CAP_PEBS_TIMING_INFO	BIT_ULL(17)
+#define PERF_CAP_PEBS_MASK		(PERF_CAP_PEBS_TRAP | PERF_CAP_ARCH_REG | \
+					 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE | \
+					 PERF_CAP_PEBS_TIMING_INFO)
=20
 #define MSR_IA32_RTIT_CTL		0x00000570
 #define RTIT_CTL_TRACEEN		BIT(0)

