Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF8E292D07
	for <lists+linux-tip-commits@lfdr.de>; Mon, 19 Oct 2020 19:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgJSRop (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 19 Oct 2020 13:44:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33174 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgJSRop (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 19 Oct 2020 13:44:45 -0400
Date:   Mon, 19 Oct 2020 17:44:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603129483;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5mjSGryX3vSNb47lPps7fktM/hIU6q64W5ctVkJiukQ=;
        b=udLRbdJI38yDtSB1f4RKF/piNy79MFSmaz5ZR0kxEDH8rbdse/BSWqDzMz/H5Lie1DMYxW
        hl5VPaL+0Cwz7pGm4OEZbz/DF8V/pr+3m/AboL56p1jEaAEryvZkPFRmG1E1e4DBzKkOA3
        s7jXWg3Uc+QAuM/LDet9DAWHJxoX5GhkLkKdzVRTd3H72MQHn5Pg1TfwPx9sp8nJcEJTqt
        1uppzafLmmprC3Kk9UqI+V9stJc5wPFA9qqrxGis12alFH0fYCz46iLaa+2kNU9DCdXas+
        BWwYF38M6fG8SZ4RBnpuONHttcidCkAXryww2dVHzYZFDfPtzKl/NzR0HiCrqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603129483;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5mjSGryX3vSNb47lPps7fktM/hIU6q64W5ctVkJiukQ=;
        b=a+DpWjQAWk31kuTbHYeskxUp1d3H/Np3SXwcI4+yZjhdEHAIdbPzMo0k9XlLZ419no0nb+
        LjEEnx7xAlkh8EDA==
From:   "tip-bot2 for Al Grant" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: correct SNOOPX field offset
Cc:     Al Grant <al.grant@foss.arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <4ac9f5cc-4388-b34a-9999-418a4099415d@foss.arm.com>
References: <4ac9f5cc-4388-b34a-9999-418a4099415d@foss.arm.com>
MIME-Version: 1.0
Message-ID: <160312948187.7002.13059882687948612179.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     f3d301c1f2f5676465cdf3259737ea19cc82731f
Gitweb:        https://git.kernel.org/tip/f3d301c1f2f5676465cdf3259737ea19cc82731f
Author:        Al Grant <al.grant@foss.arm.com>
AuthorDate:    Mon, 21 Sep 2020 21:46:37 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 19 Oct 2020 19:39:22 +02:00

perf: correct SNOOPX field offset

perf_event.h has macros that define the field offsets in the
data_src bitmask in perf records. The SNOOPX and REMOTE offsets
were both 37. These are distinct fields, and the bitfield layout
in perf_mem_data_src confirms that SNOOPX should be at offset 38.

Fixes: 52839e653b5629bd ("perf tools: Add support for printing new mem_info encodings")
Signed-off-by: Al Grant <al.grant@foss.arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/4ac9f5cc-4388-b34a-9999-418a4099415d@foss.arm.com
---
 include/uapi/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 077e7ee..b95d3c4 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1196,7 +1196,7 @@ union perf_mem_data_src {
 
 #define PERF_MEM_SNOOPX_FWD	0x01 /* forward */
 /* 1 free */
-#define PERF_MEM_SNOOPX_SHIFT	37
+#define PERF_MEM_SNOOPX_SHIFT  38
 
 /* locked instruction */
 #define PERF_MEM_LOCK_NA	0x01 /* not available */
