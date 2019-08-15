Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDD28E802
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Aug 2019 11:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbfHOJUs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 15 Aug 2019 05:20:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37261 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730212AbfHOJUr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 15 Aug 2019 05:20:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9KCbR2270870
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:20:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9KCbR2270870
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565860812;
        bh=FSn2rJARg+UoGumArUbvHVJGLugOBxP6bBonFby8xao=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=zAfvpVLi5i9utzjEXsa9s2+6StM1FWyMZD0Mug1RjmGls7oXu8K0ckv8QTMhvBvrX
         oWwJefPgp/p8YU1VNy9ZH3UL6r6KU7Z9TeK0nuO0oKp0p6BVXDaeltjo78PY1JQL3W
         VquHlJ7iDf1xJmJDDeXmui0u4TLB9KW/pZuMOrTs0k4fSilqaif9eDrURxY00bPfB9
         vtN64YdjBeDE029wneE1QWTTx4iJ8k2IYzz/ZBrTaGVWCkWRqurMrU1OkZlfSpMI0g
         Wb3BCC3u2heA+Ydml9nxMMfDFvtv3YzrGvUvGHwz6xFv/Mtrd5KOt40nV6fAckBuIF
         UXwEfI7d0hT4Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9KBpJ2270867;
        Thu, 15 Aug 2019 02:20:11 -0700
Date:   Thu, 15 Aug 2019 02:20:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Haiyan Song <tipbot@zytor.com>
Message-ID: <tip-b115df076d337a727017538d11d7d46f5bcbff15@git.kernel.org>
Cc:     yao.jin@intel.com, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@linux.intel.com,
        haiyanx.song@intel.com, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, peterz@infradead.org, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com
Reply-To: tglx@linutronix.de, jolsa@kernel.org, ak@linux.intel.com,
          hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
          acme@redhat.com, alexander.shishkin@linux.intel.com,
          peterz@infradead.org, kan.liang@linux.intel.com,
          haiyanx.song@intel.com, yao.jin@intel.com
In-Reply-To: <8859095e-5b02-d6b7-fbdc-3f42b714bae0@intel.com>
References: <8859095e-5b02-d6b7-fbdc-3f42b714bae0@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events intel: Add Icelake V1.00 event
 file
Git-Commit-ID: b115df076d337a727017538d11d7d46f5bcbff15
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Commit-ID:  b115df076d337a727017538d11d7d46f5bcbff15
Gitweb:     https://git.kernel.org/tip/b115df076d337a727017538d11d7d46f5bcbff15
Author:     Haiyan Song <haiyanx.song@intel.com>
AuthorDate: Wed, 12 Jun 2019 16:15:42 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 12 Aug 2019 16:26:02 -0300

perf vendor events intel: Add Icelake V1.00 event file

Add a Intel event file for perf.

Signed-off-by: Haiyan Song <haiyanx.song@intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/8859095e-5b02-d6b7-fbdc-3f42b714bae0@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/x86/icelake/cache.json  | 552 +++++++++++++
 .../arch/x86/icelake/floating-point.json           | 102 +++
 .../perf/pmu-events/arch/x86/icelake/frontend.json | 424 ++++++++++
 tools/perf/pmu-events/arch/x86/icelake/memory.json | 410 ++++++++++
 tools/perf/pmu-events/arch/x86/icelake/other.json  | 121 +++
 .../perf/pmu-events/arch/x86/icelake/pipeline.json | 892 +++++++++++++++++++++
 .../arch/x86/icelake/virtual-memory.json           | 236 ++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv         |   2 +
 8 files changed, 2739 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/icelake/cache.json b/tools/perf/pmu-events/arch/x86/icelake/cache.json
