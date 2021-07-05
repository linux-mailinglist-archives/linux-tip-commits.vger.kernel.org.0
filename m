Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587E03BB861
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jul 2021 09:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhGEH4b (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jul 2021 03:56:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59174 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhGEH40 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jul 2021 03:56:26 -0400
Date:   Mon, 05 Jul 2021 07:53:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625471629;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UP1Mx3MXmfnf8MFzgLDzBUsawoAP/sMGRiMzHExCXPg=;
        b=pIZ99/OtCzPWL+oc+6FZLdZwuJ8WlyiUVkzERyubL4LjSS113h9R/kBcACknC/sK+hYnth
        r1ogmoTULWkeSQW3WIFDPLJhWtZ0aIGtVhBqQUaKAhEu0bo8mUNj9/g8utL8wg34eQBKi4
        WSvQf50rZnhslHvl4Pl47AJ2x3WoEytqT0aklGzym4IX8eavfQDuoCpXHzn2cJ9U4NhNio
        rcPrSlx+zDjMaiP6gLdia9C56/K1USnDe/tkgiKIt2fW1pg8prsBKIHeYEkC+Ihuo6Ge3V
        9v3c1Wv3ALb0L/Iy9iT3EwdaqGfZDsYHfQ2ySbKCSW0jIhaJwnLNPVrCXlwIMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625471629;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UP1Mx3MXmfnf8MFzgLDzBUsawoAP/sMGRiMzHExCXPg=;
        b=R1K78OC9UFi3PC7hed5mmrvEcwuf/VGw7f5Lhb6aph3fVUjGPsmMLiYGpl7bkfvOHYih3A
        oFzUYOOgMKwrEDBw==
From:   "tip-bot2 for Zhang Rui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/cstate: Add ICELAKE_X and ICELAKE_D support
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210625133247.2813-1-rui.zhang@intel.com>
References: <20210625133247.2813-1-rui.zhang@intel.com>
MIME-Version: 1.0
Message-ID: <162547162868.395.7483921233540418539.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     87bf399f86ecf36cc84fbeb7027a2995af649d6e
Gitweb:        https://git.kernel.org/tip/87bf399f86ecf36cc84fbeb7027a2995af649d6e
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Fri, 25 Jun 2021 21:32:47 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Jul 2021 15:58:33 +02:00

perf/x86/cstate: Add ICELAKE_X and ICELAKE_D support

Introduce icx_cstates for ICELAKE_X and ICELAKE_D, and also update the
comments.

On ICELAKE_X and ICELAKE_D, Core C1, Core C6, Package C2 and Package C6
Residency MSRs are supported.

This patch has been tested on real hardware.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Acked-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Link: https://lkml.kernel.org/r/20210625133247.2813-1-rui.zhang@intel.com
---
 arch/x86/events/intel/cstate.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 4333990..c6262b1 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -40,7 +40,7 @@
  * Model specific counters:
  *	MSR_CORE_C1_RES: CORE C1 Residency Counter
  *			 perf code: 0x00
- *			 Available model: SLM,AMT,GLM,CNL,TNT,ADL
+ *			 Available model: SLM,AMT,GLM,CNL,ICX,TNT,ADL
  *			 Scope: Core (each processor core has a MSR)
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
@@ -50,8 +50,8 @@
  *	MSR_CORE_C6_RESIDENCY: CORE C6 Residency Counter
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
- *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL,
- *						TNT,RKL,ADL
+ *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
+ *						TGL,TNT,RKL,ADL
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
@@ -61,7 +61,7 @@
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
- *						KBL,CML,ICL,TGL,TNT,RKL,ADL
+ *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
@@ -72,8 +72,8 @@
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
- *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL,
- *						TNT,RKL,ADL
+ *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
+ *						TGL,TNT,RKL,ADL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
@@ -566,6 +566,14 @@ static const struct cstate_model icl_cstates __initconst = {
 				  BIT(PERF_CSTATE_PKG_C10_RES),
 };
 
+static const struct cstate_model icx_cstates __initconst = {
+	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
+				  BIT(PERF_CSTATE_CORE_C6_RES),
+
+	.pkg_events		= BIT(PERF_CSTATE_PKG_C2_RES) |
+				  BIT(PERF_CSTATE_PKG_C6_RES),
+};
+
 static const struct cstate_model adl_cstates __initconst = {
 	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
 				  BIT(PERF_CSTATE_CORE_C6_RES) |
@@ -664,6 +672,9 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&icl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&icx_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		&icx_cstates),
+
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&icl_cstates),
