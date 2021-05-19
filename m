Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C78388942
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 May 2021 10:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244835AbhESIWo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 May 2021 04:22:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37562 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244822AbhESIWo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 May 2021 04:22:44 -0400
Date:   Wed, 19 May 2021 08:21:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621412483;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8f7a7DljQW0or64tcdOkNMMQv6TTDBN/VTQLd19TF1g=;
        b=bmbaduFZfXoRDbYbWGl5Ki0L49jzPn8k70LvjBCCKNmSzBOQd6577gMjUOnMQZ+DpKoURy
        EO8krVPXGYrlp3AyO5gPUyQJgQ2ZWuRzxL/F3dBMP9Yi2XcqWK3X/FwL0Vo1G9Vb/WI+9h
        uF9kEdWKOqPdjp4XHu/mPuFW6yCUYSJy3dD/pktZ1hARI9/h0e8dJkcMzom/Lg5ThhzKYR
        3wO3Xvr31qo7+JVealx2itn16YVadjJWCoVRC4rgr/XnzGuXhv/7R2qh5XL4Ngm41fctgb
        xvKbE1GQMo8II3trzJSpIQi/ulVyUVtGBsXNDhdw4LaKKeIHRrjCpoQZ8NBgkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621412483;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8f7a7DljQW0or64tcdOkNMMQv6TTDBN/VTQLd19TF1g=;
        b=TjqCzY39VmWc/Yn4yHTYFzqBHuamO1nZr5MfHHD5EU1ZgQSMu3y22G0yh0+6jTv4NwvaCf
        WsT1xAcaEETXfDBw==
From:   "tip-bot2 for Alexander Antonov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Enable I/O stacks to IIO PMON
 mapping on ICX
Cc:     Alexander Antonov <alexander.antonov@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210426131614.16205-4-alexander.antonov@linux.intel.com>
References: <20210426131614.16205-4-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162141248257.29796.14197860640156141997.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     10337e95e04c9bcd15d9bf5b26f194c92c13da56
Gitweb:        https://git.kernel.org/tip/10337e95e04c9bcd15d9bf5b26f194c92c13da56
Author:        Alexander Antonov <alexander.antonov@linux.intel.com>
AuthorDate:    Mon, 26 Apr 2021 16:16:14 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 May 2021 12:53:57 +02:00

perf/x86/intel/uncore: Enable I/O stacks to IIO PMON mapping on ICX

This patch enables I/O stacks to IIO PMON mapping on Icelake server.

Mapping of IDs in SAD_CONTROL_CFG notation to IDs in PMON notation for
Icelake server:

Stack Name         | CBDMA/DMI | PCIe_1 | PCIe_2 | PCIe_3 | PCIe_4 | PCIe_5
SAD_CONTROL_CFG ID |     0     |    1   |    2   |    3   |    4   |    5
PMON ID            |     5     |    0   |    1   |    2   |    3   |    4

I/O stacks to IIO PMON mapping is exposed through attributes
/sys/devices/uncore_iio_<pmu_idx>/dieX, where dieX is file which holds
"Segment:Root Bus" for PCIe root port which can be monitored by that
IIO PMON block. Example for 2-S Icelake server:

==> /sys/devices/uncore_iio_0/die0 <==
0000:16
==> /sys/devices/uncore_iio_0/die1 <==
0000:97
==> /sys/devices/uncore_iio_1/die0 <==
0000:30
==> /sys/devices/uncore_iio_1/die1 <==
0000:b0
==> /sys/devices/uncore_iio_3/die0 <==
0000:4a
==> /sys/devices/uncore_iio_3/die1 <==
0000:c9
==> /sys/devices/uncore_iio_4/die0 <==
0000:64
==> /sys/devices/uncore_iio_4/die1 <==
0000:e2
==> /sys/devices/uncore_iio_5/die0 <==
0000:00
==> /sys/devices/uncore_iio_5/die1 <==
0000:80

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lkml.kernel.org/r/20210426131614.16205-4-alexander.antonov@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 51 +++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index b50c946..7622762 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5041,6 +5041,53 @@ static struct event_constraint icx_uncore_iio_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
+static umode_t
+icx_iio_mapping_visible(struct kobject *kobj, struct attribute *attr, int die)
+{
+	/* Root bus 0x00 is valid only for pmu_idx = 5. */
+	return pmu_iio_mapping_visible(kobj, attr, die, 5);
+}
+
+static struct attribute_group icx_iio_mapping_group = {
+	.is_visible	= icx_iio_mapping_visible,
+};
+
+static const struct attribute_group *icx_iio_attr_update[] = {
+	&icx_iio_mapping_group,
+	NULL,
+};
+
+/*
+ * ICX has a static mapping of stack IDs from SAD_CONTROL_CFG notation to PMON
+ */
+enum {
+	ICX_PCIE1_PMON_ID,
+	ICX_PCIE2_PMON_ID,
+	ICX_PCIE3_PMON_ID,
+	ICX_PCIE4_PMON_ID,
+	ICX_PCIE5_PMON_ID,
+	ICX_CBDMA_DMI_PMON_ID
+};
+
+static u8 icx_sad_pmon_mapping[] = {
+	ICX_CBDMA_DMI_PMON_ID,
+	ICX_PCIE1_PMON_ID,
+	ICX_PCIE2_PMON_ID,
+	ICX_PCIE3_PMON_ID,
+	ICX_PCIE4_PMON_ID,
+	ICX_PCIE5_PMON_ID,
+};
+
+static int icx_iio_get_topology(struct intel_uncore_type *type)
+{
+	return sad_cfg_iio_topology(type, icx_sad_pmon_mapping);
+}
+
+static int icx_iio_set_mapping(struct intel_uncore_type *type)
+{
+	return pmu_iio_set_mapping(type, &icx_iio_mapping_group);
+}
+
 static struct intel_uncore_type icx_uncore_iio = {
 	.name			= "iio",
 	.num_counters		= 4,
@@ -5055,6 +5102,10 @@ static struct intel_uncore_type icx_uncore_iio = {
 	.constraints		= icx_uncore_iio_constraints,
 	.ops			= &skx_uncore_iio_ops,
 	.format_group		= &snr_uncore_iio_format_group,
+	.attr_update		= icx_iio_attr_update,
+	.get_topology		= icx_iio_get_topology,
+	.set_mapping		= icx_iio_set_mapping,
+	.cleanup_mapping	= skx_iio_cleanup_mapping,
 };
 
 static struct intel_uncore_type icx_uncore_irp = {
