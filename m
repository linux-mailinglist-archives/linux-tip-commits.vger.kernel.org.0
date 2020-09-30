Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B3727F21A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Sep 2020 21:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbgI3S65 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Sep 2020 14:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730476AbgI3S6z (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Sep 2020 14:58:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92188C0613D1;
        Wed, 30 Sep 2020 11:58:55 -0700 (PDT)
Date:   Wed, 30 Sep 2020 18:58:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601492334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FvxkwoYe/ikrRdoPApLjbZFet3575658A3GTFYOz5rI=;
        b=0JBTg1PiybeJR/+QyxCcHlIGDdjDYaRdag9AHY0jBFQyRa6GIMBq9dDO1F6m5KG0jjx46I
        uhO5j9rBND4LDtHvsXkHVCvQoOciLwWHtW3/NbDPuPzaOVUsSfMXaoqTFPhr0NGMMNSEnn
        RrnpHmOHjCpKj9my3UEF05w+174jw6G5hUtSu8Ry7Eoin0VFln61b7ayx9M0HMnBtzuobB
        TqWxoG6a/9cBHKY/OHGWqHX7nyVhKKKK1+a9ORg15TFtmhajyyqF273KXy7ruWGVff3fLm
        SoAyIIirpsle6XkeEGUJMkPPDk4Zn1VKhVMSLNxiQ699PDNJYiMcPT01OfGvhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601492334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FvxkwoYe/ikrRdoPApLjbZFet3575658A3GTFYOz5rI=;
        b=8CRo5UJaeNpdmk1lKcGBYLZyKagwdsY9dl0X1zNapGwy846qavCTJ4/jo3k8M9kvcXv2TV
        YVDyE3Oxm+7ce6Cg==
From:   "tip-bot2 for Alexander Antonov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Fix for iio mapping on Skylake Server
Cc:     Kyle Meyer <kyle.meyer@hpe.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexei Budankov <alexey.budankov@linux.intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200928102133.61041-1-alexander.antonov@linux.intel.com>
References: <20200928102133.61041-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160149233331.7002.10919231011379055356.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f797f05d917ffef94249ee0aec4c14a5b50517b2
Gitweb:        https://git.kernel.org/tip/f797f05d917ffef94249ee0aec4c14a5b50517b2
Author:        Alexander Antonov <alexander.antonov@linux.intel.com>
AuthorDate:    Mon, 28 Sep 2020 13:21:33 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 29 Sep 2020 09:57:02 +02:00

perf/x86/intel/uncore: Fix for iio mapping on Skylake Server

Introduced early attributes /sys/devices/uncore_iio_<pmu_idx>/die* are
initialized by skx_iio_set_mapping(), however, for example, for multiple
segment platforms skx_iio_get_topology() returns -EPERM before a list of
attributes in skx_iio_mapping_group will have been initialized.
As a result the list is being NULL. Thus the warning
"sysfs: (bin_)attrs not set by subsystem for group: uncore_iio_*/" appears
and uncore_iio pmus are not available in sysfs. Clear IIO attr_update
to properly handle the cases when topology information cannot be
retrieved.

Fixes: bb42b3d39781 ("perf/x86/intel/uncore: Expose an Uncore unit to IIO PMON mapping")
Reported-by: Kyle Meyer <kyle.meyer@hpe.com>
Suggested-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Alexei Budankov <alexey.budankov@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lkml.kernel.org/r/20200928102133.61041-1-alexander.antonov@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 495056f..3f1e75f 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3754,7 +3754,9 @@ static int skx_iio_set_mapping(struct intel_uncore_type *type)
 
 	ret = skx_iio_get_topology(type);
 	if (ret)
-		return ret;
+		goto clear_attr_update;
+
+	ret = -ENOMEM;
 
 	/* One more for NULL. */
 	attrs = kcalloc((uncore_max_dies() + 1), sizeof(*attrs), GFP_KERNEL);
@@ -3786,8 +3788,9 @@ err:
 	kfree(eas);
 	kfree(attrs);
 	kfree(type->topology);
+clear_attr_update:
 	type->attr_update = NULL;
-	return -ENOMEM;
+	return ret;
 }
 
 static void skx_iio_cleanup_mapping(struct intel_uncore_type *type)
