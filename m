Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776E53FC712
	for <lists+linux-tip-commits@lfdr.de>; Tue, 31 Aug 2021 14:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbhHaMME (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 31 Aug 2021 08:12:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58244 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbhHaMIj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 31 Aug 2021 08:08:39 -0400
Date:   Tue, 31 Aug 2021 12:07:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630411663;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K9dAPGrsD/2t1yuauruCUJilvuu+/iqu6TIizQaMqos=;
        b=EqVhQmOROrPvyJkF1J212q7OJZGtuHiYwSxF0x0lrWsJFFntMfFLEA6gaBp4vI8w9JSefj
        v3+rskqtnwqQZlKwBF4k4wP4uAg304Dm0savv9LCbC7QPZl6nHvEPOXRTYX94mMAbie7sz
        oHQJlxWeeNk8TAC+KuHKs97YV0O1fmS5AM1WmRUCiYsGUw1FmaKtfKYSQCQuQ+9AI9DbRW
        hLDnHvvXjR4JvYdizyHIOfekACRs6Z4LOe6Vhy3XUt/Fa3Ybbrvf1h8D1HC7FGlixaKn7l
        vZEdLX4PgRosdiKg2V7kfI9iWrCMApNpzWBC7v+7MatpTFi7HXcw5SCKJcTj5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630411663;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K9dAPGrsD/2t1yuauruCUJilvuu+/iqu6TIizQaMqos=;
        b=rtthLoXacjtq9IRz/1uHXYztBtGPGIn9XnLCgq+0t01j/CoWTWr81bQZvmHduZBR1YGzHH
        UEJT+g61ivZL2mDA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Fix Intel SPR IIO event constraints
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1629991963-102621-6-git-send-email-kan.liang@linux.intel.com>
References: <1629991963-102621-6-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <163041166254.25758.3322761489528170198.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     67c5d44384f8dc57e1c1b3040423cfce99b578cd
Gitweb:        https://git.kernel.org/tip/67c5d44384f8dc57e1c1b3040423cfce99b578cd
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 26 Aug 2021 08:32:41 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 31 Aug 2021 13:59:36 +02:00

perf/x86/intel/uncore: Fix Intel SPR IIO event constraints

SPR IIO events have the exact same event constraints as ICX, so add the
constraints.

Fixes: 3ba7095beaec ("perf/x86/intel/uncore: Add Sapphire Rapids server IIO support")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1629991963-102621-6-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index ce85ee5..2d75d21 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5661,6 +5661,7 @@ static struct intel_uncore_type spr_uncore_iio = {
 	.event_mask_ext		= SNR_IIO_PMON_RAW_EVENT_MASK_EXT,
 	.format_group		= &snr_uncore_iio_format_group,
 	.attr_update		= uncore_alias_groups,
+	.constraints		= icx_uncore_iio_constraints,
 };
 
 static struct attribute *spr_uncore_raw_formats_attr[] = {
