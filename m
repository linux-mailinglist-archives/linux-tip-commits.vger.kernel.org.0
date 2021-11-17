Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D0F4547EF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Nov 2021 15:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238028AbhKQODH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Nov 2021 09:03:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60072 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238011AbhKQOCx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Nov 2021 09:02:53 -0500
Date:   Wed, 17 Nov 2021 13:59:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637157593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZFvBudrkC44Lk33g5iFCKFs5yrccUDs5BPcQ2JS40uU=;
        b=Z4RBrqDv29mCWe1GYdAsK5R/jpdON6kR47EuAYtA6hH9qzIlGGQBfQc1EsQu6thitwKDlx
        z//UoFXqzRjU4QYADub2JzCKAfYwBEe0u9OtA+5yJIyAdKXecPLAGqoj9R4u24TwUeL8x9
        swXULjoXx+ys8VWzT+zui6w0CKjKkyma6nfIa6BfLwTsO2qfJr6vW5jBKes+sEgqkptVCx
        DDJeDqTyh8BE/aKfKdRumAvqL4tzBaP3c6T7J9q7q8dfDkR3XL/dLN5FqRl54DAYu9uZkW
        A+U5kmKPgCcjjcVyVWD+AeKj1KmkTMR4IsnAsgxn4jGeI2hYrvjEHAQ1DVojKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637157593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZFvBudrkC44Lk33g5iFCKFs5yrccUDs5BPcQ2JS40uU=;
        b=cnrqRnFaUxiB/9OmZIbwcCVA8v5ll/EfLSUjB+U3b1NVuHfNiIwrdGm7NPxrKPYKFgZHF7
        andDc8L5mTNamDCw==
From:   "tip-bot2 for Alexander Antonov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/uncore: Fix IIO event constraints
 for Snowridge
Cc:     Alexander Antonov <alexander.antonov@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211115090334.3789-4-alexander.antonov@linux.intel.com>
References: <20211115090334.3789-4-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <163715759281.11128.3699523725208419040.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     bdc0feee05174418dec1fa68de2af19e1750b99f
Gitweb:        https://git.kernel.org/tip/bdc0feee05174418dec1fa68de2af19e1750b99f
Author:        Alexander Antonov <alexander.antonov@linux.intel.com>
AuthorDate:    Mon, 15 Nov 2021 12:03:34 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Nov 2021 14:48:43 +01:00

perf/x86/intel/uncore: Fix IIO event constraints for Snowridge

According to the latest uncore document, DATA_REQ_OF_CPU (0x83),
DATA_REQ_BY_CPU (0xc0) and COMP_BUF_OCCUPANCY (0xd5) events have
constraints. Add uncore IIO constraints for Snowridge.

Fixes: 210cc5f9db7a ("perf/x86/intel/uncore: Add uncore support for Snow Ridge server")
Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20211115090334.3789-4-alexander.antonov@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 9aba4ef..3660f69 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4529,6 +4529,13 @@ static void snr_iio_cleanup_mapping(struct intel_uncore_type *type)
 	pmu_iio_cleanup_mapping(type, &snr_iio_mapping_group);
 }
 
+static struct event_constraint snr_uncore_iio_constraints[] = {
+	UNCORE_EVENT_CONSTRAINT(0x83, 0x3),
+	UNCORE_EVENT_CONSTRAINT(0xc0, 0xc),
+	UNCORE_EVENT_CONSTRAINT(0xd5, 0xc),
+	EVENT_CONSTRAINT_END
+};
+
 static struct intel_uncore_type snr_uncore_iio = {
 	.name			= "iio",
 	.num_counters		= 4,
@@ -4540,6 +4547,7 @@ static struct intel_uncore_type snr_uncore_iio = {
 	.event_mask_ext		= SNR_IIO_PMON_RAW_EVENT_MASK_EXT,
 	.box_ctl		= SNR_IIO_MSR_PMON_BOX_CTL,
 	.msr_offset		= SNR_IIO_MSR_OFFSET,
+	.constraints		= snr_uncore_iio_constraints,
 	.ops			= &ivbep_uncore_msr_ops,
 	.format_group		= &snr_uncore_iio_format_group,
 	.attr_update		= snr_iio_attr_update,
