Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40453BB85B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jul 2021 09:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhGEH42 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jul 2021 03:56:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59130 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhGEH4X (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jul 2021 03:56:23 -0400
Date:   Mon, 05 Jul 2021 07:53:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625471626;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ZzX5zwBWY/quKkCEeQzzX8jBZLUSJsHGUMSLeNh4gw=;
        b=A66KcUZdSnyWrwgz7g20mjrVIpYfeSopAeDvB/PPwSPhYV0PlGw5ekULkbWnZic5xlYnGN
        KwrCRGAx7sSoqYuMLsWjEUExJj/5lWqoVOiZTLomzDsL4ATs2yA5QfS6fmXbYXTKgEF1zj
        1ZI0oc+M/y5qs67kt1UvY/S1w/JI/iDEYAe1sLv/9SWsEnfqv2J69fkyUe/g/m+MhC+UVw
        wgqbqyUeNEah4JwqpQ6sUmFoWgEmU39ai0HbB7qr3niRCcUrT/cgpnV5CuuCqXGIuAHHTm
        pD54wLcf4nz3YUfr6RJZb7kflxizQjped4NlASzownVhlTyoqnBMspqI/3RpVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625471626;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ZzX5zwBWY/quKkCEeQzzX8jBZLUSJsHGUMSLeNh4gw=;
        b=68LxldXepajkHh6MsuQ2r1m9e6Rp08doXMatZ2+USkAtsdyDOLSxcZQrVIMnnaNgv0OkKS
        /ds6FUErzVKEOMCw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add Sapphire Rapids server
 IIO support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1625087320-194204-4-git-send-email-kan.liang@linux.intel.com>
References: <1625087320-194204-4-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162547162596.395.14115544176875203047.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3ba7095beaec1bace1b5864fa92b2b7a0eaadf38
Gitweb:        https://git.kernel.org/tip/3ba7095beaec1bace1b5864fa92b2b7a0eaadf38
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 30 Jun 2021 14:08:27 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Jul 2021 15:58:37 +02:00

perf/x86/intel/uncore: Add Sapphire Rapids server IIO support

The IIO stacks are responsible for managing the traffic between the PCI
Express* (PCIe*) domain and the mesh domain. The IIO PMON block is
situated near the IIO stacks traffic controller capturing the traffic
controller as well as the PCIe* root port information.

The layout of the control registers for a IIO uncore unit is a little
bit different from the generic one.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lore.kernel.org/r/1625087320-194204-4-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 8a470d2..3b40395 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5596,11 +5596,18 @@ static struct intel_uncore_type spr_uncore_chabox = {
 	.format_group		= &spr_uncore_chabox_format_group,
 };
 
+static struct intel_uncore_type spr_uncore_iio = {
+	.name			= "iio",
+	.event_mask		= SNBEP_PMON_RAW_EVENT_MASK,
+	.event_mask_ext		= SNR_IIO_PMON_RAW_EVENT_MASK_EXT,
+	.format_group		= &snr_uncore_iio_format_group,
+};
+
 #define UNCORE_SPR_NUM_UNCORE_TYPES		12
 
 static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
 	&spr_uncore_chabox,
-	NULL,
+	&spr_uncore_iio,
 	NULL,
 	NULL,
 	NULL,
