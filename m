Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B12278724
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Sep 2020 14:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgIYMYH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 25 Sep 2020 08:24:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55990 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbgIYMX6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 25 Sep 2020 08:23:58 -0400
Date:   Fri, 25 Sep 2020 12:23:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601036637;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Q7/UDL5RjweAxfZfgdf5yt0ntIEvbyIwQ0RYipWXXE=;
        b=psZjILGClxPc1Xpm9pU7ujGrq8Xfh6S2z/BAjKSo7i6wkyPUv/+OR7d07GilbCkXA06PAx
        RkRWSZWNFqtSIRO2PDylx9uFcNqnbDRkl5N0zXgElc/ODLP6byG/fMAIWXs5pZOl0M8Tya
        Duy8CRUoO5lLPOEmVnLJ/ydZhp8ilyHal6/OciyzMNur3L1YFljWdM9JEdXdpKoIDW8hNe
        QAQdMWvb69ZnICjFa+00DXevIAwWpL4tog6SzNbDKWs6c7+Stc8N3Wq8FyShIXkPkVZZ+I
        4e9ucpI8H226yxdpH1IpV/LML6GwRn450D5ch2YfQ++Jn9IjK6p4Y/c2nSLA/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601036637;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Q7/UDL5RjweAxfZfgdf5yt0ntIEvbyIwQ0RYipWXXE=;
        b=t+J3zWQgIzIPU1SFZ8IH/Ty5ZdcdhUlOm8MMfQiMwpfbAby2sAWDWVClQaSBiyHSoARU69
        ko3Qn8OxUEb8/tCQ==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/uncore: Allow F17h user threadmask and
 slicemask specification
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200921144330.6331-3-kim.phillips@amd.com>
References: <20200921144330.6331-3-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <160103663627.7002.6693865457344797253.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8170f386f19ca7120393c957d4bfbdc07f964ab6
Gitweb:        https://git.kernel.org/tip/8170f386f19ca7120393c957d4bfbdc07f964ab6
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Mon, 21 Sep 2020 09:43:28 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Sep 2020 15:55:49 +02:00

perf/amd/uncore: Allow F17h user threadmask and slicemask specification

Continue to fully populate either one of threadmask or slicemask if the
user doesn't.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200921144330.6331-3-kim.phillips@amd.com
---
 arch/x86/events/amd/uncore.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 15c7982..1e35c93 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -181,13 +181,14 @@ static void amd_uncore_del(struct perf_event *event, int flags)
 }
 
 /*
- * Return a full thread and slice mask until per-CPU is
- * properly supported.
+ * Return a full thread and slice mask unless user
+ * has provided them
  */
-static u64 l3_thread_slice_mask(void)
+static u64 l3_thread_slice_mask(u64 config)
 {
 	if (boot_cpu_data.x86 <= 0x18)
-		return AMD64_L3_SLICE_MASK | AMD64_L3_THREAD_MASK;
+		return ((config & AMD64_L3_SLICE_MASK) ? : AMD64_L3_SLICE_MASK) |
+		       ((config & AMD64_L3_THREAD_MASK) ? : AMD64_L3_THREAD_MASK);
 
 	return AMD64_L3_EN_ALL_SLICES | AMD64_L3_EN_ALL_CORES |
 	       AMD64_L3_F19H_THREAD_MASK;
@@ -220,7 +221,7 @@ static int amd_uncore_event_init(struct perf_event *event)
 	 * For other events, the two fields do not affect the count.
 	 */
 	if (l3_mask && is_llc_event(event))
-		hwc->config |= l3_thread_slice_mask();
+		hwc->config |= l3_thread_slice_mask(event->attr.config);
 
 	uncore = event_to_amd_uncore(event);
 	if (!uncore)
@@ -277,6 +278,8 @@ DEFINE_UNCORE_FORMAT_ATTR(event12,	event,		"config:0-7,32-35");
 DEFINE_UNCORE_FORMAT_ATTR(event14,	event,		"config:0-7,32-35,59-60"); /* F17h+ DF */
 DEFINE_UNCORE_FORMAT_ATTR(event8,	event,		"config:0-7");		   /* F17h+ L3 */
 DEFINE_UNCORE_FORMAT_ATTR(umask,	umask,		"config:8-15");
+DEFINE_UNCORE_FORMAT_ATTR(slicemask,	slicemask,	"config:48-51");	   /* F17h L3 */
+DEFINE_UNCORE_FORMAT_ATTR(threadmask8,	threadmask,	"config:56-63");	   /* F17h L3 */
 
 static struct attribute *amd_uncore_df_format_attr[] = {
 	&format_attr_event12.attr, /* event14 if F17h+ */
@@ -287,6 +290,8 @@ static struct attribute *amd_uncore_df_format_attr[] = {
 static struct attribute *amd_uncore_l3_format_attr[] = {
 	&format_attr_event12.attr, /* event8 if F17h+ */
 	&format_attr_umask.attr,
+	NULL, /* slicemask if F17h */
+	NULL, /* threadmask8 if F17h */
 	NULL,
 };
 
@@ -578,8 +583,12 @@ static int __init amd_uncore_init(void)
 	}
 
 	if (boot_cpu_has(X86_FEATURE_PERFCTR_LLC)) {
-		if (boot_cpu_data.x86 >= 0x17)
-			*l3_attr = &format_attr_event8.attr;
+		if (boot_cpu_data.x86 >= 0x17) {
+			*l3_attr++ = &format_attr_event8.attr;
+			*l3_attr++ = &format_attr_umask.attr;
+			*l3_attr++ = &format_attr_slicemask.attr;
+			*l3_attr++ = &format_attr_threadmask8.attr;
+		}
 
 		amd_uncore_llc = alloc_percpu(struct amd_uncore *);
 		if (!amd_uncore_llc) {
