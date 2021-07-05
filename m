Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BCD3BB85E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jul 2021 09:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhGEH43 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jul 2021 03:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhGEH4Z (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jul 2021 03:56:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B45C0613E2;
        Mon,  5 Jul 2021 00:53:47 -0700 (PDT)
Date:   Mon, 05 Jul 2021 07:53:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625471626;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vqBCvy04UdtmncHg5I6XqvTpzcifr+VcNedtSSKgyHE=;
        b=uHKlm5szmqDc3cj4jYMUSzwtf90x3fa4wF6QxXrfgdH8Gft1TZ4pyKinfnkG1tgZB7wjCe
        zi4WxzjkUnxCYaOEM0/LoQmToUSOXmaLQ3Gf0PTcTnWF295zcWsaLrxwcv1fD75ZlKfX28
        F1y+OefZ/rQubGbQr9EvX7jPx05Y4NcuXul8TRjv3U6s+UBJD58q0a1+69ysCatD/wXhYt
        64pYg7gi44TbLi7DGjOpD9K1ZrDpsgCuRRZzR5oe+jJIGwIsNQk3n1dmQzFdkQOf4MjfsM
        KRaXExHN880tG4qTnz2UdYI+u8W1KK9RkNC8ODS4RSWNmwDniqNOSakyNPHXZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625471626;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vqBCvy04UdtmncHg5I6XqvTpzcifr+VcNedtSSKgyHE=;
        b=Sep6sDqy4/ex7YMPzze6hwelDbV1X09c1JVedmc1bSkZ2Mat6sJz3burcLu1jAvPiujXoE
        DEqnLmaBe6yOCjBQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Add Sapphire Rapids server
 IRP support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1625087320-194204-5-git-send-email-kan.liang@linux.intel.com>
References: <1625087320-194204-5-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162547162535.395.1840336185561028992.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e199eb5131591c020705deceee224b437d09ece4
Gitweb:        https://git.kernel.org/tip/e199eb5131591c020705deceee224b437d09ece4
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 30 Jun 2021 14:08:28 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Jul 2021 15:58:37 +02:00

perf/x86/intel/uncore: Add Sapphire Rapids server IRP support

The IRP is responsible for maintaining coherency for the IIO traffic
targeting coherent memory.

The layout of the control registers for a IRP uncore unit is a little
bit different from the generic one.

Factor out SPR_UNCORE_COMMON_FORMAT, which can be reused by the
following uncore units.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lore.kernel.org/r/1625087320-194204-5-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 3b40395..de5a6d1 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5603,12 +5603,37 @@ static struct intel_uncore_type spr_uncore_iio = {
 	.format_group		= &snr_uncore_iio_format_group,
 };
 
+static struct attribute *spr_uncore_raw_formats_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_umask_ext4.attr,
+	&format_attr_edge.attr,
+	&format_attr_inv.attr,
+	&format_attr_thresh8.attr,
+	NULL,
+};
+
+static const struct attribute_group spr_uncore_raw_format_group = {
+	.name			= "format",
+	.attrs			= spr_uncore_raw_formats_attr,
+};
+
+#define SPR_UNCORE_COMMON_FORMAT()				\
+	.event_mask		= SNBEP_PMON_RAW_EVENT_MASK,	\
+	.event_mask_ext		= SPR_RAW_EVENT_MASK_EXT,	\
+	.format_group		= &spr_uncore_raw_format_group
+
+static struct intel_uncore_type spr_uncore_irp = {
+	SPR_UNCORE_COMMON_FORMAT(),
+	.name			= "irp",
+
+};
+
 #define UNCORE_SPR_NUM_UNCORE_TYPES		12
 
 static struct intel_uncore_type *spr_uncores[UNCORE_SPR_NUM_UNCORE_TYPES] = {
 	&spr_uncore_chabox,
 	&spr_uncore_iio,
-	NULL,
+	&spr_uncore_irp,
 	NULL,
 	NULL,
 	NULL,
