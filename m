Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A9E3BB851
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jul 2021 09:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhGEH4X (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jul 2021 03:56:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59130 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhGEH4T (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jul 2021 03:56:19 -0400
Date:   Mon, 05 Jul 2021 07:53:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625471622;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=byxpdXjlUnfnX9QRcr+gD1o09MU8W6pkKF1/gfGwIag=;
        b=nXFBUeG1RzM/QzlKYvOsE6PosfAi8Ex/DJ42zwu9KhnpalGpQSpOERHAKMzDf3D3TnxKHD
        U02LlNP1uj30ADC1o67tfz8gca+VK5oY7w16jv0AY1qpjUJ/iWEgmD0GIxjGkgFBc9x14N
        vu+kCa6HL7WF43O7hk0BGLEvqHAod2DfpAJ0/3eg1f80Yfiw2rc/nArloyOYx6gHNPzkcc
        S3Qwp0dm5ZskCL0B5Vr6s53i16JKWGj/E6IFt1k7RfDb8jUi0UHjsPE1KDjVq/94cOIs6U
        Ydm8+o1UAqu3gKeiti8QD6/KEQIt5IvmRrmaSMrywvvTnYQ/p93IEaXFTFPy1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625471622;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=byxpdXjlUnfnX9QRcr+gD1o09MU8W6pkKF1/gfGwIag=;
        b=WfKS3omXbfi/8UBzaNN7PylcEwujuzftwQ+GKohq1GjxVN7W3JCiYIWC9xeLSmLxlLR+6y
        8AwLl6iUFYYDkEAA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add Sapphire Rapids server
 M3UPI support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1625087320-194204-11-git-send-email-kan.liang@linux.intel.com>
References: <1625087320-194204-11-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162547162143.395.417308823668991627.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2a8e51eae7c83c29795622cfc794cf83436cc05d
Gitweb:        https://git.kernel.org/tip/2a8e51eae7c83c29795622cfc794cf83436cc05d
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 30 Jun 2021 14:08:34 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Jul 2021 15:58:40 +02:00

perf/x86/intel/uncore: Add Sapphire Rapids server M3UPI support

M3 Intel UPI is the interface between the mesh and the Intel UPI link
layer. It is responsible for translating between the mesh protocol
packets and the flits that are used for transmitting data across the
Intel UPI interface.

The layout of the control registers for a M3UPI uncore unit is similar
to a UPI uncore unit.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lore.kernel.org/r/1625087320-194204-11-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 20045ba..14b9b23 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5703,6 +5703,11 @@ static struct intel_uncore_type spr_uncore_upi = {
 	.name			= "upi",
 };
 
+static struct intel_uncore_type spr_uncore_m3upi = {
+	SPR_UNCORE_PCI_COMMON_FORMAT(),
+	.name			= "m3upi",
+};
+
 #define UNCORE_SPR_NUM_UNCORE_TYPES		12
 
 static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
@@ -5715,7 +5720,7 @@ static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
 	&spr_uncore_imc,
 	&spr_uncore_m2m,
 	&spr_uncore_upi,
-	NULL,
+	&spr_uncore_m3upi,
 	NULL,
 	NULL,
 };
