Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E635927871C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Sep 2020 14:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgIYMYI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 25 Sep 2020 08:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgIYMX6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 25 Sep 2020 08:23:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383E3C0613CE;
        Fri, 25 Sep 2020 05:23:58 -0700 (PDT)
Date:   Fri, 25 Sep 2020 12:23:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601036636;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SPQvG9xdnsW8uyT04cdK5DRW6/EmrNg3pcHVicCVSqE=;
        b=Fpg4EiW5KxIXJBwOuYeD7y/qxxLgJwkutIhJtJ7u8hDfWmmnDcdKhtARF47S35mTDIrFQG
        6hw7tqqxNKXF3iBbjQwoV5LE5t6y3ttLQd7c99KreHBiyXuK7Y7A9ixPXUlNM8p+CnvlM0
        jVUKCEXNAXk4R8IoVkCWqevHHX3wzNzKo/QewEi053I+u2gDEy3+BCwyOfDYp7Wvu/XHtp
        LphZEuOYlFWToo0yASTMUUjHA7gH2YQYM9Jvsf6kiVQyUF271pLTr29WpeHdnKeuWOi6fQ
        Nvd0FbzNJmJnM0hbIljk7qJGCXxBGgewOHsrtoy9cNjNxuqTOTf/q37KnolAPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601036636;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SPQvG9xdnsW8uyT04cdK5DRW6/EmrNg3pcHVicCVSqE=;
        b=ZZqm7l62KkgyqPVkJNRfizhez9y3ENImzE4k2GM69MKt2TDB5XiZEVd4PoxRsTiOA+GhS1
        1WBsEprm2lOU22Dg==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/uncore: Allow F19h user coreid, threadmask,
 and sliceid specification
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200921144330.6331-4-kim.phillips@amd.com>
References: <20200921144330.6331-4-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <160103663580.7002.1447188278435630162.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     87a54a1fd525f2af8d82becf583c7e836918cf22
Gitweb:        https://git.kernel.org/tip/87a54a1fd525f2af8d82becf583c7e836918cf22
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Mon, 21 Sep 2020 09:43:29 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Sep 2020 15:55:50 +02:00

perf/amd/uncore: Allow F19h user coreid, threadmask, and sliceid specification

On Family 19h, the driver checks for a populated 2-bit threadmask in
order to establish that the user wants to measure individual slices,
individual cores (only one can be measured at a time), and lets
the user also directly specify enallcores and/or enallslices if
desired.

Example F19h invocation to measure L3 accesses (event 4, umask 0xff)
by the first thread (id 0 -> mask 0x1) of the first core (id 0) on the
first slice (id 0):

perf stat -a -e instructions,amd_l3/umask=0xff,event=0x4,coreid=0,threadmask=1,sliceid=0,enallcores=0,enallslices=0/ <workload>

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200921144330.6331-4-kim.phillips@amd.com
---
 arch/x86/events/amd/uncore.c | 37 ++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 1e35c93..f026715 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -190,8 +190,19 @@ static u64 l3_thread_slice_mask(u64 config)
 		return ((config & AMD64_L3_SLICE_MASK) ? : AMD64_L3_SLICE_MASK) |
 		       ((config & AMD64_L3_THREAD_MASK) ? : AMD64_L3_THREAD_MASK);
 
-	return AMD64_L3_EN_ALL_SLICES | AMD64_L3_EN_ALL_CORES |
-	       AMD64_L3_F19H_THREAD_MASK;
+	/*
+	 * If the user doesn't specify a threadmask, they're not trying to
+	 * count core 0, so we enable all cores & threads.
+	 * We'll also assume that they want to count slice 0 if they specify
+	 * a threadmask and leave sliceid and enallslices unpopulated.
+	 */
+	if (!(config & AMD64_L3_F19H_THREAD_MASK))
+		return AMD64_L3_F19H_THREAD_MASK | AMD64_L3_EN_ALL_SLICES |
+		       AMD64_L3_EN_ALL_CORES;
+
+	return config & (AMD64_L3_F19H_THREAD_MASK | AMD64_L3_SLICEID_MASK |
+			 AMD64_L3_EN_ALL_CORES | AMD64_L3_EN_ALL_SLICES |
+			 AMD64_L3_COREID_MASK);
 }
 
 static int amd_uncore_event_init(struct perf_event *event)
@@ -278,8 +289,13 @@ DEFINE_UNCORE_FORMAT_ATTR(event12,	event,		"config:0-7,32-35");
 DEFINE_UNCORE_FORMAT_ATTR(event14,	event,		"config:0-7,32-35,59-60"); /* F17h+ DF */
 DEFINE_UNCORE_FORMAT_ATTR(event8,	event,		"config:0-7");		   /* F17h+ L3 */
 DEFINE_UNCORE_FORMAT_ATTR(umask,	umask,		"config:8-15");
+DEFINE_UNCORE_FORMAT_ATTR(coreid,	coreid,		"config:42-44");	   /* F19h L3 */
 DEFINE_UNCORE_FORMAT_ATTR(slicemask,	slicemask,	"config:48-51");	   /* F17h L3 */
 DEFINE_UNCORE_FORMAT_ATTR(threadmask8,	threadmask,	"config:56-63");	   /* F17h L3 */
+DEFINE_UNCORE_FORMAT_ATTR(threadmask2,	threadmask,	"config:56-57");	   /* F19h L3 */
+DEFINE_UNCORE_FORMAT_ATTR(enallslices,	enallslices,	"config:46");		   /* F19h L3 */
+DEFINE_UNCORE_FORMAT_ATTR(enallcores,	enallcores,	"config:47");		   /* F19h L3 */
+DEFINE_UNCORE_FORMAT_ATTR(sliceid,	sliceid,	"config:48-50");	   /* F19h L3 */
 
 static struct attribute *amd_uncore_df_format_attr[] = {
 	&format_attr_event12.attr, /* event14 if F17h+ */
@@ -290,8 +306,11 @@ static struct attribute *amd_uncore_df_format_attr[] = {
 static struct attribute *amd_uncore_l3_format_attr[] = {
 	&format_attr_event12.attr, /* event8 if F17h+ */
 	&format_attr_umask.attr,
-	NULL, /* slicemask if F17h */
-	NULL, /* threadmask8 if F17h */
+	NULL, /* slicemask if F17h,	coreid if F19h */
+	NULL, /* threadmask8 if F17h,	enallslices if F19h */
+	NULL, /*			enallcores if F19h */
+	NULL, /*			sliceid if F19h */
+	NULL, /*			threadmask2 if F19h */
 	NULL,
 };
 
@@ -583,7 +602,15 @@ static int __init amd_uncore_init(void)
 	}
 
 	if (boot_cpu_has(X86_FEATURE_PERFCTR_LLC)) {
-		if (boot_cpu_data.x86 >= 0x17) {
+		if (boot_cpu_data.x86 >= 0x19) {
+			*l3_attr++ = &format_attr_event8.attr;
+			*l3_attr++ = &format_attr_umask.attr;
+			*l3_attr++ = &format_attr_coreid.attr;
+			*l3_attr++ = &format_attr_enallslices.attr;
+			*l3_attr++ = &format_attr_enallcores.attr;
+			*l3_attr++ = &format_attr_sliceid.attr;
+			*l3_attr++ = &format_attr_threadmask2.attr;
+		} else if (boot_cpu_data.x86 >= 0x17) {
 			*l3_attr++ = &format_attr_event8.attr;
 			*l3_attr++ = &format_attr_umask.attr;
 			*l3_attr++ = &format_attr_slicemask.attr;
