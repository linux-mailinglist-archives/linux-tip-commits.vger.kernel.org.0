Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0E5102A17
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Nov 2019 17:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfKSQ6G (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 19 Nov 2019 11:58:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52945 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbfKSQ6F (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 19 Nov 2019 11:58:05 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iX6oM-0007YU-GZ; Tue, 19 Nov 2019 17:57:06 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9435C1C19CF;
        Tue, 19 Nov 2019 17:56:51 +0100 (CET)
Date:   Tue, 19 Nov 2019 16:56:51 -0000
From:   "tip-bot2 for James Clark" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf vendor events power8: Fix commas so PMU event
 files are valid JSON
Cc:     James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kevin Mooney <kevin.mooney@arm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>, nd@arm.com,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191112160342.26470-2-james.clark@arm.com>
References: <20191112160342.26470-2-james.clark@arm.com>
MIME-Version: 1.0
Message-ID: <157418261148.12247.16301445508605491483.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     835e5bd90926f88d57a8d3edebf4628d01ff43ad
Gitweb:        https://git.kernel.org/tip/835e5bd90926f88d57a8d3edebf4628d01ff43ad
Author:        James Clark <james.clark@arm.com>
AuthorDate:    Tue, 12 Nov 2019 16:03:40 
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 12 Nov 2019 15:26:55 -03:00

perf vendor events power8: Fix commas so PMU event files are valid JSON

No functional change.

Remove extra commas in the power8 JSON files so that the files
can be parsed and validated by other utilities such as Python
that fail to parse invalid JSON.

Committer testing:

Before:

  $ diffstat -l -p1 /wb/1.patch | while read filename ; do echo $filename ; cat $filename | json_verify ; done
  tools/perf/pmu-events/arch/powerpc/power8/cache.json
  parse error: invalid object key (must be a string)
                                          [   {,     "EventCode": "0x4c0
                       (right here) ------^
  JSON is invalid
  tools/perf/pmu-events/arch/powerpc/power8/floating-point.json
  parse error: invalid object key (must be a string)
                                          [   {,     "EventCode": "0x200
                       (right here) ------^
  JSON is invalid
  tools/perf/pmu-events/arch/powerpc/power8/frontend.json
  parse error: invalid object key (must be a string)
                                          [   {,     "EventCode": "0x250
                       (right here) ------^
  JSON is invalid
  tools/perf/pmu-events/arch/powerpc/power8/marked.json
  parse error: invalid object key (must be a string)
                                          [   {,     "EventCode": "0x351
                       (right here) ------^
  JSON is invalid
  tools/perf/pmu-events/arch/powerpc/power8/memory.json
  parse error: invalid object key (must be a string)
                                          [   {,     "EventCode": "0x100
                       (right here) ------^
  JSON is invalid
  tools/perf/pmu-events/arch/powerpc/power8/other.json
  parse error: invalid object key (must be a string)
                                          [   {,     "EventCode": "0x1f0
                       (right here) ------^
  JSON is invalid
  tools/perf/pmu-events/arch/powerpc/power8/pipeline.json
  parse error: invalid object key (must be a string)
                                          [   {,     "EventCode": "0x100
                       (right here) ------^
  JSON is invalid
  tools/perf/pmu-events/arch/powerpc/power8/pmc.json
  parse error: invalid object key (must be a string)
                                          [   {,     "EventCode": "0x200
                       (right here) ------^
  JSON is invalid
  tools/perf/pmu-events/arch/powerpc/power8/translation.json
  parse error: invalid object key (must be a string)
                                          [   {,     "EventCode": "0x4c0
                       (right here) ------^
  JSON is invalid
  $

After:

  $ diffstat -l -p1 /wb/1.patch | while read filename ; do echo $filename ; cat $filename | json_verify ; done
  tools/perf/pmu-events/arch/powerpc/power8/cache.json
  JSON is valid
  tools/perf/pmu-events/arch/powerpc/power8/floating-point.json
  JSON is valid
  tools/perf/pmu-events/arch/powerpc/power8/frontend.json
  JSON is valid
  tools/perf/pmu-events/arch/powerpc/power8/marked.json
  JSON is valid
  tools/perf/pmu-events/arch/powerpc/power8/memory.json
  JSON is valid
  tools/perf/pmu-events/arch/powerpc/power8/other.json
  JSON is valid
  tools/perf/pmu-events/arch/powerpc/power8/pipeline.json
  JSON is valid
  tools/perf/pmu-events/arch/powerpc/power8/pmc.json
  JSON is valid
  tools/perf/pmu-events/arch/powerpc/power8/translation.json
  JSON is valid
  $

Signed-off-by: James Clark <james.clark@arm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kevin Mooney <kevin.mooney@arm.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: nd@arm.com
Link: http://lore.kernel.org/lkml/20191112160342.26470-2-james.clark@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/powerpc/power8/cache.json          |   60 ++--
 tools/perf/pmu-events/arch/powerpc/power8/floating-point.json |    6 +-
 tools/perf/pmu-events/arch/powerpc/power8/frontend.json       |  158 +++++-----
 tools/perf/pmu-events/arch/powerpc/power8/marked.json         |  266 ++++++++--------
 tools/perf/pmu-events/arch/powerpc/power8/memory.json         |   72 ++--
 tools/perf/pmu-events/arch/powerpc/power8/other.json          | 1150 +++++++++++++++++++++++++++++++++++-----------------------------------
 tools/perf/pmu-events/arch/powerpc/power8/pipeline.json       |  118 +++----
 tools/perf/pmu-events/arch/powerpc/power8/pmc.json            |   48 +--
 tools/perf/pmu-events/arch/powerpc/power8/translation.json    |   60 ++--
 9 files changed, 969 insertions(+), 969 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power8/cache.json b/tools/perf/pmu-events/arch/powerpc/power8/cache.json
index 4a3daa6..6b792b2 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/cache.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/cache.json
@@ -1,176 +1,176 @@
 [
-  {,
+  {
     "EventCode": "0x4c048",
     "EventName": "PM_DATA_FROM_DL2L3_MOD",
     "BriefDescription": "The processor's data cache was reloaded with Modified (M) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded with Modified (M) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x3c048",
     "EventName": "PM_DATA_FROM_DL2L3_SHR",
     "BriefDescription": "The processor's data cache was reloaded with Shared (S) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded with Shared (S) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x3c04c",
     "EventName": "PM_DATA_FROM_DL4",
     "BriefDescription": "The processor's data cache was reloaded from another chip's L4 on a different Node or Group (Distant) due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded from another chip's L4 on a different Node or Group (Distant) due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x1c042",
     "EventName": "PM_DATA_FROM_L2",
     "BriefDescription": "The processor's data cache was reloaded from local core's L2 due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded from local core's L2 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x200fe",
     "EventName": "PM_DATA_FROM_L2MISS",
     "BriefDescription": "Demand LD - L2 Miss (not L2 hit)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1c04e",
     "EventName": "PM_DATA_FROM_L2MISS_MOD",
     "BriefDescription": "The processor's data cache was reloaded from a localtion other than the local core's L2 due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded from a localtion other than the local core's L2 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x3c040",
     "EventName": "PM_DATA_FROM_L2_DISP_CONFLICT_LDHITST",
     "BriefDescription": "The processor's data cache was reloaded from local core's L2 with load hit store conflict due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded from local core's L2 with load hit store conflict due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x4c040",
     "EventName": "PM_DATA_FROM_L2_DISP_CONFLICT_OTHER",
     "BriefDescription": "The processor's data cache was reloaded from local core's L2 with dispatch conflict due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded from local core's L2 with dispatch conflict due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x2c040",
     "EventName": "PM_DATA_FROM_L2_MEPF",
     "BriefDescription": "The processor's data cache was reloaded from local core's L2 hit without dispatch conflicts on Mepf state due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded from local core's L2 hit without dispatch conflicts on Mepf state due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x1c040",
     "EventName": "PM_DATA_FROM_L2_NO_CONFLICT",
     "BriefDescription": "The processor's data cache was reloaded from local core's L2 without conflict due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded from local core's L2 without conflict due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x4c042",
     "EventName": "PM_DATA_FROM_L3",
     "BriefDescription": "The processor's data cache was reloaded from local core's L3 due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded from local core's L3 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x300fe",
     "EventName": "PM_DATA_FROM_L3MISS",
     "BriefDescription": "Demand LD - L3 Miss (not L2 hit and not L3 hit)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4c04e",
     "EventName": "PM_DATA_FROM_L3MISS_MOD",
     "BriefDescription": "The processor's data cache was reloaded from a localtion other than the local core's L3 due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded from a localtion other than the local core's L3 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x3c042",
     "EventName": "PM_DATA_FROM_L3_DISP_CONFLICT",
     "BriefDescription": "The processor's data cache was reloaded from local core's L3 with dispatch conflict due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded from local core's L3 with dispatch conflict due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x2c042",
     "EventName": "PM_DATA_FROM_L3_MEPF",
     "BriefDescription": "The processor's data cache was reloaded from local core's L3 without dispatch conflicts hit on Mepf state due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded from local core's L3 without dispatch conflicts hit on Mepf state due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x1c044",
     "EventName": "PM_DATA_FROM_L3_NO_CONFLICT",
     "BriefDescription": "The processor's data cache was reloaded from local core's L3 without conflict due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded from local core's L3 without conflict due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x1c04c",
     "EventName": "PM_DATA_FROM_LL4",
     "BriefDescription": "The processor's data cache was reloaded from the local chip's L4 cache due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded from the local chip's L4 cache due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x4c04a",
     "EventName": "PM_DATA_FROM_OFF_CHIP_CACHE",
     "BriefDescription": "The processor's data cache was reloaded either shared or modified data from another core's L2/L3 on a different chip (remote or distant) due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded either shared or modified data from another core's L2/L3 on a different chip (remote or distant) due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x1c048",
     "EventName": "PM_DATA_FROM_ON_CHIP_CACHE",
     "BriefDescription": "The processor's data cache was reloaded either shared or modified data from another core's L2/L3 on the same chip due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded either shared or modified data from another core's L2/L3 on the same chip due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x2c046",
     "EventName": "PM_DATA_FROM_RL2L3_MOD",
     "BriefDescription": "The processor's data cache was reloaded with Modified (M) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded with Modified (M) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x1c04a",
     "EventName": "PM_DATA_FROM_RL2L3_SHR",
     "BriefDescription": "The processor's data cache was reloaded with Shared (S) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded with Shared (S) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x3001a",
     "EventName": "PM_DATA_TABLEWALK_CYC",
     "BriefDescription": "Tablwalk Cycles (could be 1 or 2 active)",
     "PublicDescription": "Data Tablewalk Active"
   },
-  {,
+  {
     "EventCode": "0x4e04e",
     "EventName": "PM_DPTEG_FROM_L3MISS",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from a localtion other than the local core's L3 due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xd094",
     "EventName": "PM_DSLB_MISS",
     "BriefDescription": "Data SLB Miss - Total of all segment sizes",
     "PublicDescription": "Data SLB Miss - Total of all segment sizesData SLB misses"
   },
-  {,
+  {
     "EventCode": "0x1002c",
     "EventName": "PM_L1_DCACHE_RELOADED_ALL",
     "BriefDescription": "L1 data cache reloaded for demand or prefetch",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x300f6",
     "EventName": "PM_L1_DCACHE_RELOAD_VALID",
     "BriefDescription": "DL1 reloaded due to Demand Load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3e054",
     "EventName": "PM_LD_MISS_L1",
     "BriefDescription": "Load Missed L1",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x100ee",
     "EventName": "PM_LD_REF_L1",
     "BriefDescription": "All L1 D cache load references counted at finish, gated by reject",
     "PublicDescription": "Load Ref count combined for all units"
   },
-  {,
+  {
     "EventCode": "0x300f0",
     "EventName": "PM_ST_MISS_L1",
     "BriefDescription": "Store Missed L1",
     "PublicDescription": ""
-  },
+  }
 ]
diff --git a/tools/perf/pmu-events/arch/powerpc/power8/floating-point.json b/tools/perf/pmu-events/arch/powerpc/power8/floating-point.json
index 5f1bb9f..4ef0d01 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/floating-point.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/floating-point.json
@@ -1,14 +1,14 @@
 [
-  {,
+  {
     "EventCode": "0x2000e",
     "EventName": "PM_FXU_BUSY",
     "BriefDescription": "fxu0 busy and fxu1 busy",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1000e",
     "EventName": "PM_FXU_IDLE",
     "BriefDescription": "fxu0 idle and fxu1 idle",
     "PublicDescription": ""
-  },
+  }
 ]
diff --git a/tools/perf/pmu-events/arch/powerpc/power8/frontend.json b/tools/perf/pmu-events/arch/powerpc/power8/frontend.json
index 04c5f1b..1ddc306 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/frontend.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/frontend.json
@@ -1,470 +1,470 @@
 [
-  {,
+  {
     "EventCode": "0x2505e",
     "EventName": "PM_BACK_BR_CMPL",
     "BriefDescription": "Branch instruction completed with a target address less than current instruction address",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x10068",
     "EventName": "PM_BRU_FIN",
     "BriefDescription": "Branch Instruction Finished",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x20036",
     "EventName": "PM_BR_2PATH",
     "BriefDescription": "two path branch",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x40060",
     "EventName": "PM_BR_CMPL",
     "BriefDescription": "Branch Instruction completed",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x400f6",
     "EventName": "PM_BR_MPRED_CMPL",
     "BriefDescription": "Number of Branch Mispredicts",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x200fa",
     "EventName": "PM_BR_TAKEN_CMPL",
     "BriefDescription": "New event for Branch Taken",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x10018",
     "EventName": "PM_IC_DEMAND_CYC",
     "BriefDescription": "Cycles when a demand ifetch was pending",
     "PublicDescription": "Demand ifetch pending"
   },
-  {,
+  {
     "EventCode": "0x100f6",
     "EventName": "PM_IERAT_RELOAD",
     "BriefDescription": "Number of I-ERAT reloads",
     "PublicDescription": "IERAT Reloaded (Miss)"
   },
-  {,
+  {
     "EventCode": "0x4006a",
     "EventName": "PM_IERAT_RELOAD_16M",
     "BriefDescription": "IERAT Reloaded (Miss) for a 16M page",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x20064",
     "EventName": "PM_IERAT_RELOAD_4K",
     "BriefDescription": "IERAT Miss (Not implemented as DI on POWER6)",
     "PublicDescription": "IERAT Reloaded (Miss) for a 4k page"
   },
-  {,
+  {
     "EventCode": "0x3006a",
     "EventName": "PM_IERAT_RELOAD_64K",
     "BriefDescription": "IERAT Reloaded (Miss) for a 64k page",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x14050",
     "EventName": "PM_INST_CHIP_PUMP_CPRED",
     "BriefDescription": "Initial and Final Pump Scope was chip pump (prediction=correct) for an instruction fetch",
     "PublicDescription": "Initial and Final Pump Scope and data sourced across this scope was chip pump (prediction=correct) for an instruction fetch"
   },
-  {,
+  {
     "EventCode": "0x2",
     "EventName": "PM_INST_CMPL",
     "BriefDescription": "Number of PowerPC Instructions that completed",
     "PublicDescription": "PPC Instructions Finished (completed)"
   },
-  {,
+  {
     "EventCode": "0x200f2",
     "EventName": "PM_INST_DISP",
     "BriefDescription": "PPC Dispatched",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x44048",
     "EventName": "PM_INST_FROM_DL2L3_MOD",
     "BriefDescription": "The processor's Instruction cache was reloaded with Modified (M) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded with Modified (M) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x34048",
     "EventName": "PM_INST_FROM_DL2L3_SHR",
     "BriefDescription": "The processor's Instruction cache was reloaded with Shared (S) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded with Shared (S) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x3404c",
     "EventName": "PM_INST_FROM_DL4",
     "BriefDescription": "The processor's Instruction cache was reloaded from another chip's L4 on a different Node or Group (Distant) due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded from another chip's L4 on a different Node or Group (Distant) due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x4404c",
     "EventName": "PM_INST_FROM_DMEM",
     "BriefDescription": "The processor's Instruction cache was reloaded from another chip's memory on the same Node or Group (Distant) due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded from another chip's memory on the same Node or Group (Distant) due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x14042",
     "EventName": "PM_INST_FROM_L2",
     "BriefDescription": "The processor's Instruction cache was reloaded from local core's L2 due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded from local core's L2 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x1404e",
     "EventName": "PM_INST_FROM_L2MISS",
     "BriefDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L2 due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L2 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x34040",
     "EventName": "PM_INST_FROM_L2_DISP_CONFLICT_LDHITST",
     "BriefDescription": "The processor's Instruction cache was reloaded from local core's L2 with load hit store conflict due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded from local core's L2 with load hit store conflict due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x44040",
     "EventName": "PM_INST_FROM_L2_DISP_CONFLICT_OTHER",
     "BriefDescription": "The processor's Instruction cache was reloaded from local core's L2 with dispatch conflict due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded from local core's L2 with dispatch conflict due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x24040",
     "EventName": "PM_INST_FROM_L2_MEPF",
     "BriefDescription": "The processor's Instruction cache was reloaded from local core's L2 hit without dispatch conflicts on Mepf state. due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded from local core's L2 hit without dispatch conflicts on Mepf state. due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x14040",
     "EventName": "PM_INST_FROM_L2_NO_CONFLICT",
     "BriefDescription": "The processor's Instruction cache was reloaded from local core's L2 without conflict due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded from local core's L2 without conflict due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x44042",
     "EventName": "PM_INST_FROM_L3",
     "BriefDescription": "The processor's Instruction cache was reloaded from local core's L3 due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded from local core's L3 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x300fa",
     "EventName": "PM_INST_FROM_L3MISS",
     "BriefDescription": "Marked instruction was reloaded from a location beyond the local chiplet",
     "PublicDescription": "Inst from L3 miss"
   },
-  {,
+  {
     "EventCode": "0x4404e",
     "EventName": "PM_INST_FROM_L3MISS_MOD",
     "BriefDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L3 due to a instruction fetch",
     "PublicDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L3 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x34042",
     "EventName": "PM_INST_FROM_L3_DISP_CONFLICT",
     "BriefDescription": "The processor's Instruction cache was reloaded from local core's L3 with dispatch conflict due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded from local core's L3 with dispatch conflict due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x24042",
     "EventName": "PM_INST_FROM_L3_MEPF",
     "BriefDescription": "The processor's Instruction cache was reloaded from local core's L3 without dispatch conflicts hit on Mepf state. due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded from local core's L3 without dispatch conflicts hit on Mepf state. due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x14044",
     "EventName": "PM_INST_FROM_L3_NO_CONFLICT",
     "BriefDescription": "The processor's Instruction cache was reloaded from local core's L3 without conflict due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded from local core's L3 without conflict due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x1404c",
     "EventName": "PM_INST_FROM_LL4",
     "BriefDescription": "The processor's Instruction cache was reloaded from the local chip's L4 cache due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded from the local chip's L4 cache due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x24048",
     "EventName": "PM_INST_FROM_LMEM",
     "BriefDescription": "The processor's Instruction cache was reloaded from the local chip's Memory due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded from the local chip's Memory due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x2404c",
     "EventName": "PM_INST_FROM_MEMORY",
     "BriefDescription": "The processor's Instruction cache was reloaded from a memory location including L4 from local remote or distant due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded from a memory location including L4 from local remote or distant due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x4404a",
     "EventName": "PM_INST_FROM_OFF_CHIP_CACHE",
     "BriefDescription": "The processor's Instruction cache was reloaded either shared or modified data from another core's L2/L3 on a different chip (remote or distant) due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded either shared or modified data from another core's L2/L3 on a different chip (remote or distant) due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x14048",
     "EventName": "PM_INST_FROM_ON_CHIP_CACHE",
     "BriefDescription": "The processor's Instruction cache was reloaded either shared or modified data from another core's L2/L3 on the same chip due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded either shared or modified data from another core's L2/L3 on the same chip due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x24046",
     "EventName": "PM_INST_FROM_RL2L3_MOD",
     "BriefDescription": "The processor's Instruction cache was reloaded with Modified (M) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded with Modified (M) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x1404a",
     "EventName": "PM_INST_FROM_RL2L3_SHR",
     "BriefDescription": "The processor's Instruction cache was reloaded with Shared (S) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded with Shared (S) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x2404a",
     "EventName": "PM_INST_FROM_RL4",
     "BriefDescription": "The processor's Instruction cache was reloaded from another chip's L4 on the same Node or Group ( Remote) due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded from another chip's L4 on the same Node or Group ( Remote) due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x3404a",
     "EventName": "PM_INST_FROM_RMEM",
     "BriefDescription": "The processor's Instruction cache was reloaded from another chip's memory on the same Node or Group ( Remote) due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded from another chip's memory on the same Node or Group ( Remote) due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x24050",
     "EventName": "PM_INST_GRP_PUMP_CPRED",
     "BriefDescription": "Initial and Final Pump Scope was group pump (prediction=correct) for an instruction fetch",
     "PublicDescription": "Initial and Final Pump Scope and data sourced across this scope was group pump for an instruction fetch"
   },
-  {,
+  {
     "EventCode": "0x24052",
     "EventName": "PM_INST_GRP_PUMP_MPRED",
     "BriefDescription": "Final Pump Scope (Group) ended up either larger or smaller than Initial Pump Scope for an instruction fetch",
     "PublicDescription": "Final Pump Scope(Group) to get data sourced, ended up larger than Initial Pump Scope OR Final Pump Scope(Group) got data from source that was at smaller scope(Chip) Final pump was group pump and initial pump was chip or final and initial pump was gro"
   },
-  {,
+  {
     "EventCode": "0x14052",
     "EventName": "PM_INST_GRP_PUMP_MPRED_RTY",
     "BriefDescription": "Final Pump Scope (Group) ended up larger than Initial Pump Scope (Chip) for an instruction fetch",
     "PublicDescription": "Final Pump Scope(Group) to get data sourced, ended up larger than Initial Pump Scope (Chip) Final pump was group pump and initial pump was chip pumpfor an instruction fetch"
   },
-  {,
+  {
     "EventCode": "0x1003a",
     "EventName": "PM_INST_IMC_MATCH_CMPL",
     "BriefDescription": "IMC Match Count ( Not architected in P8)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x14054",
     "EventName": "PM_INST_PUMP_CPRED",
     "BriefDescription": "Pump prediction correct. Counts across all types of pumps for an instruction fetch",
     "PublicDescription": "Pump prediction correct. Counts across all types of pumpsfor an instruction fetch"
   },
-  {,
+  {
     "EventCode": "0x44052",
     "EventName": "PM_INST_PUMP_MPRED",
     "BriefDescription": "Pump misprediction. Counts across all types of pumps for an instruction fetch",
     "PublicDescription": "Pump Mis prediction Counts across all types of pumpsfor an instruction fetch"
   },
-  {,
+  {
     "EventCode": "0x34050",
     "EventName": "PM_INST_SYS_PUMP_CPRED",
     "BriefDescription": "Initial and Final Pump Scope was system pump (prediction=correct) for an instruction fetch",
     "PublicDescription": "Initial and Final Pump Scope and data sourced across this scope was system pump for an instruction fetch"
   },
-  {,
+  {
     "EventCode": "0x34052",
     "EventName": "PM_INST_SYS_PUMP_MPRED",
     "BriefDescription": "Final Pump Scope (system) mispredicted. Either the original scope was too small (Chip/Group) or the original scope was System and it should have been smaller. Counts for an instruction fetch",
     "PublicDescription": "Final Pump Scope(system) to get data sourced, ended up larger than Initial Pump Scope(Chip/Group) OR Final Pump Scope(system) got data from source that was at smaller scope(Chip/group) Final pump was system pump and initial pump was chip or group or"
   },
-  {,
+  {
     "EventCode": "0x44050",
     "EventName": "PM_INST_SYS_PUMP_MPRED_RTY",
     "BriefDescription": "Final Pump Scope (system) ended up larger than Initial Pump Scope (Chip/Group) for an instruction fetch",
     "PublicDescription": "Final Pump Scope(system) to get data sourced, ended up larger than Initial Pump Scope (Chip or Group) for an instruction fetch"
   },
-  {,
+  {
     "EventCode": "0x45048",
     "EventName": "PM_IPTEG_FROM_DL2L3_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x35048",
     "EventName": "PM_IPTEG_FROM_DL2L3_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3504c",
     "EventName": "PM_IPTEG_FROM_DL4",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from another chip's L4 on a different Node or Group (Distant) due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4504c",
     "EventName": "PM_IPTEG_FROM_DMEM",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from another chip's memory on the same Node or Group (Distant) due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x15042",
     "EventName": "PM_IPTEG_FROM_L2",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L2 due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1504e",
     "EventName": "PM_IPTEG_FROM_L2MISS",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from a localtion other than the local core's L2 due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x25040",
     "EventName": "PM_IPTEG_FROM_L2_MEPF",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L2 hit without dispatch conflicts on Mepf state. due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x15040",
     "EventName": "PM_IPTEG_FROM_L2_NO_CONFLICT",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L2 without conflict due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x45042",
     "EventName": "PM_IPTEG_FROM_L3",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L3 due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4504e",
     "EventName": "PM_IPTEG_FROM_L3MISS",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from a localtion other than the local core's L3 due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x35042",
     "EventName": "PM_IPTEG_FROM_L3_DISP_CONFLICT",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L3 with dispatch conflict due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x25042",
     "EventName": "PM_IPTEG_FROM_L3_MEPF",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L3 without dispatch conflicts hit on Mepf state. due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x15044",
     "EventName": "PM_IPTEG_FROM_L3_NO_CONFLICT",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L3 without conflict due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1504c",
     "EventName": "PM_IPTEG_FROM_LL4",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from the local chip's L4 cache due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x25048",
     "EventName": "PM_IPTEG_FROM_LMEM",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from the local chip's Memory due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2504c",
     "EventName": "PM_IPTEG_FROM_MEMORY",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from a memory location including L4 from local remote or distant due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4504a",
     "EventName": "PM_IPTEG_FROM_OFF_CHIP_CACHE",
     "BriefDescription": "A Page Table Entry was loaded into the TLB either shared or modified data from another core's L2/L3 on a different chip (remote or distant) due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x15048",
     "EventName": "PM_IPTEG_FROM_ON_CHIP_CACHE",
     "BriefDescription": "A Page Table Entry was loaded into the TLB either shared or modified data from another core's L2/L3 on the same chip due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x25046",
     "EventName": "PM_IPTEG_FROM_RL2L3_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1504a",
     "EventName": "PM_IPTEG_FROM_RL2L3_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2504a",
     "EventName": "PM_IPTEG_FROM_RL4",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from another chip's L4 on the same Node or Group ( Remote) due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3504a",
     "EventName": "PM_IPTEG_FROM_RMEM",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from another chip's memory on the same Node or Group ( Remote) due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xd096",
     "EventName": "PM_ISLB_MISS",
     "BriefDescription": "I SLB Miss",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x400fc",
     "EventName": "PM_ITLB_MISS",
     "BriefDescription": "ITLB Reloaded (always zero on POWER6)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x200fd",
     "EventName": "PM_L1_ICACHE_MISS",
     "BriefDescription": "Demand iCache Miss",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x40012",
     "EventName": "PM_L1_ICACHE_RELOADED_ALL",
     "BriefDescription": "Counts all Icache reloads includes demand, prefetchm prefetch turned into demand and demand turned into prefetch",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30068",
     "EventName": "PM_L1_ICACHE_RELOADED_PREF",
     "BriefDescription": "Counts all Icache prefetch reloads ( includes demand turned into prefetch)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x300f4",
     "EventName": "PM_THRD_CONC_RUN_INST",
     "BriefDescription": "PPC Instructions Finished when both threads in run_cycles",
     "PublicDescription": "Concurrent Run Instructions"
   },
-  {,
+  {
     "EventCode": "0x30060",
     "EventName": "PM_TM_TRANS_RUN_INST",
     "BriefDescription": "Instructions completed in transactional state",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4e014",
     "EventName": "PM_TM_TX_PASS_RUN_INST",
     "BriefDescription": "run instructions spent in successful transactions",
     "PublicDescription": ""
-  },
+  }
 ]
diff --git a/tools/perf/pmu-events/arch/powerpc/power8/marked.json b/tools/perf/pmu-events/arch/powerpc/power8/marked.json
index dcdcede..94dc58b 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/marked.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/marked.json
@@ -1,794 +1,794 @@
 [
-  {,
+  {
     "EventCode": "0x3515e",
     "EventName": "PM_MRK_BACK_BR_CMPL",
     "BriefDescription": "Marked branch instruction completed with a target address less than current instruction address",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2013a",
     "EventName": "PM_MRK_BRU_FIN",
     "BriefDescription": "bru marked instr finish",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1016e",
     "EventName": "PM_MRK_BR_CMPL",
     "BriefDescription": "Branch Instruction completed",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x301e4",
     "EventName": "PM_MRK_BR_MPRED_CMPL",
     "BriefDescription": "Marked Branch Mispredicted",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x101e2",
     "EventName": "PM_MRK_BR_TAKEN_CMPL",
     "BriefDescription": "Marked Branch Taken completed",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4d148",
     "EventName": "PM_MRK_DATA_FROM_DL2L3_MOD",
     "BriefDescription": "The processor's data cache was reloaded with Modified (M) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2d128",
     "EventName": "PM_MRK_DATA_FROM_DL2L3_MOD_CYC",
     "BriefDescription": "Duration in cycles to reload with Modified (M) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3d148",
     "EventName": "PM_MRK_DATA_FROM_DL2L3_SHR",
     "BriefDescription": "The processor's data cache was reloaded with Shared (S) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2c128",
     "EventName": "PM_MRK_DATA_FROM_DL2L3_SHR_CYC",
     "BriefDescription": "Duration in cycles to reload with Shared (S) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3d14c",
     "EventName": "PM_MRK_DATA_FROM_DL4",
     "BriefDescription": "The processor's data cache was reloaded from another chip's L4 on a different Node or Group (Distant) due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2c12c",
     "EventName": "PM_MRK_DATA_FROM_DL4_CYC",
     "BriefDescription": "Duration in cycles to reload from another chip's L4 on a different Node or Group (Distant) due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4d14c",
     "EventName": "PM_MRK_DATA_FROM_DMEM",
     "BriefDescription": "The processor's data cache was reloaded from another chip's memory on the same Node or Group (Distant) due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2d12c",
     "EventName": "PM_MRK_DATA_FROM_DMEM_CYC",
     "BriefDescription": "Duration in cycles to reload from another chip's memory on the same Node or Group (Distant) due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1d142",
     "EventName": "PM_MRK_DATA_FROM_L2",
     "BriefDescription": "The processor's data cache was reloaded from local core's L2 due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1d14e",
     "EventName": "PM_MRK_DATA_FROM_L2MISS",
     "BriefDescription": "Data cache reload L2 miss",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4c12e",
     "EventName": "PM_MRK_DATA_FROM_L2MISS_CYC",
     "BriefDescription": "Duration in cycles to reload from a localtion other than the local core's L2 due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4c122",
     "EventName": "PM_MRK_DATA_FROM_L2_CYC",
     "BriefDescription": "Duration in cycles to reload from local core's L2 due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3d140",
     "EventName": "PM_MRK_DATA_FROM_L2_DISP_CONFLICT_LDHITST",
     "BriefDescription": "The processor's data cache was reloaded from local core's L2 with load hit store conflict due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2c120",
     "EventName": "PM_MRK_DATA_FROM_L2_DISP_CONFLICT_LDHITST_CYC",
     "BriefDescription": "Duration in cycles to reload from local core's L2 with load hit store conflict due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4d140",
     "EventName": "PM_MRK_DATA_FROM_L2_DISP_CONFLICT_OTHER",
     "BriefDescription": "The processor's data cache was reloaded from local core's L2 with dispatch conflict due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2d120",
     "EventName": "PM_MRK_DATA_FROM_L2_DISP_CONFLICT_OTHER_CYC",
     "BriefDescription": "Duration in cycles to reload from local core's L2 with dispatch conflict due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2d140",
     "EventName": "PM_MRK_DATA_FROM_L2_MEPF",
     "BriefDescription": "The processor's data cache was reloaded from local core's L2 hit without dispatch conflicts on Mepf state. due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4d120",
     "EventName": "PM_MRK_DATA_FROM_L2_MEPF_CYC",
     "BriefDescription": "Duration in cycles to reload from local core's L2 hit without dispatch conflicts on Mepf state. due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1d140",
     "EventName": "PM_MRK_DATA_FROM_L2_NO_CONFLICT",
     "BriefDescription": "The processor's data cache was reloaded from local core's L2 without conflict due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4c120",
     "EventName": "PM_MRK_DATA_FROM_L2_NO_CONFLICT_CYC",
     "BriefDescription": "Duration in cycles to reload from local core's L2 without conflict due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4d142",
     "EventName": "PM_MRK_DATA_FROM_L3",
     "BriefDescription": "The processor's data cache was reloaded from local core's L3 due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x201e4",
     "EventName": "PM_MRK_DATA_FROM_L3MISS",
     "BriefDescription": "The processor's data cache was reloaded from a localtion other than the local core's L3 due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2d12e",
     "EventName": "PM_MRK_DATA_FROM_L3MISS_CYC",
     "BriefDescription": "Duration in cycles to reload from a localtion other than the local core's L3 due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2d122",
     "EventName": "PM_MRK_DATA_FROM_L3_CYC",
     "BriefDescription": "Duration in cycles to reload from local core's L3 due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3d142",
     "EventName": "PM_MRK_DATA_FROM_L3_DISP_CONFLICT",
     "BriefDescription": "The processor's data cache was reloaded from local core's L3 with dispatch conflict due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2c122",
     "EventName": "PM_MRK_DATA_FROM_L3_DISP_CONFLICT_CYC",
     "BriefDescription": "Duration in cycles to reload from local core's L3 with dispatch conflict due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2d142",
     "EventName": "PM_MRK_DATA_FROM_L3_MEPF",
     "BriefDescription": "The processor's data cache was reloaded from local core's L3 without dispatch conflicts hit on Mepf state. due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4d122",
     "EventName": "PM_MRK_DATA_FROM_L3_MEPF_CYC",
     "BriefDescription": "Duration in cycles to reload from local core's L3 without dispatch conflicts hit on Mepf state. due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1d144",
     "EventName": "PM_MRK_DATA_FROM_L3_NO_CONFLICT",
     "BriefDescription": "The processor's data cache was reloaded from local core's L3 without conflict due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4c124",
     "EventName": "PM_MRK_DATA_FROM_L3_NO_CONFLICT_CYC",
     "BriefDescription": "Duration in cycles to reload from local core's L3 without conflict due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1d14c",
     "EventName": "PM_MRK_DATA_FROM_LL4",
     "BriefDescription": "The processor's data cache was reloaded from the local chip's L4 cache due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4c12c",
     "EventName": "PM_MRK_DATA_FROM_LL4_CYC",
     "BriefDescription": "Duration in cycles to reload from the local chip's L4 cache due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2d148",
     "EventName": "PM_MRK_DATA_FROM_LMEM",
     "BriefDescription": "The processor's data cache was reloaded from the local chip's Memory due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4d128",
     "EventName": "PM_MRK_DATA_FROM_LMEM_CYC",
     "BriefDescription": "Duration in cycles to reload from the local chip's Memory due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2d14c",
     "EventName": "PM_MRK_DATA_FROM_MEMORY",
     "BriefDescription": "The processor's data cache was reloaded from a memory location including L4 from local remote or distant due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4d12c",
     "EventName": "PM_MRK_DATA_FROM_MEMORY_CYC",
     "BriefDescription": "Duration in cycles to reload from a memory location including L4 from local remote or distant due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4d14a",
     "EventName": "PM_MRK_DATA_FROM_OFF_CHIP_CACHE",
     "BriefDescription": "The processor's data cache was reloaded either shared or modified data from another core's L2/L3 on a different chip (remote or distant) due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2d12a",
     "EventName": "PM_MRK_DATA_FROM_OFF_CHIP_CACHE_CYC",
     "BriefDescription": "Duration in cycles to reload either shared or modified data from another core's L2/L3 on a different chip (remote or distant) due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1d148",
     "EventName": "PM_MRK_DATA_FROM_ON_CHIP_CACHE",
     "BriefDescription": "The processor's data cache was reloaded either shared or modified data from another core's L2/L3 on the same chip due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4c128",
     "EventName": "PM_MRK_DATA_FROM_ON_CHIP_CACHE_CYC",
     "BriefDescription": "Duration in cycles to reload either shared or modified data from another core's L2/L3 on the same chip due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2d146",
     "EventName": "PM_MRK_DATA_FROM_RL2L3_MOD",
     "BriefDescription": "The processor's data cache was reloaded with Modified (M) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4d126",
     "EventName": "PM_MRK_DATA_FROM_RL2L3_MOD_CYC",
     "BriefDescription": "Duration in cycles to reload with Modified (M) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1d14a",
     "EventName": "PM_MRK_DATA_FROM_RL2L3_SHR",
     "BriefDescription": "The processor's data cache was reloaded with Shared (S) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4c12a",
     "EventName": "PM_MRK_DATA_FROM_RL2L3_SHR_CYC",
     "BriefDescription": "Duration in cycles to reload with Shared (S) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2d14a",
     "EventName": "PM_MRK_DATA_FROM_RL4",
     "BriefDescription": "The processor's data cache was reloaded from another chip's L4 on the same Node or Group ( Remote) due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4d12a",
     "EventName": "PM_MRK_DATA_FROM_RL4_CYC",
     "BriefDescription": "Duration in cycles to reload from another chip's L4 on the same Node or Group ( Remote) due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3d14a",
     "EventName": "PM_MRK_DATA_FROM_RMEM",
     "BriefDescription": "The processor's data cache was reloaded from another chip's memory on the same Node or Group ( Remote) due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2c12a",
     "EventName": "PM_MRK_DATA_FROM_RMEM_CYC",
     "BriefDescription": "Duration in cycles to reload from another chip's memory on the same Node or Group ( Remote) due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x40118",
     "EventName": "PM_MRK_DCACHE_RELOAD_INTV",
     "BriefDescription": "Combined Intervention event",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x301e6",
     "EventName": "PM_MRK_DERAT_MISS",
     "BriefDescription": "Erat Miss (TLB Access) All page sizes",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4d154",
     "EventName": "PM_MRK_DERAT_MISS_16G",
     "BriefDescription": "Marked Data ERAT Miss (Data TLB Access) page size 16G",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3d154",
     "EventName": "PM_MRK_DERAT_MISS_16M",
     "BriefDescription": "Marked Data ERAT Miss (Data TLB Access) page size 16M",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1d156",
     "EventName": "PM_MRK_DERAT_MISS_4K",
     "BriefDescription": "Marked Data ERAT Miss (Data TLB Access) page size 4K",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2d154",
     "EventName": "PM_MRK_DERAT_MISS_64K",
     "BriefDescription": "Marked Data ERAT Miss (Data TLB Access) page size 64K",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x20132",
     "EventName": "PM_MRK_DFU_FIN",
     "BriefDescription": "Decimal Unit marked Instruction Finish",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4f148",
     "EventName": "PM_MRK_DPTEG_FROM_DL2L3_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3f148",
     "EventName": "PM_MRK_DPTEG_FROM_DL2L3_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3f14c",
     "EventName": "PM_MRK_DPTEG_FROM_DL4",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from another chip's L4 on a different Node or Group (Distant) due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4f14c",
     "EventName": "PM_MRK_DPTEG_FROM_DMEM",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from another chip's memory on the same Node or Group (Distant) due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1f142",
     "EventName": "PM_MRK_DPTEG_FROM_L2",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L2 due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1f14e",
     "EventName": "PM_MRK_DPTEG_FROM_L2MISS",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from a localtion other than the local core's L2 due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2f140",
     "EventName": "PM_MRK_DPTEG_FROM_L2_MEPF",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L2 hit without dispatch conflicts on Mepf state. due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1f140",
     "EventName": "PM_MRK_DPTEG_FROM_L2_NO_CONFLICT",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L2 without conflict due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4f142",
     "EventName": "PM_MRK_DPTEG_FROM_L3",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L3 due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4f14e",
     "EventName": "PM_MRK_DPTEG_FROM_L3MISS",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from a localtion other than the local core's L3 due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3f142",
     "EventName": "PM_MRK_DPTEG_FROM_L3_DISP_CONFLICT",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L3 with dispatch conflict due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2f142",
     "EventName": "PM_MRK_DPTEG_FROM_L3_MEPF",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L3 without dispatch conflicts hit on Mepf state. due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1f144",
     "EventName": "PM_MRK_DPTEG_FROM_L3_NO_CONFLICT",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L3 without conflict due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1f14c",
     "EventName": "PM_MRK_DPTEG_FROM_LL4",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from the local chip's L4 cache due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2f148",
     "EventName": "PM_MRK_DPTEG_FROM_LMEM",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from the local chip's Memory due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2f14c",
     "EventName": "PM_MRK_DPTEG_FROM_MEMORY",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from a memory location including L4 from local remote or distant due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4f14a",
     "EventName": "PM_MRK_DPTEG_FROM_OFF_CHIP_CACHE",
     "BriefDescription": "A Page Table Entry was loaded into the TLB either shared or modified data from another core's L2/L3 on a different chip (remote or distant) due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1f148",
     "EventName": "PM_MRK_DPTEG_FROM_ON_CHIP_CACHE",
     "BriefDescription": "A Page Table Entry was loaded into the TLB either shared or modified data from another core's L2/L3 on the same chip due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2f146",
     "EventName": "PM_MRK_DPTEG_FROM_RL2L3_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1f14a",
     "EventName": "PM_MRK_DPTEG_FROM_RL2L3_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2f14a",
     "EventName": "PM_MRK_DPTEG_FROM_RL4",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from another chip's L4 on the same Node or Group ( Remote) due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3f14a",
     "EventName": "PM_MRK_DPTEG_FROM_RMEM",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from another chip's memory on the same Node or Group ( Remote) due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x401e4",
     "EventName": "PM_MRK_DTLB_MISS",
     "BriefDescription": "Marked dtlb miss",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1d158",
     "EventName": "PM_MRK_DTLB_MISS_16G",
     "BriefDescription": "Marked Data TLB Miss page size 16G",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4d156",
     "EventName": "PM_MRK_DTLB_MISS_16M",
     "BriefDescription": "Marked Data TLB Miss page size 16M",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2d156",
     "EventName": "PM_MRK_DTLB_MISS_4K",
     "BriefDescription": "Marked Data TLB Miss page size 4k",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3d156",
     "EventName": "PM_MRK_DTLB_MISS_64K",
     "BriefDescription": "Marked Data TLB Miss page size 64K",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x40154",
     "EventName": "PM_MRK_FAB_RSP_BKILL",
     "BriefDescription": "Marked store had to do a bkill",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2f150",
     "EventName": "PM_MRK_FAB_RSP_BKILL_CYC",
     "BriefDescription": "cycles L2 RC took for a bkill",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3015e",
     "EventName": "PM_MRK_FAB_RSP_CLAIM_RTY",
     "BriefDescription": "Sampled store did a rwitm and got a rty",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30154",
     "EventName": "PM_MRK_FAB_RSP_DCLAIM",
     "BriefDescription": "Marked store had to do a dclaim",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2f152",
     "EventName": "PM_MRK_FAB_RSP_DCLAIM_CYC",
     "BriefDescription": "cycles L2 RC took for a dclaim",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4015e",
     "EventName": "PM_MRK_FAB_RSP_RD_RTY",
     "BriefDescription": "Sampled L2 reads retry count",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1015e",
     "EventName": "PM_MRK_FAB_RSP_RD_T_INTV",
     "BriefDescription": "Sampled Read got a T intervention",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4f150",
     "EventName": "PM_MRK_FAB_RSP_RWITM_CYC",
     "BriefDescription": "cycles L2 RC took for a rwitm",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2015e",
     "EventName": "PM_MRK_FAB_RSP_RWITM_RTY",
     "BriefDescription": "Sampled store did a rwitm and got a rty",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x20134",
     "EventName": "PM_MRK_FXU_FIN",
     "BriefDescription": "fxu marked instr finish",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x401e0",
     "EventName": "PM_MRK_INST_CMPL",
     "BriefDescription": "marked instruction completed",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x20130",
     "EventName": "PM_MRK_INST_DECODED",
     "BriefDescription": "marked instruction decoded",
     "PublicDescription": "marked instruction decoded. Name from ISU?"
   },
-  {,
+  {
     "EventCode": "0x101e0",
     "EventName": "PM_MRK_INST_DISP",
     "BriefDescription": "The thread has dispatched a randomly sampled marked instruction",
     "PublicDescription": "Marked Instruction dispatched"
   },
-  {,
+  {
     "EventCode": "0x30130",
     "EventName": "PM_MRK_INST_FIN",
     "BriefDescription": "marked instruction finished",
     "PublicDescription": "marked instr finish any unit"
   },
-  {,
+  {
     "EventCode": "0x401e6",
     "EventName": "PM_MRK_INST_FROM_L3MISS",
     "BriefDescription": "Marked instruction was reloaded from a location beyond the local chiplet",
     "PublicDescription": "n/a"
   },
-  {,
+  {
     "EventCode": "0x10132",
     "EventName": "PM_MRK_INST_ISSUED",
     "BriefDescription": "Marked instruction issued",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x40134",
     "EventName": "PM_MRK_INST_TIMEO",
     "BriefDescription": "marked Instruction finish timeout (instruction lost)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x101e4",
     "EventName": "PM_MRK_L1_ICACHE_MISS",
     "BriefDescription": "sampled Instruction suffered an icache Miss",
     "PublicDescription": "Marked L1 Icache Miss"
   },
-  {,
+  {
     "EventCode": "0x101ea",
     "EventName": "PM_MRK_L1_RELOAD_VALID",
     "BriefDescription": "Marked demand reload",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x20114",
     "EventName": "PM_MRK_L2_RC_DISP",
     "BriefDescription": "Marked Instruction RC dispatched in L2",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3012a",
     "EventName": "PM_MRK_L2_RC_DONE",
     "BriefDescription": "Marked RC done",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x40116",
     "EventName": "PM_MRK_LARX_FIN",
     "BriefDescription": "Larx finished",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1013e",
     "EventName": "PM_MRK_LD_MISS_EXPOSED_CYC",
     "BriefDescription": "Marked Load exposed Miss cycles",
     "PublicDescription": "Marked Load exposed Miss (use edge detect to count #)"
   },
-  {,
+  {
     "EventCode": "0x201e2",
     "EventName": "PM_MRK_LD_MISS_L1",
     "BriefDescription": "Marked DL1 Demand Miss counted at exec time",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4013e",
     "EventName": "PM_MRK_LD_MISS_L1_CYC",
     "BriefDescription": "Marked ld latency",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x40132",
     "EventName": "PM_MRK_LSU_FIN",
     "BriefDescription": "lsu marked instr finish",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x20112",
     "EventName": "PM_MRK_NTF_FIN",
     "BriefDescription": "Marked next to finish instruction finished",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1d15e",
     "EventName": "PM_MRK_RUN_CYC",
     "BriefDescription": "Marked run cycles",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3013e",
     "EventName": "PM_MRK_STALL_CMPLU_CYC",
     "BriefDescription": "Marked Group completion Stall",
     "PublicDescription": "Marked Group Completion Stall cycles (use edge detect to count #)"
   },
-  {,
+  {
     "EventCode": "0x3e158",
     "EventName": "PM_MRK_STCX_FAIL",
     "BriefDescription": "marked stcx failed",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x10134",
     "EventName": "PM_MRK_ST_CMPL",
     "BriefDescription": "marked store completed and sent to nest",
     "PublicDescription": "Marked store completed"
   },
-  {,
+  {
     "EventCode": "0x30134",
     "EventName": "PM_MRK_ST_CMPL_INT",
     "BriefDescription": "marked store finished with intervention",
     "PublicDescription": "marked store complete (data home) with intervention"
   },
-  {,
+  {
     "EventCode": "0x3f150",
     "EventName": "PM_MRK_ST_DRAIN_TO_L2DISP_CYC",
     "BriefDescription": "cycles to drain st from core to L2",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3012c",
     "EventName": "PM_MRK_ST_FWD",
     "BriefDescription": "Marked st forwards",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1f150",
     "EventName": "PM_MRK_ST_L2DISP_TO_CMPL_CYC",
     "BriefDescription": "cycles from L2 rc disp to l2 rc completion",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x20138",
     "EventName": "PM_MRK_ST_NEST",
     "BriefDescription": "Marked store sent to nest",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30132",
     "EventName": "PM_MRK_VSU_FIN",
     "BriefDescription": "VSU marked instr finish",
     "PublicDescription": "vsu (fpu) marked instr finish"
   },
-  {,
+  {
     "EventCode": "0x3d15e",
     "EventName": "PM_MULT_MRK",
     "BriefDescription": "mult marked instr",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x15152",
     "EventName": "PM_SYNC_MRK_BR_LINK",
     "BriefDescription": "Marked Branch and link branch that can cause a synchronous interrupt",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1515c",
     "EventName": "PM_SYNC_MRK_BR_MPRED",
     "BriefDescription": "Marked Branch mispredict that can cause a synchronous interrupt",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x15156",
     "EventName": "PM_SYNC_MRK_FX_DIVIDE",
     "BriefDescription": "Marked fixed point divide that can cause a synchronous interrupt",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x15158",
     "EventName": "PM_SYNC_MRK_L2HIT",
     "BriefDescription": "Marked L2 Hits that can throw a synchronous interrupt",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1515a",
     "EventName": "PM_SYNC_MRK_L2MISS",
     "BriefDescription": "Marked L2 Miss that can throw a synchronous interrupt",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x15154",
     "EventName": "PM_SYNC_MRK_L3MISS",
     "BriefDescription": "Marked L3 misses that can throw a synchronous interrupt",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x15150",
     "EventName": "PM_SYNC_MRK_PROBE_NOP",
     "BriefDescription": "Marked probeNops which can cause synchronous interrupts",
     "PublicDescription": ""
-  },
+  }
 ]
diff --git a/tools/perf/pmu-events/arch/powerpc/power8/memory.json b/tools/perf/pmu-events/arch/powerpc/power8/memory.json
index 87cdaad..2ba3342 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/memory.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/memory.json
@@ -1,212 +1,212 @@
 [
-  {,
+  {
     "EventCode": "0x10050",
     "EventName": "PM_CHIP_PUMP_CPRED",
     "BriefDescription": "Initial and Final Pump Scope was chip pump (prediction=correct) for all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)",
     "PublicDescription": "Initial and Final Pump Scope and data sourced across this scope was chip pump (prediction=correct) for all data types ( demand load,data,inst prefetch,inst fetch,xlate (I or d)"
   },
-  {,
+  {
     "EventCode": "0x1c050",
     "EventName": "PM_DATA_CHIP_PUMP_CPRED",
     "BriefDescription": "Initial and Final Pump Scope was chip pump (prediction=correct) for a demand load",
     "PublicDescription": "Initial and Final Pump Scope and data sourced across this scope was chip pump (prediction=correct) for a demand load"
   },
-  {,
+  {
     "EventCode": "0x4c04c",
     "EventName": "PM_DATA_FROM_DMEM",
     "BriefDescription": "The processor's data cache was reloaded from another chip's memory on the same Node or Group (Distant) due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded from another chip's memory on the same Node or Group (Distant) due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x2c048",
     "EventName": "PM_DATA_FROM_LMEM",
     "BriefDescription": "The processor's data cache was reloaded from the local chip's Memory due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded from the local chip's Memory due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x2c04c",
     "EventName": "PM_DATA_FROM_MEMORY",
     "BriefDescription": "The processor's data cache was reloaded from a memory location including L4 from local remote or distant due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded from a memory location including L4 from local remote or distant due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x2c04a",
     "EventName": "PM_DATA_FROM_RL4",
     "BriefDescription": "The processor's data cache was reloaded from another chip's L4 on the same Node or Group ( Remote) due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded from another chip's L4 on the same Node or Group ( Remote) due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x3c04a",
     "EventName": "PM_DATA_FROM_RMEM",
     "BriefDescription": "The processor's data cache was reloaded from another chip's memory on the same Node or Group ( Remote) due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded from another chip's memory on the same Node or Group ( Remote) due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x2c050",
     "EventName": "PM_DATA_GRP_PUMP_CPRED",
     "BriefDescription": "Initial and Final Pump Scope was group pump (prediction=correct) for a demand load",
     "PublicDescription": "Initial and Final Pump Scope and data sourced across this scope was group pump for a demand load"
   },
-  {,
+  {
     "EventCode": "0x2c052",
     "EventName": "PM_DATA_GRP_PUMP_MPRED",
     "BriefDescription": "Final Pump Scope (Group) ended up either larger or smaller than Initial Pump Scope for a demand load",
     "PublicDescription": "Final Pump Scope(Group) to get data sourced, ended up larger than Initial Pump Scope OR Final Pump Scope(Group) got data from source that was at smaller scope(Chip) Final pump was group pump and initial pump was chip or final and initial pump was gro"
   },
-  {,
+  {
     "EventCode": "0x1c052",
     "EventName": "PM_DATA_GRP_PUMP_MPRED_RTY",
     "BriefDescription": "Final Pump Scope (Group) ended up larger than Initial Pump Scope (Chip) for a demand load",
     "PublicDescription": "Final Pump Scope(Group) to get data sourced, ended up larger than Initial Pump Scope (Chip) Final pump was group pump and initial pump was chip pumpfor a demand load"
   },
-  {,
+  {
     "EventCode": "0x1c054",
     "EventName": "PM_DATA_PUMP_CPRED",
     "BriefDescription": "Pump prediction correct. Counts across all types of pumps for a demand load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4c052",
     "EventName": "PM_DATA_PUMP_MPRED",
     "BriefDescription": "Pump misprediction. Counts across all types of pumps for a demand load",
     "PublicDescription": "Pump Mis prediction Counts across all types of pumpsfor a demand load"
   },
-  {,
+  {
     "EventCode": "0x3c050",
     "EventName": "PM_DATA_SYS_PUMP_CPRED",
     "BriefDescription": "Initial and Final Pump Scope was system pump (prediction=correct) for a demand load",
     "PublicDescription": "Initial and Final Pump Scope and data sourced across this scope was system pump for a demand load"
   },
-  {,
+  {
     "EventCode": "0x3c052",
     "EventName": "PM_DATA_SYS_PUMP_MPRED",
     "BriefDescription": "Final Pump Scope (system) mispredicted. Either the original scope was too small (Chip/Group) or the original scope was System and it should have been smaller. Counts for a demand load",
     "PublicDescription": "Final Pump Scope(system) to get data sourced, ended up larger than Initial Pump Scope(Chip/Group) OR Final Pump Scope(system) got data from source that was at smaller scope(Chip/group) Final pump was system pump and initial pump was chip or group or"
   },
-  {,
+  {
     "EventCode": "0x4c050",
     "EventName": "PM_DATA_SYS_PUMP_MPRED_RTY",
     "BriefDescription": "Final Pump Scope (system) ended up larger than Initial Pump Scope (Chip/Group) for a demand load",
     "PublicDescription": "Final Pump Scope(system) to get data sourced, ended up larger than Initial Pump Scope (Chip or Group) for a demand load"
   },
-  {,
+  {
     "EventCode": "0x3e04c",
     "EventName": "PM_DPTEG_FROM_DL4",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from another chip's L4 on a different Node or Group (Distant) due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4e04c",
     "EventName": "PM_DPTEG_FROM_DMEM",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from another chip's memory on the same Node or Group (Distant) due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3e04a",
     "EventName": "PM_DPTEG_FROM_RMEM",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from another chip's memory on the same Node or Group ( Remote) due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x20050",
     "EventName": "PM_GRP_PUMP_CPRED",
     "BriefDescription": "Initial and Final Pump Scope and data sourced across this scope was group pump for all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x20052",
     "EventName": "PM_GRP_PUMP_MPRED",
     "BriefDescription": "Final Pump Scope (Group) ended up either larger or smaller than Initial Pump Scope for all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)",
     "PublicDescription": "Final Pump Scope(Group) to get data sourced, ended up larger than Initial Pump Scope OR Final Pump Scope(Group) got data from source that was at smaller scope(Chip) Final pump was group pump and initial pump was chip or final and initial pump was gro"
   },
-  {,
+  {
     "EventCode": "0x10052",
     "EventName": "PM_GRP_PUMP_MPRED_RTY",
     "BriefDescription": "Final Pump Scope (Group) ended up larger than Initial Pump Scope (Chip) for all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)",
     "PublicDescription": "Final Pump Scope(Group) to get data sourced, ended up larger than Initial Pump Scope (Chip) Final pump was group pump and initial pump was chip pumpfor all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)"
   },
-  {,
+  {
     "EventCode": "0x18082",
     "EventName": "PM_L3_CO_MEPF",
     "BriefDescription": "L3 CO of line in Mep state ( includes casthrough",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4c058",
     "EventName": "PM_MEM_CO",
     "BriefDescription": "Memory castouts from this lpar",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x10058",
     "EventName": "PM_MEM_LOC_THRESH_IFU",
     "BriefDescription": "Local Memory above threshold for IFU speculation control",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x40056",
     "EventName": "PM_MEM_LOC_THRESH_LSU_HIGH",
     "BriefDescription": "Local memory above threshold for LSU medium",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1c05e",
     "EventName": "PM_MEM_LOC_THRESH_LSU_MED",
     "BriefDescription": "Local memory above theshold for data prefetch",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2c058",
     "EventName": "PM_MEM_PREF",
     "BriefDescription": "Memory prefetch for this lpar. Includes L4",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x10056",
     "EventName": "PM_MEM_READ",
     "BriefDescription": "Reads from Memory from this lpar (includes data/inst/xlate/l1prefetch/inst prefetch). Includes L4",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3c05e",
     "EventName": "PM_MEM_RWITM",
     "BriefDescription": "Memory rwitm for this lpar",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3006e",
     "EventName": "PM_NEST_REF_CLK",
     "BriefDescription": "Multiply by 4 to obtain the number of PB cycles",
     "PublicDescription": "Nest reference clocks"
   },
-  {,
+  {
     "EventCode": "0x10054",
     "EventName": "PM_PUMP_CPRED",
     "BriefDescription": "Pump prediction correct. Counts across all types of pumps for all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)",
     "PublicDescription": "Pump prediction correct. Counts across all types of pumpsfor all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)"
   },
-  {,
+  {
     "EventCode": "0x40052",
     "EventName": "PM_PUMP_MPRED",
     "BriefDescription": "Pump misprediction. Counts across all types of pumps for all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)",
     "PublicDescription": "Pump Mis prediction Counts across all types of pumpsfor all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)"
   },
-  {,
+  {
     "EventCode": "0x30050",
     "EventName": "PM_SYS_PUMP_CPRED",
     "BriefDescription": "Initial and Final Pump Scope was system pump for all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)",
     "PublicDescription": "Initial and Final Pump Scope and data sourced across this scope was system pump for all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)"
   },
-  {,
+  {
     "EventCode": "0x30052",
     "EventName": "PM_SYS_PUMP_MPRED",
     "BriefDescription": "Final Pump Scope (system) mispredicted. Either the original scope was too small (Chip/Group) or the original scope was System and it should have been smaller. Counts for all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)",
     "PublicDescription": "Final Pump Scope(system) to get data sourced, ended up larger than Initial Pump Scope(Chip/Group) OR Final Pump Scope(system) got data from source that was at smaller scope(Chip/group) Final pump was system pump and initial pump was chip or group or"
   },
-  {,
+  {
     "EventCode": "0x40050",
     "EventName": "PM_SYS_PUMP_MPRED_RTY",
     "BriefDescription": "Final Pump Scope (system) ended up larger than Initial Pump Scope (Chip/Group) for all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)",
     "PublicDescription": "Final Pump Scope(system) to get data sourced, ended up larger than Initial Pump Scope (Chip or Group) for all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)"
-  },
+  }
 ]
diff --git a/tools/perf/pmu-events/arch/powerpc/power8/other.json b/tools/perf/pmu-events/arch/powerpc/power8/other.json
index b2a3df0..f4e760c 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/other.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/other.json
@@ -1,3446 +1,3446 @@
 [
-  {,
+  {
     "EventCode": "0x1f05e",
     "EventName": "PM_1LPAR_CYC",
     "BriefDescription": "Number of cycles in single lpar mode. All threads in the core are assigned to the same lpar",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2006e",
     "EventName": "PM_2LPAR_CYC",
     "BriefDescription": "Cycles in 2-lpar mode. Threads 0-3 belong to Lpar0 and threads 4-7 belong to Lpar1",
     "PublicDescription": "Number of cycles in 2 lpar mode"
   },
-  {,
+  {
     "EventCode": "0x4e05e",
     "EventName": "PM_4LPAR_CYC",
     "BriefDescription": "Number of cycles in 4 LPAR mode. Threads 0-1 belong to lpar0, threads 2-3 belong to lpar1, threads 4-5 belong to lpar2, and threads 6-7 belong to lpar3",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x610050",
     "EventName": "PM_ALL_CHIP_PUMP_CPRED",
     "BriefDescription": "Initial and Final Pump Scope was chip pump (prediction=correct) for all data types (demand load,data prefetch,inst prefetch,inst fetch,xlate)",
     "PublicDescription": "Initial and Final Pump Scope and data sourced across this scope was chip pump (prediction=correct) for all data types ( demand load,data,inst prefetch,inst fetch,xlate (I or d)"
   },
-  {,
+  {
     "EventCode": "0x520050",
     "EventName": "PM_ALL_GRP_PUMP_CPRED",
     "BriefDescription": "Initial and Final Pump Scope and data sourced across this scope was group pump for all data types (demand load,data prefetch,inst prefetch,inst fetch,xlate)",
     "PublicDescription": "Initial and Final Pump Scope and data sourced across this scope was group pump for all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)"
   },
-  {,
+  {
     "EventCode": "0x620052",
     "EventName": "PM_ALL_GRP_PUMP_MPRED",
     "BriefDescription": "Final Pump Scope (Group) ended up either larger or smaller than Initial Pump Scope for all data types (demand load,data prefetch,inst prefetch,inst fetch,xlate)",
     "PublicDescription": "Final Pump Scope(Group) to get data sourced, ended up larger than Initial Pump Scope OR Final Pump Scope(Group) got data from source that was at smaller scope(Chip) Final pump was group pump and initial pump was chip or final and initial pump was gro"
   },
-  {,
+  {
     "EventCode": "0x610052",
     "EventName": "PM_ALL_GRP_PUMP_MPRED_RTY",
     "BriefDescription": "Final Pump Scope (Group) ended up larger than Initial Pump Scope (Chip) for all data types (demand load,data prefetch,inst prefetch,inst fetch,xlate)",
     "PublicDescription": "Final Pump Scope(Group) to get data sourced, ended up larger than Initial Pump Scope (Chip) Final pump was group pump and initial pump was chip pumpfor all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)"
   },
-  {,
+  {
     "EventCode": "0x610054",
     "EventName": "PM_ALL_PUMP_CPRED",
     "BriefDescription": "Pump prediction correct. Counts across all types of pumps for all data types (demand load,data prefetch,inst prefetch,inst fetch,xlate)",
     "PublicDescription": "Pump prediction correct. Counts across all types of pumpsfor all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)"
   },
-  {,
+  {
     "EventCode": "0x640052",
     "EventName": "PM_ALL_PUMP_MPRED",
     "BriefDescription": "Pump misprediction. Counts across all types of pumps for all data types (demand load,data prefetch,inst prefetch,inst fetch,xlate)",
     "PublicDescription": "Pump Mis prediction Counts across all types of pumpsfor all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)"
   },
-  {,
+  {
     "EventCode": "0x630050",
     "EventName": "PM_ALL_SYS_PUMP_CPRED",
     "BriefDescription": "Initial and Final Pump Scope was system pump for all data types (demand load,data prefetch,inst prefetch,inst fetch,xlate)",
     "PublicDescription": "Initial and Final Pump Scope and data sourced across this scope was system pump for all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)"
   },
-  {,
+  {
     "EventCode": "0x630052",
     "EventName": "PM_ALL_SYS_PUMP_MPRED",
     "BriefDescription": "Final Pump Scope (system) mispredicted. Either the original scope was too small (Chip/Group) or the original scope was System and it should have been smaller. Counts for all data types (demand load,data prefetch,inst prefetch,inst fetch,xlate)",
     "PublicDescription": "Final Pump Scope(system) to get data sourced, ended up larger than Initial Pump Scope(Chip/Group) OR Final Pump Scope(system) got data from source that was at smaller scope(Chip/group) Final pump was system pump and initial pump was chip or group or"
   },
-  {,
+  {
     "EventCode": "0x640050",
     "EventName": "PM_ALL_SYS_PUMP_MPRED_RTY",
     "BriefDescription": "Final Pump Scope (system) ended up larger than Initial Pump Scope (Chip/Group) for all data types (demand load,data prefetch,inst prefetch,inst fetch,xlate)",
     "PublicDescription": "Final Pump Scope(system) to get data sourced, ended up larger than Initial Pump Scope (Chip or Group) for all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)"
   },
-  {,
+  {
     "EventCode": "0x4082",
     "EventName": "PM_BANK_CONFLICT",
     "BriefDescription": "Read blocked due to interleave conflict. The ifar logic will detect an interleave conflict and kill the data that was read that cycle",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x5086",
     "EventName": "PM_BR_BC_8",
     "BriefDescription": "Pairable BC+8 branch that has not been converted to a Resolve Finished in the BRU pipeline",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x5084",
     "EventName": "PM_BR_BC_8_CONV",
     "BriefDescription": "Pairable BC+8 branch that was converted to a Resolve Finished in the BRU pipeline",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x40ac",
     "EventName": "PM_BR_MPRED_CCACHE",
     "BriefDescription": "Conditional Branch Completed that was Mispredicted due to the Count Cache Target Prediction",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x40b8",
     "EventName": "PM_BR_MPRED_CR",
     "BriefDescription": "Conditional Branch Completed that was Mispredicted due to the BHT Direction Prediction (taken/not taken)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x40ae",
     "EventName": "PM_BR_MPRED_LSTACK",
     "BriefDescription": "Conditional Branch Completed that was Mispredicted due to the Link Stack Target Prediction",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x40ba",
     "EventName": "PM_BR_MPRED_TA",
     "BriefDescription": "Conditional Branch Completed that was Mispredicted due to the Target Address Prediction from the Count Cache or Link Stack. Only XL-form branches that resolved Taken set this event",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x10138",
     "EventName": "PM_BR_MRK_2PATH",
     "BriefDescription": "marked two path branch",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x409c",
     "EventName": "PM_BR_PRED_BR0",
     "BriefDescription": "Conditional Branch Completed on BR0 (1st branch in group) in which the HW predicted the Direction or Target",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x409e",
     "EventName": "PM_BR_PRED_BR1",
     "BriefDescription": "Conditional Branch Completed on BR1 (2nd branch in group) in which the HW predicted the Direction or Target. Note: BR1 can only be used in Single Thread Mode. In all of the SMT modes, only one branch can complete, thus BR1 is unused",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x489c",
     "EventName": "PM_BR_PRED_BR_CMPL",
     "BriefDescription": "Completion Time Event. This event can also be calculated from the direct bus as follows: if_pc_br0_br_pred(0) OR if_pc_br0_br_pred(1)",
     "PublicDescription": "IFU"
   },
-  {,
+  {
     "EventCode": "0x40a4",
     "EventName": "PM_BR_PRED_CCACHE_BR0",
     "BriefDescription": "Conditional Branch Completed on BR0 that used the Count Cache for Target Prediction",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x40a6",
     "EventName": "PM_BR_PRED_CCACHE_BR1",
     "BriefDescription": "Conditional Branch Completed on BR1 that used the Count Cache for Target Prediction",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x48a4",
     "EventName": "PM_BR_PRED_CCACHE_CMPL",
     "BriefDescription": "Completion Time Event. This event can also be calculated from the direct bus as follows: if_pc_br0_br_pred(0) AND if_pc_br0_pred_type",
     "PublicDescription": "IFU"
   },
-  {,
+  {
     "EventCode": "0x40b0",
     "EventName": "PM_BR_PRED_CR_BR0",
     "BriefDescription": "Conditional Branch Completed on BR0 that had its direction predicted. I-form branches do not set this event. In addition, B-form branches which do not use the BHT do not set this event - these are branches with BO-field set to 'always taken' and branches",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x40b2",
     "EventName": "PM_BR_PRED_CR_BR1",
     "BriefDescription": "Conditional Branch Completed on BR1 that had its direction predicted. I-form branches do not set this event. In addition, B-form branches which do not use the BHT do not set this event - these are branches with BO-field set to 'always taken' and branches",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x48b0",
     "EventName": "PM_BR_PRED_CR_CMPL",
     "BriefDescription": "Completion Time Event. This event can also be calculated from the direct bus as follows: if_pc_br0_br_pred(1)='1'",
     "PublicDescription": "IFU"
   },
-  {,
+  {
     "EventCode": "0x40a8",
     "EventName": "PM_BR_PRED_LSTACK_BR0",
     "BriefDescription": "Conditional Branch Completed on BR0 that used the Link Stack for Target Prediction",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x40aa",
     "EventName": "PM_BR_PRED_LSTACK_BR1",
     "BriefDescription": "Conditional Branch Completed on BR1 that used the Link Stack for Target Prediction",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x48a8",
     "EventName": "PM_BR_PRED_LSTACK_CMPL",
     "BriefDescription": "Completion Time Event. This event can also be calculated from the direct bus as follows: if_pc_br0_br_pred(0) AND (not if_pc_br0_pred_type)",
     "PublicDescription": "IFU"
   },
-  {,
+  {
     "EventCode": "0x40b4",
     "EventName": "PM_BR_PRED_TA_BR0",
     "BriefDescription": "Conditional Branch Completed on BR0 that had its target address predicted. Only XL-form branches set this event",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x40b6",
     "EventName": "PM_BR_PRED_TA_BR1",
     "BriefDescription": "Conditional Branch Completed on BR1 that had its target address predicted. Only XL-form branches set this event",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x48b4",
     "EventName": "PM_BR_PRED_TA_CMPL",
     "BriefDescription": "Completion Time Event. This event can also be calculated from the direct bus as follows: if_pc_br0_br_pred(0)='1'",
     "PublicDescription": "IFU"
   },
-  {,
+  {
     "EventCode": "0x40a0",
     "EventName": "PM_BR_UNCOND_BR0",
     "BriefDescription": "Unconditional Branch Completed on BR0. HW branch prediction was not used for this branch. This can be an I-form branch, a B-form branch with BO-field set to branch always, or a B-form branch which was coverted to a Resolve",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x40a2",
     "EventName": "PM_BR_UNCOND_BR1",
     "BriefDescription": "Unconditional Branch Completed on BR1. HW branch prediction was not used for this branch. This can be an I-form branch, a B-form branch with BO-field set to branch always, or a B-form branch which was coverted to a Resolve",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x48a0",
     "EventName": "PM_BR_UNCOND_CMPL",
     "BriefDescription": "Completion Time Event. This event can also be calculated from the direct bus as follows: if_pc_br0_br_pred=00 AND if_pc_br0_completed",
     "PublicDescription": "IFU"
   },
-  {,
+  {
     "EventCode": "0x3094",
     "EventName": "PM_CASTOUT_ISSUED",
     "BriefDescription": "Castouts issued",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3096",
     "EventName": "PM_CASTOUT_ISSUED_GPR",
     "BriefDescription": "Castouts issued GPR",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2090",
     "EventName": "PM_CLB_HELD",
     "BriefDescription": "CLB Hold: Any Reason",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2d018",
     "EventName": "PM_CMPLU_STALL_BRU_CRU",
     "BriefDescription": "Completion stall due to IFU",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30026",
     "EventName": "PM_CMPLU_STALL_COQ_FULL",
     "BriefDescription": "Completion stall due to CO q full",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30038",
     "EventName": "PM_CMPLU_STALL_FLUSH",
     "BriefDescription": "completion stall due to flush by own thread",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30028",
     "EventName": "PM_CMPLU_STALL_MEM_ECC_DELAY",
     "BriefDescription": "Completion stall due to mem ECC delay",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2e01c",
     "EventName": "PM_CMPLU_STALL_NO_NTF",
     "BriefDescription": "Completion stall due to nop",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2e01e",
     "EventName": "PM_CMPLU_STALL_NTCG_FLUSH",
     "BriefDescription": "Completion stall due to ntcg flush",
     "PublicDescription": "Completion stall due to reject (load hit store)"
   },
-  {,
+  {
     "EventCode": "0x4c010",
     "EventName": "PM_CMPLU_STALL_REJECT",
     "BriefDescription": "Completion stall due to LSU reject",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2c01a",
     "EventName": "PM_CMPLU_STALL_REJECT_LHS",
     "BriefDescription": "Completion stall due to reject (load hit store)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4c014",
     "EventName": "PM_CMPLU_STALL_REJ_LMQ_FULL",
     "BriefDescription": "Completion stall due to LSU reject LMQ full",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4d010",
     "EventName": "PM_CMPLU_STALL_SCALAR",
     "BriefDescription": "Completion stall due to VSU scalar instruction",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2d010",
     "EventName": "PM_CMPLU_STALL_SCALAR_LONG",
     "BriefDescription": "Completion stall due to VSU scalar long latency instruction",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2c014",
     "EventName": "PM_CMPLU_STALL_STORE",
     "BriefDescription": "Completion stall by stores this includes store agen finishes in pipe LS0/LS1 and store data finishes in LS2/LS3",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2d014",
     "EventName": "PM_CMPLU_STALL_VECTOR",
     "BriefDescription": "Completion stall due to VSU vector instruction",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4d012",
     "EventName": "PM_CMPLU_STALL_VECTOR_LONG",
     "BriefDescription": "Completion stall due to VSU vector long instruction",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2d012",
     "EventName": "PM_CMPLU_STALL_VSU",
     "BriefDescription": "Completion stall due to VSU instruction",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x16083",
     "EventName": "PM_CO0_ALLOC",
     "BriefDescription": "CO mach 0 Busy. Used by PMU to sample ave RC livetime(mach0 used as sample point)",
     "PublicDescription": "0.0"
   },
-  {,
+  {
     "EventCode": "0x16082",
     "EventName": "PM_CO0_BUSY",
     "BriefDescription": "CO mach 0 Busy. Used by PMU to sample ave RC livetime(mach0 used as sample point)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3608a",
     "EventName": "PM_CO_USAGE",
     "BriefDescription": "Continuous 16 cycle(2to1) window where this signals rotates thru sampling each L2 CO machine busy. PMU uses this wave to then do 16 cyc count to sample total number of machs running",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x40066",
     "EventName": "PM_CRU_FIN",
     "BriefDescription": "IFU Finished a (non-branch) instruction",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x61c050",
     "EventName": "PM_DATA_ALL_CHIP_PUMP_CPRED",
     "BriefDescription": "Initial and Final Pump Scope was chip pump (prediction=correct) for either demand loads or data prefetch",
     "PublicDescription": "Initial and Final Pump Scope and data sourced across this scope was chip pump (prediction=correct) for a demand load"
   },
-  {,
+  {
     "EventCode": "0x64c048",
     "EventName": "PM_DATA_ALL_FROM_DL2L3_MOD",
     "BriefDescription": "The processor's data cache was reloaded with Modified (M) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded with Modified (M) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x63c048",
     "EventName": "PM_DATA_ALL_FROM_DL2L3_SHR",
     "BriefDescription": "The processor's data cache was reloaded with Shared (S) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded with Shared (S) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x63c04c",
     "EventName": "PM_DATA_ALL_FROM_DL4",
     "BriefDescription": "The processor's data cache was reloaded from another chip's L4 on a different Node or Group (Distant) due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded from another chip's L4 on a different Node or Group (Distant) due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x64c04c",
     "EventName": "PM_DATA_ALL_FROM_DMEM",
     "BriefDescription": "The processor's data cache was reloaded from another chip's memory on the same Node or Group (Distant) due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded from another chip's memory on the same Node or Group (Distant) due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x61c042",
     "EventName": "PM_DATA_ALL_FROM_L2",
     "BriefDescription": "The processor's data cache was reloaded from local core's L2 due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded from local core's L2 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x64c046",
     "EventName": "PM_DATA_ALL_FROM_L21_MOD",
     "BriefDescription": "The processor's data cache was reloaded with Modified (M) data from another core's L2 on the same chip due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded with Modified (M) data from another core's L2 on the same chip due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x63c046",
     "EventName": "PM_DATA_ALL_FROM_L21_SHR",
     "BriefDescription": "The processor's data cache was reloaded with Shared (S) data from another core's L2 on the same chip due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded with Shared (S) data from another core's L2 on the same chip due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x61c04e",
     "EventName": "PM_DATA_ALL_FROM_L2MISS_MOD",
     "BriefDescription": "The processor's data cache was reloaded from a localtion other than the local core's L2 due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded from a localtion other than the local core's L2 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x63c040",
     "EventName": "PM_DATA_ALL_FROM_L2_DISP_CONFLICT_LDHITST",
     "BriefDescription": "The processor's data cache was reloaded from local core's L2 with load hit store conflict due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded from local core's L2 with load hit store conflict due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x64c040",
     "EventName": "PM_DATA_ALL_FROM_L2_DISP_CONFLICT_OTHER",
     "BriefDescription": "The processor's data cache was reloaded from local core's L2 with dispatch conflict due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded from local core's L2 with dispatch conflict due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x62c040",
     "EventName": "PM_DATA_ALL_FROM_L2_MEPF",
     "BriefDescription": "The processor's data cache was reloaded from local core's L2 hit without dispatch conflicts on Mepf state due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded from local core's L2 hit without dispatch conflicts on Mepf state due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x61c040",
     "EventName": "PM_DATA_ALL_FROM_L2_NO_CONFLICT",
     "BriefDescription": "The processor's data cache was reloaded from local core's L2 without conflict due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded from local core's L2 without conflict due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x64c042",
     "EventName": "PM_DATA_ALL_FROM_L3",
     "BriefDescription": "The processor's data cache was reloaded from local core's L3 due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded from local core's L3 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x64c044",
     "EventName": "PM_DATA_ALL_FROM_L31_ECO_MOD",
     "BriefDescription": "The processor's data cache was reloaded with Modified (M) data from another core's ECO L3 on the same chip due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded with Modified (M) data from another core's ECO L3 on the same chip due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x63c044",
     "EventName": "PM_DATA_ALL_FROM_L31_ECO_SHR",
     "BriefDescription": "The processor's data cache was reloaded with Shared (S) data from another core's ECO L3 on the same chip due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded with Shared (S) data from another core's ECO L3 on the same chip due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x62c044",
     "EventName": "PM_DATA_ALL_FROM_L31_MOD",
     "BriefDescription": "The processor's data cache was reloaded with Modified (M) data from another core's L3 on the same chip due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded with Modified (M) data from another core's L3 on the same chip due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x61c046",
     "EventName": "PM_DATA_ALL_FROM_L31_SHR",
     "BriefDescription": "The processor's data cache was reloaded with Shared (S) data from another core's L3 on the same chip due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded with Shared (S) data from another core's L3 on the same chip due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x64c04e",
     "EventName": "PM_DATA_ALL_FROM_L3MISS_MOD",
     "BriefDescription": "The processor's data cache was reloaded from a localtion other than the local core's L3 due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded from a localtion other than the local core's L3 due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x63c042",
     "EventName": "PM_DATA_ALL_FROM_L3_DISP_CONFLICT",
     "BriefDescription": "The processor's data cache was reloaded from local core's L3 with dispatch conflict due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded from local core's L3 with dispatch conflict due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x62c042",
     "EventName": "PM_DATA_ALL_FROM_L3_MEPF",
     "BriefDescription": "The processor's data cache was reloaded from local core's L3 without dispatch conflicts hit on Mepf state due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded from local core's L3 without dispatch conflicts hit on Mepf state due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x61c044",
     "EventName": "PM_DATA_ALL_FROM_L3_NO_CONFLICT",
     "BriefDescription": "The processor's data cache was reloaded from local core's L3 without conflict due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded from local core's L3 without conflict due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x61c04c",
     "EventName": "PM_DATA_ALL_FROM_LL4",
     "BriefDescription": "The processor's data cache was reloaded from the local chip's L4 cache due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded from the local chip's L4 cache due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x62c048",
     "EventName": "PM_DATA_ALL_FROM_LMEM",
     "BriefDescription": "The processor's data cache was reloaded from the local chip's Memory due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded from the local chip's Memory due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x62c04c",
     "EventName": "PM_DATA_ALL_FROM_MEMORY",
     "BriefDescription": "The processor's data cache was reloaded from a memory location including L4 from local remote or distant due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded from a memory location including L4 from local remote or distant due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x64c04a",
     "EventName": "PM_DATA_ALL_FROM_OFF_CHIP_CACHE",
     "BriefDescription": "The processor's data cache was reloaded either shared or modified data from another core's L2/L3 on a different chip (remote or distant) due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded either shared or modified data from another core's L2/L3 on a different chip (remote or distant) due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x61c048",
     "EventName": "PM_DATA_ALL_FROM_ON_CHIP_CACHE",
     "BriefDescription": "The processor's data cache was reloaded either shared or modified data from another core's L2/L3 on the same chip due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded either shared or modified data from another core's L2/L3 on the same chip due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x62c046",
     "EventName": "PM_DATA_ALL_FROM_RL2L3_MOD",
     "BriefDescription": "The processor's data cache was reloaded with Modified (M) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded with Modified (M) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x61c04a",
     "EventName": "PM_DATA_ALL_FROM_RL2L3_SHR",
     "BriefDescription": "The processor's data cache was reloaded with Shared (S) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded with Shared (S) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x62c04a",
     "EventName": "PM_DATA_ALL_FROM_RL4",
     "BriefDescription": "The processor's data cache was reloaded from another chip's L4 on the same Node or Group ( Remote) due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded from another chip's L4 on the same Node or Group ( Remote) due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x63c04a",
     "EventName": "PM_DATA_ALL_FROM_RMEM",
     "BriefDescription": "The processor's data cache was reloaded from another chip's memory on the same Node or Group ( Remote) due to either demand loads or data prefetch",
     "PublicDescription": "The processor's data cache was reloaded from another chip's memory on the same Node or Group ( Remote) due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x62c050",
     "EventName": "PM_DATA_ALL_GRP_PUMP_CPRED",
     "BriefDescription": "Initial and Final Pump Scope was group pump (prediction=correct) for either demand loads or data prefetch",
     "PublicDescription": "Initial and Final Pump Scope and data sourced across this scope was group pump for a demand load"
   },
-  {,
+  {
     "EventCode": "0x62c052",
     "EventName": "PM_DATA_ALL_GRP_PUMP_MPRED",
     "BriefDescription": "Final Pump Scope (Group) ended up either larger or smaller than Initial Pump Scope for either demand loads or data prefetch",
     "PublicDescription": "Final Pump Scope(Group) to get data sourced, ended up larger than Initial Pump Scope OR Final Pump Scope(Group) got data from source that was at smaller scope(Chip) Final pump was group pump and initial pump was chip or final and initial pump was gro"
   },
-  {,
+  {
     "EventCode": "0x61c052",
     "EventName": "PM_DATA_ALL_GRP_PUMP_MPRED_RTY",
     "BriefDescription": "Final Pump Scope (Group) ended up larger than Initial Pump Scope (Chip) for either demand loads or data prefetch",
     "PublicDescription": "Final Pump Scope(Group) to get data sourced, ended up larger than Initial Pump Scope (Chip) Final pump was group pump and initial pump was chip pumpfor a demand load"
   },
-  {,
+  {
     "EventCode": "0x61c054",
     "EventName": "PM_DATA_ALL_PUMP_CPRED",
     "BriefDescription": "Pump prediction correct. Counts across all types of pumps for either demand loads or data prefetch",
     "PublicDescription": "Pump prediction correct. Counts across all types of pumps for a demand load"
   },
-  {,
+  {
     "EventCode": "0x64c052",
     "EventName": "PM_DATA_ALL_PUMP_MPRED",
     "BriefDescription": "Pump misprediction. Counts across all types of pumps for either demand loads or data prefetch",
     "PublicDescription": "Pump Mis prediction Counts across all types of pumpsfor a demand load"
   },
-  {,
+  {
     "EventCode": "0x63c050",
     "EventName": "PM_DATA_ALL_SYS_PUMP_CPRED",
     "BriefDescription": "Initial and Final Pump Scope was system pump (prediction=correct) for either demand loads or data prefetch",
     "PublicDescription": "Initial and Final Pump Scope and data sourced across this scope was system pump for a demand load"
   },
-  {,
+  {
     "EventCode": "0x63c052",
     "EventName": "PM_DATA_ALL_SYS_PUMP_MPRED",
     "BriefDescription": "Final Pump Scope (system) mispredicted. Either the original scope was too small (Chip/Group) or the original scope was System and it should have been smaller. Counts for either demand loads or data prefetch",
     "PublicDescription": "Final Pump Scope(system) to get data sourced, ended up larger than Initial Pump Scope(Chip/Group) OR Final Pump Scope(system) got data from source that was at smaller scope(Chip/group) Final pump was system pump and initial pump was chip or group or"
   },
-  {,
+  {
     "EventCode": "0x64c050",
     "EventName": "PM_DATA_ALL_SYS_PUMP_MPRED_RTY",
     "BriefDescription": "Final Pump Scope (system) ended up larger than Initial Pump Scope (Chip/Group) for either demand loads or data prefetch",
     "PublicDescription": "Final Pump Scope(system) to get data sourced, ended up larger than Initial Pump Scope (Chip or Group) for a demand load"
   },
-  {,
+  {
     "EventCode": "0x4c046",
     "EventName": "PM_DATA_FROM_L21_MOD",
     "BriefDescription": "The processor's data cache was reloaded with Modified (M) data from another core's L2 on the same chip due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded with Modified (M) data from another core's L2 on the same chip due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x3c046",
     "EventName": "PM_DATA_FROM_L21_SHR",
     "BriefDescription": "The processor's data cache was reloaded with Shared (S) data from another core's L2 on the same chip due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded with Shared (S) data from another core's L2 on the same chip due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x4c044",
     "EventName": "PM_DATA_FROM_L31_ECO_MOD",
     "BriefDescription": "The processor's data cache was reloaded with Modified (M) data from another core's ECO L3 on the same chip due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded with Modified (M) data from another core's ECO L3 on the same chip due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x3c044",
     "EventName": "PM_DATA_FROM_L31_ECO_SHR",
     "BriefDescription": "The processor's data cache was reloaded with Shared (S) data from another core's ECO L3 on the same chip due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded with Shared (S) data from another core's ECO L3 on the same chip due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x2c044",
     "EventName": "PM_DATA_FROM_L31_MOD",
     "BriefDescription": "The processor's data cache was reloaded with Modified (M) data from another core's L3 on the same chip due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded with Modified (M) data from another core's L3 on the same chip due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x1c046",
     "EventName": "PM_DATA_FROM_L31_SHR",
     "BriefDescription": "The processor's data cache was reloaded with Shared (S) data from another core's L3 on the same chip due to a demand load",
     "PublicDescription": "The processor's data cache was reloaded with Shared (S) data from another core's L3 on the same chip due to either only demand loads or demand loads plus prefetches if MMCR1[16] is 1"
   },
-  {,
+  {
     "EventCode": "0x400fe",
     "EventName": "PM_DATA_FROM_MEM",
     "BriefDescription": "The processor's data cache was reloaded from a memory location including L4 from local remote or distant due to a demand load",
     "PublicDescription": "Data cache reload from memory (including L4)"
   },
-  {,
+  {
     "EventCode": "0xe0bc",
     "EventName": "PM_DC_COLLISIONS",
     "BriefDescription": "DATA Cache collisions",
     "PublicDescription": "DATA Cache collisions42"
   },
-  {,
+  {
     "EventCode": "0x1e050",
     "EventName": "PM_DC_PREF_STREAM_ALLOC",
     "BriefDescription": "Stream marked valid. The stream could have been allocated through the hardware prefetch mechanism or through software. This is combined ls0 and ls1",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2e050",
     "EventName": "PM_DC_PREF_STREAM_CONF",
     "BriefDescription": "A demand load referenced a line in an active prefetch stream. The stream could have been allocated through the hardware prefetch mechanism or through software. Combine up + down",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4e050",
     "EventName": "PM_DC_PREF_STREAM_FUZZY_CONF",
     "BriefDescription": "A demand load referenced a line in an active fuzzy prefetch stream. The stream could have been allocated through the hardware prefetch mechanism or through software.Fuzzy stream confirm (out of order effects, or pf cant keep up)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3e050",
     "EventName": "PM_DC_PREF_STREAM_STRIDED_CONF",
     "BriefDescription": "A demand load referenced a line in an active strided prefetch stream. The stream could have been allocated through the hardware prefetch mechanism or through software",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb0ba",
     "EventName": "PM_DFU",
     "BriefDescription": "Finish DFU (all finish)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb0be",
     "EventName": "PM_DFU_DCFFIX",
     "BriefDescription": "Convert from fixed opcode finish (dcffix,dcffixq)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb0bc",
     "EventName": "PM_DFU_DENBCD",
     "BriefDescription": "BCD->DPD opcode finish (denbcd, denbcdq)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb0b8",
     "EventName": "PM_DFU_MC",
     "BriefDescription": "Finish DFU multicycle",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2092",
     "EventName": "PM_DISP_CLB_HELD_BAL",
     "BriefDescription": "Dispatch/CLB Hold: Balance",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2094",
     "EventName": "PM_DISP_CLB_HELD_RES",
     "BriefDescription": "Dispatch/CLB Hold: Resource",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x20a8",
     "EventName": "PM_DISP_CLB_HELD_SB",
     "BriefDescription": "Dispatch/CLB Hold: Scoreboard",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2098",
     "EventName": "PM_DISP_CLB_HELD_SYNC",
     "BriefDescription": "Dispatch/CLB Hold: Sync type instruction",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2096",
     "EventName": "PM_DISP_CLB_HELD_TLBIE",
     "BriefDescription": "Dispatch Hold: Due to TLBIE",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x20006",
     "EventName": "PM_DISP_HELD_IQ_FULL",
     "BriefDescription": "Dispatch held due to Issue q full",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1002a",
     "EventName": "PM_DISP_HELD_MAP_FULL",
     "BriefDescription": "Dispatch for this thread was held because the Mappers were full",
     "PublicDescription": "Dispatch held due to Mapper full"
   },
-  {,
+  {
     "EventCode": "0x30018",
     "EventName": "PM_DISP_HELD_SRQ_FULL",
     "BriefDescription": "Dispatch held due SRQ no room",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30a6",
     "EventName": "PM_DISP_HOLD_GCT_FULL",
     "BriefDescription": "Dispatch Hold Due to no space in the GCT",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30008",
     "EventName": "PM_DISP_WT",
     "BriefDescription": "Dispatched Starved",
     "PublicDescription": "Dispatched Starved (not held, nothing to dispatch)"
   },
-  {,
+  {
     "EventCode": "0x4e046",
     "EventName": "PM_DPTEG_FROM_L21_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another core's L2 on the same chip due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3e046",
     "EventName": "PM_DPTEG_FROM_L21_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another core's L2 on the same chip due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3e040",
     "EventName": "PM_DPTEG_FROM_L2_DISP_CONFLICT_LDHITST",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L2 with load hit store conflict due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4e040",
     "EventName": "PM_DPTEG_FROM_L2_DISP_CONFLICT_OTHER",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L2 with dispatch conflict due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4e044",
     "EventName": "PM_DPTEG_FROM_L31_ECO_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another core's ECO L3 on the same chip due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3e044",
     "EventName": "PM_DPTEG_FROM_L31_ECO_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another core's ECO L3 on the same chip due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2e044",
     "EventName": "PM_DPTEG_FROM_L31_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another core's L3 on the same chip due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1e046",
     "EventName": "PM_DPTEG_FROM_L31_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another core's L3 on the same chip due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x50a8",
     "EventName": "PM_EAT_FORCE_MISPRED",
     "BriefDescription": "XL-form branch was mispredicted due to the predicted target address missing from EAT. The EAT forces a mispredict in this case since there is no predicated target to validate. This is a rare case that may occur when the EAT is full and a branch is issue",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4084",
     "EventName": "PM_EAT_FULL_CYC",
     "BriefDescription": "Cycles No room in EAT",
     "PublicDescription": "Cycles No room in EATSet on bank conflict and case where no ibuffers available"
   },
-  {,
+  {
     "EventCode": "0x2080",
     "EventName": "PM_EE_OFF_EXT_INT",
     "BriefDescription": "Ee off and external interrupt",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x20b4",
     "EventName": "PM_FAV_TBEGIN",
     "BriefDescription": "Dispatch time Favored tbegin",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x100f4",
     "EventName": "PM_FLOP",
     "BriefDescription": "Floating Point Operation Finished",
     "PublicDescription": "Floating Point Operations Finished"
   },
-  {,
+  {
     "EventCode": "0xa0ae",
     "EventName": "PM_FLOP_SUM_SCALAR",
     "BriefDescription": "flops summary scalar instructions",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa0ac",
     "EventName": "PM_FLOP_SUM_VEC",
     "BriefDescription": "flops summary vector instructions",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2084",
     "EventName": "PM_FLUSH_BR_MPRED",
     "BriefDescription": "Flush caused by branch mispredict",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2082",
     "EventName": "PM_FLUSH_DISP",
     "BriefDescription": "Dispatch flush",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x208c",
     "EventName": "PM_FLUSH_DISP_SB",
     "BriefDescription": "Dispatch Flush: Scoreboard",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2088",
     "EventName": "PM_FLUSH_DISP_SYNC",
     "BriefDescription": "Dispatch Flush: Sync",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x208a",
     "EventName": "PM_FLUSH_DISP_TLBIE",
     "BriefDescription": "Dispatch Flush: TLBIE",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x208e",
     "EventName": "PM_FLUSH_LSU",
     "BriefDescription": "Flush initiated by LSU",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2086",
     "EventName": "PM_FLUSH_PARTIAL",
     "BriefDescription": "Partial flush",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa0b0",
     "EventName": "PM_FPU0_FCONV",
     "BriefDescription": "Convert instruction executed",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa0b8",
     "EventName": "PM_FPU0_FEST",
     "BriefDescription": "Estimate instruction executed",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa0b4",
     "EventName": "PM_FPU0_FRSP",
     "BriefDescription": "Round to single precision instruction executed",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa0b2",
     "EventName": "PM_FPU1_FCONV",
     "BriefDescription": "Convert instruction executed",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa0ba",
     "EventName": "PM_FPU1_FEST",
     "BriefDescription": "Estimate instruction executed",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa0b6",
     "EventName": "PM_FPU1_FRSP",
     "BriefDescription": "Round to single precision instruction executed",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x50b0",
     "EventName": "PM_FUSION_TOC_GRP0_1",
     "BriefDescription": "One pair of instructions fused with TOC in Group0",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x50ae",
     "EventName": "PM_FUSION_TOC_GRP0_2",
     "BriefDescription": "Two pairs of instructions fused with TOCin Group0",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x50ac",
     "EventName": "PM_FUSION_TOC_GRP0_3",
     "BriefDescription": "Three pairs of instructions fused with TOC in Group0",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x50b2",
     "EventName": "PM_FUSION_TOC_GRP1_1",
     "BriefDescription": "One pair of instructions fused with TOX in Group1",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x50b8",
     "EventName": "PM_FUSION_VSX_GRP0_1",
     "BriefDescription": "One pair of instructions fused with VSX in Group0",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x50b6",
     "EventName": "PM_FUSION_VSX_GRP0_2",
     "BriefDescription": "Two pairs of instructions fused with VSX in Group0",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x50b4",
     "EventName": "PM_FUSION_VSX_GRP0_3",
     "BriefDescription": "Three pairs of instructions fused with VSX in Group0",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x50ba",
     "EventName": "PM_FUSION_VSX_GRP1_1",
     "BriefDescription": "One pair of instructions fused with VSX in Group1",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3000e",
     "EventName": "PM_FXU0_BUSY_FXU1_IDLE",
     "BriefDescription": "fxu0 busy and fxu1 idle",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x10004",
     "EventName": "PM_FXU0_FIN",
     "BriefDescription": "The fixed point unit Unit 0 finished an instruction. Instructions that finish may not necessary complete",
     "PublicDescription": "FXU0 Finished"
   },
-  {,
+  {
     "EventCode": "0x4000e",
     "EventName": "PM_FXU1_BUSY_FXU0_IDLE",
     "BriefDescription": "fxu0 idle and fxu1 busy",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x40004",
     "EventName": "PM_FXU1_FIN",
     "BriefDescription": "FXU1 Finished",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x20008",
     "EventName": "PM_GCT_EMPTY_CYC",
     "BriefDescription": "No itags assigned either thread (GCT Empty)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30a4",
     "EventName": "PM_GCT_MERGE",
     "BriefDescription": "Group dispatched on a merged GCT empty. GCT entries can be merged only within the same thread",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4d01e",
     "EventName": "PM_GCT_NOSLOT_BR_MPRED",
     "BriefDescription": "Gct empty for this thread due to branch mispred",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4d01a",
     "EventName": "PM_GCT_NOSLOT_BR_MPRED_ICMISS",
     "BriefDescription": "Gct empty for this thread due to Icache Miss and branch mispred",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x100f8",
     "EventName": "PM_GCT_NOSLOT_CYC",
     "BriefDescription": "No itags assigned",
     "PublicDescription": "Pipeline empty (No itags assigned , no GCT slots used)"
   },
-  {,
+  {
     "EventCode": "0x2d01e",
     "EventName": "PM_GCT_NOSLOT_DISP_HELD_ISSQ",
     "BriefDescription": "Gct empty for this thread due to dispatch hold on this thread due to Issue q full",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4d01c",
     "EventName": "PM_GCT_NOSLOT_DISP_HELD_MAP",
     "BriefDescription": "Gct empty for this thread due to dispatch hold on this thread due to Mapper full",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2e010",
     "EventName": "PM_GCT_NOSLOT_DISP_HELD_OTHER",
     "BriefDescription": "Gct empty for this thread due to dispatch hold on this thread due to sync",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2d01c",
     "EventName": "PM_GCT_NOSLOT_DISP_HELD_SRQ",
     "BriefDescription": "Gct empty for this thread due to dispatch hold on this thread due to SRQ full",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4e010",
     "EventName": "PM_GCT_NOSLOT_IC_L3MISS",
     "BriefDescription": "Gct empty for this thread due to icach l3 miss",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2d01a",
     "EventName": "PM_GCT_NOSLOT_IC_MISS",
     "BriefDescription": "Gct empty for this thread due to Icache Miss",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x20a2",
     "EventName": "PM_GCT_UTIL_11_14_ENTRIES",
     "BriefDescription": "GCT Utilization 11-14 entries",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x20a4",
     "EventName": "PM_GCT_UTIL_15_17_ENTRIES",
     "BriefDescription": "GCT Utilization 15-17 entries",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x20a6",
     "EventName": "PM_GCT_UTIL_18_ENTRIES",
     "BriefDescription": "GCT Utilization 18+ entries",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x209c",
     "EventName": "PM_GCT_UTIL_1_2_ENTRIES",
     "BriefDescription": "GCT Utilization 1-2 entries",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x209e",
     "EventName": "PM_GCT_UTIL_3_6_ENTRIES",
     "BriefDescription": "GCT Utilization 3-6 entries",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x20a0",
     "EventName": "PM_GCT_UTIL_7_10_ENTRIES",
     "BriefDescription": "GCT Utilization 7-10 entries",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1000a",
     "EventName": "PM_GRP_BR_MPRED_NONSPEC",
     "BriefDescription": "Group experienced non-speculative branch redirect",
     "PublicDescription": "Group experienced Non-speculative br mispredicct"
   },
-  {,
+  {
     "EventCode": "0x30004",
     "EventName": "PM_GRP_CMPL",
     "BriefDescription": "group completed",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3000a",
     "EventName": "PM_GRP_DISP",
     "BriefDescription": "group dispatch",
     "PublicDescription": "dispatch_success (Group Dispatched)"
   },
-  {,
+  {
     "EventCode": "0x1000c",
     "EventName": "PM_GRP_IC_MISS_NONSPEC",
     "BriefDescription": "Group experienced non-speculative I cache miss",
     "PublicDescription": "Group experi enced Non-specu lative I cache miss"
   },
-  {,
+  {
     "EventCode": "0x10130",
     "EventName": "PM_GRP_MRK",
     "BriefDescription": "Instruction Marked",
     "PublicDescription": "Instruction marked in idu"
   },
-  {,
+  {
     "EventCode": "0x509c",
     "EventName": "PM_GRP_NON_FULL_GROUP",
     "BriefDescription": "GROUPs where we did not have 6 non branch instructions in the group(ST mode), in SMT mode 3 non branches",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x50a4",
     "EventName": "PM_GRP_TERM_2ND_BRANCH",
     "BriefDescription": "There were enough instructions in the Ibuffer, but 2nd branch ends group",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x50a6",
     "EventName": "PM_GRP_TERM_FPU_AFTER_BR",
     "BriefDescription": "There were enough instructions in the Ibuffer, but FPU OP IN same group after a branch terminates a group, cant do partial flushes",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x509e",
     "EventName": "PM_GRP_TERM_NOINST",
     "BriefDescription": "Do not fill every slot in the group, Not enough instructions in the Ibuffer. This includes cases where the group started with enough instructions, but some got knocked out by a cache miss or branch redirect (which would also empty the Ibuffer)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x50a0",
     "EventName": "PM_GRP_TERM_OTHER",
     "BriefDescription": "There were enough instructions in the Ibuffer, but the group terminated early for some other reason, most likely due to a First or Last",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x50a2",
     "EventName": "PM_GRP_TERM_SLOT_LIMIT",
     "BriefDescription": "There were enough instructions in the Ibuffer, but 3 src RA/RB/RC , 2 way crack caused a group termination",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4086",
     "EventName": "PM_IBUF_FULL_CYC",
     "BriefDescription": "Cycles No room in ibuff",
     "PublicDescription": "Cycles No room in ibufffully qualified transfer (if5 valid)"
   },
-  {,
+  {
     "EventCode": "0x4098",
     "EventName": "PM_IC_DEMAND_L2_BHT_REDIRECT",
     "BriefDescription": "L2 I cache demand request due to BHT redirect, branch redirect ( 2 bubbles 3 cycles)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x409a",
     "EventName": "PM_IC_DEMAND_L2_BR_REDIRECT",
     "BriefDescription": "L2 I cache demand request due to branch Mispredict ( 15 cycle path)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4088",
     "EventName": "PM_IC_DEMAND_REQ",
     "BriefDescription": "Demand Instruction fetch request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x508a",
     "EventName": "PM_IC_INVALIDATE",
     "BriefDescription": "Ic line invalidated",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4092",
     "EventName": "PM_IC_PREF_CANCEL_HIT",
     "BriefDescription": "Prefetch Canceled due to icache hit",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4094",
     "EventName": "PM_IC_PREF_CANCEL_L2",
     "BriefDescription": "L2 Squashed request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4090",
     "EventName": "PM_IC_PREF_CANCEL_PAGE",
     "BriefDescription": "Prefetch Canceled due to page boundary",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x408a",
     "EventName": "PM_IC_PREF_REQ",
     "BriefDescription": "Instruction prefetch requests",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x408e",
     "EventName": "PM_IC_PREF_WRITE",
     "BriefDescription": "Instruction prefetch written into IL1",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4096",
     "EventName": "PM_IC_RELOAD_PRIVATE",
     "BriefDescription": "Reloading line was brought in private for a specific thread. Most lines are brought in shared for all eight thrreads. If RA does not match then invalidates and then brings it shared to other thread. In P7 line brought in private , then line was invalidat",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x5088",
     "EventName": "PM_IFU_L2_TOUCH",
     "BriefDescription": "L2 touch to update MRU on a line",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x514050",
     "EventName": "PM_INST_ALL_CHIP_PUMP_CPRED",
     "BriefDescription": "Initial and Final Pump Scope was chip pump (prediction=correct) for instruction fetches and prefetches",
     "PublicDescription": "Initial and Final Pump Scope and data sourced across this scope was chip pump (prediction=correct) for an instruction fetch"
   },
-  {,
+  {
     "EventCode": "0x544048",
     "EventName": "PM_INST_ALL_FROM_DL2L3_MOD",
     "BriefDescription": "The processor's Instruction cache was reloaded with Modified (M) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded with Modified (M) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x534048",
     "EventName": "PM_INST_ALL_FROM_DL2L3_SHR",
     "BriefDescription": "The processor's Instruction cache was reloaded with Shared (S) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded with Shared (S) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x53404c",
     "EventName": "PM_INST_ALL_FROM_DL4",
     "BriefDescription": "The processor's Instruction cache was reloaded from another chip's L4 on a different Node or Group (Distant) due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded from another chip's L4 on a different Node or Group (Distant) due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x54404c",
     "EventName": "PM_INST_ALL_FROM_DMEM",
     "BriefDescription": "The processor's Instruction cache was reloaded from another chip's memory on the same Node or Group (Distant) due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded from another chip's memory on the same Node or Group (Distant) due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x514042",
     "EventName": "PM_INST_ALL_FROM_L2",
     "BriefDescription": "The processor's Instruction cache was reloaded from local core's L2 due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded from local core's L2 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x544046",
     "EventName": "PM_INST_ALL_FROM_L21_MOD",
     "BriefDescription": "The processor's Instruction cache was reloaded with Modified (M) data from another core's L2 on the same chip due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded with Modified (M) data from another core's L2 on the same chip due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x534046",
     "EventName": "PM_INST_ALL_FROM_L21_SHR",
     "BriefDescription": "The processor's Instruction cache was reloaded with Shared (S) data from another core's L2 on the same chip due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded with Shared (S) data from another core's L2 on the same chip due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x51404e",
     "EventName": "PM_INST_ALL_FROM_L2MISS",
     "BriefDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L2 due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L2 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x534040",
     "EventName": "PM_INST_ALL_FROM_L2_DISP_CONFLICT_LDHITST",
     "BriefDescription": "The processor's Instruction cache was reloaded from local core's L2 with load hit store conflict due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded from local core's L2 with load hit store conflict due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x544040",
     "EventName": "PM_INST_ALL_FROM_L2_DISP_CONFLICT_OTHER",
     "BriefDescription": "The processor's Instruction cache was reloaded from local core's L2 with dispatch conflict due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded from local core's L2 with dispatch conflict due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x524040",
     "EventName": "PM_INST_ALL_FROM_L2_MEPF",
     "BriefDescription": "The processor's Instruction cache was reloaded from local core's L2 hit without dispatch conflicts on Mepf state. due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded from local core's L2 hit without dispatch conflicts on Mepf state. due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x514040",
     "EventName": "PM_INST_ALL_FROM_L2_NO_CONFLICT",
     "BriefDescription": "The processor's Instruction cache was reloaded from local core's L2 without conflict due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded from local core's L2 without conflict due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x544042",
     "EventName": "PM_INST_ALL_FROM_L3",
     "BriefDescription": "The processor's Instruction cache was reloaded from local core's L3 due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded from local core's L3 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x544044",
     "EventName": "PM_INST_ALL_FROM_L31_ECO_MOD",
     "BriefDescription": "The processor's Instruction cache was reloaded with Modified (M) data from another core's ECO L3 on the same chip due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded with Modified (M) data from another core's ECO L3 on the same chip due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x534044",
     "EventName": "PM_INST_ALL_FROM_L31_ECO_SHR",
     "BriefDescription": "The processor's Instruction cache was reloaded with Shared (S) data from another core's ECO L3 on the same chip due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded with Shared (S) data from another core's ECO L3 on the same chip due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x524044",
     "EventName": "PM_INST_ALL_FROM_L31_MOD",
     "BriefDescription": "The processor's Instruction cache was reloaded with Modified (M) data from another core's L3 on the same chip due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded with Modified (M) data from another core's L3 on the same chip due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x514046",
     "EventName": "PM_INST_ALL_FROM_L31_SHR",
     "BriefDescription": "The processor's Instruction cache was reloaded with Shared (S) data from another core's L3 on the same chip due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded with Shared (S) data from another core's L3 on the same chip due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x54404e",
     "EventName": "PM_INST_ALL_FROM_L3MISS_MOD",
     "BriefDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L3 due to a instruction fetch",
     "PublicDescription": "The processor's Instruction cache was reloaded from a localtion other than the local core's L3 due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x534042",
     "EventName": "PM_INST_ALL_FROM_L3_DISP_CONFLICT",
     "BriefDescription": "The processor's Instruction cache was reloaded from local core's L3 with dispatch conflict due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded from local core's L3 with dispatch conflict due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x524042",
     "EventName": "PM_INST_ALL_FROM_L3_MEPF",
     "BriefDescription": "The processor's Instruction cache was reloaded from local core's L3 without dispatch conflicts hit on Mepf state. due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded from local core's L3 without dispatch conflicts hit on Mepf state. due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x514044",
     "EventName": "PM_INST_ALL_FROM_L3_NO_CONFLICT",
     "BriefDescription": "The processor's Instruction cache was reloaded from local core's L3 without conflict due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded from local core's L3 without conflict due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x51404c",
     "EventName": "PM_INST_ALL_FROM_LL4",
     "BriefDescription": "The processor's Instruction cache was reloaded from the local chip's L4 cache due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded from the local chip's L4 cache due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x524048",
     "EventName": "PM_INST_ALL_FROM_LMEM",
     "BriefDescription": "The processor's Instruction cache was reloaded from the local chip's Memory due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded from the local chip's Memory due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x52404c",
     "EventName": "PM_INST_ALL_FROM_MEMORY",
     "BriefDescription": "The processor's Instruction cache was reloaded from a memory location including L4 from local remote or distant due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded from a memory location including L4 from local remote or distant due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x54404a",
     "EventName": "PM_INST_ALL_FROM_OFF_CHIP_CACHE",
     "BriefDescription": "The processor's Instruction cache was reloaded either shared or modified data from another core's L2/L3 on a different chip (remote or distant) due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded either shared or modified data from another core's L2/L3 on a different chip (remote or distant) due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x514048",
     "EventName": "PM_INST_ALL_FROM_ON_CHIP_CACHE",
     "BriefDescription": "The processor's Instruction cache was reloaded either shared or modified data from another core's L2/L3 on the same chip due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded either shared or modified data from another core's L2/L3 on the same chip due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x524046",
     "EventName": "PM_INST_ALL_FROM_RL2L3_MOD",
     "BriefDescription": "The processor's Instruction cache was reloaded with Modified (M) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded with Modified (M) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x51404a",
     "EventName": "PM_INST_ALL_FROM_RL2L3_SHR",
     "BriefDescription": "The processor's Instruction cache was reloaded with Shared (S) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded with Shared (S) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x52404a",
     "EventName": "PM_INST_ALL_FROM_RL4",
     "BriefDescription": "The processor's Instruction cache was reloaded from another chip's L4 on the same Node or Group ( Remote) due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded from another chip's L4 on the same Node or Group ( Remote) due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x53404a",
     "EventName": "PM_INST_ALL_FROM_RMEM",
     "BriefDescription": "The processor's Instruction cache was reloaded from another chip's memory on the same Node or Group ( Remote) due to instruction fetches and prefetches",
     "PublicDescription": "The processor's Instruction cache was reloaded from another chip's memory on the same Node or Group ( Remote) due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x524050",
     "EventName": "PM_INST_ALL_GRP_PUMP_CPRED",
     "BriefDescription": "Initial and Final Pump Scope was group pump (prediction=correct) for instruction fetches and prefetches",
     "PublicDescription": "Initial and Final Pump Scope and data sourced across this scope was group pump for an instruction fetch"
   },
-  {,
+  {
     "EventCode": "0x524052",
     "EventName": "PM_INST_ALL_GRP_PUMP_MPRED",
     "BriefDescription": "Final Pump Scope (Group) ended up either larger or smaller than Initial Pump Scope for instruction fetches and prefetches",
     "PublicDescription": "Final Pump Scope(Group) to get data sourced, ended up larger than Initial Pump Scope OR Final Pump Scope(Group) got data from source that was at smaller scope(Chip) Final pump was group pump and initial pump was chip or final and initial pump was gro"
   },
-  {,
+  {
     "EventCode": "0x514052",
     "EventName": "PM_INST_ALL_GRP_PUMP_MPRED_RTY",
     "BriefDescription": "Final Pump Scope (Group) ended up larger than Initial Pump Scope (Chip) for instruction fetches and prefetches",
     "PublicDescription": "Final Pump Scope(Group) to get data sourced, ended up larger than Initial Pump Scope (Chip) Final pump was group pump and initial pump was chip pumpfor an instruction fetch"
   },
-  {,
+  {
     "EventCode": "0x514054",
     "EventName": "PM_INST_ALL_PUMP_CPRED",
     "BriefDescription": "Pump prediction correct. Counts across all types of pumps for instruction fetches and prefetches",
     "PublicDescription": "Pump prediction correct. Counts across all types of pumpsfor an instruction fetch"
   },
-  {,
+  {
     "EventCode": "0x544052",
     "EventName": "PM_INST_ALL_PUMP_MPRED",
     "BriefDescription": "Pump misprediction. Counts across all types of pumps for instruction fetches and prefetches",
     "PublicDescription": "Pump Mis prediction Counts across all types of pumpsfor an instruction fetch"
   },
-  {,
+  {
     "EventCode": "0x534050",
     "EventName": "PM_INST_ALL_SYS_PUMP_CPRED",
     "BriefDescription": "Initial and Final Pump Scope was system pump (prediction=correct) for instruction fetches and prefetches",
     "PublicDescription": "Initial and Final Pump Scope and data sourced across this scope was system pump for an instruction fetch"
   },
-  {,
+  {
     "EventCode": "0x534052",
     "EventName": "PM_INST_ALL_SYS_PUMP_MPRED",
     "BriefDescription": "Final Pump Scope (system) mispredicted. Either the original scope was too small (Chip/Group) or the original scope was System and it should have been smaller. Counts for instruction fetches and prefetches",
     "PublicDescription": "Final Pump Scope(system) to get data sourced, ended up larger than Initial Pump Scope(Chip/Group) OR Final Pump Scope(system) got data from source that was at smaller scope(Chip/group) Final pump was system pump and initial pump was chip or group or"
   },
-  {,
+  {
     "EventCode": "0x544050",
     "EventName": "PM_INST_ALL_SYS_PUMP_MPRED_RTY",
     "BriefDescription": "Final Pump Scope (system) ended up larger than Initial Pump Scope (Chip/Group) for instruction fetches and prefetches",
     "PublicDescription": "Final Pump Scope(system) to get data sourced, ended up larger than Initial Pump Scope (Chip or Group) for an instruction fetch"
   },
-  {,
+  {
     "EventCode": "0x4080",
     "EventName": "PM_INST_FROM_L1",
     "BriefDescription": "Instruction fetches from L1",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x44046",
     "EventName": "PM_INST_FROM_L21_MOD",
     "BriefDescription": "The processor's Instruction cache was reloaded with Modified (M) data from another core's L2 on the same chip due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded with Modified (M) data from another core's L2 on the same chip due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x34046",
     "EventName": "PM_INST_FROM_L21_SHR",
     "BriefDescription": "The processor's Instruction cache was reloaded with Shared (S) data from another core's L2 on the same chip due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded with Shared (S) data from another core's L2 on the same chip due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x44044",
     "EventName": "PM_INST_FROM_L31_ECO_MOD",
     "BriefDescription": "The processor's Instruction cache was reloaded with Modified (M) data from another core's ECO L3 on the same chip due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded with Modified (M) data from another core's ECO L3 on the same chip due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x34044",
     "EventName": "PM_INST_FROM_L31_ECO_SHR",
     "BriefDescription": "The processor's Instruction cache was reloaded with Shared (S) data from another core's ECO L3 on the same chip due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded with Shared (S) data from another core's ECO L3 on the same chip due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x24044",
     "EventName": "PM_INST_FROM_L31_MOD",
     "BriefDescription": "The processor's Instruction cache was reloaded with Modified (M) data from another core's L3 on the same chip due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded with Modified (M) data from another core's L3 on the same chip due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x14046",
     "EventName": "PM_INST_FROM_L31_SHR",
     "BriefDescription": "The processor's Instruction cache was reloaded with Shared (S) data from another core's L3 on the same chip due to an instruction fetch (not prefetch)",
     "PublicDescription": "The processor's Instruction cache was reloaded with Shared (S) data from another core's L3 on the same chip due to either an instruction fetch or instruction fetch plus prefetch if MMCR1[17] is 1"
   },
-  {,
+  {
     "EventCode": "0x30016",
     "EventName": "PM_INST_IMC_MATCH_DISP",
     "BriefDescription": "Matched Instructions Dispatched",
     "PublicDescription": "IMC Matches dispatched"
   },
-  {,
+  {
     "EventCode": "0x30014",
     "EventName": "PM_IOPS_DISP",
     "BriefDescription": "Internal Operations dispatched",
     "PublicDescription": "IOPS dispatched"
   },
-  {,
+  {
     "EventCode": "0x45046",
     "EventName": "PM_IPTEG_FROM_L21_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another core's L2 on the same chip due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x35046",
     "EventName": "PM_IPTEG_FROM_L21_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another core's L2 on the same chip due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x35040",
     "EventName": "PM_IPTEG_FROM_L2_DISP_CONFLICT_LDHITST",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L2 with load hit store conflict due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x45040",
     "EventName": "PM_IPTEG_FROM_L2_DISP_CONFLICT_OTHER",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L2 with dispatch conflict due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x45044",
     "EventName": "PM_IPTEG_FROM_L31_ECO_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another core's ECO L3 on the same chip due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x35044",
     "EventName": "PM_IPTEG_FROM_L31_ECO_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another core's ECO L3 on the same chip due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x25044",
     "EventName": "PM_IPTEG_FROM_L31_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another core's L3 on the same chip due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x15046",
     "EventName": "PM_IPTEG_FROM_L31_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another core's L3 on the same chip due to a instruction side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4608e",
     "EventName": "PM_ISIDE_L2MEMACC",
     "BriefDescription": "valid when first beat of data comes in for an i-side fetch where data came from mem(or L4)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30ac",
     "EventName": "PM_ISU_REF_FX0",
     "BriefDescription": "FX0 ISU reject",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30ae",
     "EventName": "PM_ISU_REF_FX1",
     "BriefDescription": "FX1 ISU reject",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x38ac",
     "EventName": "PM_ISU_REF_FXU",
     "BriefDescription": "FXU ISU reject from either pipe",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30b0",
     "EventName": "PM_ISU_REF_LS0",
     "BriefDescription": "LS0 ISU reject",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30b2",
     "EventName": "PM_ISU_REF_LS1",
     "BriefDescription": "LS1 ISU reject",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30b4",
     "EventName": "PM_ISU_REF_LS2",
     "BriefDescription": "LS2 ISU reject",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30b6",
     "EventName": "PM_ISU_REF_LS3",
     "BriefDescription": "LS3 ISU reject",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x309c",
     "EventName": "PM_ISU_REJECTS_ALL",
     "BriefDescription": "All isu rejects could be more than 1 per cycle",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30a2",
     "EventName": "PM_ISU_REJECT_RES_NA",
     "BriefDescription": "ISU reject due to resource not available",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x309e",
     "EventName": "PM_ISU_REJECT_SAR_BYPASS",
     "BriefDescription": "Reject because of SAR bypass",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30a0",
     "EventName": "PM_ISU_REJECT_SRC_NA",
     "BriefDescription": "ISU reject due to source not available",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30a8",
     "EventName": "PM_ISU_REJ_VS0",
     "BriefDescription": "VS0 ISU reject",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30aa",
     "EventName": "PM_ISU_REJ_VS1",
     "BriefDescription": "VS1 ISU reject",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x38a8",
     "EventName": "PM_ISU_REJ_VSU",
     "BriefDescription": "VSU ISU reject from either pipe",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30b8",
     "EventName": "PM_ISYNC",
     "BriefDescription": "Isync count per thread",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x200301ea",
     "EventName": "PM_L1MISS_LAT_EXC_1024",
     "BriefDescription": "L1 misses that took longer than 1024 cyles to resolve (miss to reload)",
     "PublicDescription": "Reload latency exceeded 1024 cyc"
   },
-  {,
+  {
     "EventCode": "0x200401ec",
     "EventName": "PM_L1MISS_LAT_EXC_2048",
     "BriefDescription": "L1 misses that took longer than 2048 cyles to resolve (miss to reload)",
     "PublicDescription": "Reload latency exceeded 2048 cyc"
   },
-  {,
+  {
     "EventCode": "0x200101e8",
     "EventName": "PM_L1MISS_LAT_EXC_256",
     "BriefDescription": "L1 misses that took longer than 256 cyles to resolve (miss to reload)",
     "PublicDescription": "Reload latency exceeded 256 cyc"
   },
-  {,
+  {
     "EventCode": "0x200201e6",
     "EventName": "PM_L1MISS_LAT_EXC_32",
     "BriefDescription": "L1 misses that took longer than 32 cyles to resolve (miss to reload)",
     "PublicDescription": "Reload latency exceeded 32 cyc"
   },
-  {,
+  {
     "EventCode": "0x26086",
     "EventName": "PM_L1PF_L2MEMACC",
     "BriefDescription": "valid when first beat of data comes in for an L1pref where data came from mem(or L4)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x408c",
     "EventName": "PM_L1_DEMAND_WRITE",
     "BriefDescription": "Instruction Demand sectors wriittent into IL1",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x27084",
     "EventName": "PM_L2_CHIP_PUMP",
     "BriefDescription": "RC requests that were local on chip pump attempts",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x27086",
     "EventName": "PM_L2_GROUP_PUMP",
     "BriefDescription": "RC requests that were on Node Pump attempts",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3708a",
     "EventName": "PM_L2_RTY_ST",
     "BriefDescription": "RC retries on PB for any store from core",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x17080",
     "EventName": "PM_L2_ST",
     "BriefDescription": "All successful D-side store dispatches for this thread",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x17082",
     "EventName": "PM_L2_ST_MISS",
     "BriefDescription": "All successful D-side store dispatches for this thread that were L2 Miss",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1e05e",
     "EventName": "PM_L2_TM_REQ_ABORT",
     "BriefDescription": "TM abort",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3e05c",
     "EventName": "PM_L2_TM_ST_ABORT_SISTER",
     "BriefDescription": "TM marked store abort",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x819082",
     "EventName": "PM_L3_CI_USAGE",
     "BriefDescription": "rotating sample of 16 CI or CO actives",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x83908b",
     "EventName": "PM_L3_CO0_ALLOC",
     "BriefDescription": "lifetime, sample of CO machine 0 valid",
     "PublicDescription": "0.0"
   },
-  {,
+  {
     "EventCode": "0x83908a",
     "EventName": "PM_L3_CO0_BUSY",
     "BriefDescription": "lifetime, sample of CO machine 0 valid",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x28086",
     "EventName": "PM_L3_CO_L31",
     "BriefDescription": "L3 CO to L3.1 OR of port 0 and 1 ( lossy)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x28084",
     "EventName": "PM_L3_CO_MEM",
     "BriefDescription": "L3 CO to memory OR of port 0 and 1 ( lossy)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1e052",
     "EventName": "PM_L3_LD_PREF",
     "BriefDescription": "L3 Load Prefetches",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x84908d",
     "EventName": "PM_L3_PF0_ALLOC",
     "BriefDescription": "lifetime, sample of PF machine 0 valid",
     "PublicDescription": "0.0"
   },
-  {,
+  {
     "EventCode": "0x84908c",
     "EventName": "PM_L3_PF0_BUSY",
     "BriefDescription": "lifetime, sample of PF machine 0 valid",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x18080",
     "EventName": "PM_L3_PF_MISS_L3",
     "BriefDescription": "L3 Prefetch missed in L3",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3808a",
     "EventName": "PM_L3_PF_OFF_CHIP_CACHE",
     "BriefDescription": "L3 Prefetch from Off chip cache",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4808e",
     "EventName": "PM_L3_PF_OFF_CHIP_MEM",
     "BriefDescription": "L3 Prefetch from Off chip memory",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x38088",
     "EventName": "PM_L3_PF_ON_CHIP_CACHE",
     "BriefDescription": "L3 Prefetch from On chip cache",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4808c",
     "EventName": "PM_L3_PF_ON_CHIP_MEM",
     "BriefDescription": "L3 Prefetch from On chip memory",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x829084",
     "EventName": "PM_L3_PF_USAGE",
     "BriefDescription": "rotating sample of 32 PF actives",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4e052",
     "EventName": "PM_L3_PREF_ALL",
     "BriefDescription": "Total HW L3 prefetches(Load+store)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x84908f",
     "EventName": "PM_L3_RD0_ALLOC",
     "BriefDescription": "lifetime, sample of RD machine 0 valid",
     "PublicDescription": "0.0"
   },
-  {,
+  {
     "EventCode": "0x84908e",
     "EventName": "PM_L3_RD0_BUSY",
     "BriefDescription": "lifetime, sample of RD machine 0 valid",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x829086",
     "EventName": "PM_L3_RD_USAGE",
     "BriefDescription": "rotating sample of 16 RD actives",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x839089",
     "EventName": "PM_L3_SN0_ALLOC",
     "BriefDescription": "lifetime, sample of snooper machine 0 valid",
     "PublicDescription": "0.0"
   },
-  {,
+  {
     "EventCode": "0x839088",
     "EventName": "PM_L3_SN0_BUSY",
     "BriefDescription": "lifetime, sample of snooper machine 0 valid",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x819080",
     "EventName": "PM_L3_SN_USAGE",
     "BriefDescription": "rotating sample of 8 snoop valids",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2e052",
     "EventName": "PM_L3_ST_PREF",
     "BriefDescription": "L3 store Prefetches",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3e052",
     "EventName": "PM_L3_SW_PREF",
     "BriefDescription": "Data stream touchto L3",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x18081",
     "EventName": "PM_L3_WI0_ALLOC",
     "BriefDescription": "lifetime, sample of Write Inject machine 0 valid",
     "PublicDescription": "0.0"
   },
-  {,
+  {
     "EventCode": "0xc080",
     "EventName": "PM_LD_REF_L1_LSU0",
     "BriefDescription": "LS0 L1 D cache load references counted at finish, gated by reject",
     "PublicDescription": "LS0 L1 D cache load references counted at finish, gated by rejectLSU0 L1 D cache load references"
   },
-  {,
+  {
     "EventCode": "0xc082",
     "EventName": "PM_LD_REF_L1_LSU1",
     "BriefDescription": "LS1 L1 D cache load references counted at finish, gated by reject",
     "PublicDescription": "LS1 L1 D cache load references counted at finish, gated by rejectLSU1 L1 D cache load references"
   },
-  {,
+  {
     "EventCode": "0xc094",
     "EventName": "PM_LD_REF_L1_LSU2",
     "BriefDescription": "LS2 L1 D cache load references counted at finish, gated by reject",
     "PublicDescription": "LS2 L1 D cache load references counted at finish, gated by reject42"
   },
-  {,
+  {
     "EventCode": "0xc096",
     "EventName": "PM_LD_REF_L1_LSU3",
     "BriefDescription": "LS3 L1 D cache load references counted at finish, gated by reject",
     "PublicDescription": "LS3 L1 D cache load references counted at finish, gated by reject42"
   },
-  {,
+  {
     "EventCode": "0x509a",
     "EventName": "PM_LINK_STACK_INVALID_PTR",
     "BriefDescription": "A flush were LS ptr is invalid, results in a pop , A lot of interrupts between push and pops",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x5098",
     "EventName": "PM_LINK_STACK_WRONG_ADD_PRED",
     "BriefDescription": "Link stack predicts wrong address, because of link stack design limitation",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xe080",
     "EventName": "PM_LS0_ERAT_MISS_PREF",
     "BriefDescription": "LS0 Erat miss due to prefetch",
     "PublicDescription": "LS0 Erat miss due to prefetch42"
   },
-  {,
+  {
     "EventCode": "0xd0b8",
     "EventName": "PM_LS0_L1_PREF",
     "BriefDescription": "LS0 L1 cache data prefetches",
     "PublicDescription": "LS0 L1 cache data prefetches42"
   },
-  {,
+  {
     "EventCode": "0xc098",
     "EventName": "PM_LS0_L1_SW_PREF",
     "BriefDescription": "Software L1 Prefetches, including SW Transient Prefetches",
     "PublicDescription": "Software L1 Prefetches, including SW Transient Prefetches42"
   },
-  {,
+  {
     "EventCode": "0xe082",
     "EventName": "PM_LS1_ERAT_MISS_PREF",
     "BriefDescription": "LS1 Erat miss due to prefetch",
     "PublicDescription": "LS1 Erat miss due to prefetch42"
   },
-  {,
+  {
     "EventCode": "0xd0ba",
     "EventName": "PM_LS1_L1_PREF",
     "BriefDescription": "LS1 L1 cache data prefetches",
     "PublicDescription": "LS1 L1 cache data prefetches42"
   },
-  {,
+  {
     "EventCode": "0xc09a",
     "EventName": "PM_LS1_L1_SW_PREF",
     "BriefDescription": "Software L1 Prefetches, including SW Transient Prefetches",
     "PublicDescription": "Software L1 Prefetches, including SW Transient Prefetches42"
   },
-  {,
+  {
     "EventCode": "0xc0b0",
     "EventName": "PM_LSU0_FLUSH_LRQ",
     "BriefDescription": "LS0 Flush: LRQ",
     "PublicDescription": "LS0 Flush: LRQLSU0 LRQ flushes"
   },
-  {,
+  {
     "EventCode": "0xc0b8",
     "EventName": "PM_LSU0_FLUSH_SRQ",
     "BriefDescription": "LS0 Flush: SRQ",
     "PublicDescription": "LS0 Flush: SRQLSU0 SRQ lhs flushes"
   },
-  {,
+  {
     "EventCode": "0xc0a4",
     "EventName": "PM_LSU0_FLUSH_ULD",
     "BriefDescription": "LS0 Flush: Unaligned Load",
     "PublicDescription": "LS0 Flush: Unaligned LoadLSU0 unaligned load flushes"
   },
-  {,
+  {
     "EventCode": "0xc0ac",
     "EventName": "PM_LSU0_FLUSH_UST",
     "BriefDescription": "LS0 Flush: Unaligned Store",
     "PublicDescription": "LS0 Flush: Unaligned StoreLSU0 unaligned store flushes"
   },
-  {,
+  {
     "EventCode": "0xf088",
     "EventName": "PM_LSU0_L1_CAM_CANCEL",
     "BriefDescription": "ls0 l1 tm cam cancel",
     "PublicDescription": "ls0 l1 tm cam cancel42"
   },
-  {,
+  {
     "EventCode": "0x1e056",
     "EventName": "PM_LSU0_LARX_FIN",
     "BriefDescription": "Larx finished in LSU pipe0",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xd08c",
     "EventName": "PM_LSU0_LMQ_LHR_MERGE",
     "BriefDescription": "LS0 Load Merged with another cacheline request",
     "PublicDescription": "LS0 Load Merged with another cacheline request42"
   },
-  {,
+  {
     "EventCode": "0xc08c",
     "EventName": "PM_LSU0_NCLD",
     "BriefDescription": "LS0 Non-cachable Loads counted at finish",
     "PublicDescription": "LS0 Non-cachable Loads counted at finishLSU0 non-cacheable loads"
   },
-  {,
+  {
     "EventCode": "0xe090",
     "EventName": "PM_LSU0_PRIMARY_ERAT_HIT",
     "BriefDescription": "Primary ERAT hit",
     "PublicDescription": "Primary ERAT hit42"
   },
-  {,
+  {
     "EventCode": "0x1e05a",
     "EventName": "PM_LSU0_REJECT",
     "BriefDescription": "LSU0 reject",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xc09c",
     "EventName": "PM_LSU0_SRQ_STFWD",
     "BriefDescription": "LS0 SRQ forwarded data to a load",
     "PublicDescription": "LS0 SRQ forwarded data to a loadLSU0 SRQ store forwarded"
   },
-  {,
+  {
     "EventCode": "0xf084",
     "EventName": "PM_LSU0_STORE_REJECT",
     "BriefDescription": "ls0 store reject",
     "PublicDescription": "ls0 store reject42"
   },
-  {,
+  {
     "EventCode": "0xe0a8",
     "EventName": "PM_LSU0_TMA_REQ_L2",
     "BriefDescription": "addrs only req to L2 only on the first one,Indication that Load footprint is not expanding",
     "PublicDescription": "addrs only req to L2 only on the first one,Indication that Load footprint is not expanding42"
   },
-  {,
+  {
     "EventCode": "0xe098",
     "EventName": "PM_LSU0_TM_L1_HIT",
     "BriefDescription": "Load tm hit in L1",
     "PublicDescription": "Load tm hit in L142"
   },
-  {,
+  {
     "EventCode": "0xe0a0",
     "EventName": "PM_LSU0_TM_L1_MISS",
     "BriefDescription": "Load tm L1 miss",
     "PublicDescription": "Load tm L1 miss42"
   },
-  {,
+  {
     "EventCode": "0xc0b2",
     "EventName": "PM_LSU1_FLUSH_LRQ",
     "BriefDescription": "LS1 Flush: LRQ",
     "PublicDescription": "LS1 Flush: LRQLSU1 LRQ flushes"
   },
-  {,
+  {
     "EventCode": "0xc0ba",
     "EventName": "PM_LSU1_FLUSH_SRQ",
     "BriefDescription": "LS1 Flush: SRQ",
     "PublicDescription": "LS1 Flush: SRQLSU1 SRQ lhs flushes"
   },
-  {,
+  {
     "EventCode": "0xc0a6",
     "EventName": "PM_LSU1_FLUSH_ULD",
     "BriefDescription": "LS 1 Flush: Unaligned Load",
     "PublicDescription": "LS 1 Flush: Unaligned LoadLSU1 unaligned load flushes"
   },
-  {,
+  {
     "EventCode": "0xc0ae",
     "EventName": "PM_LSU1_FLUSH_UST",
     "BriefDescription": "LS1 Flush: Unaligned Store",
     "PublicDescription": "LS1 Flush: Unaligned StoreLSU1 unaligned store flushes"
   },
-  {,
+  {
     "EventCode": "0xf08a",
     "EventName": "PM_LSU1_L1_CAM_CANCEL",
     "BriefDescription": "ls1 l1 tm cam cancel",
     "PublicDescription": "ls1 l1 tm cam cancel42"
   },
-  {,
+  {
     "EventCode": "0x2e056",
     "EventName": "PM_LSU1_LARX_FIN",
     "BriefDescription": "Larx finished in LSU pipe1",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xd08e",
     "EventName": "PM_LSU1_LMQ_LHR_MERGE",
     "BriefDescription": "LS1 Load Merge with another cacheline request",
     "PublicDescription": "LS1 Load Merge with another cacheline request42"
   },
-  {,
+  {
     "EventCode": "0xc08e",
     "EventName": "PM_LSU1_NCLD",
     "BriefDescription": "LS1 Non-cachable Loads counted at finish",
     "PublicDescription": "LS1 Non-cachable Loads counted at finishLSU1 non-cacheable loads"
   },
-  {,
+  {
     "EventCode": "0xe092",
     "EventName": "PM_LSU1_PRIMARY_ERAT_HIT",
     "BriefDescription": "Primary ERAT hit",
     "PublicDescription": "Primary ERAT hit42"
   },
-  {,
+  {
     "EventCode": "0x2e05a",
     "EventName": "PM_LSU1_REJECT",
     "BriefDescription": "LSU1 reject",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xc09e",
     "EventName": "PM_LSU1_SRQ_STFWD",
     "BriefDescription": "LS1 SRQ forwarded data to a load",
     "PublicDescription": "LS1 SRQ forwarded data to a loadLSU1 SRQ store forwarded"
   },
-  {,
+  {
     "EventCode": "0xf086",
     "EventName": "PM_LSU1_STORE_REJECT",
     "BriefDescription": "ls1 store reject",
     "PublicDescription": "ls1 store reject42"
   },
-  {,
+  {
     "EventCode": "0xe0aa",
     "EventName": "PM_LSU1_TMA_REQ_L2",
     "BriefDescription": "addrs only req to L2 only on the first one,Indication that Load footprint is not expanding",
     "PublicDescription": "addrs only req to L2 only on the first one,Indication that Load footprint is not expanding42"
   },
-  {,
+  {
     "EventCode": "0xe09a",
     "EventName": "PM_LSU1_TM_L1_HIT",
     "BriefDescription": "Load tm hit in L1",
     "PublicDescription": "Load tm hit in L142"
   },
-  {,
+  {
     "EventCode": "0xe0a2",
     "EventName": "PM_LSU1_TM_L1_MISS",
     "BriefDescription": "Load tm L1 miss",
     "PublicDescription": "Load tm L1 miss42"
   },
-  {,
+  {
     "EventCode": "0xc0b4",
     "EventName": "PM_LSU2_FLUSH_LRQ",
     "BriefDescription": "LS02Flush: LRQ",
     "PublicDescription": "LS02Flush: LRQ42"
   },
-  {,
+  {
     "EventCode": "0xc0bc",
     "EventName": "PM_LSU2_FLUSH_SRQ",
     "BriefDescription": "LS2 Flush: SRQ",
     "PublicDescription": "LS2 Flush: SRQ42"
   },
-  {,
+  {
     "EventCode": "0xc0a8",
     "EventName": "PM_LSU2_FLUSH_ULD",
     "BriefDescription": "LS3 Flush: Unaligned Load",
     "PublicDescription": "LS3 Flush: Unaligned Load42"
   },
-  {,
+  {
     "EventCode": "0xf08c",
     "EventName": "PM_LSU2_L1_CAM_CANCEL",
     "BriefDescription": "ls2 l1 tm cam cancel",
     "PublicDescription": "ls2 l1 tm cam cancel42"
   },
-  {,
+  {
     "EventCode": "0x3e056",
     "EventName": "PM_LSU2_LARX_FIN",
     "BriefDescription": "Larx finished in LSU pipe2",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xc084",
     "EventName": "PM_LSU2_LDF",
     "BriefDescription": "LS2 Scalar Loads",
     "PublicDescription": "LS2 Scalar Loads42"
   },
-  {,
+  {
     "EventCode": "0xc088",
     "EventName": "PM_LSU2_LDX",
     "BriefDescription": "LS0 Vector Loads",
     "PublicDescription": "LS0 Vector Loads42"
   },
-  {,
+  {
     "EventCode": "0xd090",
     "EventName": "PM_LSU2_LMQ_LHR_MERGE",
     "BriefDescription": "LS0 Load Merged with another cacheline request",
     "PublicDescription": "LS0 Load Merged with another cacheline request42"
   },
-  {,
+  {
     "EventCode": "0xe094",
     "EventName": "PM_LSU2_PRIMARY_ERAT_HIT",
     "BriefDescription": "Primary ERAT hit",
     "PublicDescription": "Primary ERAT hit42"
   },
-  {,
+  {
     "EventCode": "0x3e05a",
     "EventName": "PM_LSU2_REJECT",
     "BriefDescription": "LSU2 reject",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xc0a0",
     "EventName": "PM_LSU2_SRQ_STFWD",
     "BriefDescription": "LS2 SRQ forwarded data to a load",
     "PublicDescription": "LS2 SRQ forwarded data to a load42"
   },
-  {,
+  {
     "EventCode": "0xe0ac",
     "EventName": "PM_LSU2_TMA_REQ_L2",
     "BriefDescription": "addrs only req to L2 only on the first one,Indication that Load footprint is not expanding",
     "PublicDescription": "addrs only req to L2 only on the first one,Indication that Load footprint is not expanding42"
   },
-  {,
+  {
     "EventCode": "0xe09c",
     "EventName": "PM_LSU2_TM_L1_HIT",
     "BriefDescription": "Load tm hit in L1",
     "PublicDescription": "Load tm hit in L142"
   },
-  {,
+  {
     "EventCode": "0xe0a4",
     "EventName": "PM_LSU2_TM_L1_MISS",
     "BriefDescription": "Load tm L1 miss",
     "PublicDescription": "Load tm L1 miss42"
   },
-  {,
+  {
     "EventCode": "0xc0b6",
     "EventName": "PM_LSU3_FLUSH_LRQ",
     "BriefDescription": "LS3 Flush: LRQ",
     "PublicDescription": "LS3 Flush: LRQ42"
   },
-  {,
+  {
     "EventCode": "0xc0be",
     "EventName": "PM_LSU3_FLUSH_SRQ",
     "BriefDescription": "LS13 Flush: SRQ",
     "PublicDescription": "LS13 Flush: SRQ42"
   },
-  {,
+  {
     "EventCode": "0xc0aa",
     "EventName": "PM_LSU3_FLUSH_ULD",
     "BriefDescription": "LS 14Flush: Unaligned Load",
     "PublicDescription": "LS 14Flush: Unaligned Load42"
   },
-  {,
+  {
     "EventCode": "0xf08e",
     "EventName": "PM_LSU3_L1_CAM_CANCEL",
     "BriefDescription": "ls3 l1 tm cam cancel",
     "PublicDescription": "ls3 l1 tm cam cancel42"
   },
-  {,
+  {
     "EventCode": "0x4e056",
     "EventName": "PM_LSU3_LARX_FIN",
     "BriefDescription": "Larx finished in LSU pipe3",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xc086",
     "EventName": "PM_LSU3_LDF",
     "BriefDescription": "LS3 Scalar Loads",
     "PublicDescription": "LS3 Scalar Loads 42"
   },
-  {,
+  {
     "EventCode": "0xc08a",
     "EventName": "PM_LSU3_LDX",
     "BriefDescription": "LS1 Vector Loads",
     "PublicDescription": "LS1 Vector Loads42"
   },
-  {,
+  {
     "EventCode": "0xd092",
     "EventName": "PM_LSU3_LMQ_LHR_MERGE",
     "BriefDescription": "LS1 Load Merge with another cacheline request",
     "PublicDescription": "LS1 Load Merge with another cacheline request42"
   },
-  {,
+  {
     "EventCode": "0xe096",
     "EventName": "PM_LSU3_PRIMARY_ERAT_HIT",
     "BriefDescription": "Primary ERAT hit",
     "PublicDescription": "Primary ERAT hit42"
   },
-  {,
+  {
     "EventCode": "0x4e05a",
     "EventName": "PM_LSU3_REJECT",
     "BriefDescription": "LSU3 reject",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xc0a2",
     "EventName": "PM_LSU3_SRQ_STFWD",
     "BriefDescription": "LS3 SRQ forwarded data to a load",
     "PublicDescription": "LS3 SRQ forwarded data to a load42"
   },
-  {,
+  {
     "EventCode": "0xe0ae",
     "EventName": "PM_LSU3_TMA_REQ_L2",
     "BriefDescription": "addrs only req to L2 only on the first one,Indication that Load footprint is not expanding",
     "PublicDescription": "addrs only req to L2 only on the first one,Indication that Load footprint is not expanding42"
   },
-  {,
+  {
     "EventCode": "0xe09e",
     "EventName": "PM_LSU3_TM_L1_HIT",
     "BriefDescription": "Load tm hit in L1",
     "PublicDescription": "Load tm hit in L142"
   },
-  {,
+  {
     "EventCode": "0xe0a6",
     "EventName": "PM_LSU3_TM_L1_MISS",
     "BriefDescription": "Load tm L1 miss",
     "PublicDescription": "Load tm L1 miss42"
   },
-  {,
+  {
     "EventCode": "0xe880",
     "EventName": "PM_LSU_ERAT_MISS_PREF",
     "BriefDescription": "Erat miss due to prefetch, on either pipe",
     "PublicDescription": "LSU"
   },
-  {,
+  {
     "EventCode": "0xc8ac",
     "EventName": "PM_LSU_FLUSH_UST",
     "BriefDescription": "Unaligned Store Flush on either pipe",
     "PublicDescription": "LSU"
   },
-  {,
+  {
     "EventCode": "0xd0a4",
     "EventName": "PM_LSU_FOUR_TABLEWALK_CYC",
     "BriefDescription": "Cycles when four tablewalks pending on this thread",
     "PublicDescription": "Cycles when four tablewalks pending on this thread42"
   },
-  {,
+  {
     "EventCode": "0x10066",
     "EventName": "PM_LSU_FX_FIN",
     "BriefDescription": "LSU Finished a FX operation (up to 2 per cycle",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xd8b8",
     "EventName": "PM_LSU_L1_PREF",
     "BriefDescription": "hw initiated , include sw streaming forms as well , include sw streams as a separate event",
     "PublicDescription": "LSU"
   },
-  {,
+  {
     "EventCode": "0xc898",
     "EventName": "PM_LSU_L1_SW_PREF",
     "BriefDescription": "Software L1 Prefetches, including SW Transient Prefetches, on both pipes",
     "PublicDescription": "LSU"
   },
-  {,
+  {
     "EventCode": "0xc884",
     "EventName": "PM_LSU_LDF",
     "BriefDescription": "FPU loads only on LS2/LS3 ie LU0/LU1",
     "PublicDescription": "LSU"
   },
-  {,
+  {
     "EventCode": "0xc888",
     "EventName": "PM_LSU_LDX",
     "BriefDescription": "Vector loads can issue only on LS2/LS3",
     "PublicDescription": "LSU"
   },
-  {,
+  {
     "EventCode": "0xd0a2",
     "EventName": "PM_LSU_LMQ_FULL_CYC",
     "BriefDescription": "LMQ full",
     "PublicDescription": "LMQ fullCycles LMQ full"
   },
-  {,
+  {
     "EventCode": "0xd0a1",
     "EventName": "PM_LSU_LMQ_S0_ALLOC",
     "BriefDescription": "Per thread - use edge detect to count allocates On a per thread basis, level signal indicating Slot 0 is valid. By instrumenting a single slot we can calculate service time for that slot. Previous machines required a separate signal indicating the slot was allocated. Because any signal can be routed to any counter in P8, we can count level in one PMC and edge detect in another PMC using the same signal",
     "PublicDescription": "0.0"
   },
-  {,
+  {
     "EventCode": "0xd0a0",
     "EventName": "PM_LSU_LMQ_S0_VALID",
     "BriefDescription": "Slot 0 of LMQ valid",
     "PublicDescription": "Slot 0 of LMQ validLMQ slot 0 valid"
   },
-  {,
+  {
     "EventCode": "0x3001c",
     "EventName": "PM_LSU_LMQ_SRQ_EMPTY_ALL_CYC",
     "BriefDescription": "ALL threads lsu empty (lmq and srq empty)",
     "PublicDescription": "ALL threads lsu empty (lmq and srq empty). Issue HW016541"
   },
-  {,
+  {
     "EventCode": "0xd09f",
     "EventName": "PM_LSU_LRQ_S0_ALLOC",
     "BriefDescription": "Per thread - use edge detect to count allocates On a per thread basis, level signal indicating Slot 0 is valid. By instrumenting a single slot we can calculate service time for that slot. Previous machines required a separate signal indicating the slot was allocated. Because any signal can be routed to any counter in P8, we can count level in one PMC and edge detect in another PMC using the same signal",
     "PublicDescription": "0.0"
   },
-  {,
+  {
     "EventCode": "0xd09e",
     "EventName": "PM_LSU_LRQ_S0_VALID",
     "BriefDescription": "Slot 0 of LRQ valid",
     "PublicDescription": "Slot 0 of LRQ validLRQ slot 0 valid"
   },
-  {,
+  {
     "EventCode": "0xf091",
     "EventName": "PM_LSU_LRQ_S43_ALLOC",
     "BriefDescription": "LRQ slot 43 was released",
     "PublicDescription": "0.0"
   },
-  {,
+  {
     "EventCode": "0xf090",
     "EventName": "PM_LSU_LRQ_S43_VALID",
     "BriefDescription": "LRQ slot 43 was busy",
     "PublicDescription": "LRQ slot 43 was busy42"
   },
-  {,
+  {
     "EventCode": "0x30162",
     "EventName": "PM_LSU_MRK_DERAT_MISS",
     "BriefDescription": "DERAT Reloaded (Miss)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xc88c",
     "EventName": "PM_LSU_NCLD",
     "BriefDescription": "count at finish so can return only on ls0 or ls1",
     "PublicDescription": "LSU"
   },
-  {,
+  {
     "EventCode": "0xc092",
     "EventName": "PM_LSU_NCST",
     "BriefDescription": "Non-cachable Stores sent to nest",
     "PublicDescription": "Non-cachable Stores sent to nest42"
   },
-  {,
+  {
     "EventCode": "0x10064",
     "EventName": "PM_LSU_REJECT",
     "BriefDescription": "LSU Reject (up to 4 per cycle)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xd082",
     "EventName": "PM_LSU_SET_MPRED",
     "BriefDescription": "Line already in cache at reload time",
     "PublicDescription": "Line already in cache at reload time42"
   },
-  {,
+  {
     "EventCode": "0x40008",
     "EventName": "PM_LSU_SRQ_EMPTY_CYC",
     "BriefDescription": "ALL threads srq empty",
     "PublicDescription": "All threads srq empty"
   },
-  {,
+  {
     "EventCode": "0xd09d",
     "EventName": "PM_LSU_SRQ_S0_ALLOC",
     "BriefDescription": "Per thread - use edge detect to count allocates On a per thread basis, level signal indicating Slot 0 is valid. By instrumenting a single slot we can calculate service time for that slot. Previous machines required a separate signal indicating the slot was allocated. Because any signal can be routed to any counter in P8, we can count level in one PMC and edge detect in another PMC using the same signal",
     "PublicDescription": "0.0"
   },
-  {,
+  {
     "EventCode": "0xd09c",
     "EventName": "PM_LSU_SRQ_S0_VALID",
     "BriefDescription": "Slot 0 of SRQ valid",
     "PublicDescription": "Slot 0 of SRQ validSRQ slot 0 valid"
   },
-  {,
+  {
     "EventCode": "0xf093",
     "EventName": "PM_LSU_SRQ_S39_ALLOC",
     "BriefDescription": "SRQ slot 39 was released",
     "PublicDescription": "0.0"
   },
-  {,
+  {
     "EventCode": "0xf092",
     "EventName": "PM_LSU_SRQ_S39_VALID",
     "BriefDescription": "SRQ slot 39 was busy",
     "PublicDescription": "SRQ slot 39 was busy42"
   },
-  {,
+  {
     "EventCode": "0xd09b",
     "EventName": "PM_LSU_SRQ_SYNC",
     "BriefDescription": "A sync in the SRQ ended",
     "PublicDescription": "0.0"
   },
-  {,
+  {
     "EventCode": "0xd09a",
     "EventName": "PM_LSU_SRQ_SYNC_CYC",
     "BriefDescription": "A sync is in the SRQ (edge detect to count)",
     "PublicDescription": "A sync is in the SRQ (edge detect to count)SRQ sync duration"
   },
-  {,
+  {
     "EventCode": "0xf084",
     "EventName": "PM_LSU_STORE_REJECT",
     "BriefDescription": "Store reject on either pipe",
     "PublicDescription": "LSU"
   },
-  {,
+  {
     "EventCode": "0xd0a6",
     "EventName": "PM_LSU_TWO_TABLEWALK_CYC",
     "BriefDescription": "Cycles when two tablewalks pending on this thread",
     "PublicDescription": "Cycles when two tablewalks pending on this thread42"
   },
-  {,
+  {
     "EventCode": "0x5094",
     "EventName": "PM_LWSYNC",
     "BriefDescription": "threaded version, IC Misses where we got EA dir hit but no sector valids were on. ICBI took line out",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x209a",
     "EventName": "PM_LWSYNC_HELD",
     "BriefDescription": "LWSYNC held at dispatch",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3013a",
     "EventName": "PM_MRK_CRU_FIN",
     "BriefDescription": "IFU non-branch finished",
     "PublicDescription": "IFU non-branch marked instruction finished"
   },
-  {,
+  {
     "EventCode": "0x4d146",
     "EventName": "PM_MRK_DATA_FROM_L21_MOD",
     "BriefDescription": "The processor's data cache was reloaded with Modified (M) data from another core's L2 on the same chip due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2d126",
     "EventName": "PM_MRK_DATA_FROM_L21_MOD_CYC",
     "BriefDescription": "Duration in cycles to reload with Modified (M) data from another core's L2 on the same chip due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3d146",
     "EventName": "PM_MRK_DATA_FROM_L21_SHR",
     "BriefDescription": "The processor's data cache was reloaded with Shared (S) data from another core's L2 on the same chip due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2c126",
     "EventName": "PM_MRK_DATA_FROM_L21_SHR_CYC",
     "BriefDescription": "Duration in cycles to reload with Shared (S) data from another core's L2 on the same chip due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4d144",
     "EventName": "PM_MRK_DATA_FROM_L31_ECO_MOD",
     "BriefDescription": "The processor's data cache was reloaded with Modified (M) data from another core's ECO L3 on the same chip due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2d124",
     "EventName": "PM_MRK_DATA_FROM_L31_ECO_MOD_CYC",
     "BriefDescription": "Duration in cycles to reload with Modified (M) data from another core's ECO L3 on the same chip due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3d144",
     "EventName": "PM_MRK_DATA_FROM_L31_ECO_SHR",
     "BriefDescription": "The processor's data cache was reloaded with Shared (S) data from another core's ECO L3 on the same chip due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2c124",
     "EventName": "PM_MRK_DATA_FROM_L31_ECO_SHR_CYC",
     "BriefDescription": "Duration in cycles to reload with Shared (S) data from another core's ECO L3 on the same chip due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2d144",
     "EventName": "PM_MRK_DATA_FROM_L31_MOD",
     "BriefDescription": "The processor's data cache was reloaded with Modified (M) data from another core's L3 on the same chip due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4d124",
     "EventName": "PM_MRK_DATA_FROM_L31_MOD_CYC",
     "BriefDescription": "Duration in cycles to reload with Modified (M) data from another core's L3 on the same chip due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1d146",
     "EventName": "PM_MRK_DATA_FROM_L31_SHR",
     "BriefDescription": "The processor's data cache was reloaded with Shared (S) data from another core's L3 on the same chip due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4c126",
     "EventName": "PM_MRK_DATA_FROM_L31_SHR_CYC",
     "BriefDescription": "Duration in cycles to reload with Shared (S) data from another core's L3 on the same chip due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x201e0",
     "EventName": "PM_MRK_DATA_FROM_MEM",
     "BriefDescription": "The processor's data cache was reloaded from a memory location including L4 from local remote or distant due to a marked load",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4f146",
     "EventName": "PM_MRK_DPTEG_FROM_L21_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another core's L2 on the same chip due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3f146",
     "EventName": "PM_MRK_DPTEG_FROM_L21_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another core's L2 on the same chip due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3f140",
     "EventName": "PM_MRK_DPTEG_FROM_L2_DISP_CONFLICT_LDHITST",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L2 with load hit store conflict due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4f140",
     "EventName": "PM_MRK_DPTEG_FROM_L2_DISP_CONFLICT_OTHER",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L2 with dispatch conflict due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4f144",
     "EventName": "PM_MRK_DPTEG_FROM_L31_ECO_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another core's ECO L3 on the same chip due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3f144",
     "EventName": "PM_MRK_DPTEG_FROM_L31_ECO_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another core's ECO L3 on the same chip due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2f144",
     "EventName": "PM_MRK_DPTEG_FROM_L31_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another core's L3 on the same chip due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1f146",
     "EventName": "PM_MRK_DPTEG_FROM_L31_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another core's L3 on the same chip due to a marked data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30156",
     "EventName": "PM_MRK_FAB_RSP_MATCH",
     "BriefDescription": "ttype and cresp matched as specified in MMCR1",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4f152",
     "EventName": "PM_MRK_FAB_RSP_MATCH_CYC",
     "BriefDescription": "cresp/ttype match cycles",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2013c",
     "EventName": "PM_MRK_FILT_MATCH",
     "BriefDescription": "Marked filter Match",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1013c",
     "EventName": "PM_MRK_FIN_STALL_CYC",
     "BriefDescription": "Marked instruction Finish Stall cycles (marked finish after NTC) (use edge detect to count )",
     "PublicDescription": "Marked instruction Finish Stall cycles (marked finish after NTC) (use edge detect to count #)"
   },
-  {,
+  {
     "EventCode": "0x40130",
     "EventName": "PM_MRK_GRP_CMPL",
     "BriefDescription": "marked instruction finished (completed)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4013a",
     "EventName": "PM_MRK_GRP_IC_MISS",
     "BriefDescription": "Marked Group experienced I cache miss",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3013c",
     "EventName": "PM_MRK_GRP_NTC",
     "BriefDescription": "Marked group ntc cycles",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1013f",
     "EventName": "PM_MRK_LD_MISS_EXPOSED",
     "BriefDescription": "Marked Load exposed Miss (exposed period ended)",
     "PublicDescription": "Marked Load exposed Miss (use edge detect to count #)"
   },
-  {,
+  {
     "EventCode": "0xd180",
     "EventName": "PM_MRK_LSU_FLUSH",
     "BriefDescription": "Flush: (marked) : All Cases",
     "PublicDescription": "Flush: (marked) : All Cases42"
   },
-  {,
+  {
     "EventCode": "0xd188",
     "EventName": "PM_MRK_LSU_FLUSH_LRQ",
     "BriefDescription": "Flush: (marked) LRQ",
     "PublicDescription": "Flush: (marked) LRQMarked LRQ flushes"
   },
-  {,
+  {
     "EventCode": "0xd18a",
     "EventName": "PM_MRK_LSU_FLUSH_SRQ",
     "BriefDescription": "Flush: (marked) SRQ",
     "PublicDescription": "Flush: (marked) SRQMarked SRQ lhs flushes"
   },
-  {,
+  {
     "EventCode": "0xd184",
     "EventName": "PM_MRK_LSU_FLUSH_ULD",
     "BriefDescription": "Flush: (marked) Unaligned Load",
     "PublicDescription": "Flush: (marked) Unaligned LoadMarked unaligned load flushes"
   },
-  {,
+  {
     "EventCode": "0xd186",
     "EventName": "PM_MRK_LSU_FLUSH_UST",
     "BriefDescription": "Flush: (marked) Unaligned Store",
     "PublicDescription": "Flush: (marked) Unaligned StoreMarked unaligned store flushes"
   },
-  {,
+  {
     "EventCode": "0x40164",
     "EventName": "PM_MRK_LSU_REJECT",
     "BriefDescription": "LSU marked reject (up to 2 per cycle)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30164",
     "EventName": "PM_MRK_LSU_REJECT_ERAT_MISS",
     "BriefDescription": "LSU marked reject due to ERAT (up to 2 per cycle)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1d15a",
     "EventName": "PM_MRK_SRC_PREF_TRACK_EFF",
     "BriefDescription": "Marked src pref track was effective",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3d15a",
     "EventName": "PM_MRK_SRC_PREF_TRACK_INEFF",
     "BriefDescription": "Prefetch tracked was ineffective for marked src",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4d15c",
     "EventName": "PM_MRK_SRC_PREF_TRACK_MOD",
     "BriefDescription": "Prefetch tracked was moderate for marked src",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1d15c",
     "EventName": "PM_MRK_SRC_PREF_TRACK_MOD_L2",
     "BriefDescription": "Marked src Prefetch Tracked was moderate (source L2)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3d15c",
     "EventName": "PM_MRK_SRC_PREF_TRACK_MOD_L3",
     "BriefDescription": "Prefetch tracked was moderate (L3 hit) for marked src",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1c15a",
     "EventName": "PM_MRK_TGT_PREF_TRACK_EFF",
     "BriefDescription": "Marked target pref track was effective",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3c15a",
     "EventName": "PM_MRK_TGT_PREF_TRACK_INEFF",
     "BriefDescription": "Prefetch tracked was ineffective for marked target",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4c15c",
     "EventName": "PM_MRK_TGT_PREF_TRACK_MOD",
     "BriefDescription": "Prefetch tracked was moderate for marked target",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1c15c",
     "EventName": "PM_MRK_TGT_PREF_TRACK_MOD_L2",
     "BriefDescription": "Marked target Prefetch Tracked was moderate (source L2)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3c15c",
     "EventName": "PM_MRK_TGT_PREF_TRACK_MOD_L3",
     "BriefDescription": "Prefetch tracked was moderate (L3 hit) for marked target",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x20b0",
     "EventName": "PM_NESTED_TEND",
     "BriefDescription": "Completion time nested tend",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x20b6",
     "EventName": "PM_NON_FAV_TBEGIN",
     "BriefDescription": "Dispatch time non favored tbegin",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2001a",
     "EventName": "PM_NTCG_ALL_FIN",
     "BriefDescription": "Cycles after all instructions have finished to group completed",
     "PublicDescription": "Ccycles after all instructions have finished to group completed"
   },
-  {,
+  {
     "EventCode": "0x20ac",
     "EventName": "PM_OUTER_TBEGIN",
     "BriefDescription": "Completion time outer tbegin",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x20ae",
     "EventName": "PM_OUTER_TEND",
     "BriefDescription": "Completion time outer tend",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2005a",
     "EventName": "PM_PREF_TRACKED",
     "BriefDescription": "Total number of Prefetch Operations that were tracked",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1005a",
     "EventName": "PM_PREF_TRACK_EFF",
     "BriefDescription": "Prefetch Tracked was effective",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3005a",
     "EventName": "PM_PREF_TRACK_INEFF",
     "BriefDescription": "Prefetch tracked was ineffective",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4005a",
     "EventName": "PM_PREF_TRACK_MOD",
     "BriefDescription": "Prefetch tracked was moderate",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1005c",
     "EventName": "PM_PREF_TRACK_MOD_L2",
     "BriefDescription": "Prefetch Tracked was moderate (source L2)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3005c",
     "EventName": "PM_PREF_TRACK_MOD_L3",
     "BriefDescription": "Prefetch tracked was moderate (L3)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xe084",
     "EventName": "PM_PTE_PREFETCH",
     "BriefDescription": "PTE prefetches",
     "PublicDescription": "PTE prefetches42"
   },
-  {,
+  {
     "EventCode": "0x16081",
     "EventName": "PM_RC0_ALLOC",
     "BriefDescription": "RC mach 0 Busy. Used by PMU to sample ave RC livetime(mach0 used as sample point)",
     "PublicDescription": "0.0"
   },
-  {,
+  {
     "EventCode": "0x16080",
     "EventName": "PM_RC0_BUSY",
     "BriefDescription": "RC mach 0 Busy. Used by PMU to sample ave RC livetime(mach0 used as sample point)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x200301ea",
     "EventName": "PM_RC_LIFETIME_EXC_1024",
     "BriefDescription": "Number of times the RC machine for a sampled instruction was active for more than 1024 cycles",
     "PublicDescription": "Reload latency exceeded 1024 cyc"
   },
-  {,
+  {
     "EventCode": "0x200401ec",
     "EventName": "PM_RC_LIFETIME_EXC_2048",
     "BriefDescription": "Number of times the RC machine for a sampled instruction was active for more than 2048 cycles",
     "PublicDescription": "Threshold counter exceeded a value of 2048"
   },
-  {,
+  {
     "EventCode": "0x200101e8",
     "EventName": "PM_RC_LIFETIME_EXC_256",
     "BriefDescription": "Number of times the RC machine for a sampled instruction was active for more than 256 cycles",
     "PublicDescription": "Threshold counter exceed a count of 256"
   },
-  {,
+  {
     "EventCode": "0x200201e6",
     "EventName": "PM_RC_LIFETIME_EXC_32",
     "BriefDescription": "Number of times the RC machine for a sampled instruction was active for more than 32 cycles",
     "PublicDescription": "Reload latency exceeded 32 cyc"
   },
-  {,
+  {
     "EventCode": "0x36088",
     "EventName": "PM_RC_USAGE",
     "BriefDescription": "Continuous 16 cycle(2to1) window where this signals rotates thru sampling each L2 RC machine busy. PMU uses this wave to then do 16 cyc count to sample total number of machs running",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x20004",
     "EventName": "PM_REAL_SRQ_FULL",
     "BriefDescription": "Out of real srq entries",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2006a",
     "EventName": "PM_RUN_CYC_SMT2_SHRD_MODE",
     "BriefDescription": "cycles this threads run latch is set and the core is in SMT2 shared mode",
     "PublicDescription": "Cycles run latch is set and core is in SMT2-shared mode"
   },
-  {,
+  {
     "EventCode": "0x1006a",
     "EventName": "PM_RUN_CYC_SMT2_SPLIT_MODE",
     "BriefDescription": "Cycles run latch is set and core is in SMT2-split mode",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4006c",
     "EventName": "PM_RUN_CYC_SMT8_MODE",
     "BriefDescription": "Cycles run latch is set and core is in SMT8 mode",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xf082",
     "EventName": "PM_SEC_ERAT_HIT",
     "BriefDescription": "secondary ERAT Hit",
     "PublicDescription": "secondary ERAT Hit42"
   },
-  {,
+  {
     "EventCode": "0x508c",
     "EventName": "PM_SHL_CREATED",
     "BriefDescription": "Store-Hit-Load Table Entry Created",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x508e",
     "EventName": "PM_SHL_ST_CONVERT",
     "BriefDescription": "Store-Hit-Load Table Read Hit with entry Enabled",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x5090",
     "EventName": "PM_SHL_ST_DISABLE",
     "BriefDescription": "Store-Hit-Load Table Read Hit with entry Disabled (entry was disabled due to the entry shown to not prevent the flush)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x26085",
     "EventName": "PM_SN0_ALLOC",
     "BriefDescription": "SN mach 0 Busy. Used by PMU to sample ave RC livetime(mach0 used as sample point)",
     "PublicDescription": "0.0"
   },
-  {,
+  {
     "EventCode": "0x26084",
     "EventName": "PM_SN0_BUSY",
     "BriefDescription": "SN mach 0 Busy. Used by PMU to sample ave RC livetime(mach0 used as sample point)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xd0b2",
     "EventName": "PM_SNOOP_TLBIE",
     "BriefDescription": "TLBIE snoop",
     "PublicDescription": "TLBIE snoopSnoop TLBIE"
   },
-  {,
+  {
     "EventCode": "0x4608c",
     "EventName": "PM_SN_USAGE",
     "BriefDescription": "Continuous 16 cycle(2to1) window where this signals rotates thru sampling each L2 SN machine busy. PMU uses this wave to then do 16 cyc count to sample total number of machs running",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x10028",
     "EventName": "PM_STALL_END_GCT_EMPTY",
     "BriefDescription": "Count ended because GCT went empty",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xc090",
     "EventName": "PM_STCX_LSU",
     "BriefDescription": "STCX executed reported at sent to nest",
     "PublicDescription": "STCX executed reported at sent to nest42"
   },
-  {,
+  {
     "EventCode": "0x3090",
     "EventName": "PM_SWAP_CANCEL",
     "BriefDescription": "SWAP cancel , rtag not available",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3092",
     "EventName": "PM_SWAP_CANCEL_GPR",
     "BriefDescription": "SWAP cancel , rtag not available for gpr",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x308c",
     "EventName": "PM_SWAP_COMPLETE",
     "BriefDescription": "swap cast in completed",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x308e",
     "EventName": "PM_SWAP_COMPLETE_GPR",
     "BriefDescription": "swap cast in completed fpr gpr",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xe086",
     "EventName": "PM_TABLEWALK_CYC_PREF",
     "BriefDescription": "tablewalk qualified for pte prefetches",
     "PublicDescription": "tablewalk qualified for pte prefetches42"
   },
-  {,
+  {
     "EventCode": "0x20b2",
     "EventName": "PM_TABORT_TRECLAIM",
     "BriefDescription": "Completion time tabortnoncd, tabortcd, treclaim",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xe0ba",
     "EventName": "PM_TEND_PEND_CYC",
     "BriefDescription": "TEND latency per thread",
     "PublicDescription": "TEND latency per thread42"
   },
-  {,
+  {
     "EventCode": "0x10012",
     "EventName": "PM_THRD_GRP_CMPL_BOTH_CYC",
     "BriefDescription": "Cycles group completed on both completion slots by any thread",
     "PublicDescription": "Two threads finished same cycle (gated by run latch)"
   },
-  {,
+  {
     "EventCode": "0x40bc",
     "EventName": "PM_THRD_PRIO_0_1_CYC",
     "BriefDescription": "Cycles thread running at priority level 0 or 1",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x40be",
     "EventName": "PM_THRD_PRIO_2_3_CYC",
     "BriefDescription": "Cycles thread running at priority level 2 or 3",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x5080",
     "EventName": "PM_THRD_PRIO_4_5_CYC",
     "BriefDescription": "Cycles thread running at priority level 4 or 5",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x5082",
     "EventName": "PM_THRD_PRIO_6_7_CYC",
     "BriefDescription": "Cycles thread running at priority level 6 or 7",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3098",
     "EventName": "PM_THRD_REBAL_CYC",
     "BriefDescription": "cycles rebalance was active",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x20b8",
     "EventName": "PM_TM_BEGIN_ALL",
     "BriefDescription": "Tm any tbegin",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x20ba",
     "EventName": "PM_TM_END_ALL",
     "BriefDescription": "Tm any tend",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3086",
     "EventName": "PM_TM_FAIL_CONF_NON_TM",
     "BriefDescription": "TEXAS fail reason @ completion",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3088",
     "EventName": "PM_TM_FAIL_CON_TM",
     "BriefDescription": "TEXAS fail reason @ completion",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xe0b2",
     "EventName": "PM_TM_FAIL_DISALLOW",
     "BriefDescription": "TM fail disallow",
     "PublicDescription": "TM fail disallow42"
   },
-  {,
+  {
     "EventCode": "0x3084",
     "EventName": "PM_TM_FAIL_FOOTPRINT_OVERFLOW",
     "BriefDescription": "TEXAS fail reason @ completion",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xe0b8",
     "EventName": "PM_TM_FAIL_NON_TX_CONFLICT",
     "BriefDescription": "Non transactional conflict from LSU whtver gets repoted to texas",
     "PublicDescription": "Non transactional conflict from LSU whtver gets repoted to texas42"
   },
-  {,
+  {
     "EventCode": "0x308a",
     "EventName": "PM_TM_FAIL_SELF",
     "BriefDescription": "TEXAS fail reason @ completion",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xe0b4",
     "EventName": "PM_TM_FAIL_TLBIE",
     "BriefDescription": "TLBIE hit bloom filter",
     "PublicDescription": "TLBIE hit bloom filter42"
   },
-  {,
+  {
     "EventCode": "0xe0b6",
     "EventName": "PM_TM_FAIL_TX_CONFLICT",
     "BriefDescription": "Transactional conflict from LSU, whatever gets reported to texas",
     "PublicDescription": "Transactional conflict from LSU, whatever gets reported to texas 42"
   },
-  {,
+  {
     "EventCode": "0x20bc",
     "EventName": "PM_TM_TBEGIN",
     "BriefDescription": "Tm nested tbegin",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3080",
     "EventName": "PM_TM_TRESUME",
     "BriefDescription": "Tm resume",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x20be",
     "EventName": "PM_TM_TSUSPEND",
     "BriefDescription": "Tm suspend",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xe08c",
     "EventName": "PM_UP_PREF_L3",
     "BriefDescription": "Micropartition prefetch",
     "PublicDescription": "Micropartition prefetch42"
   },
-  {,
+  {
     "EventCode": "0xe08e",
     "EventName": "PM_UP_PREF_POINTER",
     "BriefDescription": "Micrpartition pointer prefetches",
     "PublicDescription": "Micrpartition pointer prefetches42"
   },
-  {,
+  {
     "EventCode": "0xa0a4",
     "EventName": "PM_VSU0_16FLOP",
     "BriefDescription": "Sixteen flops operation (SP vector versions of fdiv,fsqrt)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa080",
     "EventName": "PM_VSU0_1FLOP",
     "BriefDescription": "one flop (fadd, fmul, fsub, fcmp, fsel, fabs, fnabs, fres, fsqrte, fneg) operation finished",
     "PublicDescription": "one flop (fadd, fmul, fsub, fcmp, fsel, fabs, fnabs, fres, fsqrte, fneg) operation finishedDecode into 1,2,4 FLOP according to instr IOP, multiplied by #vector elements according to route( eg x1, x2, x4) Only if instr sends finish to ISU"
   },
-  {,
+  {
     "EventCode": "0xa098",
     "EventName": "PM_VSU0_2FLOP",
     "BriefDescription": "two flops operation (scalar fmadd, fnmadd, fmsub, fnmsub and DP vector versions of single flop instructions)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa09c",
     "EventName": "PM_VSU0_4FLOP",
     "BriefDescription": "four flops operation (scalar fdiv, fsqrt, DP vector version of fmadd, fnmadd, fmsub, fnmsub, SP vector versions of single flop instructions)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa0a0",
     "EventName": "PM_VSU0_8FLOP",
     "BriefDescription": "eight flops operation (DP vector versions of fdiv,fsqrt and SP vector versions of fmadd,fnmadd,fmsub,fnmsub)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb0a4",
     "EventName": "PM_VSU0_COMPLEX_ISSUED",
     "BriefDescription": "Complex VMX instruction issued",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb0b4",
     "EventName": "PM_VSU0_CY_ISSUED",
     "BriefDescription": "Cryptographic instruction RFC02196 Issued",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb0a8",
     "EventName": "PM_VSU0_DD_ISSUED",
     "BriefDescription": "64BIT Decimal Issued",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa08c",
     "EventName": "PM_VSU0_DP_2FLOP",
     "BriefDescription": "DP vector version of fmul, fsub, fcmp, fsel, fabs, fnabs, fres ,fsqrte, fneg",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa090",
     "EventName": "PM_VSU0_DP_FMA",
     "BriefDescription": "DP vector version of fmadd,fnmadd,fmsub,fnmsub",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa094",
     "EventName": "PM_VSU0_DP_FSQRT_FDIV",
     "BriefDescription": "DP vector versions of fdiv,fsqrt",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb0ac",
     "EventName": "PM_VSU0_DQ_ISSUED",
     "BriefDescription": "128BIT Decimal Issued",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb0b0",
     "EventName": "PM_VSU0_EX_ISSUED",
     "BriefDescription": "Direct move 32/64b VRFtoGPR RFC02206 Issued",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa0bc",
     "EventName": "PM_VSU0_FIN",
     "BriefDescription": "VSU0 Finished an instruction",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa084",
     "EventName": "PM_VSU0_FMA",
     "BriefDescription": "two flops operation (fmadd, fnmadd, fmsub, fnmsub) Scalar instructions only!",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb098",
     "EventName": "PM_VSU0_FPSCR",
     "BriefDescription": "Move to/from FPSCR type instruction issued on Pipe 0",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa088",
     "EventName": "PM_VSU0_FSQRT_FDIV",
     "BriefDescription": "four flops operation (fdiv,fsqrt) Scalar Instructions only!",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb090",
     "EventName": "PM_VSU0_PERMUTE_ISSUED",
     "BriefDescription": "Permute VMX Instruction Issued",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb088",
     "EventName": "PM_VSU0_SCALAR_DP_ISSUED",
     "BriefDescription": "Double Precision scalar instruction issued on Pipe0",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb094",
     "EventName": "PM_VSU0_SIMPLE_ISSUED",
     "BriefDescription": "Simple VMX instruction issued",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa0a8",
     "EventName": "PM_VSU0_SINGLE",
     "BriefDescription": "FPU single precision",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb09c",
     "EventName": "PM_VSU0_SQ",
     "BriefDescription": "Store Vector Issued",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb08c",
     "EventName": "PM_VSU0_STF",
     "BriefDescription": "FPU store (SP or DP) issued on Pipe0",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb080",
     "EventName": "PM_VSU0_VECTOR_DP_ISSUED",
     "BriefDescription": "Double Precision vector instruction issued on Pipe0",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb084",
     "EventName": "PM_VSU0_VECTOR_SP_ISSUED",
     "BriefDescription": "Single Precision vector instruction issued (executed)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa0a6",
     "EventName": "PM_VSU1_16FLOP",
     "BriefDescription": "Sixteen flops operation (SP vector versions of fdiv,fsqrt)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa082",
     "EventName": "PM_VSU1_1FLOP",
     "BriefDescription": "one flop (fadd, fmul, fsub, fcmp, fsel, fabs, fnabs, fres, fsqrte, fneg) operation finished",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa09a",
     "EventName": "PM_VSU1_2FLOP",
     "BriefDescription": "two flops operation (scalar fmadd, fnmadd, fmsub, fnmsub and DP vector versions of single flop instructions)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa09e",
     "EventName": "PM_VSU1_4FLOP",
     "BriefDescription": "four flops operation (scalar fdiv, fsqrt, DP vector version of fmadd, fnmadd, fmsub, fnmsub, SP vector versions of single flop instructions)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa0a2",
     "EventName": "PM_VSU1_8FLOP",
     "BriefDescription": "eight flops operation (DP vector versions of fdiv,fsqrt and SP vector versions of fmadd,fnmadd,fmsub,fnmsub)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb0a6",
     "EventName": "PM_VSU1_COMPLEX_ISSUED",
     "BriefDescription": "Complex VMX instruction issued",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb0b6",
     "EventName": "PM_VSU1_CY_ISSUED",
     "BriefDescription": "Cryptographic instruction RFC02196 Issued",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb0aa",
     "EventName": "PM_VSU1_DD_ISSUED",
     "BriefDescription": "64BIT Decimal Issued",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa08e",
     "EventName": "PM_VSU1_DP_2FLOP",
     "BriefDescription": "DP vector version of fmul, fsub, fcmp, fsel, fabs, fnabs, fres ,fsqrte, fneg",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa092",
     "EventName": "PM_VSU1_DP_FMA",
     "BriefDescription": "DP vector version of fmadd,fnmadd,fmsub,fnmsub",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa096",
     "EventName": "PM_VSU1_DP_FSQRT_FDIV",
     "BriefDescription": "DP vector versions of fdiv,fsqrt",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb0ae",
     "EventName": "PM_VSU1_DQ_ISSUED",
     "BriefDescription": "128BIT Decimal Issued",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb0b2",
     "EventName": "PM_VSU1_EX_ISSUED",
     "BriefDescription": "Direct move 32/64b VRFtoGPR RFC02206 Issued",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa0be",
     "EventName": "PM_VSU1_FIN",
     "BriefDescription": "VSU1 Finished an instruction",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa086",
     "EventName": "PM_VSU1_FMA",
     "BriefDescription": "two flops operation (fmadd, fnmadd, fmsub, fnmsub) Scalar instructions only!",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb09a",
     "EventName": "PM_VSU1_FPSCR",
     "BriefDescription": "Move to/from FPSCR type instruction issued on Pipe 0",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa08a",
     "EventName": "PM_VSU1_FSQRT_FDIV",
     "BriefDescription": "four flops operation (fdiv,fsqrt) Scalar Instructions only!",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb092",
     "EventName": "PM_VSU1_PERMUTE_ISSUED",
     "BriefDescription": "Permute VMX Instruction Issued",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb08a",
     "EventName": "PM_VSU1_SCALAR_DP_ISSUED",
     "BriefDescription": "Double Precision scalar instruction issued on Pipe1",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb096",
     "EventName": "PM_VSU1_SIMPLE_ISSUED",
     "BriefDescription": "Simple VMX instruction issued",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xa0aa",
     "EventName": "PM_VSU1_SINGLE",
     "BriefDescription": "FPU single precision",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb09e",
     "EventName": "PM_VSU1_SQ",
     "BriefDescription": "Store Vector Issued",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb08e",
     "EventName": "PM_VSU1_STF",
     "BriefDescription": "FPU store (SP or DP) issued on Pipe1",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb082",
     "EventName": "PM_VSU1_VECTOR_DP_ISSUED",
     "BriefDescription": "Double Precision vector instruction issued on Pipe1",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0xb086",
     "EventName": "PM_VSU1_VECTOR_SP_ISSUED",
     "BriefDescription": "Single Precision vector instruction issued (executed)",
     "PublicDescription": ""
-  },
+  }
 ]
diff --git a/tools/perf/pmu-events/arch/powerpc/power8/pipeline.json b/tools/perf/pmu-events/arch/powerpc/power8/pipeline.json
index 293f3a4..0acfaae 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/pipeline.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/pipeline.json
@@ -1,350 +1,350 @@
 [
-  {,
+  {
     "EventCode": "0x100f2",
     "EventName": "PM_1PLUS_PPC_CMPL",
     "BriefDescription": "1 or more ppc insts finished",
     "PublicDescription": "1 or more ppc insts finished (completed)"
   },
-  {,
+  {
     "EventCode": "0x400f2",
     "EventName": "PM_1PLUS_PPC_DISP",
     "BriefDescription": "Cycles at least one Instr Dispatched",
     "PublicDescription": "Cycles at least one Instr Dispatched. Could be a group with only microcode. Issue HW016521"
   },
-  {,
+  {
     "EventCode": "0x100fa",
     "EventName": "PM_ANY_THRD_RUN_CYC",
     "BriefDescription": "One of threads in run_cycles",
     "PublicDescription": "Any thread in run_cycles (was one thread in run_cycles)"
   },
-  {,
+  {
     "EventCode": "0x4000a",
     "EventName": "PM_CMPLU_STALL",
     "BriefDescription": "Completion stall",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4d018",
     "EventName": "PM_CMPLU_STALL_BRU",
     "BriefDescription": "Completion stall due to a Branch Unit",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2c012",
     "EventName": "PM_CMPLU_STALL_DCACHE_MISS",
     "BriefDescription": "Completion stall by Dcache miss",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2c018",
     "EventName": "PM_CMPLU_STALL_DMISS_L21_L31",
     "BriefDescription": "Completion stall by Dcache miss which resolved on chip ( excluding local L2/L3)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2c016",
     "EventName": "PM_CMPLU_STALL_DMISS_L2L3",
     "BriefDescription": "Completion stall by Dcache miss which resolved in L2/L3",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4c016",
     "EventName": "PM_CMPLU_STALL_DMISS_L2L3_CONFLICT",
     "BriefDescription": "Completion stall due to cache miss that resolves in the L2 or L3 with a conflict",
     "PublicDescription": "Completion stall due to cache miss resolving in core's L2/L3 with a conflict"
   },
-  {,
+  {
     "EventCode": "0x4c01a",
     "EventName": "PM_CMPLU_STALL_DMISS_L3MISS",
     "BriefDescription": "Completion stall due to cache miss resolving missed the L3",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4c018",
     "EventName": "PM_CMPLU_STALL_DMISS_LMEM",
     "BriefDescription": "Completion stall due to cache miss that resolves in local memory",
     "PublicDescription": "Completion stall due to cache miss resolving in core's Local Memory"
   },
-  {,
+  {
     "EventCode": "0x2c01c",
     "EventName": "PM_CMPLU_STALL_DMISS_REMOTE",
     "BriefDescription": "Completion stall by Dcache miss which resolved from remote chip (cache or memory)",
     "PublicDescription": "Completion stall by Dcache miss which resolved on chip ( excluding local L2/L3)"
   },
-  {,
+  {
     "EventCode": "0x4c012",
     "EventName": "PM_CMPLU_STALL_ERAT_MISS",
     "BriefDescription": "Completion stall due to LSU reject ERAT miss",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4d016",
     "EventName": "PM_CMPLU_STALL_FXLONG",
     "BriefDescription": "Completion stall due to a long latency fixed point instruction",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2d016",
     "EventName": "PM_CMPLU_STALL_FXU",
     "BriefDescription": "Completion stall due to FXU",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30036",
     "EventName": "PM_CMPLU_STALL_HWSYNC",
     "BriefDescription": "completion stall due to hwsync",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4d014",
     "EventName": "PM_CMPLU_STALL_LOAD_FINISH",
     "BriefDescription": "Completion stall due to a Load finish",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2c010",
     "EventName": "PM_CMPLU_STALL_LSU",
     "BriefDescription": "Completion stall by LSU instruction",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x10036",
     "EventName": "PM_CMPLU_STALL_LWSYNC",
     "BriefDescription": "completion stall due to isync/lwsync",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30006",
     "EventName": "PM_CMPLU_STALL_OTHER_CMPL",
     "BriefDescription": "Instructions core completed while this tread was stalled",
     "PublicDescription": "Instructions core completed while this thread was stalled"
   },
-  {,
+  {
     "EventCode": "0x4c01c",
     "EventName": "PM_CMPLU_STALL_ST_FWD",
     "BriefDescription": "Completion stall due to store forward",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1001c",
     "EventName": "PM_CMPLU_STALL_THRD",
     "BriefDescription": "Completion Stalled due to thread conflict. Group ready to complete but it was another thread's turn",
     "PublicDescription": "Completion stall due to thread conflict"
   },
-  {,
+  {
     "EventCode": "0x1e",
     "EventName": "PM_CYC",
     "BriefDescription": "Cycles",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x10006",
     "EventName": "PM_DISP_HELD",
     "BriefDescription": "Dispatch Held",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4003c",
     "EventName": "PM_DISP_HELD_SYNC_HOLD",
     "BriefDescription": "Dispatch held due to SYNC hold",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x200f8",
     "EventName": "PM_EXT_INT",
     "BriefDescription": "external interrupt",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x400f8",
     "EventName": "PM_FLUSH",
     "BriefDescription": "Flush (any type)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30012",
     "EventName": "PM_FLUSH_COMPLETION",
     "BriefDescription": "Completion Flush",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3000c",
     "EventName": "PM_FREQ_DOWN",
     "BriefDescription": "Power Management: Below Threshold B",
     "PublicDescription": "Frequency is being slewed down due to Power Management"
   },
-  {,
+  {
     "EventCode": "0x4000c",
     "EventName": "PM_FREQ_UP",
     "BriefDescription": "Power Management: Above Threshold A",
     "PublicDescription": "Frequency is being slewed up due to Power Management"
   },
-  {,
+  {
     "EventCode": "0x2000a",
     "EventName": "PM_HV_CYC",
     "BriefDescription": "Cycles in which msr_hv is high. Note that this event does not take msr_pr into consideration",
     "PublicDescription": "cycles in hypervisor mode"
   },
-  {,
+  {
     "EventCode": "0x3405e",
     "EventName": "PM_IFETCH_THROTTLE",
     "BriefDescription": "Cycles in which Instruction fetch throttle was active",
     "PublicDescription": "Cycles instruction fecth was throttled in IFU"
   },
-  {,
+  {
     "EventCode": "0x10014",
     "EventName": "PM_IOPS_CMPL",
     "BriefDescription": "Internal Operations completed",
     "PublicDescription": "IOPS Completed"
   },
-  {,
+  {
     "EventCode": "0x3c058",
     "EventName": "PM_LARX_FIN",
     "BriefDescription": "Larx finished",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1002e",
     "EventName": "PM_LD_CMPL",
     "BriefDescription": "count of Loads completed",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x10062",
     "EventName": "PM_LD_L3MISS_PEND_CYC",
     "BriefDescription": "Cycles L3 miss was pending for this thread",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30066",
     "EventName": "PM_LSU_FIN",
     "BriefDescription": "LSU Finished an instruction (up to 2 per cycle)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2003e",
     "EventName": "PM_LSU_LMQ_SRQ_EMPTY_CYC",
     "BriefDescription": "LSU empty (lmq and srq empty)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2e05c",
     "EventName": "PM_LSU_REJECT_ERAT_MISS",
     "BriefDescription": "LSU Reject due to ERAT (up to 4 per cycles)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4e05c",
     "EventName": "PM_LSU_REJECT_LHS",
     "BriefDescription": "LSU Reject due to LHS (up to 4 per cycle)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1e05c",
     "EventName": "PM_LSU_REJECT_LMQ_FULL",
     "BriefDescription": "LSU reject due to LMQ full ( 4 per cycle)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1001a",
     "EventName": "PM_LSU_SRQ_FULL_CYC",
     "BriefDescription": "Storage Queue is full and is blocking dispatch",
     "PublicDescription": "SRQ is Full"
   },
-  {,
+  {
     "EventCode": "0x40014",
     "EventName": "PM_PROBE_NOP_DISP",
     "BriefDescription": "ProbeNops dispatched",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x600f4",
     "EventName": "PM_RUN_CYC",
     "BriefDescription": "Run_cycles",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3006c",
     "EventName": "PM_RUN_CYC_SMT2_MODE",
     "BriefDescription": "Cycles run latch is set and core is in SMT2 mode",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2006c",
     "EventName": "PM_RUN_CYC_SMT4_MODE",
     "BriefDescription": "cycles this threads run latch is set and the core is in SMT4 mode",
     "PublicDescription": "Cycles run latch is set and core is in SMT4 mode"
   },
-  {,
+  {
     "EventCode": "0x1006c",
     "EventName": "PM_RUN_CYC_ST_MODE",
     "BriefDescription": "Cycles run latch is set and core is in ST mode",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x500fa",
     "EventName": "PM_RUN_INST_CMPL",
     "BriefDescription": "Run_Instructions",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1e058",
     "EventName": "PM_STCX_FAIL",
     "BriefDescription": "stcx failed",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x20016",
     "EventName": "PM_ST_CMPL",
     "BriefDescription": "Store completion count",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x200f0",
     "EventName": "PM_ST_FIN",
     "BriefDescription": "Store Instructions Finished",
     "PublicDescription": "Store Instructions Finished (store sent to nest)"
   },
-  {,
+  {
     "EventCode": "0x20018",
     "EventName": "PM_ST_FWD",
     "BriefDescription": "Store forwards that finished",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x10026",
     "EventName": "PM_TABLEWALK_CYC",
     "BriefDescription": "Cycles when a tablewalk (I or D) is active",
     "PublicDescription": "Tablewalk Active"
   },
-  {,
+  {
     "EventCode": "0x300f8",
     "EventName": "PM_TB_BIT_TRANS",
     "BriefDescription": "timebase event",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2000c",
     "EventName": "PM_THRD_ALL_RUN_CYC",
     "BriefDescription": "All Threads in Run_cycles (was both threads in run_cycles)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30058",
     "EventName": "PM_TLBIE_FIN",
     "BriefDescription": "tlbie finished",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x10060",
     "EventName": "PM_TM_TRANS_RUN_CYC",
     "BriefDescription": "run cycles in transactional state",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2e012",
     "EventName": "PM_TM_TX_PASS_RUN_CYC",
     "BriefDescription": "cycles spent in successful transactions",
     "PublicDescription": "run cycles spent in successful transactions"
-  },
+  }
 ]
diff --git a/tools/perf/pmu-events/arch/powerpc/power8/pmc.json b/tools/perf/pmu-events/arch/powerpc/power8/pmc.json
index 583e4d9..5e0469f 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/pmc.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/pmc.json
@@ -1,140 +1,140 @@
 [
-  {,
+  {
     "EventCode": "0x20010",
     "EventName": "PM_PMC1_OVERFLOW",
     "BriefDescription": "Overflow from counter 1",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30010",
     "EventName": "PM_PMC2_OVERFLOW",
     "BriefDescription": "Overflow from counter 2",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30020",
     "EventName": "PM_PMC2_REWIND",
     "BriefDescription": "PMC2 Rewind Event (did not match condition)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x10022",
     "EventName": "PM_PMC2_SAVED",
     "BriefDescription": "PMC2 Rewind Value saved",
     "PublicDescription": "PMC2 Rewind Value saved (matched condition)"
   },
-  {,
+  {
     "EventCode": "0x40010",
     "EventName": "PM_PMC3_OVERFLOW",
     "BriefDescription": "Overflow from counter 3",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x10010",
     "EventName": "PM_PMC4_OVERFLOW",
     "BriefDescription": "Overflow from counter 4",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x10020",
     "EventName": "PM_PMC4_REWIND",
     "BriefDescription": "PMC4 Rewind Event",
     "PublicDescription": "PMC4 Rewind Event (did not match condition)"
   },
-  {,
+  {
     "EventCode": "0x30022",
     "EventName": "PM_PMC4_SAVED",
     "BriefDescription": "PMC4 Rewind Value saved (matched condition)",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x10024",
     "EventName": "PM_PMC5_OVERFLOW",
     "BriefDescription": "Overflow from counter 5",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x30024",
     "EventName": "PM_PMC6_OVERFLOW",
     "BriefDescription": "Overflow from counter 6",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x400f4",
     "EventName": "PM_RUN_PURR",
     "BriefDescription": "Run_PURR",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x10008",
     "EventName": "PM_RUN_SPURR",
     "BriefDescription": "Run SPURR",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x0",
     "EventName": "PM_SUSPENDED",
     "BriefDescription": "Counter OFF",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x301ea",
     "EventName": "PM_THRESH_EXC_1024",
     "BriefDescription": "Threshold counter exceeded a value of 1024",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x401ea",
     "EventName": "PM_THRESH_EXC_128",
     "BriefDescription": "Threshold counter exceeded a value of 128",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x401ec",
     "EventName": "PM_THRESH_EXC_2048",
     "BriefDescription": "Threshold counter exceeded a value of 2048",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x101e8",
     "EventName": "PM_THRESH_EXC_256",
     "BriefDescription": "Threshold counter exceed a count of 256",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x201e6",
     "EventName": "PM_THRESH_EXC_32",
     "BriefDescription": "Threshold counter exceeded a value of 32",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x101e6",
     "EventName": "PM_THRESH_EXC_4096",
     "BriefDescription": "Threshold counter exceed a count of 4096",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x201e8",
     "EventName": "PM_THRESH_EXC_512",
     "BriefDescription": "Threshold counter exceeded a value of 512",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x301e8",
     "EventName": "PM_THRESH_EXC_64",
     "BriefDescription": "IFU non-branch finished",
     "PublicDescription": "Threshold counter exceeded a value of 64"
   },
-  {,
+  {
     "EventCode": "0x101ec",
     "EventName": "PM_THRESH_MET",
     "BriefDescription": "threshold exceeded",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4016e",
     "EventName": "PM_THRESH_NOT_MET",
     "BriefDescription": "Threshold counter did not meet threshold",
     "PublicDescription": ""
-  },
+  }
 ]
diff --git a/tools/perf/pmu-events/arch/powerpc/power8/translation.json b/tools/perf/pmu-events/arch/powerpc/power8/translation.json
index e47a554..623e747 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/translation.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/translation.json
@@ -1,176 +1,176 @@
 [
-  {,
+  {
     "EventCode": "0x4c054",
     "EventName": "PM_DERAT_MISS_16G",
     "BriefDescription": "Data ERAT Miss (Data TLB Access) page size 16G",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3c054",
     "EventName": "PM_DERAT_MISS_16M",
     "BriefDescription": "Data ERAT Miss (Data TLB Access) page size 16M",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1c056",
     "EventName": "PM_DERAT_MISS_4K",
     "BriefDescription": "Data ERAT Miss (Data TLB Access) page size 4K",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2c054",
     "EventName": "PM_DERAT_MISS_64K",
     "BriefDescription": "Data ERAT Miss (Data TLB Access) page size 64K",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4e048",
     "EventName": "PM_DPTEG_FROM_DL2L3_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3e048",
     "EventName": "PM_DPTEG_FROM_DL2L3_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1e042",
     "EventName": "PM_DPTEG_FROM_L2",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L2 due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1e04e",
     "EventName": "PM_DPTEG_FROM_L2MISS",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from a localtion other than the local core's L2 due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2e040",
     "EventName": "PM_DPTEG_FROM_L2_MEPF",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L2 hit without dispatch conflicts on Mepf state. due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1e040",
     "EventName": "PM_DPTEG_FROM_L2_NO_CONFLICT",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L2 without conflict due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4e042",
     "EventName": "PM_DPTEG_FROM_L3",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L3 due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3e042",
     "EventName": "PM_DPTEG_FROM_L3_DISP_CONFLICT",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L3 with dispatch conflict due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2e042",
     "EventName": "PM_DPTEG_FROM_L3_MEPF",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L3 without dispatch conflicts hit on Mepf state. due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1e044",
     "EventName": "PM_DPTEG_FROM_L3_NO_CONFLICT",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L3 without conflict due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1e04c",
     "EventName": "PM_DPTEG_FROM_LL4",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from the local chip's L4 cache due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2e048",
     "EventName": "PM_DPTEG_FROM_LMEM",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from the local chip's Memory due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2e04c",
     "EventName": "PM_DPTEG_FROM_MEMORY",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from a memory location including L4 from local remote or distant due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4e04a",
     "EventName": "PM_DPTEG_FROM_OFF_CHIP_CACHE",
     "BriefDescription": "A Page Table Entry was loaded into the TLB either shared or modified data from another core's L2/L3 on a different chip (remote or distant) due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1e048",
     "EventName": "PM_DPTEG_FROM_ON_CHIP_CACHE",
     "BriefDescription": "A Page Table Entry was loaded into the TLB either shared or modified data from another core's L2/L3 on the same chip due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2e046",
     "EventName": "PM_DPTEG_FROM_RL2L3_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x1e04a",
     "EventName": "PM_DPTEG_FROM_RL2L3_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2e04a",
     "EventName": "PM_DPTEG_FROM_RL4",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from another chip's L4 on the same Node or Group ( Remote) due to a data side request",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x300fc",
     "EventName": "PM_DTLB_MISS",
     "BriefDescription": "Data PTEG reload",
     "PublicDescription": "Data PTEG Reloaded (DTLB Miss)"
   },
-  {,
+  {
     "EventCode": "0x1c058",
     "EventName": "PM_DTLB_MISS_16G",
     "BriefDescription": "Data TLB Miss page size 16G",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x4c056",
     "EventName": "PM_DTLB_MISS_16M",
     "BriefDescription": "Data TLB Miss page size 16M",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x2c056",
     "EventName": "PM_DTLB_MISS_4K",
     "BriefDescription": "Data TLB Miss page size 4k",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x3c056",
     "EventName": "PM_DTLB_MISS_64K",
     "BriefDescription": "Data TLB Miss page size 64K",
     "PublicDescription": ""
   },
-  {,
+  {
     "EventCode": "0x200f6",
     "EventName": "PM_LSU_DERAT_MISS",
     "BriefDescription": "DERAT Reloaded due to a DERAT miss",
     "PublicDescription": "DERAT Reloaded (Miss)"
   },
-  {,
+  {
     "EventCode": "0x20066",
     "EventName": "PM_TLB_MISS",
     "BriefDescription": "TLB Miss (I + D)",
     "PublicDescription": ""
-  },
+  }
 ]
