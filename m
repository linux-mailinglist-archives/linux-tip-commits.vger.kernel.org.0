Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D3A3FC70F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 31 Aug 2021 14:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbhHaMMD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 31 Aug 2021 08:12:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58234 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241686AbhHaMIj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 31 Aug 2021 08:08:39 -0400
Date:   Tue, 31 Aug 2021 12:07:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630411662;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zuKOmzbX3D/R7ftvLWS76D1VsGyaWqPxpZ4+8NJ98ZE=;
        b=YMdNcQJO5joc/HlLimYBhkgRk47y35c14V7xXo/pyyRpObgJNw/GTR2vfMsNMCZNPGy0mV
        +NifSeKKfAhP50bkqUr1t3vU5dfVdgO/Ile2m8yYou9pHirdP1oSUOTJSI6AhhtQbz1Fgs
        EZIsCmOEDAb2TWsNdTSPgLc41m78exeP+jMG9feJ0vYxRsGJ1i8TAacyGdap655AfsTCC5
        MNMx6yWMWbBb7muOAMqX9BwZ+5eyNf+146yAIIYvh1SIqAjKLRgvsPCz+ZtSDcMxAoel1x
        o06iaObfeAvfQSv9qpEW8yP/0+T8nhetXmkN4gd2EgYWCWka1mVNeZU8wBfBgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630411662;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zuKOmzbX3D/R7ftvLWS76D1VsGyaWqPxpZ4+8NJ98ZE=;
        b=NPdE0SgwlxpO+uDe1ruluTpJMu/T17OeUUzI0JPsRvHsNgYS8fEMG/fMOZtRMVtC4so3W2
        3HjN/rFDDkGjvOAQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Fix Intel SPR M2PCIE event
 constraints
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1629991963-102621-7-git-send-email-kan.liang@linux.intel.com>
References: <1629991963-102621-7-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <163041166175.25758.8859491168761891164.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f01d7d558e1855d4aa8e927b86111846536dd476
Gitweb:        https://git.kernel.org/tip/f01d7d558e1855d4aa8e927b86111846536dd476
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 26 Aug 2021 08:32:42 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 31 Aug 2021 13:59:37 +02:00

perf/x86/intel/uncore: Fix Intel SPR M2PCIE event constraints

Similar to the ICX M2PCIE  events, some of the SPR M2PCIE events also
have constraints. Add the constraints for SPR M2PCIE.

Fixes: f85ef898f884 ("perf/x86/intel/uncore: Add Sapphire Rapids server M2PCIe support")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1629991963-102621-7-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 2d75d21..cd53057 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5690,9 +5690,16 @@ static struct intel_uncore_type spr_uncore_irp = {
 
 };
 
+static struct event_constraint spr_uncore_m2pcie_constraints[] = {
+	UNCORE_EVENT_CONSTRAINT(0x14, 0x3),
+	UNCORE_EVENT_CONSTRAINT(0x2d, 0x3),
+	EVENT_CONSTRAINT_END
+};
+
 static struct intel_uncore_type spr_uncore_m2pcie = {
 	SPR_UNCORE_COMMON_FORMAT(),
 	.name			= "m2pcie",
+	.constraints		= spr_uncore_m2pcie_constraints,
 };
 
 static struct intel_uncore_type spr_uncore_pcu = {
