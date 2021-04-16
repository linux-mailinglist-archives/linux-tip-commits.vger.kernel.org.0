Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA4536235F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 17:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245419AbhDPPCY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 11:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245426AbhDPPCT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 11:02:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B56C06175F;
        Fri, 16 Apr 2021 08:01:54 -0700 (PDT)
Date:   Fri, 16 Apr 2021 15:01:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618585312;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DlzVX2fhLUy3xZ9Be6klVEUbzVNRxaacdmIxX7a81Jc=;
        b=c48p89HScVFCw+fQQ2rweBO3R00LQK94v3PpoOfxa/4ybPynaogVJFdURPNmAfk+K2/lOR
        rmiqnci+vOhe1YKezagSkL7/fQT9AMTxqiT/SSmslJeDEEp0NBg3YM6zq5anyaJR5S9muZ
        3L9PfHQrvEuZ+l0jZeunP67XS80O/1/HTtkFhNsPHgXvJlKRv0ZGAcgDEtLfIZCKrrfMp2
        EQMdRjZqN67rpv4k74lYdrqMRrKXpGvSAiIlDdinumBjPkFXcLNR7j++mG/Z3jyB0GTWq2
        adbPC9VNeYOo84zQEIMrfsuaHncEdPNgYSi0hmTEZGibmFrP/1TRbTYHACAp9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618585312;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DlzVX2fhLUy3xZ9Be6klVEUbzVNRxaacdmIxX7a81Jc=;
        b=uwftFF/oM68fV8wNYfEA7qVotynBVPOAmbHTgqmj4Zb6rbXh9zFo5zP7VuTl8/I4dKIu31
        rYeX2KU4G+h8HkCg==
From:   "tip-bot2 for Alexander Shishkin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf intel-pt: Use aux_watermark
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210414154955.49603-3-alexander.shishkin@linux.intel.com>
References: <20210414154955.49603-3-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161858531224.29796.4660387647259409979.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     874fc35cdd55e2d46161901de43ec58ca2efc5fe
Gitweb:        https://git.kernel.org/tip/874fc35cdd55e2d46161901de43ec58ca2efc5fe
Author:        Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate:    Wed, 14 Apr 2021 18:49:55 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Apr 2021 16:32:39 +02:00

perf intel-pt: Use aux_watermark

Turns out, the default setting of attr.aux_watermark to half of the total
buffer size is not very useful, especially with smaller buffers. The
problem is that, after half of the buffer is filled up, the kernel updates
->aux_head and sets up the next "transaction", while observing that
->aux_tail is still zero (as userspace haven't had the chance to update
it), meaning that the trace will have to stop at the end of this second
"transaction". This means, for example, that the second PERF_RECORD_AUX in
every trace comes with TRUNCATED flag set.

Setting attr.aux_watermark to quarter of the buffer gives enough space for
the ->aux_tail update to be observed and prevents the data loss.

The obligatory before/after showcase:

> # perf_before record -e intel_pt//u -m,8 uname
> Linux
> [ perf record: Woken up 6 times to write data ]
> Warning:
> AUX data lost 4 times out of 10!
>
> [ perf record: Captured and wrote 0.099 MB perf.data ]
> # perf record -e intel_pt//u -m,8 uname
> Linux
> [ perf record: Woken up 4 times to write data ]
> [ perf record: Captured and wrote 0.039 MB perf.data ]

The effect is still visible with large workloads and large buffers,
although less pronounced.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210414154955.49603-3-alexander.shishkin@linux.intel.com
---
 tools/perf/arch/x86/util/intel-pt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index a6420c6..6df0dc0 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -776,6 +776,12 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 		}
 	}
 
+	if (!opts->auxtrace_snapshot_mode && !opts->auxtrace_sample_mode) {
+		u32 aux_watermark = opts->auxtrace_mmap_pages * page_size / 4;
+
+		intel_pt_evsel->core.attr.aux_watermark = aux_watermark;
+	}
+
 	intel_pt_parse_terms(intel_pt_pmu->name, &intel_pt_pmu->format,
 			     "tsc", &tsc_bit);
 