new file mode 100644
index 000000000000..3529fc338c17
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/icelake/cache.json
@@ -0,0 +1,552 @@
+[
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of demand Data Read requests that miss L2 cache. Only not rejected loads are counted.",
+        "EventCode": "0x24",
+        "Counter": "0,1,2,3",
+        "UMask": "0x21",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Demand Data Read miss L2, no rejects"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests that miss L2 cache.",
+        "EventCode": "0x24",
+        "Counter": "0,1,2,3",
+        "UMask": "0x22",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "L2_RQSTS.RFO_MISS",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "RFO requests that miss L2 cache"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts L2 cache misses when fetching instructions.",
+        "EventCode": "0x24",
+        "Counter": "0,1,2,3",
+        "UMask": "0x24",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "L2_RQSTS.CODE_RD_MISS",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "L2 cache misses when fetching instructions"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts demand requests that miss L2 cache.",
+        "EventCode": "0x24",
+        "Counter": "0,1,2,3",
+        "UMask": "0x27",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "L2_RQSTS.ALL_DEMAND_MISS",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Demand requests that miss L2 cache"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts Software prefetch requests that miss the L2 cache. This event accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions.",
+        "EventCode": "0x24",
+        "Counter": "0,1,2,3",
+        "UMask": "0x28",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "L2_RQSTS.SWPF_MISS",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "SW prefetch requests that miss L2 cache."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of demand Data Read requests initiated by load instructions that hit L2 cache.",
+        "EventCode": "0x24",
+        "Counter": "0,1,2,3",
+        "UMask": "0xc1",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Demand Data Read requests that hit L2 cache"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the RFO (Read-for-Ownership) requests that hit L2 cache.",
+        "EventCode": "0x24",
+        "Counter": "0,1,2,3",
+        "UMask": "0xc2",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "L2_RQSTS.RFO_HIT",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "RFO requests that hit L2 cache"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts L2 cache hits when fetching instructions, code reads.",
+        "EventCode": "0x24",
+        "Counter": "0,1,2,3",
+        "UMask": "0xc4",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "L2_RQSTS.CODE_RD_HIT",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "L2 cache hits when fetching instructions, code reads."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts Software prefetch requests that hit the L2 cache. This event accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions.",
+        "EventCode": "0x24",
+        "Counter": "0,1,2,3",
+        "UMask": "0xc8",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "L2_RQSTS.SWPF_HIT",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "SW prefetch requests that hit L2 cache."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of demand Data Read requests (including requests from L1D hardware prefetchers). These loads may hit or miss L2 cache. Only non rejected loads are counted.",
+        "EventCode": "0x24",
+        "Counter": "0,1,2,3",
+        "UMask": "0xe1",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Demand Data Read requests"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the total number of RFO (read for ownership) requests to L2 cache. L2 RFO requests include both L1D demand RFO misses as well as L1D RFO prefetches.",
+        "EventCode": "0x24",
+        "Counter": "0,1,2,3",
+        "UMask": "0xe2",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "L2_RQSTS.ALL_RFO",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "RFO requests to L2 cache"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the total number of L2 code requests.",
+        "EventCode": "0x24",
+        "Counter": "0,1,2,3",
+        "UMask": "0xe4",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "L2_RQSTS.ALL_CODE_RD",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "L2 code requests"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts demand requests to L2 cache.",
+        "EventCode": "0x24",
+        "Counter": "0,1,2,3",
+        "UMask": "0xe7",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "L2_RQSTS.ALL_DEMAND_REFERENCES",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Demand requests to L2 cache"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts number of L1D misses that are outstanding in each cycle, that is each cycle the number of Fill Buffers (FB) outstanding required by Demand Reads. FB either is held by demand loads, or it is held by non-demand loads and gets hit at least once by demand. The valid outstanding interval is defined until the FB deallocation by one of the following ways: from FB allocation, if FB is allocated by demand from the demand Hit FB, if it is allocated by hardware or software prefetch. Note: In the L1D, a Demand Read contains cacheable or noncacheable demand loads, including ones causing cache-line splits and reads due to page walks resulted from any request type.",
+        "EventCode": "0x48",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "L1D_PEND_MISS.PENDING",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of L1D misses that are outstanding"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts duration of L1D miss outstanding in cycles.",
+        "EventCode": "0x48",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "L1D_PEND_MISS.PENDING_CYCLES",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles with L1D load Misses outstanding.",
+        "CounterMask": "1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts number of cycles a demand request has waited due to L1D Fill Buffer (FB) unavailablability. Demand requests include cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
+        "EventCode": "0x48",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "L1D_PEND_MISS.FB_FULL",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of cycles a demand request has waited due to L1D Fill Buffer (FB) unavailablability."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts number of phases a demand request has waited due to L1D Fill Buffer (FB) unavailablability. Demand requests include cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
+        "EventCode": "0x48",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "L1D_PEND_MISS.FB_FULL_PERIODS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of phases a demand request has waited due to L1D Fill Buffer (FB) unavailablability.",
+        "CounterMask": "1",
+        "EdgeDetect": "1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts number of cycles a demand request has waited due to L1D due to lack of L2 resources. Demand requests include cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
+        "EventCode": "0x48",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "L1D_PEND_MISS.L2_STALL",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of cycles a demand request has waited due to L1D due to lack of L2 resources."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts L1D data line replacements including opportunistic replacements, and replacements that require stall-for-replace or block-for-replace.",
+        "EventCode": "0x51",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "L1D.REPLACEMENT",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Counts the number of cache lines replaced in L1 data cache."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of offcore outstanding demand rfo Reads transactions in the super queue every cycle. The 'Offcore outstanding' state of the transaction lasts from the L2 miss until the sending transaction completion to requestor (SQ deallocation). See the corresponding Umask under OFFCORE_REQUESTS.",
+        "EventCode": "0x60",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles with offcore outstanding demand rfo reads transactions in SuperQueue (SQ), queue to uncore.",
+        "CounterMask": "1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of offcore outstanding cacheable Core Data Read transactions in the super queue every cycle. A transaction is considered to be in the Offcore outstanding state between L2 miss and transaction completion sent to requestor (SQ de-allocation). See corresponding Umask under OFFCORE_REQUESTS.",
+        "EventCode": "0x60",
+        "Counter": "0,1,2,3",
+        "UMask": "0x8",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Offcore outstanding cacheable Core Data Read transactions in SuperQueue (SQ), queue to uncore"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts cycles when offcore outstanding cacheable Core Data Read transactions are present in the super queue. A transaction is considered to be in the Offcore outstanding state between L2 miss and transaction completion sent to requestor (SQ de-allocation). See corresponding Umask under OFFCORE_REQUESTS.",
+        "EventCode": "0x60",
+        "Counter": "0,1,2,3",
+        "UMask": "0x8",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles when offcore outstanding cacheable Core Data Read transactions are present in SuperQueue (SQ), queue to uncore.",
+        "CounterMask": "1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the Demand Data Read requests sent to uncore. Use it in conjunction with OFFCORE_REQUESTS_OUTSTANDING to determine average latency in the uncore.",
+        "EventCode": "0xB0",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "OFFCORE_REQUESTS.DEMAND_DATA_RD",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Demand Data Read requests sent to uncore"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the demand RFO (read for ownership) requests including regular RFOs, locks, ItoM.",
+        "EventCode": "0xB0",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "OFFCORE_REQUESTS.DEMAND_RFO",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Demand RFO requests including regular RFOs, locks, ItoM"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the demand and prefetch data reads. All Core Data Reads include cacheable 'Demands' and L2 prefetchers (not L3 prefetchers). Counting also covers reads due to page walks resulted from any request type.",
+        "EventCode": "0xB0",
+        "Counter": "0,1,2,3",
+        "UMask": "0x8",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "OFFCORE_REQUESTS.ALL_DATA_RD",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Demand and prefetch data reads"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts memory transactions reached the super queue including requests initiated by the core, all L3 prefetches, page walks, etc..",
+        "EventCode": "0xB0",
+        "Counter": "0,1,2,3",
+        "UMask": "0x80",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "OFFCORE_REQUESTS.ALL_REQUESTS",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Any memory transaction that reached the SQ."
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired load instructions that true miss the STLB.",
+        "EventCode": "0xD0",
+        "Counter": "0,1,2,3",
+        "UMask": "0x11",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "MEM_INST_RETIRED.STLB_MISS_LOADS",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Retired load instructions that miss the STLB.",
+        "Data_LA": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired store instructions that true miss the STLB.",
+        "EventCode": "0xD0",
+        "Counter": "0,1,2,3",
+        "UMask": "0x12",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "MEM_INST_RETIRED.STLB_MISS_STORES",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Retired store instructions that miss the STLB.",
+        "Data_LA": "1",
+        "L1_Hit_Indication": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired load instructions with locked access.",
+        "EventCode": "0xD0",
+        "Counter": "0,1,2,3",
+        "UMask": "0x21",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "MEM_INST_RETIRED.LOCK_LOADS",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Retired load instructions with locked access.",
+        "Data_LA": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired load instructions that split across a cacheline boundary.",
+        "EventCode": "0xD0",
+        "Counter": "0,1,2,3",
+        "UMask": "0x41",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "MEM_INST_RETIRED.SPLIT_LOADS",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Retired load instructions that split across a cacheline boundary.",
+        "Data_LA": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired store instructions that split across a cacheline boundary.",
+        "EventCode": "0xD0",
+        "Counter": "0,1,2,3",
+        "UMask": "0x42",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "MEM_INST_RETIRED.SPLIT_STORES",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Retired store instructions that split across a cacheline boundary.",
+        "Data_LA": "1",
+        "L1_Hit_Indication": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts all retired load instructions. This event accounts for SW prefetch instructions for loads.",
+        "EventCode": "0xD0",
+        "Counter": "0,1,2,3",
+        "UMask": "0x81",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "MEM_INST_RETIRED.ALL_LOADS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "All retired load instructions.",
+        "Data_LA": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts all retired store instructions. This event account for SW prefetch instructions and PREFETCHW instruction for stores.",
+        "EventCode": "0xD0",
+        "Counter": "0,1,2,3",
+        "UMask": "0x82",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "MEM_INST_RETIRED.ALL_STORES",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "All retired store instructions.",
+        "Data_LA": "1",
+        "L1_Hit_Indication": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired load instructions with at least one uop that hit in the L1 data cache. This event includes all SW prefetches and lock instructions regardless of the data source.",
+        "EventCode": "0xD1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "MEM_LOAD_RETIRED.L1_HIT",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Retired load instructions with L1 cache hits as data sources",
+        "Data_LA": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired load instructions with L2 cache hits as data sources.",
+        "EventCode": "0xD1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "MEM_LOAD_RETIRED.L2_HIT",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Retired load instructions with L2 cache hits as data sources",
+        "Data_LA": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired load instructions with at least one uop that hit in the L3 cache.",
+        "EventCode": "0xD1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "MEM_LOAD_RETIRED.L3_HIT",
+        "SampleAfterValue": "50021",
+        "BriefDescription": "Retired load instructions with L3 cache hits as data sources",
+        "Data_LA": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired load instructions with at least one uop that missed in the L1 cache.",
+        "EventCode": "0xD1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x8",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "MEM_LOAD_RETIRED.L1_MISS",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Retired load instructions missed L1 cache as data sources",
+        "Data_LA": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired load instructions missed L2 cache as data sources.",
+        "EventCode": "0xD1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x10",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "MEM_LOAD_RETIRED.L2_MISS",
+        "SampleAfterValue": "50021",
+        "BriefDescription": "Retired load instructions missed L2 cache as data sources",
+        "Data_LA": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired load instructions with at least one uop that missed in the L3 cache.",
+        "EventCode": "0xD1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x20",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "MEM_LOAD_RETIRED.L3_MISS",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Retired load instructions missed L3 cache as data sources",
+        "Data_LA": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired load instructions with at least one uop was load missed in L1 but hit FB (Fill Buffers) due to preceding miss to the same cache line with data not ready.",
+        "EventCode": "0xd1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x40",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "MEM_LOAD_RETIRED.FB_HIT",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Number of completed demand load requests that missed the L1, but hit the FB(fill buffer), because a preceding miss to the same cacheline initiated the line to be brought into L1, but data is not yet ready in L1.",
+        "Data_LA": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the retired load instructions whose data sources were L3 hit and cross-core snoop missed in on-pkg core cache.",
+        "EventCode": "0xd2",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
+        "SampleAfterValue": "20011",
+        "BriefDescription": "Retired load instructions whose data sources were L3 hit and cross-core snoop missed in on-pkg core cache.",
+        "Data_LA": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired load instructions whose data sources were L3 and cross-core snoop hits in on-pkg core cache.",
+        "EventCode": "0xd2",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT",
+        "SampleAfterValue": "20011",
+        "BriefDescription": "Retired load instructions whose data sources were L3 and cross-core snoop hits in on-pkg core cache",
+        "Data_LA": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired load instructions whose data sources were HitM responses from shared L3.",
+        "EventCode": "0xd2",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM",
+        "SampleAfterValue": "20011",
+        "BriefDescription": "Retired load instructions whose data sources were HitM responses from shared L3",
+        "Data_LA": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired load instructions whose data sources were hits in L3 without snoops required.",
+        "EventCode": "0xd2",
+        "Counter": "0,1,2,3",
+        "UMask": "0x8",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NONE",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Retired load instructions whose data sources were hits in L3 without snoops required",
+        "Data_LA": "1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of L2 cache lines filling the L2. Counting does not cover rejects.",
+        "EventCode": "0xF1",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1f",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "L2_LINES_IN.ALL",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "L2 cache lines filling L2"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the cycles for which the thread is active and the superQ cannot take any more entries.",
+        "EventCode": "0xF4",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "SQ_MISC.SQ_FULL",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Cycles the thread is active and superQ cannot take any more entries."
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/icelake/floating-point.json b/tools/perf/pmu-events/arch/x86/icelake/floating-point.json
new file mode 100644
index 000000000000..594c5551f610
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/icelake/floating-point.json
@@ -0,0 +1,102 @@
+[
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts all microcode Floating Point assists.",
+        "EventCode": "0xC1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "ASSISTS.FP",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts all microcode FP assists.",
+        "CounterMask": "1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts number of SSE/AVX computational scalar double precision floating-point instructions retired; some instructions will count twice as noted below.  Each count represents 1 computational operation. Applies to SSE* and AVX* scalar double precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform 2 calculations per element.",
+        "EventCode": "0xc7",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "FP_ARITH_INST_RETIRED.SCALAR_DOUBLE",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of SSE/AVX computational scalar double precision floating-point instructions retired; some instructions will count twice as noted below.  Each count represents 1 computation. Applies to SSE* and AVX* scalar double precision floating-point instructions: ADD SUB MUL DIV MIN MAX RCP14 RSQRT14 RANGE SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform 2 calculations per element."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts number of SSE/AVX computational scalar single precision floating-point instructions retired; some instructions will count twice as noted below.  Each count represents 1 computational operation. Applies to SSE* and AVX* scalar single precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform 2 calculations per element.",
+        "EventCode": "0xc7",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "FP_ARITH_INST_RETIRED.SCALAR_SINGLE",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of SSE/AVX computational scalar single precision floating-point instructions retired; some instructions will count twice as noted below.  Each count represents 1 computation. Applies to SSE* and AVX* scalar single precision floating-point instructions: ADD SUB MUL DIV MIN MAX RCP14 RSQRT14 RANGE SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform 2 calculations per element."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts number of SSE/AVX computational 128-bit packed double precision floating-point instructions retired; some instructions will count twice as noted below.  Each count represents 2 computation operations, one for each element.  Applies to SSE* and AVX* packed double precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform 2 calculations per element.",
+        "EventCode": "0xc7",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of SSE/AVX computational 128-bit packed double precision floating-point instructions retired; some instructions will count twice as noted below.  Each count represents 2 computation operations, one for each element.  Applies to SSE* and AVX* packed double precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT RSQRT14 RCP14 RANGE DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform 2 calculations per element."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts number of SSE/AVX computational 128-bit packed single precision floating-point instructions retired; some instructions will count twice as noted below.  Each count represents 4 computation operations, one for each element.  Applies to SSE* and AVX* packed single precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform 2 calculations per element.",
+        "EventCode": "0xc7",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x8",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of SSE/AVX computational 128-bit packed single precision floating-point instructions retired; some instructions will count twice as noted below.  Each count represents 4 computation operations, one for each element.  Applies to SSE* and AVX* packed single precision floating-point instructions: ADD SUB MUL DIV MIN MAX RCP14 RSQRT14 SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform 2 calculations per element."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts number of SSE/AVX computational 256-bit packed double precision floating-point instructions retired; some instructions will count twice as noted below.  Each count represents 4 computation operations, one for each element.  Applies to SSE* and AVX* packed double precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform 2 calculations per element.",
+        "EventCode": "0xc7",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x10",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of SSE/AVX computational 256-bit packed double precision floating-point instructions retired; some instructions will count twice as noted below.  Each count represents 4 computation operations, one for each element.  Applies to SSE* and AVX* packed double precision floating-point instructions: ADD SUB MUL DIV MIN MAX RCP14 RSQRT14 RANGE SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform 2 calculations per element."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts number of SSE/AVX computational 256-bit packed single precision floating-point instructions retired; some instructions will count twice as noted below.  Each count represents 8 computation operations, one for each element.  Applies to SSE* and AVX* packed single precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX SQRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform 2 calculations per element.",
+        "EventCode": "0xc7",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x20",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of SSE/AVX computational 256-bit packed single precision floating-point instructions retired; some instructions will count twice as noted below.  Each count represents 8 computation operations, one for each element.  Applies to SSE* and AVX* packed single precision floating-point instructions: ADD SUB MUL DIV MIN MAX RCP14 RSQRT14 RANGE SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they perform 2 calculations per element."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts number of SSE/AVX computational 512-bit packed double precision floating-point instructions retired; some instructions will count twice as noted below.  Each count represents 8 computation operations, one for each element.  Applies to SSE* and AVX* packed double precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14 RCP14 RANGE FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform 2 calculations per element.",
+        "EventCode": "0xc7",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x40",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of SSE/AVX computational 512-bit packed double precision floating-point instructions retired; some instructions will count twice as noted below.  Each count represents 16 computation operations, one for each element.  Applies to SSE* and AVX* packed double precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14 RCP14 RANGE FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform 2 calculations per element."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts number of SSE/AVX computational 512-bit packed double precision floating-point instructions retired; some instructions will count twice as noted below.  Each count represents 16 computation operations, one for each element.  Applies to SSE* and AVX* packed double precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14 RCP14 RANGE FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform 2 calculations per element.",
+        "EventCode": "0xc7",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x80",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of SSE/AVX computational 512-bit packed double precision floating-point instructions retired; some instructions will count twice as noted below.  Each count represents 8 computation operations, one for each element.  Applies to SSE* and AVX* packed double precision floating-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT14 RCP14 RANGE FM(N)ADD/SUB. FM(N)ADD/SUB instructions count twice as they perform 2 calculations per element."
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/icelake/frontend.json b/tools/perf/pmu-events/arch/x86/icelake/frontend.json
new file mode 100644
index 000000000000..9c3cfbfcec0f
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/icelake/frontend.json
@@ -0,0 +1,424 @@
+[
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of uops delivered to Instruction Decode Queue (IDQ) from the MITE path. This also means that uops are not being delivered from the Decode Stream Buffer (DSB).",
+        "EventCode": "0x79",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "IDQ.MITE_UOPS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Uops delivered to Instruction Decode Queue (IDQ) from MITE path"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of cycles where optimal number of uops was delivered to the Instruction Decode Queue (IDQ) from the MITE (legacy decode pipeline) path. During these cycles uops are not being delivered from the Decode Stream Buffer (DSB).",
+        "EventCode": "0x79",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "IDQ.MITE_CYCLES_OK",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles MITE is delivering optimal number of Uops",
+        "CounterMask": "5"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of cycles uops were delivered to the Instruction Decode Queue (IDQ) from the MITE (legacy decode pipeline) path. During these cycles uops are not being delivered from the Decode Stream Buffer (DSB).",
+        "EventCode": "0x79",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "IDQ.MITE_CYCLES_ANY",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles MITE is delivering any Uop",
+        "CounterMask": "1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of uops delivered to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path.",
+        "EventCode": "0x79",
+        "Counter": "0,1,2,3",
+        "UMask": "0x8",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "IDQ.DSB_UOPS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Uops delivered to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of cycles where optimal number of uops was delivered to the Instruction Decode Queue (IDQ) from the MITE (legacy decode pipeline) path. During these cycles uops are not being delivered from the Decode Stream Buffer (DSB).",
+        "EventCode": "0x79",
+        "Counter": "0,1,2,3",
+        "UMask": "0x8",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "IDQ.DSB_CYCLES_OK",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles DSB is delivering optimal number of Uops",
+        "CounterMask": "5"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of cycles uops were delivered to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path.",
+        "EventCode": "0x79",
+        "Counter": "0,1,2,3",
+        "UMask": "0x8",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "IDQ.DSB_CYCLES_ANY",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is delivering any Uop",
+        "CounterMask": "1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Number of switches from DSB (Decode Stream Buffer) or MITE (legacy decode pipeline) to the Microcode Sequencer.",
+        "EventCode": "0x79",
+        "Counter": "0,1,2,3",
+        "UMask": "0x30",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "IDQ.MS_SWITCHES",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of switches from DSB or MITE to the MS",
+        "CounterMask": "1",
+        "EdgeDetect": "1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the total number of uops delivered by the Microcode Sequencer (MS). Any instruction over 4 uops will be delivered by the MS. Some instructions such as transcendentals may additionally generate uops from the MS.",
+        "EventCode": "0x79",
+        "Counter": "0,1,2,3",
+        "UMask": "0x30",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "IDQ.MS_UOPS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Uops delivered to IDQ while MS is busy"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts cycles during which uops are being delivered to Instruction Decode Queue (IDQ) while the Microcode Sequencer (MS) is busy. Uops maybe initiated by Decode Stream Buffer (DSB) or MITE.",
+        "EventCode": "0x79",
+        "Counter": "0,1,2,3",
+        "UMask": "0x30",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "IDQ.MS_CYCLES_ANY",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles when uops are being delivered to IDQ while MS is busy",
+        "CounterMask": "1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts cycles where a code line fetch is stalled due to an L1 instruction cache miss. The legacy decode pipeline works at a 16 Byte granularity.",
+        "EventCode": "0x80",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "ICACHE_16B.IFDATA_STALL",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles where a code fetch is stalled due to L1 instruction cache miss."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts instruction fetch tag lookups that hit in the instruction cache (L1I). Counts at 64-byte cache-line granularity. Accounts for both cacheable and uncacheable accesses.",
+        "EventCode": "0x83",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "ICACHE_64B.IFTAG_HIT",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Instruction fetch tag lookups that hit in the instruction cache (L1I). Counts at 64-byte cache-line granularity."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts instruction fetch tag lookups that miss in the instruction cache (L1I). Counts at 64-byte cache-line granularity. Accounts for both cacheable and uncacheable accesses.",
+        "EventCode": "0x83",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "ICACHE_64B.IFTAG_MISS",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Instruction fetch tag lookups that miss in the instruction cache (L1I). Counts at 64-byte cache-line granularity."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts cycles where a code fetch is stalled due to L1 instruction cache tag miss.",
+        "EventCode": "0x83",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "ICACHE_64B.IFTAG_STALL",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Cycles where a code fetch is stalled due to L1 instruction cache tag miss."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of uops not delivered to by the Instruction Decode Queue (IDQ) to the back-end of the pipeline when there was no back-end stalls. This event counts for one SMT thread in a given cycle.",
+        "EventCode": "0x9C",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Uops not delivered by IDQ when backend of the machine is not stalled"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of cycles when no uops were delivered by the Instruction Decode Queue (IDQ) to the back-end of the pipeline when there was no back-end stalls. This event counts for one SMT thread in a given cycle.",
+        "EventCode": "0x9c",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles when no uops are not delivered by the IDQ when backend of the machine is not stalled",
+        "CounterMask": "5"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of cycles when the optimal number of uops were delivered by the Instruction Decode Queue (IDQ) to the back-end of the pipeline when there was no back-end stalls. This event counts for one SMT thread in a given cycle.",
+        "EventCode": "0x9C",
+        "Invert": "1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles when optimal number of uops was delivered to the back-end when the back-end is not stalled",
+        "CounterMask": "1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Decode Stream Buffer (DSB) is a Uop-cache that holds translations of previously fetched instructions that were decoded by the legacy x86 decode pipeline (MITE). This event counts fetch penalty cycles when a transition occurs from DSB to MITE.",
+        "EventCode": "0xAB",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "DSB-to-MITE switch true penalty cycles."
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired Instructions that experienced DSB (Decode stream buffer i.e. the decoded instruction-cache) miss.",
+        "EventCode": "0xC6",
+        "MSRValue": "0x11",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "FRONTEND_RETIRED.DSB_MISS",
+        "MSRIndex": "0x3F7",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Retired Instructions who experienced DSB miss.",
+        "TakenAlone": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired Instructions who experienced Instruction L1 Cache true miss.",
+        "EventCode": "0xC6",
+        "MSRValue": "0x12",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "FRONTEND_RETIRED.L1I_MISS",
+        "MSRIndex": "0x3F7",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Retired Instructions who experienced Instruction L1 Cache true miss.",
+        "TakenAlone": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired Instructions who experienced Instruction L2 Cache true miss.",
+        "EventCode": "0xC6",
+        "MSRValue": "0x13",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "FRONTEND_RETIRED.L2_MISS",
+        "MSRIndex": "0x3F7",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Retired Instructions who experienced Instruction L2 Cache true miss.",
+        "TakenAlone": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired Instructions that experienced iTLB (Instruction TLB) true miss.",
+        "EventCode": "0xC6",
+        "MSRValue": "0x14",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "FRONTEND_RETIRED.ITLB_MISS",
+        "MSRIndex": "0x3F7",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Retired Instructions who experienced iTLB true miss.",
+        "TakenAlone": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired Instructions that experienced STLB (2nd level TLB) true miss.",
+        "EventCode": "0xC6",
+        "MSRValue": "0x15",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "FRONTEND_RETIRED.STLB_MISS",
+        "MSRIndex": "0x3F7",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Retired Instructions who experienced STLB (2nd level TLB) true miss.",
+        "TakenAlone": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 2 cycles which was not interrupted by a back-end stall.",
+        "EventCode": "0xC6",
+        "MSRValue": "0x500206",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_2",
+        "MSRIndex": "0x3F7",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 2 cycles which was not interrupted by a back-end stall.",
+        "TakenAlone": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 4 cycles which was not interrupted by a back-end stall.",
+        "EventCode": "0xC6",
+        "MSRValue": "0x500406",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_4",
+        "MSRIndex": "0x3F7",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 4 cycles which was not interrupted by a back-end stall.",
+        "TakenAlone": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired instructions that are delivered to the back-end after a front-end stall of at least 8 cycles. During this period the front-end delivered no uops.",
+        "EventCode": "0xC6",
+        "MSRValue": "0x500806",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_8",
+        "MSRIndex": "0x3F7",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 8 cycles which was not interrupted by a back-end stall.",
+        "TakenAlone": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired instructions that are delivered to the back-end after a front-end stall of at least 16 cycles. During this period the front-end delivered no uops.",
+        "EventCode": "0xC6",
+        "MSRValue": "0x501006",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_16",
+        "MSRIndex": "0x3F7",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 16 cycles which was not interrupted by a back-end stall.",
+        "TakenAlone": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired instructions that are delivered to the back-end after a front-end stall of at least 32 cycles. During this period the front-end delivered no uops.",
+        "EventCode": "0xC6",
+        "MSRValue": "0x502006",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_32",
+        "MSRIndex": "0x3F7",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 32 cycles which was not interrupted by a back-end stall.",
+        "TakenAlone": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 64 cycles which was not interrupted by a back-end stall.",
+        "EventCode": "0xC6",
+        "MSRValue": "0x504006",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_64",
+        "MSRIndex": "0x3F7",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 64 cycles which was not interrupted by a back-end stall.",
+        "TakenAlone": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 128 cycles which was not interrupted by a back-end stall.",
+        "EventCode": "0xC6",
+        "MSRValue": "0x508006",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_128",
+        "MSRIndex": "0x3F7",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 128 cycles which was not interrupted by a back-end stall.",
+        "TakenAlone": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 256 cycles which was not interrupted by a back-end stall.",
+        "EventCode": "0xC6",
+        "MSRValue": "0x510006",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_256",
+        "MSRIndex": "0x3F7",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 256 cycles which was not interrupted by a back-end stall.",
+        "TakenAlone": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 512 cycles which was not interrupted by a back-end stall.",
+        "EventCode": "0xC6",
+        "MSRValue": "0x520006",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_512",
+        "MSRIndex": "0x3F7",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Retired instructions that are fetched after an interval where the front-end delivered no uops for a period of 512 cycles which was not interrupted by a back-end stall.",
+        "TakenAlone": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts retired instructions that are delivered to the back-end after the front-end had at least 1 bubble-slot for a period of 2 cycles. A bubble-slot is an empty issue-pipeline slot while there was no RAT stall.",
+        "EventCode": "0xC6",
+        "MSRValue": "0x100206",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1",
+        "MSRIndex": "0x3F7",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Retired instructions that are fetched after an interval where the front-end had at least 1 bubble-slot for a period of 2 cycles which was not interrupted by a back-end stall.",
+        "TakenAlone": "1"
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/icelake/memory.json b/tools/perf/pmu-events/arch/x86/icelake/memory.json
new file mode 100644
index 000000000000..f158366b9dd6
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/icelake/memory.json
@@ -0,0 +1,410 @@
+[
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of times a TSX line had a cache conflict.",
+        "EventCode": "0x54",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "TX_MEM.ABORT_CONFLICT",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of times a transactional abort was signaled due to a data conflict on a transactionally accessed address"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Speculatively counts the number Transactional Synchronization Extensions (TSX) Aborts due to a data capacity limitation for transactional writes.",
+        "EventCode": "0x54",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "TX_MEM.ABORT_CAPACITY_WRITE",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Speculatively counts the number TSX Aborts due to a data capacity limitation for transactional writes."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of times a TSX Abort was triggered due to a non-release/commit store to lock.",
+        "EventCode": "0x54",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "TX_MEM.ABORT_HLE_STORE_TO_ELIDED_LOCK",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Number of times a HLE transactional region aborted due to a non XRELEASE prefixed instruction writing to an elided lock in the elision buffer"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of times a TSX Abort was triggered due to commit but Lock Buffer not empty.",
+        "EventCode": "0x54",
+        "Counter": "0,1,2,3",
+        "UMask": "0x8",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "TX_MEM.ABORT_HLE_ELISION_BUFFER_NOT_EMPTY",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of times an HLE transactional execution aborted due to NoAllocatedElisionBuffer being non-zero."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of times a TSX Abort was triggered due to release/commit but data and address mismatch.",
+        "EventCode": "0x54",
+        "Counter": "0,1,2,3",
+        "UMask": "0x10",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "TX_MEM.ABORT_HLE_ELISION_BUFFER_MISMATCH",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of times an HLE transactional execution aborted due to XRELEASE lock not satisfying the address and value requirements in the elision buffer"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of times a TSX Abort was triggered due to attempting an unsupported alignment from Lock Buffer.",
+        "EventCode": "0x54",
+        "Counter": "0,1,2,3",
+        "UMask": "0x20",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "TX_MEM.ABORT_HLE_ELISION_BUFFER_UNSUPPORTED_ALIGNMENT",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of times an HLE transactional execution aborted due to an unsupported read alignment from the elision buffer."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of times we could not allocate Lock Buffer.",
+        "EventCode": "0x54",
+        "Counter": "0,1,2,3",
+        "UMask": "0x40",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "TX_MEM.HLE_ELISION_BUFFER_FULL",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of times HLE lock could not be elided due to ElisionBufferAvailable being zero."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts Unfriendly TSX abort triggered by a vzeroupper instruction.",
+        "EventCode": "0x5d",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "TX_EXEC.MISC2",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Counts the number of times a class of instructions that may cause a transactional abort was executed inside a transactional region"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts Unfriendly TSX abort triggered by a nest count that is too deep.",
+        "EventCode": "0x5d",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "TX_EXEC.MISC3",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of times an instruction execution caused the transactional nest count supported to be exceeded"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "EventCode": "0xA3",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "CYCLE_ACTIVITY.CYCLES_L3_MISS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles while L3 cache miss demand load is outstanding.",
+        "CounterMask": "2"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "EventCode": "0xA3",
+        "Counter": "0,1,2,3",
+        "UMask": "0x6",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "CYCLE_ACTIVITY.STALLS_L3_MISS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Execution stalls while L3 cache miss demand load is outstanding.",
+        "CounterMask": "6"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Demand Data Read requests who miss L3 cache.",
+        "EventCode": "0xB0",
+        "Counter": "0,1,2,3",
+        "UMask": "0x10",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Demand Data Read requests who miss L3 cache"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of Machine Clears detected dye to memory ordering. Memory Ordering Machine Clears may apply when a memory read may not conform to the memory ordering rules of the x86 architecture",
+        "EventCode": "0xc3",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Number of machine clears due to memory ordering conflicts."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of times we entered an HLE region. Does not count nested transactions.",
+        "EventCode": "0xC8",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "HLE_RETIRED.START",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of times an HLE execution started."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of times HLE commit succeeded.",
+        "EventCode": "0xC8",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "HLE_RETIRED.COMMIT",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of times an HLE execution successfully committed",
+        "Data_LA": "1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of times HLE abort was triggered.",
+        "EventCode": "0xc8",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "HLE_RETIRED.ABORTED",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of times an HLE execution aborted due to any reasons (multiple categories may count as one)."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of times an HLE execution aborted due to various memory events (e.g., read/write capacity and conflicts).",
+        "EventCode": "0xC8",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x8",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "HLE_RETIRED.ABORTED_MEM",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of times an HLE execution aborted due to various memory events (e.g., read/write capacity and conflicts)."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of times an HLE execution aborted due to HLE-unfriendly instructions and certain unfriendly events (such as AD assists etc.).",
+        "EventCode": "0xC8",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x20",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "HLE_RETIRED.ABORTED_UNFRIENDLY",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of times an HLE execution aborted due to HLE-unfriendly instructions and certain unfriendly events (such as AD assists etc.)."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of times an HLE execution aborted due to unfriendly events (such as interrupts).",
+        "EventCode": "0xC8",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x80",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "HLE_RETIRED.ABORTED_EVENTS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of times an HLE execution aborted due to unfriendly events (such as interrupts)."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of times we entered an RTM region. Does not count nested transactions.",
+        "EventCode": "0xC9",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "RTM_RETIRED.START",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of times an RTM execution started."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of times RTM commit succeeded.",
+        "EventCode": "0xC9",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "RTM_RETIRED.COMMIT",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of times an RTM execution successfully committed"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of times RTM abort was triggered.",
+        "EventCode": "0xc9",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "RTM_RETIRED.ABORTED",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of times an RTM execution aborted.",
+        "Data_LA": "1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of times an RTM execution aborted due to various memory events (e.g. read/write capacity and conflicts).",
+        "EventCode": "0xC9",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x8",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "RTM_RETIRED.ABORTED_MEM",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of times an RTM execution aborted due to various memory events (e.g. read/write capacity and conflicts)"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of times an RTM execution aborted due to HLE-unfriendly instructions.",
+        "EventCode": "0xC9",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x20",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "RTM_RETIRED.ABORTED_UNFRIENDLY",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of times an RTM execution aborted due to HLE-unfriendly instructions"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of times an RTM execution aborted due to incompatible memory type.",
+        "EventCode": "0xC9",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x40",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "RTM_RETIRED.ABORTED_MEMTYPE",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of times an RTM execution aborted due to incompatible memory type"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of times an RTM execution aborted due to none of the previous 4 categories (e.g. interrupt).",
+        "EventCode": "0xC9",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x80",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "RTM_RETIRED.ABORTED_EVENTS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of times an RTM execution aborted due to none of the previous 4 categories (e.g. interrupt)"
+    },
+    {
+        "PEBS": "2",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 4 cycles.  Reported latency may be longer than just the memory latency.",
+        "EventCode": "0xcd",
+        "MSRValue": "0x4",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
+        "MSRIndex": "0x3F6",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 4 cycles.",
+        "TakenAlone": "1"
+    },
+    {
+        "PEBS": "2",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 8 cycles.  Reported latency may be longer than just the memory latency.",
+        "EventCode": "0xcd",
+        "MSRValue": "0x8",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
+        "MSRIndex": "0x3F6",
+        "SampleAfterValue": "50021",
+        "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 8 cycles.",
+        "TakenAlone": "1"
+    },
+    {
+        "PEBS": "2",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 16 cycles.  Reported latency may be longer than just the memory latency.",
+        "EventCode": "0xcd",
+        "MSRValue": "0x10",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
+        "MSRIndex": "0x3F6",
+        "SampleAfterValue": "20011",
+        "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 16 cycles.",
+        "TakenAlone": "1"
+    },
+    {
+        "PEBS": "2",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 32 cycles.  Reported latency may be longer than just the memory latency.",
+        "EventCode": "0xcd",
+        "MSRValue": "0x20",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
+        "MSRIndex": "0x3F6",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 32 cycles.",
+        "TakenAlone": "1"
+    },
+    {
+        "PEBS": "2",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 64 cycles.  Reported latency may be longer than just the memory latency.",
+        "EventCode": "0xcd",
+        "MSRValue": "0x40",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
+        "MSRIndex": "0x3F6",
+        "SampleAfterValue": "2003",
+        "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 64 cycles.",
+        "TakenAlone": "1"
+    },
+    {
+        "PEBS": "2",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 128 cycles.  Reported latency may be longer than just the memory latency.",
+        "EventCode": "0xcd",
+        "MSRValue": "0x80",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
+        "MSRIndex": "0x3F6",
+        "SampleAfterValue": "1009",
+        "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 128 cycles.",
+        "TakenAlone": "1"
+    },
+    {
+        "PEBS": "2",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 256 cycles.  Reported latency may be longer than just the memory latency.",
+        "EventCode": "0xcd",
+        "MSRValue": "0x100",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
+        "MSRIndex": "0x3F6",
+        "SampleAfterValue": "503",
+        "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 256 cycles.",
+        "TakenAlone": "1"
+    },
+    {
+        "PEBS": "2",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 512 cycles.  Reported latency may be longer than just the memory latency.",
+        "EventCode": "0xcd",
+        "MSRValue": "0x200",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
+        "MSRIndex": "0x3F6",
+        "SampleAfterValue": "101",
+        "BriefDescription": "Counts randomly selected loads when the latency from first dispatch to completion is greater than 512 cycles.",
+        "TakenAlone": "1"
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/icelake/other.json b/tools/perf/pmu-events/arch/x86/icelake/other.json
new file mode 100644
index 000000000000..f8dfdb847224
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/icelake/other.json
@@ -0,0 +1,121 @@
+[
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of available slots for an unhalted logical processor. The event increments by machine-width of the narrowest pipeline as employed by the Top-down Microarchitecture Analysis method. The count is distributed among unhalted logical processors (hyper-threads) who share the same physical core. Software can use this event as the denominator for the top-level metrics of the Top-down Microarchitecture Analysis method. This event is counted on a designated fixed counter (Fixed Counter 3) and is an architectural event.",
+        "Counter": "35",
+        "UMask": "0x4",
+        "PEBScounters": "35",
+        "EventName": "TOPDOWN.SLOTS",
+        "SampleAfterValue": "10000003",
+        "BriefDescription": "Counts the number of available slots for an unhalted logical processor."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts Core cycles where the core was running with power-delivery for baseline license level 0.  This includes non-AVX codes, SSE, AVX 128-bit, and low-current AVX 256-bit codes.",
+        "EventCode": "0x28",
+        "Counter": "0,1,2,3",
+        "UMask": "0x7",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "CORE_POWER.LVL0_TURBO_LICENSE",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Core cycles where the core was running in a manner where Turbo may be clipped to the Non-AVX turbo schedule."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts Core cycles where the core was running with power-delivery for license level 1.  This includes high current AVX 256-bit instructions as well as low current AVX 512-bit instructions.",
+        "EventCode": "0x28",
+        "Counter": "0,1,2,3",
+        "UMask": "0x18",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "CORE_POWER.LVL1_TURBO_LICENSE",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Core cycles where the core was running in a manner where Turbo may be clipped to the AVX2 turbo schedule."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Core cycles where the core was running with power-delivery for license level 2 (introduced in Skylake Server microarchtecture).  This includes high current AVX 512-bit instructions.",
+        "EventCode": "0x28",
+        "Counter": "0,1,2,3",
+        "UMask": "0x20",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "CORE_POWER.LVL2_TURBO_LICENSE",
+        "SampleAfterValue": "200003",
+        "BriefDescription": "Core cycles where the core was running in a manner where Turbo may be clipped to the AVX512 turbo schedule."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of PREFETCHNTA instructions executed.",
+        "EventCode": "0x32",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "SW_PREFETCH_ACCESS.NTA",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of PREFETCHNTA instructions executed."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of PREFETCHT0 instructions executed.",
+        "EventCode": "0x32",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "SW_PREFETCH_ACCESS.T0",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of PREFETCHT0 instructions executed."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT2 instructions executed.",
+        "EventCode": "0x32",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "SW_PREFETCH_ACCESS.T1_T2",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instructions executed."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of PREFETCHW instructions executed.",
+        "EventCode": "0x32",
+        "Counter": "0,1,2,3",
+        "UMask": "0x8",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of PREFETCHW instructions executed."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of available slots for an unhalted logical processor. The event increments by machine-width of the narrowest pipeline as employed by the Top-down Microarchitecture Analysis method. The count is distributed among unhalted logical processors (hyper-threads) who share the same physical core.",
+        "EventCode": "0xa4",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "TOPDOWN.SLOTS_P",
+        "SampleAfterValue": "10000003",
+        "BriefDescription": "Counts the number of available slots for an unhalted logical processor."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "EventCode": "0xA4",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
+        "SampleAfterValue": "10000003",
+        "BriefDescription": "Issue slots where no uops were being issued due to lack of back end resources."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of occurrences where a microcode assist is invoked by hardware Examples include AD (page Access Dirty), FP and AVX related assists.",
+        "EventCode": "0xc1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x7",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "ASSISTS.ANY",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Number of occurrences where a microcode assist is invoked by hardware."
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/icelake/pipeline.json b/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
new file mode 100644
index 000000000000..6d8311e634aa
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
@@ -0,0 +1,892 @@
+[
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of X86 instructions retired - an Architectural PerfMon event. Counting continues during hardware interrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is counted by a designated fixed counter freeing up programmable counters to count other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
+        "Counter": "32",
+        "UMask": "0x1",
+        "PEBScounters": "32",
+        "EventName": "INST_RETIRED.ANY",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of instructions retired. Fixed Counter - architectural event"
+    },
+    {
+        "PEBS": "2",
+        "CollectPEBSRecord": "3",
+        "PublicDescription": "A version of INST_RETIRED that allows for a more unbiased distribution of samples across instructions retired. It utilizes the Precise Distribution of Instructions Retired (PDIR) feature to mitigate some bias in how retired instructions get sampled. Use on Fixed Counter 0.",
+        "Counter": "32",
+        "UMask": "0x1",
+        "PEBScounters": "32",
+        "EventName": "INST_RETIRED.PREC_DIST",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Precise instruction retired event with a reduced effect of PEBS shadow in IP distribution"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of core cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. This event is a component in many key event ratios. The core frequency may change from time to time due to transitions associated with Enhanced Intel SpeedStep Technology or TM2. For this reason this event may have a changing ratio with regards to time. When the core frequency is constant, this event can approximate elapsed time while the core was not in the halt state. It is counted on a dedicated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events.",
+        "Counter": "33",
+        "UMask": "0x2",
+        "PEBScounters": "33",
+        "EventName": "CPU_CLK_UNHALTED.THREAD",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Core cycles when the thread is not in halt state"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of reference cycles when the core is not in a halt state. The core enters the halt state when it is running the HLT instruction or the MWAIT instruction. This event is not affected by core frequency changes (for example, P states, TM2 transitions) but has the same incrementing frequency as the time stamp counter. This event can approximate elapsed time while the core was not in a halt state. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It is counted on a dedicated fixed counter, leaving the four (eight when Hyperthreading is disabled) programmable counters available for other events. Note: On all current platforms this event stops counting during 'throttling (TM)' states duty off periods the processor is 'halted'.  The counter update is done at a lower clock rate then the core clock the overflow status bit for this counter may appear 'sticky'.  After the counter has overflowed and software clears t!
 he overflow status bit and resets the counter to less than MAX. The reset value to the counter is not clocked immediately so the overflow status bit will flip 'high (1)' and generate another PMI (if enabled) after which the reset value gets clocked into the counter. Therefore, software will get the interrupt, read the overflow status bit '1 for bit 34 while the counter value is less than MAX. Software should ignore this case.",
+        "Counter": "34",
+        "UMask": "0x3",
+        "PEBScounters": "34",
+        "EventName": "CPU_CLK_UNHALTED.REF_TSC",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Reference cycles when the core is not in halt state."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of times the load operation got the true Block-on-Store blocking code preventing store forwarding. This includes cases when: a. preceding store conflicts with the load (incomplete overlap),b. store forwarding is impossible due to u-arch limitations, c. preceding lock RMW operations are not forwarded, d. store has the no-forward bit set (uncacheable/page-split/masked stores), e. all-blocking stores are used (mostly, fences and port I/O), and others. The most common case is a load blocked due to its address range overlapping with a preceding smaller uncompleted store. Note: This event does not take into account cases of out-of-SW-control (for example, SbTailHit), unknown physical STA, and cases of blocking loads on store due to being non-WB memory type or a lock. These cases are covered by other events. See the table of not supported store forwards in the Optimization Guide.",
+        "EventCode": "0x03",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "LD_BLOCKS.STORE_FORWARD",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Loads blocked by overlapping with store buffer that cannot be forwarded."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of times that split load operations are temporarily blocked because all resources for handling the split accesses are in use.",
+        "EventCode": "0x03",
+        "Counter": "0,1,2,3",
+        "UMask": "0x8",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "LD_BLOCKS.NO_SR",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "The number of times that split load operations are temporarily blocked because all resources for handling the split accesses are in use."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of times a load got blocked due to false dependencies in MOB due to partial compare on address.",
+        "EventCode": "0x07",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "False dependencies in MOB due to partial compare on address."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts core cycles when the Resource allocator was stalled due to recovery from an earlier branch misprediction or machine clear event.",
+        "EventCode": "0x0D",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "INT_MISC.RECOVERY_CYCLES",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Core cycles the allocator was stalled due to recovery from earlier clear event for this thread"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts cycles the Backend cluster is recovering after a miss-speculation or a Store Buffer or Load Buffer drain stall.",
+        "EventCode": "0x0D",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x3",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "INT_MISC.ALL_RECOVERY_CYCLES",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles the Backend cluster is recovering after a miss-speculation or a Store Buffer or Load Buffer drain stall.",
+        "CounterMask": "1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Cycles after recovery from a branch misprediction or machine clear till the first uop is issued from the resteered path.",
+        "EventCode": "0x0d",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x80",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "INT_MISC.CLEAR_RESTEER_CYCLES",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Counts cycles after recovery from a branch misprediction or machine clear till the first uop is issued from the resteered path."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of uops that the Resource Allocation Table (RAT) issues to the Reservation Station (RS).",
+        "EventCode": "0x0E",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "UOPS_ISSUED.ANY",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Uops that RAT issues to RS"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts cycles during which the Resource Allocation Table (RAT) does not issue any Uops to the reservation station (RS) for the current thread.",
+        "EventCode": "0x0E",
+        "Invert": "1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "UOPS_ISSUED.STALL_CYCLES",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles when RAT does not issue Uops to RS for the thread",
+        "CounterMask": "1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts cycles when divide unit is busy executing divide or square root operations. Accounts for integer and floating-point operations.",
+        "EventCode": "0x14",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x9",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "ARITH.DIVIDER_ACTIVE",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles when divide unit is busy executing divide or square root operations.",
+        "CounterMask": "1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "This is an architectural event that counts the number of thread cycles while the thread is not in a halt state. The thread enters the halt state when it is running the HLT instruction. The core frequency may change from time to time due to power or thermal throttling. For this reason, this event may have a changing ratio with regards to wall clock time.",
+        "EventCode": "0x3C",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "CPU_CLK_UNHALTED.THREAD_P",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Thread cycles when thread is not in halt state"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts core crystal clock cycles when the thread is unhalted.",
+        "EventCode": "0x3C",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "CPU_CLK_UNHALTED.REF_XCLK",
+        "SampleAfterValue": "25003",
+        "BriefDescription": "Core crystal clock cycles when the thread is unhalted."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts Core crystal clock cycles when current thread is unhalted and the other thread is halted.",
+        "EventCode": "0x3C",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
+        "SampleAfterValue": "25003",
+        "BriefDescription": "Core crystal clock cycles when this thread is unhalted and the other thread is halted."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts all not software-prefetch load dispatches that hit the fill buffer (FB) allocated for the software prefetch. It can also be incremented by some lock instructions. So it should only be used with profiling so that the locks can be excluded by ASM (Assembly File) inspection of the nearby instructions.",
+        "EventCode": "0x4c",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "LOAD_HIT_PREFETCH.SWPF",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts the number of demand load dispatches that hit L1D fill buffer (FB) allocated for software prefetch."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts cycles during which the reservation station (RS) is empty for this logical processor. This is usually caused when the front-end pipeline runs into stravation periods (e.g. branch mispredictions or i-cache misses)",
+        "EventCode": "0x5E",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "RS_EVENTS.EMPTY_CYCLES",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles when Reservation Station (RS) is empty for the thread"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts end of periods where the Reservation Station (RS) was empty. Could be useful to closely sample on front-end latency issues (see the FRONTEND_RETIRED event of designated precise events)",
+        "EventCode": "0x5E",
+        "Invert": "1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "RS_EVENTS.EMPTY_END",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Counts end of periods where the Reservation Station (RS) was empty.",
+        "CounterMask": "1",
+        "EdgeDetect": "1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts cycles that the Instruction Length decoder (ILD) stalls occurred due to dynamically changing prefix length of the decoded instruction (by operand size prefix instruction 0x66, address size prefix instruction 0x67 or REX.W for Intel64). Count is proportional to the number of prefixes in a 16B-line. This may result in a three-cycle penalty for each LCP (Length changing prefix) in a 16-byte chunk.",
+        "EventCode": "0x87",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "ILD_STALL.LCP",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Stalls caused by changing prefix length of the instruction."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts, on the per-thread basis, cycles during which at least one uop is dispatched from the Reservation Station (RS) to port 0.",
+        "EventCode": "0xa1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "UOPS_DISPATCHED.PORT_0",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of uops executed on port 0"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts, on the per-thread basis, cycles during which at least one uop is dispatched from the Reservation Station (RS) to port 1.",
+        "EventCode": "0xa1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "UOPS_DISPATCHED.PORT_1",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of uops executed on port 1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts, on the per-thread basis, cycles during which at least one uop is dispatched from the Reservation Station (RS) to ports 2 and 3.",
+        "EventCode": "0xa1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "UOPS_DISPATCHED.PORT_2_3",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of uops executed on port 2 and 3"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts, on the per-thread basis, cycles during which at least one uop is dispatched from the Reservation Station (RS) to ports 5 and 9.",
+        "EventCode": "0xa1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x10",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "UOPS_DISPATCHED.PORT_4_9",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of uops executed on port 4 and 9"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts, on the per-thread basis, cycles during which at least one uop is dispatched from the Reservation Station (RS) to port 5.",
+        "EventCode": "0xa1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x20",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "UOPS_DISPATCHED.PORT_5",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of uops executed on port 5"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts, on the per-thread basis, cycles during which at least one uop is dispatched from the Reservation Station (RS) to port 6.",
+        "EventCode": "0xa1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x40",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "UOPS_DISPATCHED.PORT_6",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of uops executed on port 6"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts, on the per-thread basis, cycles during which at least one uop is dispatched from the Reservation Station (RS) to ports 7 and 8.",
+        "EventCode": "0xa1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x80",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "UOPS_DISPATCHED.PORT_7_8",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of uops executed on port 7 and 8"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "EventCode": "0xa2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "RESOURCE_STALLS.SCOREBOARD",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Counts cycles where the pipeline is stalled due to serializing operations."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts allocation stall cycles caused by the store buffer (SB) being full. This counts cycles that the pipeline back-end blocked uop delivery from the front-end.",
+        "EventCode": "0xA2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x8",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "RESOURCE_STALLS.SB",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles stalled due to no store buffers available. (not including draining form sync)."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "EventCode": "0xA3",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "CYCLE_ACTIVITY.CYCLES_L2_MISS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles while L2 cache miss demand load is outstanding.",
+        "CounterMask": "1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "EventCode": "0xA3",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "CYCLE_ACTIVITY.STALLS_TOTAL",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Total execution stalls.",
+        "CounterMask": "4"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "EventCode": "0xA3",
+        "Counter": "0,1,2,3",
+        "UMask": "0x5",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "CYCLE_ACTIVITY.STALLS_L2_MISS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Execution stalls while L2 cache miss demand load is outstanding.",
+        "CounterMask": "5"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "EventCode": "0xA3",
+        "Counter": "0,1,2,3",
+        "UMask": "0x8",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_MISS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles while L1 cache miss demand load is outstanding.",
+        "CounterMask": "8"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "EventCode": "0xA3",
+        "Counter": "0,1,2,3",
+        "UMask": "0xc",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "CYCLE_ACTIVITY.STALLS_L1D_MISS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Execution stalls while L1 cache miss demand load is outstanding.",
+        "CounterMask": "12"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "EventCode": "0xA3",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x10",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "CYCLE_ACTIVITY.CYCLES_MEM_ANY",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles while memory subsystem has an outstanding load.",
+        "CounterMask": "16"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "EventCode": "0xA3",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x14",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "CYCLE_ACTIVITY.STALLS_MEM_ANY",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Execution stalls while memory subsystem has an outstanding load.",
+        "CounterMask": "20"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts cycles during which a total of 1 uop was executed on all ports and Reservation Station (RS) was not empty.",
+        "EventCode": "0xa6",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "EXE_ACTIVITY.1_PORTS_UTIL",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles total of 1 uop is executed on all ports and Reservation Station was not empty."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts cycles during which a total of 2 uops were executed on all ports and Reservation Station (RS) was not empty.",
+        "EventCode": "0xa6",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "EXE_ACTIVITY.2_PORTS_UTIL",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles total of 2 uops are executed on all ports and Reservation Station was not empty."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts cycles where the Store Buffer was full and no loads caused an execution stall.",
+        "EventCode": "0xA6",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x40",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "EXE_ACTIVITY.BOUND_ON_STORES",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles where the Store Buffer was full and no loads caused an execution stall.",
+        "CounterMask": "2"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts cycles during which no uops were executed on all ports and Reservation Station (RS) was not empty.",
+        "EventCode": "0xa6",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x80",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "EXE_ACTIVITY.EXE_BOUND_0_PORTS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles where no uops were executed, the Reservation Station was not empty, the Store Buffer was full and there was no outstanding load."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of uops delivered to the back-end by the LSD(Loop Stream Detector).",
+        "EventCode": "0xA8",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "LSD.UOPS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of Uops delivered by the LSD."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the cycles when at least one uop is delivered by the LSD (Loop-stream detector).",
+        "EventCode": "0xA8",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "LSD.CYCLES_ACTIVE",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles Uops delivered by the LSD, but didn't come from the decoder.",
+        "CounterMask": "1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the cycles when optimal number of uops is delivered by the LSD (Loop-stream detector).",
+        "EventCode": "0xa8",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "LSD.CYCLES_OK",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles optimal number of Uops delivered by the LSD, but did not come from the decoder.",
+        "CounterMask": "5"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "EventCode": "0xB1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "UOPS_EXECUTED.THREAD",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Counts the number of uops to be executed per-thread each cycle."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts cycles during which no uops were dispatched from the Reservation Station (RS) per thread.",
+        "EventCode": "0xB1",
+        "Invert": "1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "UOPS_EXECUTED.STALL_CYCLES",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Counts number of cycles no uops were dispatched to be executed on this thread.",
+        "CounterMask": "1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Cycles where at least 1 uop was executed per-thread.",
+        "EventCode": "0xb1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_1",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles where at least 1 uop was executed per-thread",
+        "CounterMask": "1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Cycles where at least 2 uops were executed per-thread.",
+        "EventCode": "0xb1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_2",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles where at least 2 uops were executed per-thread",
+        "CounterMask": "2"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Cycles where at least 3 uops were executed per-thread.",
+        "EventCode": "0xb1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_3",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles where at least 3 uops were executed per-thread",
+        "CounterMask": "3"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Cycles where at least 4 uops were executed per-thread.",
+        "EventCode": "0xb1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "UOPS_EXECUTED.CYCLES_GE_4",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles where at least 4 uops were executed per-thread",
+        "CounterMask": "4"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of uops executed from any thread.",
+        "EventCode": "0xB1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "UOPS_EXECUTED.CORE",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of uops executed on the core."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts cycles when at least 1 micro-op is executed from any thread on physical core.",
+        "EventCode": "0xB1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_1",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles at least 1 micro-op is executed from any thread on physical core.",
+        "CounterMask": "1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts cycles when at least 2 micro-ops are executed from any thread on physical core.",
+        "EventCode": "0xB1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_2",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles at least 2 micro-op is executed from any thread on physical core.",
+        "CounterMask": "2"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts cycles when at least 3 micro-ops are executed from any thread on physical core.",
+        "EventCode": "0xB1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_3",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles at least 3 micro-op is executed from any thread on physical core.",
+        "CounterMask": "3"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts cycles when at least 4 micro-ops are executed from any thread on physical core.",
+        "EventCode": "0xB1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_4",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles at least 4 micro-op is executed from any thread on physical core.",
+        "CounterMask": "4"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of x87 uops executed.",
+        "EventCode": "0xB1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x10",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "UOPS_EXECUTED.X87",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Counts the number of x87 uops dispatched."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of X86 instructions retired - an Architectural PerfMon event. Counting continues during hardware interrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is counted by a designated fixed counter freeing up programmable counters to count other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
+        "EventCode": "0xC0",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "INST_RETIRED.ANY_P",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of instructions retired. General Counter - architectural event"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of cycles using always true condition (uops_ret &amp;lt; 16) applied to non PEBS uops retired event.",
+        "EventCode": "0xC2",
+        "Invert": "1",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "UOPS_RETIRED.TOTAL_CYCLES",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycles with less than 10 actually retired uops.",
+        "CounterMask": "10"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the retirement slots used each cycle.",
+        "EventCode": "0xc2",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "UOPS_RETIRED.SLOTS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Retirement slots used."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of machine clears (nukes) of any type.",
+        "EventCode": "0xC3",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "MACHINE_CLEARS.COUNT",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Number of machine clears (nukes) of any type.",
+        "CounterMask": "1",
+        "EdgeDetect": "1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts self-modifying code (SMC) detected, which causes a machine clear.",
+        "EventCode": "0xC3",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "MACHINE_CLEARS.SMC",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Self-modifying code (SMC) detected."
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts all branch instructions retired.",
+        "EventCode": "0xC4",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
+        "SampleAfterValue": "400009",
+        "BriefDescription": "All branch instructions retired."
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts taken conditional branch instructions retired.",
+        "EventCode": "0xc4",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "BR_INST_RETIRED.COND_TAKEN",
+        "SampleAfterValue": "400009",
+        "BriefDescription": "Taken conditional branch instructions retired."
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts both direct and indirect near call instructions retired.",
+        "EventCode": "0xC4",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "BR_INST_RETIRED.NEAR_CALL",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Direct and indirect near call instructions retired."
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts return instructions retired.",
+        "EventCode": "0xC4",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x8",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "BR_INST_RETIRED.NEAR_RETURN",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Return instructions retired."
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts not taken branch instructions retired.",
+        "EventCode": "0xC4",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x10",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "BR_INST_RETIRED.COND_NTAKEN",
+        "SampleAfterValue": "400009",
+        "BriefDescription": "Not taken branch instructions retired."
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts conditional branch instructions retired.",
+        "EventCode": "0xc4",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x11",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "BR_INST_RETIRED.COND",
+        "SampleAfterValue": "400009",
+        "BriefDescription": "Conditional branch instructions retired."
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts taken branch instructions retired.",
+        "EventCode": "0xC4",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x20",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
+        "SampleAfterValue": "400009",
+        "BriefDescription": "Taken branch instructions retired."
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts far branch instructions retired.",
+        "EventCode": "0xC4",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x40",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "BR_INST_RETIRED.FAR_BRANCH",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Far branch instructions retired."
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts all indirect branch instructions retired (excluding RETs. TSX aborts is considered indirect branch).",
+        "EventCode": "0xc4",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x80",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "BR_INST_RETIRED.INDIRECT",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "All indirect branch instructions retired (excluding RETs. TSX aborts are considered indirect branch)."
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts all the retired branch instructions that were mispredicted by the processor. A branch misprediction occurs when the processor incorrectly predicts the destination of the branch.  When the misprediction is discovered at execution, all the instructions executed in the wrong (speculative) path must be discarded, and the processor must start fetching from the correct path.",
+        "EventCode": "0xC5",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
+        "SampleAfterValue": "400009",
+        "BriefDescription": "All mispredicted branch instructions retired.",
+        "Data_LA": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts taken conditional mispredicted branch instructions retired.",
+        "EventCode": "0xc5",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN",
+        "SampleAfterValue": "400009",
+        "BriefDescription": "number of branch instructions retired that were mispredicted and taken. Non PEBS",
+        "Data_LA": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts mispredicted conditional branch instructions retired.",
+        "EventCode": "0xc5",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x11",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "BR_MISP_RETIRED.COND",
+        "SampleAfterValue": "400009",
+        "BriefDescription": "Mispredicted conditional branch instructions retired.",
+        "Data_LA": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts number of near branch instructions retired that were mispredicted and taken.",
+        "EventCode": "0xC5",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x20",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
+        "SampleAfterValue": "400009",
+        "BriefDescription": "Number of near branch instructions retired that were mispredicted and taken.",
+        "Data_LA": "1"
+    },
+    {
+        "PEBS": "1",
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts all miss-predicted indirect branch instructions retired (excluding RETs. TSX aborts is considered indirect branch).",
+        "EventCode": "0xC5",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x80",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "BR_MISP_RETIRED.INDIRECT",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "All miss-predicted indirect branch instructions retired (excluding RETs. TSX aborts is considered indirect branch).",
+        "Data_LA": "1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Increments when an entry is added to the Last Branch Record (LBR) array (or removed from the array in case of RETURNs in call stack mode). The event requires LBR enable via IA32_DEBUGCTL MSR and branch type selection via MSR_LBR_SELECT.",
+        "EventCode": "0xcc",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x20",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "MISC_RETIRED.LBR_INSERTS",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Increments whenever there is an update to the LBR array."
+    },
+    {
+        "PublicDescription": "Counts number of retired PAUSE instructions (that do not end up with a VMExit to the VMM; TSX aborted Instructions may be counted).",
+        "EventCode": "0xcc",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x40",
+        "EventName": "MISC_RETIRED.PAUSE_INST",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of retired PAUSE instructions."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of times the front-end is resteered when it finds a branch instruction in a fetch line. This occurs for the first time a branch instruction is fetched or when the branch is not tracked by the BPU (Branch Prediction Unit) anymore.",
+        "EventCode": "0xE6",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "BACLEARS.ANY",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Counts the total number when the front end is resteered, mainly when the BPU cannot provide a correct prediction and this is corrected by other branch handling mechanisms at the front end."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "This event distributes cycle counts between active hyperthreads, i.e., those in C0.  A hyperthread becomes inactive when it executes the HLT or MWAIT instructions.  If all other hyperthreads are inactive (or disabled or do not exist), all counts are attributed to this hyperthread. To obtain the full count when the Core is active, sum the counts from each hyperthread.",
+        "EventCode": "0xec",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3,4,5,6,7",
+        "EventName": "CPU_CLK_UNHALTED.DISTRIBUTED",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Cycle counts are evenly distributed between active threads in the Core."
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/icelake/virtual-memory.json b/tools/perf/pmu-events/arch/x86/icelake/virtual-memory.json
new file mode 100644
index 000000000000..7180a900c175
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/icelake/virtual-memory.json
@@ -0,0 +1,236 @@
+[
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts page walks completed due to demand data loads whose address translations missed in the TLB and were mapped to 4K pages.  The page walks can end with or without a page fault.",
+        "EventCode": "0x08",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Page walks completed due to a demand data load to a 4K page."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts page walks completed due to demand data loads whose address translations missed in the TLB and were mapped to 2M/4M pages.  The page walks can end with or without a page fault.",
+        "EventCode": "0x08",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Page walks completed due to a demand data load to a 2M/4M page."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts demand data loads that caused a completed page walk of any page size (4K/2M/4M/1G). This implies it missed in all TLB levels. The page walk can end with or without a fault.",
+        "EventCode": "0x08",
+        "Counter": "0,1,2,3",
+        "UMask": "0xe",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Load miss in all TLB levels causes a page walk that completes. (All page sizes)"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of page walks outstanding for a demand load in the PMH (Page Miss Handler) each cycle.",
+        "EventCode": "0x08",
+        "Counter": "0,1,2,3",
+        "UMask": "0x10",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "DTLB_LOAD_MISSES.WALK_PENDING",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of page walks outstanding for a demand load in the PMH each cycle."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Miss Handler) is busy with a page walk for a demand load.",
+        "EventCode": "0x08",
+        "Counter": "0,1,2,3",
+        "UMask": "0x10",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "DTLB_LOAD_MISSES.WALK_ACTIVE",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Cycles when at least one PMH is busy with a page walk for a demand load.",
+        "CounterMask": "1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts loads that miss the DTLB (Data TLB) and hit the STLB (Second level TLB).",
+        "EventCode": "0x08",
+        "Counter": "0,1,2,3",
+        "UMask": "0x20",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Loads that miss the DTLB and hit the STLB."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts page walks completed due to demand data stores whose address translations missed in the TLB and were mapped to 4K pages.  The page walks can end with or without a page fault.",
+        "EventCode": "0x49",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Page walks completed due to a demand data store to a 4K page."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts page walks completed due to demand data stores whose address translations missed in the TLB and were mapped to 2M/4M pages.  The page walks can end with or without a page fault.",
+        "EventCode": "0x49",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Page walks completed due to a demand data store to a 2M/4M page."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts demand data stores that caused a completed page walk of any page size (4K/2M/4M/1G). This implies it missed in all TLB levels. The page walk can end with or without a fault.",
+        "EventCode": "0x49",
+        "Counter": "0,1,2,3",
+        "UMask": "0xe",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Store misses in all TLB levels causes a page walk that completes. (All page sizes)"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of page walks outstanding for a store in the PMH (Page Miss Handler) each cycle.",
+        "EventCode": "0x49",
+        "Counter": "0,1,2,3",
+        "UMask": "0x10",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "DTLB_STORE_MISSES.WALK_PENDING",
+        "SampleAfterValue": "2000003",
+        "BriefDescription": "Number of page walks outstanding for a store in the PMH each cycle."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Miss Handler) is busy with a page walk for a store.",
+        "EventCode": "0x49",
+        "Counter": "0,1,2,3",
+        "UMask": "0x10",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "DTLB_STORE_MISSES.WALK_ACTIVE",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Cycles when at least one PMH is busy with a page walk for a store.",
+        "CounterMask": "1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts stores that miss the DTLB (Data TLB) and hit the STLB (2nd Level TLB).",
+        "EventCode": "0x49",
+        "Counter": "0,1,2,3",
+        "UMask": "0x20",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "DTLB_STORE_MISSES.STLB_HIT",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Stores that miss the DTLB and hit the STLB."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts completed page walks (4K page size) caused by a code fetch. This implies it missed in the ITLB and further levels of TLB. The page walk can end with or without a fault.",
+        "EventCode": "0x85",
+        "Counter": "0,1,2,3",
+        "UMask": "0x2",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Code miss in all TLB levels causes a page walk that completes. (4K)"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts code misses in all ITLB (Instruction TLB) levels that caused a completed page walk (2M and 4M page sizes). The page walk can end with or without a fault.",
+        "EventCode": "0x85",
+        "Counter": "0,1,2,3",
+        "UMask": "0x4",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Code miss in all TLB levels causes a page walk that completes. (2M/4M)"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts completed page walks (2M and 4M page sizes) caused by a code fetch. This implies it missed in the ITLB (Instruction TLB) and further levels of TLB. The page walk can end with or without a fault.",
+        "EventCode": "0x85",
+        "Counter": "0,1,2,3",
+        "UMask": "0xe",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Code miss in all TLB levels causes a page walk that completes. (All page sizes)"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of page walks outstanding for an outstanding code (instruction fetch) request in the PMH (Page Miss Handler) each cycle.",
+        "EventCode": "0x85",
+        "Counter": "0,1,2,3",
+        "UMask": "0x10",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "ITLB_MISSES.WALK_PENDING",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Number of page walks outstanding for an outstanding code request in the PMH each cycle."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts cycles when at least one PMH (Page Miss Handler) is busy with a page walk for a code (instruction fetch) request.",
+        "EventCode": "0x85",
+        "Counter": "0,1,2,3",
+        "UMask": "0x10",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "ITLB_MISSES.WALK_ACTIVE",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Cycles when at least one PMH is busy with a page walk for code (instruction fetch) request.",
+        "CounterMask": "1"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts instruction fetch requests that miss the ITLB (Instruction TLB) and hit the STLB (Second-level TLB).",
+        "EventCode": "0x85",
+        "Counter": "0,1,2,3",
+        "UMask": "0x20",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "ITLB_MISSES.STLB_HIT",
+        "SampleAfterValue": "100003",
+        "BriefDescription": "Instruction fetch requests that miss the ITLB and hit the STLB."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of flushes of the big or small ITLB pages. Counting include both TLB Flush (covering all sets) and TLB Set Clear (set-specific).",
+        "EventCode": "0xAE",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "ITLB.ITLB_FLUSH",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "Flushing of the Instruction TLB (ITLB) pages, includes 4k/2M/4M pages."
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of DTLB flush attempts of the thread-specific entries.",
+        "EventCode": "0xBD",
+        "Counter": "0,1,2,3",
+        "UMask": "0x1",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "TLB_FLUSH.DTLB_THREAD",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "DTLB flush attempts of the thread-specific entries"
+    },
+    {
+        "CollectPEBSRecord": "2",
+        "PublicDescription": "Counts the number of any STLB flush attempts (such as entire, VPID, PCID, InvPage, CR3 write, etc.).",
+        "EventCode": "0xBD",
+        "Counter": "0,1,2,3",
+        "UMask": "0x20",
+        "PEBScounters": "0,1,2,3",
+        "EventName": "TLB_FLUSH.STLB_ANY",
+        "SampleAfterValue": "100007",
+        "BriefDescription": "STLB flush attempts"
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index d6984a3017e0..b90e5fec2f32 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -33,4 +33,6 @@ GenuineIntel-6-25,v2,westmereep-sp,core
 GenuineIntel-6-2F,v2,westmereex,core
 GenuineIntel-6-55-[01234],v1,skylakex,core
 GenuineIntel-6-55-[56789ABCDEF],v1,cascadelakex,core
+GenuineIntel-6-7D,v1,icelake,core
+GenuineIntel-6-7E,v1,icelake,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdfam17h,core
