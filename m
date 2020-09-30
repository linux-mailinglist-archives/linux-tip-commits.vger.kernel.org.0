Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A86C27F221
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Sep 2020 21:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbgI3S67 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Sep 2020 14:58:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58866 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731029AbgI3S66 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Sep 2020 14:58:58 -0400
Date:   Wed, 30 Sep 2020 18:58:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601492336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qDtetnlJ+/6JjqID8WUvIBkPZ0RC04dg3/HDORbi914=;
        b=ot82F4g3KIGwXIzIECtz+qt95UKOlyRymRn9Inv9FAQ3/2xyLii8DSnfOBuUQ72weL7SEf
        Zwt/TzfgymY3UY7dGnpQPM6kJVm9NAyx4AKmXwMplmthi97g2Wu2FF+V8nwuWGXp251rny
        8iVgSIrXlOQErj3DkYPXjXFqoDBbnPd6qwJVkS/TCZHZT9Os/5j/j/Cy+5xgg0U9xQayd7
        6WRrZrQuLOgwnKR1RfII1TVFkRJv0YOtZxODCfQwy8jV9IH0jxMf5KPRT4RQFOj7cLe2nc
        yhWa0fY+CPWYbCTzIfqXnQnDwk+Eq4wUXNZJBR9rplswB7L8+OaV9js0weUrBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601492336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qDtetnlJ+/6JjqID8WUvIBkPZ0RC04dg3/HDORbi914=;
        b=hUmlZtFsLmej2mpTHfJb0U+lpZJQzvzqNlC8PjpaUZhM+PE3AWB2hGkqR2q1yN7B3JOhoM
        cZswgvEr+Nw5ghDw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Update Ice Lake uncore units
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200925134905.8839-2-kan.liang@linux.intel.com>
References: <20200925134905.8839-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160149233519.7002.671960374835824909.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8f5d41f3a0f495435c88ebba8fc150c931c10fef
Gitweb:        https://git.kernel.org/tip/8f5d41f3a0f495435c88ebba8fc150c931c10fef
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 25 Sep 2020 06:49:04 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 29 Sep 2020 09:57:01 +02:00

perf/x86/intel/uncore: Update Ice Lake uncore units

There are some updates for the Icelake model specific uncore performance
monitors. (The update can be found at 10th generation intel core
processors families specification update Revision 004, ICL068)

1) Counter 0 of ARB uncore unit is not available for software use
2) The global 'enable bit' (bit 29) and 'freeze bit' (bit 31) of
   MSR_UNC_PERF_GLOBAL_CTRL cannot be used to control counter behavior.
   Needs to use local enable in event select MSR.

Accessing the modified bit/registers will be ignored by HW. Users may
observe inaccurate results with the current code.

The changes of the MSR_UNC_PERF_GLOBAL_CTRL imply that groups cannot be
read atomically anymore. Although the error of the result for a group
becomes a bit bigger, it still far lower than not using a group. The
group support is still kept. Only Remove the *_box() related
implementation.

Since the counter 0 of ARB uncore unit is not available, update the MSR
address for the ARB uncore unit.

There is no change for IMC uncore unit, which only include free-running
counters.

Fixes: 6e394376ee89 ("perf/x86/intel/uncore: Add Intel Icelake uncore support")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200925134905.8839-2-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snb.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index d2d43b6..2bdfcf8 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -126,6 +126,10 @@
 #define ICL_UNC_CBO_0_PER_CTR0			0x702
 #define ICL_UNC_CBO_MSR_OFFSET			0x8
 
+/* ICL ARB register */
+#define ICL_UNC_ARB_PER_CTR			0x3b1
+#define ICL_UNC_ARB_PERFEVTSEL			0x3b3
+
 DEFINE_UNCORE_FORMAT_ATTR(event, event, "config:0-7");
 DEFINE_UNCORE_FORMAT_ATTR(umask, umask, "config:8-15");
 DEFINE_UNCORE_FORMAT_ATTR(edge, edge, "config:18");
@@ -313,6 +317,12 @@ void skl_uncore_cpu_init(void)
 	snb_uncore_arb.ops = &skl_uncore_msr_ops;
 }
 
+static struct intel_uncore_ops icl_uncore_msr_ops = {
+	.disable_event	= snb_uncore_msr_disable_event,
+	.enable_event	= snb_uncore_msr_enable_event,
+	.read_counter	= uncore_msr_read_counter,
+};
+
 static struct intel_uncore_type icl_uncore_cbox = {
 	.name		= "cbox",
 	.num_counters   = 4,
@@ -321,7 +331,7 @@ static struct intel_uncore_type icl_uncore_cbox = {
 	.event_ctl	= SNB_UNC_CBO_0_PERFEVTSEL0,
 	.event_mask	= SNB_UNC_RAW_EVENT_MASK,
 	.msr_offset	= ICL_UNC_CBO_MSR_OFFSET,
-	.ops		= &skl_uncore_msr_ops,
+	.ops		= &icl_uncore_msr_ops,
 	.format_group	= &snb_uncore_format_group,
 };
 
@@ -350,13 +360,25 @@ static struct intel_uncore_type icl_uncore_clockbox = {
 	.single_fixed	= 1,
 	.event_mask	= SNB_UNC_CTL_EV_SEL_MASK,
 	.format_group	= &icl_uncore_clock_format_group,
-	.ops		= &skl_uncore_msr_ops,
+	.ops		= &icl_uncore_msr_ops,
 	.event_descs	= icl_uncore_events,
 };
 
+static struct intel_uncore_type icl_uncore_arb = {
+	.name		= "arb",
+	.num_counters   = 1,
+	.num_boxes	= 1,
+	.perf_ctr_bits	= 44,
+	.perf_ctr	= ICL_UNC_ARB_PER_CTR,
+	.event_ctl	= ICL_UNC_ARB_PERFEVTSEL,
+	.event_mask	= SNB_UNC_RAW_EVENT_MASK,
+	.ops		= &icl_uncore_msr_ops,
+	.format_group	= &snb_uncore_format_group,
+};
+
 static struct intel_uncore_type *icl_msr_uncores[] = {
 	&icl_uncore_cbox,
-	&snb_uncore_arb,
+	&icl_uncore_arb,
 	&icl_uncore_clockbox,
 	NULL,
 };
@@ -374,7 +396,6 @@ void icl_uncore_cpu_init(void)
 {
 	uncore_msr_uncores = icl_msr_uncores;
 	icl_uncore_cbox.num_boxes = icl_get_cbox_num();
-	snb_uncore_arb.ops = &skl_uncore_msr_ops;
 }
 
 static struct intel_uncore_type *tgl_msr_uncores[] = {
