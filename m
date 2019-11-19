Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4B9102A0B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Nov 2019 17:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbfKSQ5u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 19 Nov 2019 11:57:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52938 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbfKSQ5t (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 19 Nov 2019 11:57:49 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iX6oI-0007Xb-BQ; Tue, 19 Nov 2019 17:57:02 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4D4741C19DE;
        Tue, 19 Nov 2019 17:56:51 +0100 (CET)
Date:   Tue, 19 Nov 2019 16:56:51 -0000
From:   "tip-bot2 for James Clark" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf vendor events power9: Fix commas so PMU event
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
In-Reply-To: <20191112160342.26470-3-james.clark@arm.com>
References: <20191112160342.26470-3-james.clark@arm.com>
MIME-Version: 1.0
Message-ID: <157418261118.12247.13666102260311989226.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     da3ef7f6cd5222f5a0289c4eb34254c62629b603
Gitweb:        https://git.kernel.org/tip/da3ef7f6cd5222f5a0289c4eb34254c62629b603
Author:        James Clark <james.clark@arm.com>
AuthorDate:    Tue, 12 Nov 2019 16:03:41 
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 12 Nov 2019 15:26:55 -03:00

perf vendor events power9: Fix commas so PMU event files are valid JSON

No functional change.

Remove extra commas in the power9 JSON files so that the files
can be parsed and validated by other utilities such as Python
that fail to parse invalid JSON.

Before:

  $ diffstat -l -p1 /wb/1.patch | while read filename ; do echo $filename ; cat $filename | json_verify ; done
  tools/perf/pmu-events/arch/powerpc/power9/cache.json
  parse error: invalid object key (must be a string)
                                          [   {,     "EventCode": "0x300
                       (right here) ------^
  JSON is invalid
  tools/perf/pmu-events/arch/powerpc/power9/floating-point.json
  parse error: invalid object key (must be a string)
                                          [   {,     "EventCode": "0x141
                       (right here) ------^
  JSON is invalid
  tools/perf/pmu-events/arch/powerpc/power9/frontend.json
  parse error: invalid object key (must be a string)
                                          [   {,     "EventCode": "0x250
                       (right here) ------^
  JSON is invalid
  tools/perf/pmu-events/arch/powerpc/power9/marked.json
  parse error: invalid object key (must be a string)
                                          [   {,     "EventCode": "0x301
                       (right here) ------^
  JSON is invalid
  tools/perf/pmu-events/arch/powerpc/power9/memory.json
  parse error: invalid object key (must be a string)
                                          [   {,     "EventCode": "0x300
                       (right here) ------^
  JSON is invalid
  tools/perf/pmu-events/arch/powerpc/power9/other.json
  parse error: invalid object key (must be a string)
                                          [   {,     "EventCode": "0x308
                       (right here) ------^
  JSON is invalid
  tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
  parse error: invalid object key (must be a string)
                                          [   {,     "EventCode": "0x4D0
                       (right here) ------^
  JSON is invalid
  tools/perf/pmu-events/arch/powerpc/power9/pmc.json
  parse error: invalid object key (must be a string)
                                          [   {,     "EventCode": "0x200
                       (right here) ------^
  JSON is invalid
  tools/perf/pmu-events/arch/powerpc/power9/translation.json
  parse error: invalid object key (must be a string)
                                          [   {,     "EventCode": "0x1E"
                       (right here) ------^
  JSON is invalid
  $

After:

  $ diffstat -l -p1 /wb/1.patch | while read filename ; do echo $filename ; cat $filename | json_verify ; done
  tools/perf/pmu-events/arch/powerpc/power9/cache.json
  JSON is valid
  tools/perf/pmu-events/arch/powerpc/power9/floating-point.json
  JSON is valid
  tools/perf/pmu-events/arch/powerpc/power9/frontend.json
  JSON is valid
  tools/perf/pmu-events/arch/powerpc/power9/marked.json
  JSON is valid
  tools/perf/pmu-events/arch/powerpc/power9/memory.json
  JSON is valid
  tools/perf/pmu-events/arch/powerpc/power9/other.json
  JSON is valid
  tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
  JSON is valid
  tools/perf/pmu-events/arch/powerpc/power9/pmc.json
  JSON is valid
  tools/perf/pmu-events/arch/powerpc/power9/translation.json
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
Link: http://lore.kernel.org/lkml/20191112160342.26470-3-james.clark@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/powerpc/power9/cache.json          |  44 +-
 tools/perf/pmu-events/arch/powerpc/power9/floating-point.json |  14 +-
 tools/perf/pmu-events/arch/powerpc/power9/frontend.json       | 142 +-
 tools/perf/pmu-events/arch/powerpc/power9/marked.json         | 250 +-
 tools/perf/pmu-events/arch/powerpc/power9/memory.json         |  52 +-
 tools/perf/pmu-events/arch/powerpc/power9/other.json          | 934 +++----
 tools/perf/pmu-events/arch/powerpc/power9/pipeline.json       | 212 +-
 tools/perf/pmu-events/arch/powerpc/power9/pmc.json            |  48 +-
 tools/perf/pmu-events/arch/powerpc/power9/translation.json    |  92 +-
 9 files changed, 894 insertions(+), 894 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/cache.json b/tools/perf/pmu-events/arch/powerpc/power9/cache.json
index 8510721..2984190 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/cache.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/cache.json
@@ -1,107 +1,107 @@
 [
-  {,
+  {
     "EventCode": "0x300F4",
     "EventName": "PM_THRD_CONC_RUN_INST",
     "BriefDescription": "PPC Instructions Finished by this thread when all threads in the core had the run-latch set"
   },
-  {,
+  {
     "EventCode": "0x1E056",
     "EventName": "PM_CMPLU_STALL_FLUSH_ANY_THREAD",
     "BriefDescription": "Cycles in which the NTC instruction is not allowed to complete because any of the 4 threads in the same core suffered a flush, which blocks completion"
   },
-  {,
+  {
     "EventCode": "0x4D016",
     "EventName": "PM_CMPLU_STALL_FXLONG",
     "BriefDescription": "Completion stall due to a long latency scalar fixed point instruction (division, square root)"
   },
-  {,
+  {
     "EventCode": "0x2D016",
     "EventName": "PM_CMPLU_STALL_FXU",
     "BriefDescription": "Finish stall due to a scalar fixed point or CR instruction in the execution pipeline. These instructions get routed to the ALU, ALU2, and DIV pipes"
   },
-  {,
+  {
     "EventCode": "0x4D12A",
     "EventName": "PM_MRK_DATA_FROM_RL4_CYC",
     "BriefDescription": "Duration in cycles to reload from another chip's L4 on the same Node or Group ( Remote) due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x1003C",
     "EventName": "PM_CMPLU_STALL_DMISS_L2L3",
     "BriefDescription": "Completion stall by Dcache miss which resolved in L2/L3"
   },
-  {,
+  {
     "EventCode": "0x4C014",
     "EventName": "PM_CMPLU_STALL_LMQ_FULL",
     "BriefDescription": "Finish stall because the NTF instruction was a load that missed in the L1 and the LMQ was unable to accept this load miss request because it was full"
   },
-  {,
+  {
     "EventCode": "0x14048",
     "EventName": "PM_INST_FROM_ON_CHIP_CACHE",
     "BriefDescription": "The processor's Instruction cache was reloaded either shared or modified data from another core's L2/L3 on the same chip due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x4D014",
     "EventName": "PM_CMPLU_STALL_LOAD_FINISH",
     "BriefDescription": "Finish stall because the NTF instruction was a load instruction with all its dependencies satisfied just going through the LSU pipe to finish"
   },
-  {,
+  {
     "EventCode": "0x2404A",
     "EventName": "PM_INST_FROM_RL4",
     "BriefDescription": "The processor's Instruction cache was reloaded from another chip's L4 on the same Node or Group ( Remote) due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x1404A",
     "EventName": "PM_INST_FROM_RL2L3_SHR",
     "BriefDescription": "The processor's Instruction cache was reloaded with Shared (S) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x401EA",
     "EventName": "PM_THRESH_EXC_128",
     "BriefDescription": "Threshold counter exceeded a value of 128"
   },
-  {,
+  {
     "EventCode": "0x400F6",
     "EventName": "PM_BR_MPRED_CMPL",
     "BriefDescription": "Number of Branch Mispredicts"
   },
-  {,
+  {
     "EventCode": "0x2F140",
     "EventName": "PM_MRK_DPTEG_FROM_L2_MEPF",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L2 hit without dispatch conflicts on Mepf state. due to a marked data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x101E6",
     "EventName": "PM_THRESH_EXC_4096",
     "BriefDescription": "Threshold counter exceed a count of 4096"
   },
-  {,
+  {
     "EventCode": "0x3F14A",
     "EventName": "PM_MRK_DPTEG_FROM_RMEM",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from another chip's memory on the same Node or Group ( Remote) due to a marked data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x4C016",
     "EventName": "PM_CMPLU_STALL_DMISS_L2L3_CONFLICT",
     "BriefDescription": "Completion stall due to cache miss that resolves in the L2 or L3 with a conflict"
   },
-  {,
+  {
     "EventCode": "0x2C01A",
     "EventName": "PM_CMPLU_STALL_LHS",
     "BriefDescription": "Finish stall because the NTF instruction was a load that hit on an older store and it was waiting for store data"
   },
-  {,
+  {
     "EventCode": "0x401E4",
     "EventName": "PM_MRK_DTLB_MISS",
     "BriefDescription": "Marked dtlb miss"
   },
-  {,
+  {
     "EventCode": "0x24046",
     "EventName": "PM_INST_FROM_RL2L3_MOD",
     "BriefDescription": "The processor's Instruction cache was reloaded with Modified (M) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x1002A",
     "EventName": "PM_CMPLU_STALL_LARX",
     "BriefDescription": "Finish stall because the NTF instruction was a larx waiting to be satisfied"
   }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/floating-point.json b/tools/perf/pmu-events/arch/powerpc/power9/floating-point.json
index 8a83bca..d228d6c 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/floating-point.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/floating-point.json
@@ -1,32 +1,32 @@
 [
-  {,
+  {
     "EventCode": "0x1415A",
     "EventName": "PM_MRK_DATA_FROM_L2_DISP_CONFLICT_LDHITST_CYC",
     "BriefDescription": "Duration in cycles to reload from local core's L2 with load hit store conflict due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x10058",
     "EventName": "PM_MEM_LOC_THRESH_IFU",
     "BriefDescription": "Local Memory above threshold for IFU speculation control"
   },
-  {,
+  {
     "EventCode": "0x2D028",
     "EventName": "PM_RADIX_PWC_L2_PDE_FROM_L2",
     "BriefDescription": "A Page Directory Entry was reloaded to a level 2 page walk cache from the core's L2 data cache"
   },
-  {,
+  {
     "EventCode": "0x30012",
     "EventName": "PM_FLUSH_COMPLETION",
     "BriefDescription": "The instruction that was next to complete did not complete because it suffered a flush"
   },
-  {,
+  {
     "EventCode": "0x2D154",
     "EventName": "PM_MRK_DERAT_MISS_64K",
     "BriefDescription": "Marked Data ERAT Miss (Data TLB Access) page size 64K"
   },
-  {,
+  {
     "EventCode": "0x4016E",
     "EventName": "PM_THRESH_NOT_MET",
     "BriefDescription": "Threshold counter did not meet threshold"
   }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/frontend.json b/tools/perf/pmu-events/arch/powerpc/power9/frontend.json
index f9fa84b..c8add9d 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/frontend.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/frontend.json
@@ -1,355 +1,355 @@
 [
-  {,
+  {
     "EventCode": "0x25044",
     "EventName": "PM_IPTEG_FROM_L31_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another core's L3 on the same chip due to a instruction side request"
   },
-  {,
+  {
     "EventCode": "0x101E8",
     "EventName": "PM_THRESH_EXC_256",
     "BriefDescription": "Threshold counter exceed a count of 256"
   },
-  {,
+  {
     "EventCode": "0x4504E",
     "EventName": "PM_IPTEG_FROM_L3MISS",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from a location other than the local core's L3 due to a instruction side request"
   },
-  {,
+  {
     "EventCode": "0x1006A",
     "EventName": "PM_NTC_ISSUE_HELD_DARQ_FULL",
     "BriefDescription": "The NTC instruction is being held at dispatch because there are no slots in the DARQ for it"
   },
-  {,
+  {
     "EventCode": "0x4E016",
     "EventName": "PM_CMPLU_STALL_LSAQ_ARB",
     "BriefDescription": "Finish stall because the NTF instruction was a load or store that was held in LSAQ because an older instruction from SRQ or LRQ won arbitration to the LSU pipe when this instruction tried to launch"
   },
-  {,
+  {
     "EventCode": "0x1001A",
     "EventName": "PM_LSU_SRQ_FULL_CYC",
     "BriefDescription": "Cycles in which the Store Queue is full on all 4 slices. This is event is not per thread. All the threads will see the same count for this core resource"
   },
-  {,
+  {
     "EventCode": "0x1E15E",
     "EventName": "PM_MRK_L2_TM_REQ_ABORT",
     "BriefDescription": "TM abort"
   },
-  {,
+  {
     "EventCode": "0x34052",
     "EventName": "PM_INST_SYS_PUMP_MPRED",
     "BriefDescription": "Final Pump Scope (system) mispredicted. Either the original scope was too small (Chip/Group) or the original scope was System and it should have been smaller. Counts for an instruction fetch"
   },
-  {,
+  {
     "EventCode": "0x20114",
     "EventName": "PM_MRK_L2_RC_DISP",
     "BriefDescription": "Marked Instruction RC dispatched in L2"
   },
-  {,
+  {
     "EventCode": "0x4C044",
     "EventName": "PM_DATA_FROM_L31_ECO_MOD",
     "BriefDescription": "The processor's data cache was reloaded with Modified (M) data from another core's ECO L3 on the same chip due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x1C044",
     "EventName": "PM_DATA_FROM_L3_NO_CONFLICT",
     "BriefDescription": "The processor's data cache was reloaded from local core's L3 without conflict due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x44050",
     "EventName": "PM_INST_SYS_PUMP_MPRED_RTY",
     "BriefDescription": "Final Pump Scope (system) ended up larger than Initial Pump Scope (Chip/Group) for an instruction fetch"
   },
-  {,
+  {
     "EventCode": "0x30154",
     "EventName": "PM_MRK_FAB_RSP_DCLAIM",
     "BriefDescription": "Marked store had to do a dclaim"
   },
-  {,
+  {
     "EventCode": "0x30014",
     "EventName": "PM_CMPLU_STALL_STORE_FIN_ARB",
     "BriefDescription": "Finish stall because the NTF instruction was a store waiting for a slot in the store finish pipe. This means the instruction is ready to finish but there are instructions ahead of it, using the finish pipe"
   },
-  {,
+  {
     "EventCode": "0x3E054",
     "EventName": "PM_LD_MISS_L1",
     "BriefDescription": "Load Missed L1, counted at execution time (can be greater than loads finished). LMQ merges are not included in this count. i.e. if a load instruction misses on an address that is already allocated on the LMQ, this event will not increment for that load). Note that this count is per slice, so if a load spans multiple slices this event will increment multiple times for a single load."
   },
-  {,
+  {
     "EventCode": "0x2E01A",
     "EventName": "PM_CMPLU_STALL_LSU_FLUSH_NEXT",
     "BriefDescription": "Completion stall of one cycle because the LSU requested to flush the next iop in the sequence. It takes 1 cycle for the ISU to process this request before the LSU instruction is allowed to complete"
   },
-  {,
+  {
     "EventCode": "0x2D01C",
     "EventName": "PM_CMPLU_STALL_STCX",
     "BriefDescription": "Finish stall because the NTF instruction was a stcx waiting for response from L2"
   },
-  {,
+  {
     "EventCode": "0x2C010",
     "EventName": "PM_CMPLU_STALL_LSU",
     "BriefDescription": "Completion stall by LSU instruction"
   },
-  {,
+  {
     "EventCode": "0x2C042",
     "EventName": "PM_DATA_FROM_L3_MEPF",
     "BriefDescription": "The processor's data cache was reloaded from local core's L3 without dispatch conflicts hit on Mepf state due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x4E012",
     "EventName": "PM_CMPLU_STALL_MTFPSCR",
     "BriefDescription": "Completion stall because the ISU is updating the register and notifying the Effective Address Table (EAT)"
   },
-  {,
+  {
     "EventCode": "0x100F2",
     "EventName": "PM_1PLUS_PPC_CMPL",
     "BriefDescription": "1 or more ppc insts finished"
   },
-  {,
+  {
     "EventCode": "0x3001C",
     "EventName": "PM_LSU_REJECT_LMQ_FULL",
     "BriefDescription": "LSU Reject due to LMQ full (up to 4 per cycles)"
   },
-  {,
+  {
     "EventCode": "0x15046",
     "EventName": "PM_IPTEG_FROM_L31_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another core's L3 on the same chip due to a instruction side request"
   },
-  {,
+  {
     "EventCode": "0x1015E",
     "EventName": "PM_MRK_FAB_RSP_RD_T_INTV",
     "BriefDescription": "Sampled Read got a T intervention"
   },
-  {,
+  {
     "EventCode": "0x101EC",
     "EventName": "PM_THRESH_MET",
     "BriefDescription": "threshold exceeded"
   },
-  {,
+  {
     "EventCode": "0x10020",
     "EventName": "PM_PMC4_REWIND",
     "BriefDescription": "PMC4 Rewind Event"
   },
-  {,
+  {
     "EventCode": "0x301EA",
     "EventName": "PM_THRESH_EXC_1024",
     "BriefDescription": "Threshold counter exceeded a value of 1024"
   },
-  {,
+  {
     "EventCode": "0x34056",
     "EventName": "PM_CMPLU_STALL_LSU_MFSPR",
     "BriefDescription": "Finish stall because the NTF instruction was a mfspr instruction targeting an LSU SPR and it was waiting for the register data to be returned"
   },
-  {,
+  {
     "EventCode": "0x44056",
     "EventName": "PM_VECTOR_ST_CMPL",
     "BriefDescription": "Number of vector store instructions completed"
   },
-  {,
+  {
     "EventCode": "0x2C124",
     "EventName": "PM_MRK_DATA_FROM_L2_DISP_CONFLICT_OTHER",
     "BriefDescription": "The processor's data cache was reloaded from local core's L2 with dispatch conflict due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x4C12A",
     "EventName": "PM_MRK_DATA_FROM_RL2L3_SHR_CYC",
     "BriefDescription": "Duration in cycles to reload with Shared (S) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x30060",
     "EventName": "PM_TM_TRANS_RUN_INST",
     "BriefDescription": "Run instructions completed in transactional state (gated by the run latch)"
   },
-  {,
+  {
     "EventCode": "0x2C014",
     "EventName": "PM_CMPLU_STALL_STORE_FINISH",
     "BriefDescription": "Finish stall because the NTF instruction was a store with all its dependencies met, just waiting to go through the LSU pipe to finish"
   },
-  {,
+  {
     "EventCode": "0x3515A",
     "EventName": "PM_MRK_DATA_FROM_ON_CHIP_CACHE_CYC",
     "BriefDescription": "Duration in cycles to reload either shared or modified data from another core's L2/L3 on the same chip due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x34050",
     "EventName": "PM_INST_SYS_PUMP_CPRED",
     "BriefDescription": "Initial and Final Pump Scope was system pump (prediction=correct) for an instruction fetch"
   },
-  {,
+  {
     "EventCode": "0x3015E",
     "EventName": "PM_MRK_FAB_RSP_CLAIM_RTY",
     "BriefDescription": "Sampled store did a rwitm and got a rty"
   },
-  {,
+  {
     "EventCode": "0x0",
     "EventName": "PM_SUSPENDED",
     "BriefDescription": "Counter OFF"
   },
-  {,
+  {
     "EventCode": "0x10010",
     "EventName": "PM_PMC4_OVERFLOW",
     "BriefDescription": "Overflow from counter 4"
   },
-  {,
+  {
     "EventCode": "0x3E04A",
     "EventName": "PM_DPTEG_FROM_RMEM",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from another chip's memory on the same Node or Group ( Remote) due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x2F152",
     "EventName": "PM_MRK_FAB_RSP_DCLAIM_CYC",
     "BriefDescription": "cycles L2 RC took for a dclaim"
   },
-  {,
+  {
     "EventCode": "0x10004",
     "EventName": "PM_CMPLU_STALL_LRQ_OTHER",
     "BriefDescription": "Finish stall due to LRQ miscellaneous reasons, lost arbitration to LMQ slot, bank collisions, set prediction cleanup, set prediction multihit and others"
   },
-  {,
+  {
     "EventCode": "0x4F150",
     "EventName": "PM_MRK_FAB_RSP_RWITM_CYC",
     "BriefDescription": "cycles L2 RC took for a rwitm"
   },
-  {,
+  {
     "EventCode": "0x4E042",
     "EventName": "PM_DPTEG_FROM_L3",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L3 due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x1F054",
     "EventName": "PM_TLB_HIT",
     "BriefDescription": "Number of times the TLB had the data required by the instruction. Applies to both HPT and RPT"
   },
-  {,
+  {
     "EventCode": "0x2C01E",
     "EventName": "PM_CMPLU_STALL_SYNC_PMU_INT",
     "BriefDescription": "Cycles in which the NTC instruction is waiting for a synchronous PMU interrupt"
   },
-  {,
+  {
     "EventCode": "0x24050",
     "EventName": "PM_IOPS_CMPL",
     "BriefDescription": "Internal Operations completed"
   },
-  {,
+  {
     "EventCode": "0x1515C",
     "EventName": "PM_SYNC_MRK_BR_MPRED",
     "BriefDescription": "Marked Branch mispredict that can cause a synchronous interrupt"
   },
-  {,
+  {
     "EventCode": "0x300FA",
     "EventName": "PM_INST_FROM_L3MISS",
     "BriefDescription": "Marked instruction was reloaded from a location beyond the local chiplet"
   },
-  {,
+  {
     "EventCode": "0x15044",
     "EventName": "PM_IPTEG_FROM_L3_NO_CONFLICT",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L3 without conflict due to a instruction side request"
   },
-  {,
+  {
     "EventCode": "0x15152",
     "EventName": "PM_SYNC_MRK_BR_LINK",
     "BriefDescription": "Marked Branch and link branch that can cause a synchronous interrupt"
   },
-  {,
+  {
     "EventCode": "0x1E050",
     "EventName": "PM_CMPLU_STALL_TEND",
     "BriefDescription": "Finish stall because the NTF instruction was a tend instruction awaiting response from L2"
   },
-  {,
+  {
     "EventCode": "0x1013E",
     "EventName": "PM_MRK_LD_MISS_EXPOSED_CYC",
     "BriefDescription": "Marked Load exposed Miss (use edge detect to count #)"
   },
-  {,
+  {
     "EventCode": "0x25042",
     "EventName": "PM_IPTEG_FROM_L3_MEPF",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L3 without dispatch conflicts hit on Mepf state. due to a instruction side request"
   },
-  {,
+  {
     "EventCode": "0x14054",
     "EventName": "PM_INST_PUMP_CPRED",
     "BriefDescription": "Pump prediction correct. Counts across all types of pumps for an instruction fetch"
   },
-  {,
+  {
     "EventCode": "0x4015E",
     "EventName": "PM_MRK_FAB_RSP_RD_RTY",
     "BriefDescription": "Sampled L2 reads retry count"
   },
-  {,
+  {
     "EventCode": "0x45048",
     "EventName": "PM_IPTEG_FROM_DL2L3_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to a instruction side request"
   },
-  {,
+  {
     "EventCode": "0x44052",
     "EventName": "PM_INST_PUMP_MPRED",
     "BriefDescription": "Pump misprediction. Counts across all types of pumps for an instruction fetch"
   },
-  {,
+  {
     "EventCode": "0x30026",
     "EventName": "PM_CMPLU_STALL_STORE_DATA",
     "BriefDescription": "Finish stall because the next to finish instruction was a store waiting on data"
   },
-  {,
+  {
     "EventCode": "0x301E6",
     "EventName": "PM_MRK_DERAT_MISS",
     "BriefDescription": "Erat Miss (TLB Access) All page sizes"
   },
-  {,
+  {
     "EventCode": "0x24154",
     "EventName": "PM_THRESH_ACC",
     "BriefDescription": "This event increments every time the threshold event counter ticks. Thresholding must be enabled (via MMCRA) and the thresholding start event must occur for this counter to increment. It will stop incrementing when the thresholding stop event occurs or when thresholding is disabled, until the next time a configured thresholding start event occurs."
   },
-  {,
+  {
     "EventCode": "0x2015E",
     "EventName": "PM_MRK_FAB_RSP_RWITM_RTY",
     "BriefDescription": "Sampled store did a rwitm and got a rty"
   },
-  {,
+  {
     "EventCode": "0x200FA",
     "EventName": "PM_BR_TAKEN_CMPL",
     "BriefDescription": "New event for Branch Taken"
   },
-  {,
+  {
     "EventCode": "0x35044",
     "EventName": "PM_IPTEG_FROM_L31_ECO_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another core's ECO L3 on the same chip due to a instruction side request"
   },
-  {,
+  {
     "EventCode": "0x4C010",
     "EventName": "PM_CMPLU_STALL_STORE_PIPE_ARB",
     "BriefDescription": "Finish stall because the NTF instruction was a store waiting for the next relaunch opportunity after an internal reject. This means the instruction is ready to relaunch and tried once but lost arbitration"
   },
-  {,
+  {
     "EventCode": "0x4C01C",
     "EventName": "PM_CMPLU_STALL_ST_FWD",
     "BriefDescription": "Completion stall due to store forward"
   },
-  {,
+  {
     "EventCode": "0x3515C",
     "EventName": "PM_MRK_DATA_FROM_RL4",
     "BriefDescription": "The processor's data cache was reloaded from another chip's L4 on the same Node or Group ( Remote) due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x2D14C",
     "EventName": "PM_MRK_DATA_FROM_L31_ECO_SHR",
     "BriefDescription": "The processor's data cache was reloaded with Shared (S) data from another core's ECO L3 on the same chip due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x40116",
     "EventName": "PM_MRK_LARX_FIN",
     "BriefDescription": "Larx finished"
   },
-  {,
+  {
     "EventCode": "0x1003A",
     "EventName": "PM_CMPLU_STALL_LSU_FIN",
     "BriefDescription": "Finish stall because the NTF instruction was an LSU op (other than a load or a store) with all its dependencies met and just going through the LSU pipe to finish"
   },
-  {,
+  {
     "EventCode": "0x3012A",
     "EventName": "PM_MRK_L2_RC_DONE",
     "BriefDescription": "Marked RC done"
   },
-  {,
+  {
     "EventCode": "0x45044",
     "EventName": "PM_IPTEG_FROM_L31_ECO_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another core's ECO L3 on the same chip due to a instruction side request"
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/marked.json b/tools/perf/pmu-events/arch/powerpc/power9/marked.json
index b1954c3..b24d25a 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/marked.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/marked.json
@@ -1,625 +1,625 @@
 [
-  {,
+  {
     "EventCode": "0x3013E",
     "EventName": "PM_MRK_STALL_CMPLU_CYC",
     "BriefDescription": "Number of cycles the marked instruction is experiencing a stall while it is next to complete (NTC)"
   },
-  {,
+  {
     "EventCode": "0x4F056",
     "EventName": "PM_RADIX_PWC_L1_PDE_FROM_L3MISS",
     "BriefDescription": "A Page Directory Entry was reloaded to a level 1 page walk cache from beyond the core's L3 data cache. The source could be local/remote/distant memory or another core's cache"
   },
-  {,
+  {
     "EventCode": "0x24158",
     "EventName": "PM_MRK_INST",
     "BriefDescription": "An instruction was marked. Includes both Random Instruction Sampling (RIS) at decode time and Random Event Sampling (RES) at the time the configured event happens"
   },
-  {,
+  {
     "EventCode": "0x1E046",
     "EventName": "PM_DPTEG_FROM_L31_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another core's L3 on the same chip due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x3C04A",
     "EventName": "PM_DATA_FROM_RMEM",
     "BriefDescription": "The processor's data cache was reloaded from another chip's memory on the same Node or Group ( Remote) due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x2C01C",
     "EventName": "PM_CMPLU_STALL_DMISS_REMOTE",
     "BriefDescription": "Completion stall by Dcache miss which resolved from remote chip (cache or memory)"
   },
-  {,
+  {
     "EventCode": "0x44040",
     "EventName": "PM_INST_FROM_L2_DISP_CONFLICT_OTHER",
     "BriefDescription": "The processor's Instruction cache was reloaded from local core's L2 with dispatch conflict due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x2E050",
     "EventName": "PM_DARQ0_7_9_ENTRIES",
     "BriefDescription": "Cycles in which 7,8, or 9 DARQ entries (out of 12) are in use"
   },
-  {,
+  {
     "EventCode": "0x2D02E",
     "EventName": "PM_RADIX_PWC_L3_PTE_FROM_L2",
     "BriefDescription": "A Page Table Entry was reloaded to a level 3 page walk cache from the core's L2 data cache. This implies that a level 4 PWC access was not necessary for this translation"
   },
-  {,
+  {
     "EventCode": "0x3F05E",
     "EventName": "PM_RADIX_PWC_L3_PTE_FROM_L3",
     "BriefDescription": "A Page Table Entry was reloaded to a level 3 page walk cache from the core's L3 data cache. This implies that a level 4 PWC access was not necessary for this translation"
   },
-  {,
+  {
     "EventCode": "0x2E01E",
     "EventName": "PM_CMPLU_STALL_NTC_FLUSH",
     "BriefDescription": "Completion stall due to ntc flush"
   },
-  {,
+  {
     "EventCode": "0x1F14C",
     "EventName": "PM_MRK_DPTEG_FROM_LL4",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from the local chip's L4 cache due to a marked data side request.. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x20130",
     "EventName": "PM_MRK_INST_DECODED",
     "BriefDescription": "An instruction was marked at decode time. Random Instruction Sampling (RIS) only"
   },
-  {,
+  {
     "EventCode": "0x3F144",
     "EventName": "PM_MRK_DPTEG_FROM_L31_ECO_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another core's ECO L3 on the same chip due to a marked data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x4D058",
     "EventName": "PM_VECTOR_FLOP_CMPL",
     "BriefDescription": "Vector FP instruction completed"
   },
-  {,
+  {
     "EventCode": "0x14040",
     "EventName": "PM_INST_FROM_L2_NO_CONFLICT",
     "BriefDescription": "The processor's Instruction cache was reloaded from local core's L2 without conflict due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x4404E",
     "EventName": "PM_INST_FROM_L3MISS_MOD",
     "BriefDescription": "The processor's Instruction cache was reloaded from a location other than the local core's L3 due to a instruction fetch"
   },
-  {,
+  {
     "EventCode": "0x3003A",
     "EventName": "PM_CMPLU_STALL_EXCEPTION",
     "BriefDescription": "Cycles in which the NTC instruction is not allowed to complete because it was interrupted by ANY exception, which has to be serviced before the instruction can complete"
   },
-  {,
+  {
     "EventCode": "0x4F144",
     "EventName": "PM_MRK_DPTEG_FROM_L31_ECO_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another core's ECO L3 on the same chip due to a marked data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x3E044",
     "EventName": "PM_DPTEG_FROM_L31_ECO_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another core's ECO L3 on the same chip due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x300F6",
     "EventName": "PM_L1_DCACHE_RELOAD_VALID",
     "BriefDescription": "DL1 reloaded due to Demand Load"
   },
-  {,
+  {
     "EventCode": "0x1415E",
     "EventName": "PM_MRK_DATA_FROM_L3MISS_CYC",
     "BriefDescription": "Duration in cycles to reload from a location other than the local core's L3 due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x1E052",
     "EventName": "PM_CMPLU_STALL_SLB",
     "BriefDescription": "Finish stall because the NTF instruction was awaiting L2 response for an SLB"
   },
-  {,
+  {
     "EventCode": "0x4404C",
     "EventName": "PM_INST_FROM_DMEM",
     "BriefDescription": "The processor's Instruction cache was reloaded from another chip's memory on the same Node or Group (Distant) due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x3000E",
     "EventName": "PM_FXU_1PLUS_BUSY",
     "BriefDescription": "At least one of the 4 FXU units is busy"
   },
-  {,
+  {
     "EventCode": "0x2C048",
     "EventName": "PM_DATA_FROM_LMEM",
     "BriefDescription": "The processor's data cache was reloaded from the local chip's Memory due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x3000A",
     "EventName": "PM_CMPLU_STALL_PM",
     "BriefDescription": "Finish stall because the NTF instruction was issued to the Permute execution pipe and waiting to finish. Includes permute and decimal fixed point instructions (128 bit BCD arithmetic) + a few 128 bit fixpoint add/subtract instructions with carry. Not qualified by vector or multicycle"
   },
-  {,
+  {
     "EventCode": "0x1504E",
     "EventName": "PM_IPTEG_FROM_L2MISS",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from a location other than the local core's L2 due to a instruction side request"
   },
-  {,
+  {
     "EventCode": "0x1C052",
     "EventName": "PM_DATA_GRP_PUMP_MPRED_RTY",
     "BriefDescription": "Final Pump Scope (Group) ended up larger than Initial Pump Scope (Chip) for a demand load"
   },
-  {,
+  {
     "EventCode": "0x30008",
     "EventName": "PM_DISP_STARVED",
     "BriefDescription": "Dispatched Starved"
   },
-  {,
+  {
     "EventCode": "0x14042",
     "EventName": "PM_INST_FROM_L2",
     "BriefDescription": "The processor's Instruction cache was reloaded from local core's L2 due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x4000C",
     "EventName": "PM_FREQ_UP",
     "BriefDescription": "Power Management: Above Threshold A"
   },
-  {,
+  {
     "EventCode": "0x3C050",
     "EventName": "PM_DATA_SYS_PUMP_CPRED",
     "BriefDescription": "Initial and Final Pump Scope was system pump (prediction=correct) for a demand load"
   },
-  {,
+  {
     "EventCode": "0x25040",
     "EventName": "PM_IPTEG_FROM_L2_MEPF",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L2 hit without dispatch conflicts on Mepf state. due to a instruction side request"
   },
-  {,
+  {
     "EventCode": "0x10132",
     "EventName": "PM_MRK_INST_ISSUED",
     "BriefDescription": "Marked instruction issued"
   },
-  {,
+  {
     "EventCode": "0x1C046",
     "EventName": "PM_DATA_FROM_L31_SHR",
     "BriefDescription": "The processor's data cache was reloaded with Shared (S) data from another core's L3 on the same chip due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x2C044",
     "EventName": "PM_DATA_FROM_L31_MOD",
     "BriefDescription": "The processor's data cache was reloaded with Modified (M) data from another core's L3 on the same chip due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x2C04A",
     "EventName": "PM_DATA_FROM_RL4",
     "BriefDescription": "The processor's data cache was reloaded from another chip's L4 on the same Node or Group ( Remote) due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x24044",
     "EventName": "PM_INST_FROM_L31_MOD",
     "BriefDescription": "The processor's Instruction cache was reloaded with Modified (M) data from another core's L3 on the same chip due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x4C050",
     "EventName": "PM_DATA_SYS_PUMP_MPRED_RTY",
     "BriefDescription": "Final Pump Scope (system) ended up larger than Initial Pump Scope (Chip/Group) for a demand load"
   },
-  {,
+  {
     "EventCode": "0x2C052",
     "EventName": "PM_DATA_GRP_PUMP_MPRED",
     "BriefDescription": "Final Pump Scope (Group) ended up either larger or smaller than Initial Pump Scope for a demand load"
   },
-  {,
+  {
     "EventCode": "0x2F148",
     "EventName": "PM_MRK_DPTEG_FROM_LMEM",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from the local chip's Memory due to a marked data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x4D01A",
     "EventName": "PM_CMPLU_STALL_EIEIO",
     "BriefDescription": "Finish stall because the NTF instruction is an EIEIO waiting for response from L2"
   },
-  {,
+  {
     "EventCode": "0x4F14E",
     "EventName": "PM_MRK_DPTEG_FROM_L3MISS",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from a location other than the local core's L3 due to a marked data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x4F05A",
     "EventName": "PM_RADIX_PWC_L4_PTE_FROM_L3",
     "BriefDescription": "A Page Table Entry was reloaded to a level 4 page walk cache from the core's L3 data cache. This is the deepest level of PWC possible for a translation"
   },
-  {,
+  {
     "EventCode": "0x1F05A",
     "EventName": "PM_RADIX_PWC_L4_PTE_FROM_L2",
     "BriefDescription": "A Page Table Entry was reloaded to a level 4 page walk cache from the core's L2 data cache. This is the deepest level of PWC possible for a translation"
   },
-  {,
+  {
     "EventCode": "0x30068",
     "EventName": "PM_L1_ICACHE_RELOADED_PREF",
     "BriefDescription": "Counts all Icache prefetch reloads ( includes demand turned into prefetch)"
   },
-  {,
+  {
     "EventCode": "0x4C04A",
     "EventName": "PM_DATA_FROM_OFF_CHIP_CACHE",
     "BriefDescription": "The processor's data cache was reloaded either shared or modified data from another core's L2/L3 on a different chip (remote or distant) due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x400FE",
     "EventName": "PM_DATA_FROM_MEMORY",
     "BriefDescription": "The processor's data cache was reloaded from a memory location including L4 from local remote or distant due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x3F058",
     "EventName": "PM_RADIX_PWC_L1_PDE_FROM_L3",
     "BriefDescription": "A Page Directory Entry was reloaded to a level 1 page walk cache from the core's L3 data cache"
   },
-  {,
+  {
     "EventCode": "0x3C052",
     "EventName": "PM_DATA_SYS_PUMP_MPRED",
     "BriefDescription": "Final Pump Scope (system) mispredicted. Either the original scope was too small (Chip/Group) or the original scope was System and it should have been smaller. Counts for a demand load"
   },
-  {,
+  {
     "EventCode": "0x4D142",
     "EventName": "PM_MRK_DATA_FROM_L3",
     "BriefDescription": "The processor's data cache was reloaded from local core's L3 due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x30050",
     "EventName": "PM_SYS_PUMP_CPRED",
     "BriefDescription": "Initial and Final Pump Scope was system pump for all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)"
   },
-  {,
+  {
     "EventCode": "0x30028",
     "EventName": "PM_CMPLU_STALL_SPEC_FINISH",
     "BriefDescription": "Finish stall while waiting for the non-speculative finish of either a stcx waiting for its result or a load waiting for non-critical sectors of data and ECC"
   },
-  {,
+  {
     "EventCode": "0x400F4",
     "EventName": "PM_RUN_PURR",
     "BriefDescription": "Run_PURR"
   },
-  {,
+  {
     "EventCode": "0x3404C",
     "EventName": "PM_INST_FROM_DL4",
     "BriefDescription": "The processor's Instruction cache was reloaded from another chip's L4 on a different Node or Group (Distant) due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x3D05A",
     "EventName": "PM_NTC_ISSUE_HELD_OTHER",
     "BriefDescription": "The NTC instruction is being held at dispatch during regular pipeline cycles, or because the VSU is busy with multi-cycle instructions, or because of a write-back collision with VSU"
   },
-  {,
+  {
     "EventCode": "0x2E048",
     "EventName": "PM_DPTEG_FROM_LMEM",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from the local chip's Memory due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x2D02A",
     "EventName": "PM_RADIX_PWC_L3_PDE_FROM_L2",
     "BriefDescription": "A Page Directory Entry was reloaded to a level 3 page walk cache from the core's L2 data cache"
   },
-  {,
+  {
     "EventCode": "0x1F05C",
     "EventName": "PM_RADIX_PWC_L3_PDE_FROM_L3",
     "BriefDescription": "A Page Directory Entry was reloaded to a level 3 page walk cache from the core's L3 data cache"
   },
-  {,
+  {
     "EventCode": "0x4D04A",
     "EventName": "PM_DARQ0_0_3_ENTRIES",
     "BriefDescription": "Cycles in which 3 or less DARQ entries (out of 12) are in use"
   },
-  {,
+  {
     "EventCode": "0x1404C",
     "EventName": "PM_INST_FROM_LL4",
     "BriefDescription": "The processor's Instruction cache was reloaded from the local chip's L4 cache due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x200FD",
     "EventName": "PM_L1_ICACHE_MISS",
     "BriefDescription": "Demand iCache Miss"
   },
-  {,
+  {
     "EventCode": "0x34040",
     "EventName": "PM_INST_FROM_L2_DISP_CONFLICT_LDHITST",
     "BriefDescription": "The processor's Instruction cache was reloaded from local core's L2 with load hit store conflict due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x20138",
     "EventName": "PM_MRK_ST_NEST",
     "BriefDescription": "Marked store sent to nest"
   },
-  {,
+  {
     "EventCode": "0x44048",
     "EventName": "PM_INST_FROM_DL2L3_MOD",
     "BriefDescription": "The processor's Instruction cache was reloaded with Modified (M) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x35046",
     "EventName": "PM_IPTEG_FROM_L21_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another core's L2 on the same chip due to a instruction side request"
   },
-  {,
+  {
     "EventCode": "0x4C04E",
     "EventName": "PM_DATA_FROM_L3MISS_MOD",
     "BriefDescription": "The processor's data cache was reloaded from a location other than the local core's L3 due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x401E0",
     "EventName": "PM_MRK_INST_CMPL",
     "BriefDescription": "marked instruction completed"
   },
-  {,
+  {
     "EventCode": "0x2C128",
     "EventName": "PM_MRK_DATA_FROM_DL2L3_SHR_CYC",
     "BriefDescription": "Duration in cycles to reload with Shared (S) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x34044",
     "EventName": "PM_INST_FROM_L31_ECO_SHR",
     "BriefDescription": "The processor's Instruction cache was reloaded with Shared (S) data from another core's ECO L3 on the same chip due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x4E018",
     "EventName": "PM_CMPLU_STALL_NTC_DISP_FIN",
     "BriefDescription": "Finish stall because the NTF instruction was one that must finish at dispatch."
   },
-  {,
+  {
     "EventCode": "0x2E05E",
     "EventName": "PM_LMQ_EMPTY_CYC",
     "BriefDescription": "Cycles in which the LMQ has no pending load misses for this thread"
   },
-  {,
+  {
     "EventCode": "0x4C122",
     "EventName": "PM_DARQ1_0_3_ENTRIES",
     "BriefDescription": "Cycles in which 3 or fewer DARQ1 entries (out of 12) are in use"
   },
-  {,
+  {
     "EventCode": "0x4F058",
     "EventName": "PM_RADIX_PWC_L2_PTE_FROM_L3",
     "BriefDescription": "A Page Table Entry was reloaded to a level 2 page walk cache from the core's L3 data cache. This implies that level 3 and level 4 PWC accesses were not necessary for this translation"
   },
-  {,
+  {
     "EventCode": "0x14046",
     "EventName": "PM_INST_FROM_L31_SHR",
     "BriefDescription": "The processor's Instruction cache was reloaded with Shared (S) data from another core's L3 on the same chip due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x3012C",
     "EventName": "PM_MRK_ST_FWD",
     "BriefDescription": "Marked st forwards"
   },
-  {,
+  {
     "EventCode": "0x101E0",
     "EventName": "PM_MRK_INST_DISP",
     "BriefDescription": "The thread has dispatched a randomly sampled marked instruction"
   },
-  {,
+  {
     "EventCode": "0x1D058",
     "EventName": "PM_DARQ0_10_12_ENTRIES",
     "BriefDescription": "Cycles in which 10 or more DARQ entries (out of 12) are in use"
   },
-  {,
+  {
     "EventCode": "0x300FE",
     "EventName": "PM_DATA_FROM_L3MISS",
     "BriefDescription": "Demand LD - L3 Miss (not L2 hit and not L3 hit)"
   },
-  {,
+  {
     "EventCode": "0x30006",
     "EventName": "PM_CMPLU_STALL_OTHER_CMPL",
     "BriefDescription": "Instructions the core completed while this tread was stalled"
   },
-  {,
+  {
     "EventCode": "0x1005C",
     "EventName": "PM_CMPLU_STALL_DP",
     "BriefDescription": "Finish stall because the NTF instruction was a scalar instruction issued to the Double Precision execution pipe and waiting to finish. Includes binary floating point instructions in 32 and 64 bit binary floating point format. Not qualified multicycle. Qualified by NOT vector"
   },
-  {,
+  {
     "EventCode": "0x1E042",
     "EventName": "PM_DPTEG_FROM_L2",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L2 due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x1016E",
     "EventName": "PM_MRK_BR_CMPL",
     "BriefDescription": "Branch Instruction completed"
   },
-  {,
+  {
     "EventCode": "0x2013A",
     "EventName": "PM_MRK_BRU_FIN",
     "BriefDescription": "bru marked instr finish"
   },
-  {,
+  {
     "EventCode": "0x4F05E",
     "EventName": "PM_RADIX_PWC_L3_PTE_FROM_L3MISS",
     "BriefDescription": "A Page Table Entry was reloaded to a level 3 page walk cache from beyond the core's L3 data cache. This implies that a level 4 PWC access was not necessary for this translation. The source could be local/remote/distant memory or another core's cache"
   },
-  {,
+  {
     "EventCode": "0x400FC",
     "EventName": "PM_ITLB_MISS",
     "BriefDescription": "ITLB Reloaded. Counts 1 per ITLB miss for HPT but multiple for radix depending on number of levels traveresed"
   },
-  {,
+  {
     "EventCode": "0x1E044",
     "EventName": "PM_DPTEG_FROM_L3_NO_CONFLICT",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L3 without conflict due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x4D05A",
     "EventName": "PM_NON_MATH_FLOP_CMPL",
     "BriefDescription": "Non FLOP operation completed"
   },
-  {,
+  {
     "EventCode": "0x101E2",
     "EventName": "PM_MRK_BR_TAKEN_CMPL",
     "BriefDescription": "Marked Branch Taken completed"
   },
-  {,
+  {
     "EventCode": "0x3E158",
     "EventName": "PM_MRK_STCX_FAIL",
     "BriefDescription": "marked stcx failed"
   },
-  {,
+  {
     "EventCode": "0x1C048",
     "EventName": "PM_DATA_FROM_ON_CHIP_CACHE",
     "BriefDescription": "The processor's data cache was reloaded either shared or modified data from another core's L2/L3 on the same chip due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x1C054",
     "EventName": "PM_DATA_PUMP_CPRED",
     "BriefDescription": "Pump prediction correct. Counts across all types of pumps for a demand load"
   },
-  {,
+  {
     "EventCode": "0x4405E",
     "EventName": "PM_DARQ_STORE_REJECT",
     "BriefDescription": "The DARQ attempted to transmit a store into an LSAQ or SRQ entry but It was rejected. Divide by PM_DARQ_STORE_XMIT to get reject ratio"
   },
-  {,
+  {
     "EventCode": "0x1C042",
     "EventName": "PM_DATA_FROM_L2",
     "BriefDescription": "The processor's data cache was reloaded from local core's L2 due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x1D14C",
     "EventName": "PM_MRK_DATA_FROM_LL4",
     "BriefDescription": "The processor's data cache was reloaded from the local chip's L4 cache due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x1006C",
     "EventName": "PM_RUN_CYC_ST_MODE",
     "BriefDescription": "Cycles run latch is set and core is in ST mode"
   },
-  {,
+  {
     "EventCode": "0x3C044",
     "EventName": "PM_DATA_FROM_L31_ECO_SHR",
     "BriefDescription": "The processor's data cache was reloaded with Shared (S) data from another core's ECO L3 on the same chip due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x4C052",
     "EventName": "PM_DATA_PUMP_MPRED",
     "BriefDescription": "Pump misprediction. Counts across all types of pumps for a demand load"
   },
-  {,
+  {
     "EventCode": "0x20050",
     "EventName": "PM_GRP_PUMP_CPRED",
     "BriefDescription": "Initial and Final Pump Scope and data sourced across this scope was group pump for all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)"
   },
-  {,
+  {
     "EventCode": "0x1F150",
     "EventName": "PM_MRK_ST_L2DISP_TO_CMPL_CYC",
     "BriefDescription": "cycles from L2 rc disp to l2 rc completion"
   },
-  {,
+  {
     "EventCode": "0x4505A",
     "EventName": "PM_SP_FLOP_CMPL",
     "BriefDescription": "SP instruction completed"
   },
-  {,
+  {
     "EventCode": "0x4000A",
     "EventName": "PM_ISQ_36_44_ENTRIES",
     "BriefDescription": "Cycles in which 36 or more Issue Queue entries are in use. This is a shared event, not per thread. There are 44 issue queue entries across 4 slices in the whole core"
   },
-  {,
+  {
     "EventCode": "0x2C12E",
     "EventName": "PM_MRK_DATA_FROM_LL4_CYC",
     "BriefDescription": "Duration in cycles to reload from the local chip's L4 cache due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x2C058",
     "EventName": "PM_MEM_PREF",
     "BriefDescription": "Memory prefetch for this thread. Includes L4"
   },
-  {,
+  {
     "EventCode": "0x40012",
     "EventName": "PM_L1_ICACHE_RELOADED_ALL",
     "BriefDescription": "Counts all Icache reloads includes demand, prefetch, prefetch turned into demand and demand turned into prefetch"
   },
-  {,
+  {
     "EventCode": "0x3003C",
     "EventName": "PM_CMPLU_STALL_NESTED_TEND",
     "BriefDescription": "Completion stall because the ISU is updating the TEXASR to keep track of the nested tend and decrement the TEXASR nested level. This is a short delay"
   },
-  {,
+  {
     "EventCode": "0x3D05C",
     "EventName": "PM_DISP_HELD_HB_FULL",
     "BriefDescription": "Dispatch held due to History Buffer full. Could be GPR/VSR/VMR/FPR/CR/XVF; CR; XVF (XER/VSCR/FPSCR)"
   },
-  {,
+  {
     "EventCode": "0x30052",
     "EventName": "PM_SYS_PUMP_MPRED",
     "BriefDescription": "Final Pump Scope (system) mispredicted. Either the original scope was too small (Chip/Group) or the original scope was System and it should have been smaller. Counts for all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)"
   },
-  {,
+  {
     "EventCode": "0x2E044",
     "EventName": "PM_DPTEG_FROM_L31_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another core's L3 on the same chip due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x34048",
     "EventName": "PM_INST_FROM_DL2L3_SHR",
     "BriefDescription": "The processor's Instruction cache was reloaded with Shared (S) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x45042",
     "EventName": "PM_IPTEG_FROM_L3",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L3 due to a instruction side request"
   },
-  {,
+  {
     "EventCode": "0x15042",
     "EventName": "PM_IPTEG_FROM_L2",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L2 due to a instruction side request"
   },
-  {,
+  {
     "EventCode": "0x1C05E",
     "EventName": "PM_MEM_LOC_THRESH_LSU_MED",
     "BriefDescription": "Local memory above threshold for data prefetch"
   },
-  {,
+  {
     "EventCode": "0x40134",
     "EventName": "PM_MRK_INST_TIMEO",
     "BriefDescription": "marked Instruction finish timeout (instruction lost)"
   },
-  {,
+  {
     "EventCode": "0x1002C",
     "EventName": "PM_L1_DCACHE_RELOADED_ALL",
     "BriefDescription": "L1 data cache reloaded for demand. If MMCR1[16] is 1, prefetches will be included as well"
   },
-  {,
+  {
     "EventCode": "0x30130",
     "EventName": "PM_MRK_INST_FIN",
     "BriefDescription": "marked instruction finished"
   },
-  {,
+  {
     "EventCode": "0x1F14A",
     "EventName": "PM_MRK_DPTEG_FROM_RL2L3_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to a marked data side request.. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x3504E",
     "EventName": "PM_DARQ0_4_6_ENTRIES",
     "BriefDescription": "Cycles in which 4, 5, or 6 DARQ entries (out of 12) are in use"
   },
-  {,
+  {
     "EventCode": "0x30064",
     "EventName": "PM_DARQ_STORE_XMIT",
     "BriefDescription": "The DARQ attempted to transmit a store into an LSAQ or SRQ entry. Includes rejects. Not qualified by thread, so it includes counts for the whole core"
   },
-  {,
+  {
     "EventCode": "0x45046",
     "EventName": "PM_IPTEG_FROM_L21_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another core's L2 on the same chip due to a instruction side request"
   },
-  {,
+  {
     "EventCode": "0x2C016",
     "EventName": "PM_CMPLU_STALL_PASTE",
     "BriefDescription": "Finish stall because the NTF instruction was a paste waiting for response from L2"
   },
-  {,
+  {
     "EventCode": "0x24156",
     "EventName": "PM_MRK_STCX_FIN",
     "BriefDescription": "Number of marked stcx instructions finished. This includes instructions in the speculative path of a branch that may be flushed"
   },
-  {,
+  {
     "EventCode": "0x15150",
     "EventName": "PM_SYNC_MRK_PROBE_NOP",
     "BriefDescription": "Marked probeNops which can cause synchronous interrupts"
   },
-  {,
+  {
     "EventCode": "0x301E4",
     "EventName": "PM_MRK_BR_MPRED_CMPL",
     "BriefDescription": "Marked Branch Mispredicted"
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/memory.json b/tools/perf/pmu-events/arch/powerpc/power9/memory.json
index c3bb283..a3488f3 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/memory.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/memory.json
@@ -1,127 +1,127 @@
 [
-  {,
+  {
     "EventCode": "0x3006E",
     "EventName": "PM_NEST_REF_CLK",
     "BriefDescription": "Multiply by 4 to obtain the number of PB cycles"
   },
-  {,
+  {
     "EventCode": "0x20010",
     "EventName": "PM_PMC1_OVERFLOW",
     "BriefDescription": "Overflow from counter 1"
   },
-  {,
+  {
     "EventCode": "0x2005A",
     "EventName": "PM_DARQ1_7_9_ENTRIES",
     "BriefDescription": "Cycles in which 7 to 9 DARQ1 entries (out of 12) are in use"
   },
-  {,
+  {
     "EventCode": "0x3C048",
     "EventName": "PM_DATA_FROM_DL2L3_SHR",
     "BriefDescription": "The processor's data cache was reloaded with Shared (S) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x10008",
     "EventName": "PM_RUN_SPURR",
     "BriefDescription": "Run SPURR"
   },
-  {,
+  {
     "EventCode": "0x200F6",
     "EventName": "PM_LSU_DERAT_MISS",
     "BriefDescription": "DERAT Reloaded due to a DERAT miss"
   },
-  {,
+  {
     "EventCode": "0x4C048",
     "EventName": "PM_DATA_FROM_DL2L3_MOD",
     "BriefDescription": "The processor's data cache was reloaded with Modified (M) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x1D15E",
     "EventName": "PM_MRK_RUN_CYC",
     "BriefDescription": "Run cycles in which a marked instruction is in the pipeline"
   },
-  {,
+  {
     "EventCode": "0x4003E",
     "EventName": "PM_LD_CMPL",
     "BriefDescription": "count of Loads completed"
   },
-  {,
+  {
     "EventCode": "0x4C042",
     "EventName": "PM_DATA_FROM_L3",
     "BriefDescription": "The processor's data cache was reloaded from local core's L3 due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x4D02C",
     "EventName": "PM_PMC1_REWIND",
     "BriefDescription": "PMC1 rewind event"
   },
-  {,
+  {
     "EventCode": "0x15158",
     "EventName": "PM_SYNC_MRK_L2HIT",
     "BriefDescription": "Marked L2 Hits that can throw a synchronous interrupt"
   },
-  {,
+  {
     "EventCode": "0x3404A",
     "EventName": "PM_INST_FROM_RMEM",
     "BriefDescription": "The processor's Instruction cache was reloaded from another chip's memory on the same Node or Group ( Remote) due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x301E2",
     "EventName": "PM_MRK_ST_CMPL",
     "BriefDescription": "Marked store completed and sent to nest"
   },
-  {,
+  {
     "EventCode": "0x1C050",
     "EventName": "PM_DATA_CHIP_PUMP_CPRED",
     "BriefDescription": "Initial and Final Pump Scope was chip pump (prediction=correct) for a demand load"
   },
-  {,
+  {
     "EventCode": "0x4C040",
     "EventName": "PM_DATA_FROM_L2_DISP_CONFLICT_OTHER",
     "BriefDescription": "The processor's data cache was reloaded from local core's L2 with dispatch conflict due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x2E05C",
     "EventName": "PM_LSU_REJECT_ERAT_MISS",
     "BriefDescription": "LSU Reject due to ERAT (up to 4 per cycles)"
   },
-  {,
+  {
     "EventCode": "0x1000A",
     "EventName": "PM_PMC3_REWIND",
     "BriefDescription": "PMC3 rewind event. A rewind happens when a speculative event (such as latency or CPI stack) is selected on PMC3 and the stall reason or reload source did not match the one programmed in PMC3. When this occurs, the count in PMC3 will not change."
   },
-  {,
+  {
     "EventCode": "0x3C058",
     "EventName": "PM_LARX_FIN",
     "BriefDescription": "Larx finished"
   },
-  {,
+  {
     "EventCode": "0x1C040",
     "EventName": "PM_DATA_FROM_L2_NO_CONFLICT",
     "BriefDescription": "The processor's data cache was reloaded from local core's L2 without conflict due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x2C040",
     "EventName": "PM_DATA_FROM_L2_MEPF",
     "BriefDescription": "The processor's data cache was reloaded from local core's L2 hit without dispatch conflicts on Mepf state due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x2E05A",
     "EventName": "PM_LRQ_REJECT",
     "BriefDescription": "Internal LSU reject from LRQ. Rejects cause the load to go back to LRQ, but it stays contained within the LSU once it gets issued. This event counts the number of times the LRQ attempts to relaunch an instruction after a reject. Any load can suffer multiple rejects"
   },
-  {,
+  {
     "EventCode": "0x2C05C",
     "EventName": "PM_INST_GRP_PUMP_CPRED",
     "BriefDescription": "Initial and Final Pump Scope was group pump (prediction=correct) for an instruction fetch (demand only)"
   },
-  {,
+  {
     "EventCode": "0x4D056",
     "EventName": "PM_NON_FMA_FLOP_CMPL",
     "BriefDescription": "Non FMA instruction completed"
   },
-  {,
+  {
     "EventCode": "0x3E050",
     "EventName": "PM_DARQ1_4_6_ENTRIES",
     "BriefDescription": "Cycles in which 4, 5, or 6 DARQ1 entries (out of 12) are in use"
   }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/other.json b/tools/perf/pmu-events/arch/powerpc/power9/other.json
index 62b8642..3f69422 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/other.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/other.json
@@ -1,2335 +1,2335 @@
 [
-  {,
+  {
     "EventCode": "0x3084",
     "EventName": "PM_ISU1_ISS_HOLD_ALL",
     "BriefDescription": "All ISU rejects"
   },
-  {,
+  {
     "EventCode": "0xF880",
     "EventName": "PM_SNOOP_TLBIE",
     "BriefDescription": "TLBIE snoop"
   },
-  {,
+  {
     "EventCode": "0x4088",
     "EventName": "PM_IC_DEMAND_REQ",
     "BriefDescription": "Demand Instruction fetch request"
   },
-  {,
+  {
     "EventCode": "0x20A4",
     "EventName": "PM_TM_TRESUME",
     "BriefDescription": "TM resume instruction completed"
   },
-  {,
+  {
     "EventCode": "0x40008",
     "EventName": "PM_SRQ_EMPTY_CYC",
     "BriefDescription": "Cycles in which the SRQ has at least one (out of four) empty slice"
   },
-  {,
+  {
     "EventCode": "0x20064",
     "EventName": "PM_IERAT_RELOAD_4K",
     "BriefDescription": "IERAT reloaded (after a miss) for 4K pages"
   },
-  {,
+  {
     "EventCode": "0x260B4",
     "EventName": "PM_L3_P2_LCO_RTY",
     "BriefDescription": "L3 initiated LCO received retry on port 2 (can try 4 times)"
   },
-  {,
+  {
     "EventCode": "0x20006",
     "EventName": "PM_DISP_HELD_ISSQ_FULL",
     "BriefDescription": "Dispatch held due to Issue q full. Includes issue queue and branch queue"
   },
-  {,
+  {
     "EventCode": "0x201E4",
     "EventName": "PM_MRK_DATA_FROM_L3MISS",
     "BriefDescription": "The processor's data cache was reloaded from a location other than the local core's L3 due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x4E044",
     "EventName": "PM_DPTEG_FROM_L31_ECO_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another core's ECO L3 on the same chip due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x40B8",
     "EventName": "PM_BR_MPRED_TAKEN_CR",
     "BriefDescription": "A Conditional Branch that resolved to taken was mispredicted as not taken (due to the BHT Direction Prediction)."
   },
-  {,
+  {
     "EventCode": "0xF8AC",
     "EventName": "PM_DC_DEALLOC_NO_CONF",
     "BriefDescription": "A demand load referenced a line in an active fuzzy prefetch stream. The stream could have been allocated through the hardware prefetch mechanism or through software.Fuzzy stream confirm (out of order effects, or pf cant keep up)"
   },
-  {,
+  {
     "EventCode": "0xD090",
     "EventName": "PM_LS0_DC_COLLISIONS",
     "BriefDescription": "Read-write data cache collisions"
   },
-  {,
+  {
     "EventCode": "0x40BC",
     "EventName": "PM_THRD_PRIO_0_1_CYC",
     "BriefDescription": "Cycles thread running at priority level 0 or 1"
   },
-  {,
+  {
     "EventCode": "0x4C054",
     "EventName": "PM_DERAT_MISS_16G_1G",
     "BriefDescription": "Data ERAT Miss (Data TLB Access) page size 16G (hpt mode) or 1G (radix mode)"
   },
-  {,
+  {
     "EventCode": "0x2084",
     "EventName": "PM_FLUSH_HB_RESTORE_CYC",
     "BriefDescription": "Cycles in which no new instructions can be dispatched to the ICT after a flush.  History buffer recovery"
   },
-  {,
+  {
     "EventCode": "0x4F054",
     "EventName": "PM_RADIX_PWC_MISS",
     "BriefDescription": "A radix translation attempt missed in the TLB and all levels of page walk cache."
   },
-  {,
+  {
     "EventCode": "0x26882",
     "EventName": "PM_L2_DC_INV",
     "BriefDescription": "D-cache invalidates sent over the reload bus to the core"
   },
-  {,
+  {
     "EventCode": "0x24048",
     "EventName": "PM_INST_FROM_LMEM",
     "BriefDescription": "The processor's Instruction cache was reloaded from the local chip's Memory due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0xD8B4",
     "EventName": "PM_LSU0_LRQ_S0_VALID_CYC",
     "BriefDescription": "Slot 0 of LRQ valid"
   },
-  {,
+  {
     "EventCode": "0x2E052",
     "EventName": "PM_TM_PASSED",
     "BriefDescription": "Number of TM transactions that passed"
   },
-  {,
+  {
     "EventCode": "0xF088",
     "EventName": "PM_LSU0_STORE_REJECT",
     "BriefDescription": "All internal store rejects cause the instruction to go back to the SRQ and go to sleep until woken up to try again after the condition has been met"
   },
-  {,
+  {
     "EventCode": "0x360B2",
     "EventName": "PM_L3_GRP_GUESS_WRONG_LOW",
     "BriefDescription": "Prefetch scope predictor selected GS or NNS, but was wrong because scope was LNS"
   },
-  {,
+  {
     "EventCode": "0x168A6",
     "EventName": "PM_TM_CAM_OVERFLOW",
     "BriefDescription": "L3 TM CAM is full when a L2 castout of TM_SC line occurs.  Line is pushed to memory"
   },
-  {,
+  {
     "EventCode": "0xE8B0",
     "EventName": "PM_TEND_PEND_CYC",
     "BriefDescription": "TEND latency per thread"
   },
-  {,
+  {
     "EventCode": "0x4884",
     "EventName": "PM_IBUF_FULL_CYC",
     "BriefDescription": "Cycles No room in ibuff"
   },
-  {,
+  {
     "EventCode": "0xD08C",
     "EventName": "PM_LSU2_LDMX_FIN",
     "BriefDescription": "New P9 instruction LDMX. The definition of this new PMU event is (from the ldmx RFC02491):  The thread has executed an ldmx instruction that accessed a doubleword that contains an effective address within an enabled section of the Load Monitored region.  This event, therefore, should not occur if the FSCR has disabled the load monitored facility (FSCR[52]) or disabled the EBB facility (FSCR[56])."
   },
-  {,
+  {
     "EventCode": "0x300F8",
     "EventName": "PM_TB_BIT_TRANS",
     "BriefDescription": "timebase event"
   },
-  {,
+  {
     "EventCode": "0x3C040",
     "EventName": "PM_DATA_FROM_L2_DISP_CONFLICT_LDHITST",
     "BriefDescription": "The processor's data cache was reloaded from local core's L2 with load hit store conflict due to a demand load"
   },
-  {,
+  {
     "EventCode": "0xE0BC",
     "EventName": "PM_LS0_PTE_TABLEWALK_CYC",
     "BriefDescription": "Cycles when a tablewalk is pending on this thread on table 0"
   },
-  {,
+  {
     "EventCode": "0x3884",
     "EventName": "PM_ISU3_ISS_HOLD_ALL",
     "BriefDescription": "All ISU rejects"
   },
-  {,
+  {
     "EventCode": "0x468A0",
     "EventName": "PM_L3_PF_OFF_CHIP_MEM",
     "BriefDescription": "L3 PF from Off chip memory"
   },
-  {,
+  {
     "EventCode": "0x268AA",
     "EventName": "PM_L3_P1_LCO_DATA",
     "BriefDescription": "LCO sent with data port 1"
   },
-  {,
+  {
     "EventCode": "0xE894",
     "EventName": "PM_LSU1_TM_L1_HIT",
     "BriefDescription": "Load tm hit in L1"
   },
-  {,
+  {
     "EventCode": "0x5888",
     "EventName": "PM_IC_INVALIDATE",
     "BriefDescription": "Ic line invalidated"
   },
-  {,
+  {
     "EventCode": "0x2890",
     "EventName": "PM_DISP_CLB_HELD_TLBIE",
     "BriefDescription": "Dispatch Hold: Due to TLBIE"
   },
-  {,
+  {
     "EventCode": "0x1001C",
     "EventName": "PM_CMPLU_STALL_THRD",
     "BriefDescription": "Completion Stalled because the thread was blocked"
   },
-  {,
+  {
     "EventCode": "0x368A6",
     "EventName": "PM_SNP_TM_HIT_T",
     "BriefDescription": "TM snoop that is a store hits line in L3 in T, Tn or Te state (shared modified)"
   },
-  {,
+  {
     "EventCode": "0x3001A",
     "EventName": "PM_DATA_TABLEWALK_CYC",
     "BriefDescription": "Data Tablewalk Cycles.  Could be 1 or 2 active tablewalks. Includes data prefetches."
   },
-  {,
+  {
     "EventCode": "0xD894",
     "EventName": "PM_LS3_DC_COLLISIONS",
     "BriefDescription": "Read-write data cache collisions"
   },
-  {,
+  {
     "EventCode": "0x35158",
     "EventName": "PM_MRK_DATA_FROM_L31_ECO_MOD_CYC",
     "BriefDescription": "Duration in cycles to reload with Modified (M) data from another core's ECO L3 on the same chip due to a marked load"
   },
-  {,
+  {
     "EventCode": "0xF0B4",
     "EventName": "PM_DC_PREF_CONS_ALLOC",
     "BriefDescription": "Prefetch stream allocated in the conservative phase by either the hardware prefetch mechanism or software prefetch. The sum of this pair subtracted from the total number of allocs will give the total allocs in normal phase"
   },
-  {,
+  {
     "EventCode": "0xF894",
     "EventName": "PM_LSU3_L1_CAM_CANCEL",
     "BriefDescription": "ls3 l1 tm cam cancel"
   },
-  {,
+  {
     "EventCode": "0x2888",
     "EventName": "PM_FLUSH_DISP_TLBIE",
     "BriefDescription": "Dispatch Flush: TLBIE"
   },
-  {,
+  {
     "EventCode": "0x4E11E",
     "EventName": "PM_MRK_DATA_FROM_DMEM_CYC",
     "BriefDescription": "Duration in cycles to reload from another chip's memory on the same Node or Group (Distant) due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x14156",
     "EventName": "PM_MRK_DATA_FROM_L2_CYC",
     "BriefDescription": "Duration in cycles to reload from local core's L2 due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x468A6",
     "EventName": "PM_RD_CLEARING_SC",
     "BriefDescription": "Core TM load hits line in L3 in TM_SC state and causes it to be invalidated"
   },
-  {,
+  {
     "EventCode": "0xD0B0",
     "EventName": "PM_HWSYNC",
     "BriefDescription": "A hwsync instruction was decoded and transferred"
   },
-  {,
+  {
     "EventCode": "0x168B0",
     "EventName": "PM_L3_P1_NODE_PUMP",
     "BriefDescription": "L3 PF sent with nodal scope port 1, counts even retried requests"
   },
-  {,
+  {
     "EventCode": "0xD0BC",
     "EventName": "PM_LSU0_1_LRQF_FULL_CYC",
     "BriefDescription": "Counts the number of cycles the LRQF is full.  LRQF is the queue that holds loads between finish and completion.  If it fills up, instructions stay in LRQ until completion, potentially backing up the LRQ"
   },
-  {,
+  {
     "EventCode": "0x2D148",
     "EventName": "PM_MRK_DATA_FROM_L2_DISP_CONFLICT_LDHITST",
     "BriefDescription": "The processor's data cache was reloaded from local core's L2 with load hit store conflict due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x468AE",
     "EventName": "PM_L3_P3_CO_RTY",
     "BriefDescription": "L3 CO received retry port 3 (memory only), every retry counted"
   },
-  {,
+  {
     "EventCode": "0x460A8",
     "EventName": "PM_SN_HIT",
     "BriefDescription": "Any port snooper hit L3.  Up to 4 can happen in a cycle but we only count 1"
   },
-  {,
+  {
     "EventCode": "0x360AA",
     "EventName": "PM_L3_P0_CO_MEM",
     "BriefDescription": "L3 CO to memory port 0 with or without data"
   },
-  {,
+  {
     "EventCode": "0xF0A4",
     "EventName": "PM_DC_PREF_HW_ALLOC",
     "BriefDescription": "Prefetch stream allocated by the hardware prefetch mechanism"
   },
-  {,
+  {
     "EventCode": "0xF0BC",
     "EventName": "PM_LS2_UNALIGNED_ST",
     "BriefDescription": "Store instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the Store of that size.  If the Store wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
   },
-  {,
+  {
     "EventCode": "0xD0AC",
     "EventName": "PM_SRQ_SYNC_CYC",
     "BriefDescription": "A sync is in the S2Q (edge detect to count)"
   },
-  {,
+  {
     "EventCode": "0x401E6",
     "EventName": "PM_MRK_INST_FROM_L3MISS",
     "BriefDescription": "Marked instruction was reloaded from a location beyond the local chiplet"
   },
-  {,
+  {
     "EventCode": "0x58A8",
     "EventName": "PM_DECODE_HOLD_ICT_FULL",
     "BriefDescription": "Counts the number of cycles in which the IFU was not able to decode and transmit one or more instructions because all itags were in use.  This means the ICT is full for this thread"
   },
-  {,
+  {
     "EventCode": "0x26082",
     "EventName": "PM_L2_IC_INV",
     "BriefDescription": "I-cache Invalidates sent over the realod bus to the core"
   },
-  {,
+  {
     "EventCode": "0xC8AC",
     "EventName": "PM_LSU_FLUSH_RELAUNCH_MISS",
     "BriefDescription": "If a load that has already returned data and has to relaunch for any reason then gets a miss (erat, setp, data cache), it will often be flushed at relaunch time because the data might be inconsistent"
   },
-  {,
+  {
     "EventCode": "0x260A4",
     "EventName": "PM_L3_LD_HIT",
     "BriefDescription": "L3 Hits for demand LDs"
   },
-  {,
+  {
     "EventCode": "0xF0A0",
     "EventName": "PM_DATA_STORE",
     "BriefDescription": "All ops that drain from s2q to L2 containing data"
   },
-  {,
+  {
     "EventCode": "0x1D148",
     "EventName": "PM_MRK_DATA_FROM_RMEM",
     "BriefDescription": "The processor's data cache was reloaded from another chip's memory on the same Node or Group ( Remote) due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x16088",
     "EventName": "PM_L2_LOC_GUESS_CORRECT",
     "BriefDescription": "L2 guess local (LNS) and guess was correct (ie data local)"
   },
-  {,
+  {
     "EventCode": "0x160A4",
     "EventName": "PM_L3_HIT",
     "BriefDescription": "L3 Hits (L2 miss hitting L3, including data/instrn/xlate)"
   },
-  {,
+  {
     "EventCode": "0xE09C",
     "EventName": "PM_LSU0_TM_L1_MISS",
     "BriefDescription": "Load tm L1 miss"
   },
-  {,
+  {
     "EventCode": "0x168B4",
     "EventName": "PM_L3_P1_LCO_RTY",
     "BriefDescription": "L3 initiated LCO received retry on port 1 (can try 4 times)"
   },
-  {,
+  {
     "EventCode": "0x268AC",
     "EventName": "PM_L3_RD_USAGE",
     "BriefDescription": "Rotating sample of 16 RD actives"
   },
-  {,
+  {
     "EventCode": "0x1415C",
     "EventName": "PM_MRK_DATA_FROM_L3_MEPF_CYC",
     "BriefDescription": "Duration in cycles to reload from local core's L3 without dispatch conflicts hit on Mepf state due to a marked load"
   },
-  {,
+  {
     "EventCode": "0xE880",
     "EventName": "PM_L1_SW_PREF",
     "BriefDescription": "Software L1 Prefetches, including SW Transient Prefetches"
   },
-  {,
+  {
     "EventCode": "0x288C",
     "EventName": "PM_DISP_CLB_HELD_BAL",
     "BriefDescription": "Dispatch/CLB Hold: Balance Flush"
   },
-  {,
+  {
     "EventCode": "0x101EA",
     "EventName": "PM_MRK_L1_RELOAD_VALID",
     "BriefDescription": "Marked demand reload"
   },
-  {,
+  {
     "EventCode": "0x1D156",
     "EventName": "PM_MRK_LD_MISS_L1_CYC",
     "BriefDescription": "Marked ld latency"
   },
-  {,
+  {
     "EventCode": "0x4C01A",
     "EventName": "PM_CMPLU_STALL_DMISS_L3MISS",
     "BriefDescription": "Completion stall due to cache miss resolving missed the L3"
   },
-  {,
+  {
     "EventCode": "0x2006C",
     "EventName": "PM_RUN_CYC_SMT4_MODE",
     "BriefDescription": "Cycles in which this thread's run latch is set and the core is in SMT4 mode"
   },
-  {,
+  {
     "EventCode": "0x1D14E",
     "EventName": "PM_MRK_DATA_FROM_OFF_CHIP_CACHE_CYC",
     "BriefDescription": "Duration in cycles to reload either shared or modified data from another core's L2/L3 on a different chip (remote or distant) due to a marked load"
   },
-  {,
+  {
     "EventCode": "0xF888",
     "EventName": "PM_LSU1_STORE_REJECT",
     "BriefDescription": "All internal store rejects cause the instruction to go back to the SRQ and go to sleep until woken up to try again after the condition has been met"
   },
-  {,
+  {
     "EventCode": "0xC098",
     "EventName": "PM_LS2_UNALIGNED_LD",
     "BriefDescription": "Load instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the load of that size.  If the load wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
   },
-  {,
+  {
     "EventCode": "0x20058",
     "EventName": "PM_DARQ1_10_12_ENTRIES",
     "BriefDescription": "Cycles in which 10 or  more DARQ1 entries (out of 12) are in use"
   },
-  {,
+  {
     "EventCode": "0x360A6",
     "EventName": "PM_SNP_TM_HIT_M",
     "BriefDescription": "TM snoop that is a store hits line in L3 in M or Mu state (exclusive modified)"
   },
-  {,
+  {
     "EventCode": "0x5898",
     "EventName": "PM_LINK_STACK_INVALID_PTR",
     "BriefDescription": "It is most often caused by certain types of flush where the pointer is not available. Can result in the data in the link stack becoming unusable."
   },
-  {,
+  {
     "EventCode": "0x46088",
     "EventName": "PM_L2_CHIP_PUMP",
     "BriefDescription": "RC requests that were local (aka chip) pump attempts"
   },
-  {,
+  {
     "EventCode": "0x28A0",
     "EventName": "PM_TM_TSUSPEND",
     "BriefDescription": "TM suspend instruction completed"
   },
-  {,
+  {
     "EventCode": "0x20054",
     "EventName": "PM_L1_PREF",
     "BriefDescription": "A data line was written to the L1 due to a hardware or software prefetch"
   },
-  {,
+  {
     "EventCode": "0x2608E",
     "EventName": "PM_TM_LD_CONF",
     "BriefDescription": "TM Load (fav or non-fav) ran into conflict (failed)"
   },
-  {,
+  {
     "EventCode": "0x1D144",
     "EventName": "PM_MRK_DATA_FROM_L3_DISP_CONFLICT",
     "BriefDescription": "The processor's data cache was reloaded from local core's L3 with dispatch conflict due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x400FA",
     "EventName": "PM_RUN_INST_CMPL",
     "BriefDescription": "Run_Instructions"
   },
-  {,
+  {
     "EventCode": "0x15154",
     "EventName": "PM_SYNC_MRK_L3MISS",
     "BriefDescription": "Marked L3 misses that can throw a synchronous interrupt"
   },
-  {,
+  {
     "EventCode": "0xE0B4",
     "EventName": "PM_LS0_TM_DISALLOW",
     "BriefDescription": "A TM-ineligible instruction tries to execute inside a transaction and the LSU disallows it"
   },
-  {,
+  {
     "EventCode": "0x26884",
     "EventName": "PM_DSIDE_MRU_TOUCH",
     "BriefDescription": "D-side L2 MRU touch commands sent to the L2"
   },
-  {,
+  {
     "EventCode": "0x30134",
     "EventName": "PM_MRK_ST_CMPL_INT",
     "BriefDescription": "marked store finished with intervention"
   },
-  {,
+  {
     "EventCode": "0xC0B8",
     "EventName": "PM_LSU_FLUSH_SAO",
     "BriefDescription": "A load-hit-load condition with Strong Address Ordering will have address compare disabled and flush"
   },
-  {,
+  {
     "EventCode": "0x50A8",
     "EventName": "PM_EAT_FORCE_MISPRED",
     "BriefDescription": "XL-form branch was mispredicted due to the predicted target address missing from EAT.  The EAT forces a mispredict in this case since there is no predicated target to validate.  This is a rare case that may occur when the EAT is full and a branch is issued"
   },
-  {,
+  {
     "EventCode": "0xC094",
     "EventName": "PM_LS0_UNALIGNED_LD",
     "BriefDescription": "Load instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the load of that size.  If the load wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
   },
-  {,
+  {
     "EventCode": "0xF8BC",
     "EventName": "PM_LS3_UNALIGNED_ST",
     "BriefDescription": "Store instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the Store of that size.  If the Store wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
   },
-  {,
+  {
     "EventCode": "0x460AE",
     "EventName": "PM_L3_P2_CO_RTY",
     "BriefDescription": "L3 CO received retry port 2 (memory only), every retry counted"
   },
-  {,
+  {
     "EventCode": "0x58B0",
     "EventName": "PM_BTAC_GOOD_RESULT",
     "BriefDescription": "BTAC predicts a taken branch and the BHT agrees, and the target address is correct"
   },
-  {,
+  {
     "EventCode": "0x1C04C",
     "EventName": "PM_DATA_FROM_LL4",
     "BriefDescription": "The processor's data cache was reloaded from the local chip's L4 cache due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x3608E",
     "EventName": "PM_TM_ST_CONF",
     "BriefDescription": "TM Store (fav or non-fav) ran into conflict (failed)"
   },
-  {,
+  {
     "EventCode": "0xF8A0",
     "EventName": "PM_NON_DATA_STORE",
     "BriefDescription": "All ops that drain from s2q to L2 and contain no data"
   },
-  {,
+  {
     "EventCode": "0x3F146",
     "EventName": "PM_MRK_DPTEG_FROM_L21_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another core's L2 on the same chip due to a marked data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x40A0",
     "EventName": "PM_BR_UNCOND",
     "BriefDescription": "Unconditional Branch Completed. HW branch prediction was not used for this branch. This can be an I-form branch, a B-form branch with BO-field set to branch always, or a B-form branch which was covenrted to a Resolve."
   },
-  {,
+  {
     "EventCode": "0xF8A8",
     "EventName": "PM_DC_PREF_FUZZY_CONF",
     "BriefDescription": "A demand load referenced a line in an active fuzzy prefetch stream. The stream could have been allocated through the hardware prefetch mechanism or through software.Fuzzy stream confirm (out of order effects, or pf cant keep up)"
   },
-  {,
+  {
     "EventCode": "0xF8A4",
     "EventName": "PM_DC_PREF_SW_ALLOC",
     "BriefDescription": "Prefetch stream allocated by software prefetching"
   },
-  {,
+  {
     "EventCode": "0xE0A0",
     "EventName": "PM_LSU2_TM_L1_MISS",
     "BriefDescription": "Load tm L1 miss"
   },
-  {,
+  {
     "EventCode": "0xC880",
     "EventName": "PM_LS1_LD_VECTOR_FIN",
     "BriefDescription": "LS1 finished load vector op"
   },
-  {,
+  {
     "EventCode": "0x2894",
     "EventName": "PM_TM_OUTER_TEND",
     "BriefDescription": "Completion time outer tend"
   },
-  {,
+  {
     "EventCode": "0xF098",
     "EventName": "PM_XLATE_HPT_MODE",
     "BriefDescription": "LSU reports every cycle the thread is in HPT translation mode (as opposed to radix mode)"
   },
-  {,
+  {
     "EventCode": "0x2C04E",
     "EventName": "PM_LD_MISS_L1_FIN",
     "BriefDescription": "Number of load instructions that finished with an L1 miss. Note that even if a load spans multiple slices this event will increment only once per load op."
   },
-  {,
+  {
     "EventCode": "0x30162",
     "EventName": "PM_MRK_LSU_DERAT_MISS",
     "BriefDescription": "Marked derat reload (miss) for any page size"
   },
-  {,
+  {
     "EventCode": "0x160A0",
     "EventName": "PM_L3_PF_MISS_L3",
     "BriefDescription": "L3 PF missed in L3"
   },
-  {,
+  {
     "EventCode": "0x1C04A",
     "EventName": "PM_DATA_FROM_RL2L3_SHR",
     "BriefDescription": "The processor's data cache was reloaded with Shared (S) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x268B0",
     "EventName": "PM_L3_P1_GRP_PUMP",
     "BriefDescription": "L3 PF sent with grp scope port 1, counts even retried requests"
   },
-  {,
+  {
     "EventCode": "0x30016",
     "EventName": "PM_CMPLU_STALL_SRQ_FULL",
     "BriefDescription": "Finish stall because the NTF instruction was a store that was held in LSAQ because the SRQ was full"
   },
-  {,
+  {
     "EventCode": "0x40B4",
     "EventName": "PM_BR_PRED_TA",
     "BriefDescription": "Conditional Branch Completed that had its target address predicted. Only XL-form branches set this event.  This equal the sum of CCACHE, LSTACK, and PCACHE"
   },
-  {,
+  {
     "EventCode": "0x40AC",
     "EventName": "PM_BR_MPRED_CCACHE",
     "BriefDescription": "Conditional Branch Completed that was Mispredicted due to the Count Cache Target Prediction"
   },
-  {,
+  {
     "EventCode": "0x3688A",
     "EventName": "PM_L2_RTY_LD",
     "BriefDescription": "RC retries on PB for any load from core (excludes DCBFs)"
   },
-  {,
+  {
     "EventCode": "0xE08C",
     "EventName": "PM_LSU0_ERAT_HIT",
     "BriefDescription": "Primary ERAT hit.  There is no secondary ERAT"
   },
-  {,
+  {
     "EventCode": "0xE088",
     "EventName": "PM_LS2_ERAT_MISS_PREF",
     "BriefDescription": "LS0 Erat miss due to prefetch"
   },
-  {,
+  {
     "EventCode": "0xF0A8",
     "EventName": "PM_DC_PREF_CONF",
     "BriefDescription": "A demand load referenced a line in an active prefetch stream. The stream could have been allocated through the hardware prefetch mechanism or through software. Includes forwards and backwards streams"
   },
-  {,
+  {
     "EventCode": "0x16888",
     "EventName": "PM_L2_LOC_GUESS_WRONG",
     "BriefDescription": "L2 guess local (LNS) and guess was not correct (ie data not on chip)"
   },
-  {,
+  {
     "EventCode": "0xC888",
     "EventName": "PM_LSU_DTLB_MISS_64K",
     "BriefDescription": "Data TLB Miss page size 64K"
   },
-  {,
+  {
     "EventCode": "0xE0A4",
     "EventName": "PM_TMA_REQ_L2",
     "BriefDescription": "addrs only req to L2 only on the first one,Indication that Load footprint is not expanding"
   },
-  {,
+  {
     "EventCode": "0xC088",
     "EventName": "PM_LSU_DTLB_MISS_4K",
     "BriefDescription": "Data TLB Miss page size 4K"
   },
-  {,
+  {
     "EventCode": "0x3C042",
     "EventName": "PM_DATA_FROM_L3_DISP_CONFLICT",
     "BriefDescription": "The processor's data cache was reloaded from local core's L3 with dispatch conflict due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x168AA",
     "EventName": "PM_L3_P1_LCO_NO_DATA",
     "BriefDescription": "Dataless L3 LCO sent port 1"
   },
-  {,
+  {
     "EventCode": "0x3D140",
     "EventName": "PM_MRK_DATA_FROM_L2_DISP_CONFLICT_OTHER_CYC",
     "BriefDescription": "Duration in cycles to reload from local core's L2 with dispatch conflict due to a marked load"
   },
-  {,
+  {
     "EventCode": "0xC89C",
     "EventName": "PM_LS1_LAUNCH_HELD_PREF",
     "BriefDescription": "Number of times a load or store instruction was unable to launch/relaunch because a high priority prefetch used that relaunch cycle"
   },
-  {,
+  {
     "EventCode": "0x4894",
     "EventName": "PM_IC_RELOAD_PRIVATE",
     "BriefDescription": "Reloading line was brought in private for a specific thread.  Most lines are brought in shared for all eight threads.  If RA does not match then invalidates and then brings it shared to other thread. In P7 line brought in private , then line was invalidat"
   },
-  {,
+  {
     "EventCode": "0x1688E",
     "EventName": "PM_TM_LD_CAUSED_FAIL",
     "BriefDescription": "Non-TM Load caused any thread to fail"
   },
-  {,
+  {
     "EventCode": "0x26084",
     "EventName": "PM_L2_RCLD_DISP_FAIL_OTHER",
     "BriefDescription": "All D-side-Ld or I-side-instruction-fetch dispatch attempts for this thread that failed due to reasons other than an address collision conflicts with an L2 machines (e.g. Read-Claim/Snoop machine not available)"
   },
-  {,
+  {
     "EventCode": "0x101E4",
     "EventName": "PM_MRK_L1_ICACHE_MISS",
     "BriefDescription": "sampled Instruction suffered an icache Miss"
   },
-  {,
+  {
     "EventCode": "0x20A0",
     "EventName": "PM_TM_NESTED_TBEGIN",
     "BriefDescription": "Completion Tm nested tbegin"
   },
-  {,
+  {
     "EventCode": "0x368AA",
     "EventName": "PM_L3_P1_CO_MEM",
     "BriefDescription": "L3 CO to memory port 1 with or without data"
   },
-  {,
+  {
     "EventCode": "0xC8A4",
     "EventName": "PM_LSU3_FALSE_LHS",
     "BriefDescription": "False LHS match detected"
   },
-  {,
+  {
     "EventCode": "0xF0B0",
     "EventName": "PM_L3_LD_PREF",
     "BriefDescription": "L3 load prefetch, sourced from a hardware or software stream, was sent to the nest"
   },
-  {,
+  {
     "EventCode": "0x4D012",
     "EventName": "PM_PMC3_SAVED",
     "BriefDescription": "PMC3 Rewind Value saved"
   },
-  {,
+  {
     "EventCode": "0xE888",
     "EventName": "PM_LS3_ERAT_MISS_PREF",
     "BriefDescription": "LS1 Erat miss due to prefetch"
   },
-  {,
+  {
     "EventCode": "0x368B4",
     "EventName": "PM_L3_RD0_BUSY",
     "BriefDescription": "Lifetime, sample of RD machine 0 valid"
   },
-  {,
+  {
     "EventCode": "0x46080",
     "EventName": "PM_L2_DISP_ALL_L2MISS",
     "BriefDescription": "All successful D-side-Ld/St or I-side-instruction-fetch dispatches for this thread that were an L2 miss"
   },
-  {,
+  {
     "EventCode": "0xF8B8",
     "EventName": "PM_LS1_UNALIGNED_ST",
     "BriefDescription": "Store instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the Store of that size.  If the Store wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
   },
-  {,
+  {
     "EventCode": "0x408C",
     "EventName": "PM_L1_DEMAND_WRITE",
     "BriefDescription": "Instruction Demand sectors written into IL1"
   },
-  {,
+  {
     "EventCode": "0x368A8",
     "EventName": "PM_SN_INVL",
     "BriefDescription": "Any port snooper detects a store to a line in the Sx state and invalidates the line.  Up to 4 can happen in a cycle but we only count 1"
   },
-  {,
+  {
     "EventCode": "0x160B2",
     "EventName": "PM_L3_LOC_GUESS_CORRECT",
     "BriefDescription": "Prefetch scope predictor selected LNS and was correct"
   },
-  {,
+  {
     "EventCode": "0x48B4",
     "EventName": "PM_DECODE_FUSION_CONST_GEN",
     "BriefDescription": "32-bit constant generation"
   },
-  {,
+  {
     "EventCode": "0x4D146",
     "EventName": "PM_MRK_DATA_FROM_L21_MOD",
     "BriefDescription": "The processor's data cache was reloaded with Modified (M) data from another core's L2 on the same chip due to a marked load"
   },
-  {,
+  {
     "EventCode": "0xE080",
     "EventName": "PM_S2Q_FULL",
     "BriefDescription": "Cycles during which the S2Q is full"
   },
-  {,
+  {
     "EventCode": "0x268B4",
     "EventName": "PM_L3_P3_LCO_RTY",
     "BriefDescription": "L3 initiated LCO received retry on port 3 (can try 4 times)"
   },
-  {,
+  {
     "EventCode": "0xD8B8",
     "EventName": "PM_LSU0_LMQ_S0_VALID",
     "BriefDescription": "Slot 0 of LMQ valid"
   },
-  {,
+  {
     "EventCode": "0x2098",
     "EventName": "PM_TM_NESTED_TEND",
     "BriefDescription": "Completion time nested tend"
   },
-  {,
+  {
     "EventCode": "0x368A0",
     "EventName": "PM_L3_PF_OFF_CHIP_CACHE",
     "BriefDescription": "L3 PF from Off chip cache"
   },
-  {,
+  {
     "EventCode": "0x20056",
     "EventName": "PM_TAKEN_BR_MPRED_CMPL",
     "BriefDescription": "Total number of taken branches that were incorrectly predicted as not-taken. This event counts branches completed and does not include speculative instructions"
   },
-  {,
+  {
     "EventCode": "0x4688A",
     "EventName": "PM_L2_SYS_PUMP",
     "BriefDescription": "RC requests that were system pump attempts"
   },
-  {,
+  {
     "EventCode": "0xE090",
     "EventName": "PM_LSU2_ERAT_HIT",
     "BriefDescription": "Primary ERAT hit.  There is no secondary ERAT"
   },
-  {,
+  {
     "EventCode": "0x4001C",
     "EventName": "PM_INST_IMC_MATCH_CMPL",
     "BriefDescription": "IMC Match Count"
   },
-  {,
+  {
     "EventCode": "0x40A8",
     "EventName": "PM_BR_PRED_LSTACK",
     "BriefDescription": "Conditional Branch Completed  that used the Link Stack for Target Prediction"
   },
-  {,
+  {
     "EventCode": "0x268A2",
     "EventName": "PM_L3_CI_MISS",
     "BriefDescription": "L3 castins miss (total count)"
   },
-  {,
+  {
     "EventCode": "0x289C",
     "EventName": "PM_TM_NON_FAV_TBEGIN",
     "BriefDescription": "Dispatch time non favored tbegin"
   },
-  {,
+  {
     "EventCode": "0xF08C",
     "EventName": "PM_LSU2_STORE_REJECT",
     "BriefDescription": "All internal store rejects cause the instruction to go back to the SRQ and go to sleep until woken up to try again after the condition has been met"
   },
-  {,
+  {
     "EventCode": "0x360A0",
     "EventName": "PM_L3_PF_ON_CHIP_CACHE",
     "BriefDescription": "L3 PF from On chip cache"
   },
-  {,
+  {
     "EventCode": "0x35152",
     "EventName": "PM_MRK_DATA_FROM_L2MISS_CYC",
     "BriefDescription": "Duration in cycles to reload from a location other than the local core's L2 due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x160AC",
     "EventName": "PM_L3_SN_USAGE",
     "BriefDescription": "Rotating sample of 16 snoop valids"
   },
-  {,
+  {
     "EventCode": "0x1608C",
     "EventName": "PM_RC0_BUSY",
     "BriefDescription": "RC mach 0 Busy. Used by PMU to sample ave RC lifetime (mach0 used as sample point)"
   },
-  {,
+  {
     "EventCode": "0x36082",
     "EventName": "PM_L2_LD_DISP",
     "BriefDescription": "All successful D-side-Ld or I-side-instruction-fetch dispatches for this thread"
   },
-  {,
+  {
     "EventCode": "0xF8B0",
     "EventName": "PM_L3_SW_PREF",
     "BriefDescription": "L3 load prefetch, sourced from a software prefetch stream, was sent to the nest"
   },
-  {,
+  {
     "EventCode": "0xF884",
     "EventName": "PM_TABLEWALK_CYC_PREF",
     "BriefDescription": "tablewalk qualified for pte  prefetches"
   },
-  {,
+  {
     "EventCode": "0x4D144",
     "EventName": "PM_MRK_DATA_FROM_L31_ECO_MOD",
     "BriefDescription": "The processor's data cache was reloaded with Modified (M) data from another core's ECO L3 on the same chip due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x16884",
     "EventName": "PM_L2_RCLD_DISP_FAIL_ADDR",
     "BriefDescription": "All D-side-Ld or I-side-instruction-fetch dispatch attempts for this thread that failed due to an address collision conflicts with an L2 machines already working on this line (e.g. ld-hit-stq or Read-claim/Castout/Snoop machines)"
   },
-  {,
+  {
     "EventCode": "0x460A0",
     "EventName": "PM_L3_PF_ON_CHIP_MEM",
     "BriefDescription": "L3 PF from On chip memory"
   },
-  {,
+  {
     "EventCode": "0xF084",
     "EventName": "PM_PTE_PREFETCH",
     "BriefDescription": "PTE prefetches"
   },
-  {,
+  {
     "EventCode": "0x2D026",
     "EventName": "PM_RADIX_PWC_L1_PDE_FROM_L2",
     "BriefDescription": "A Page Directory Entry was reloaded to a level 1 page walk cache from the core's L2 data cache"
   },
-  {,
+  {
     "EventCode": "0x48B0",
     "EventName": "PM_BR_MPRED_PCACHE",
     "BriefDescription": "Conditional Branch Completed that was Mispredicted due to pattern cache prediction"
   },
-  {,
+  {
     "EventCode": "0x2C126",
     "EventName": "PM_MRK_DATA_FROM_L2",
     "BriefDescription": "The processor's data cache was reloaded from local core's L2 due to a marked load"
   },
-  {,
+  {
     "EventCode": "0xE0AC",
     "EventName": "PM_TM_FAIL_TLBIE",
     "BriefDescription": "Transaction failed because there was a TLBIE hit in the bloom filter"
   },
-  {,
+  {
     "EventCode": "0x260AA",
     "EventName": "PM_L3_P0_LCO_DATA",
     "BriefDescription": "LCO sent with data port 0"
   },
-  {,
+  {
     "EventCode": "0x4888",
     "EventName": "PM_IC_PREF_REQ",
     "BriefDescription": "Instruction prefetch requests"
   },
-  {,
+  {
     "EventCode": "0xC898",
     "EventName": "PM_LS3_UNALIGNED_LD",
     "BriefDescription": "Load instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the load of that size.  If the load wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
   },
-  {,
+  {
     "EventCode": "0x488C",
     "EventName": "PM_IC_PREF_WRITE",
     "BriefDescription": "Instruction prefetch written into IL1"
   },
-  {,
+  {
     "EventCode": "0xF89C",
     "EventName": "PM_XLATE_MISS",
     "BriefDescription": "The LSU requested a line from L2 for translation.  It may be satisfied from any source beyond L2.  Includes speculative instructions. Includes instruction, prefetch and demand"
   },
-  {,
+  {
     "EventCode": "0x14158",
     "EventName": "PM_MRK_DATA_FROM_L2_NO_CONFLICT_CYC",
     "BriefDescription": "Duration in cycles to reload from local core's L2 without conflict due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x35156",
     "EventName": "PM_MRK_DATA_FROM_L31_SHR_CYC",
     "BriefDescription": "Duration in cycles to reload with Shared (S) data from another core's L3 on the same chip due to a marked load"
   },
-  {,
+  {
     "EventCode": "0xC88C",
     "EventName": "PM_LSU_DTLB_MISS_16G_1G",
     "BriefDescription": "Data TLB Miss page size 16G (HPT) or 1G (Radix)"
   },
-  {,
+  {
     "EventCode": "0x268A6",
     "EventName": "PM_TM_RST_SC",
     "BriefDescription": "TM snoop hits line in L3 that is TM_SC state and causes it to be invalidated"
   },
-  {,
+  {
     "EventCode": "0x468A4",
     "EventName": "PM_L3_TRANS_PF",
     "BriefDescription": "L3 Transient prefetch received from L2"
   },
-  {,
+  {
     "EventCode": "0x4094",
     "EventName": "PM_IC_PREF_CANCEL_L2",
     "BriefDescription": "L2 Squashed a demand or prefetch request"
   },
-  {,
+  {
     "EventCode": "0x48AC",
     "EventName": "PM_BR_MPRED_LSTACK",
     "BriefDescription": "Conditional Branch Completed that was Mispredicted due to the Link Stack Target Prediction"
   },
-  {,
+  {
     "EventCode": "0xE88C",
     "EventName": "PM_LSU1_ERAT_HIT",
     "BriefDescription": "Primary ERAT hit.  There is no secondary ERAT"
   },
-  {,
+  {
     "EventCode": "0xC0B4",
     "EventName": "PM_LSU_FLUSH_WRK_ARND",
     "BriefDescription": "LSU workaround flush.  These flushes are setup with programmable scan only latches to perform various actions when the flush macro receives a trigger from the dbg macros. These actions include things like flushing the next op encountered for a particular thread or flushing the next op that is NTC op that is encountered on a particular slice. The kind of flush that the workaround is setup to perform is highly variable."
   },
-  {,
+  {
     "EventCode": "0x34054",
     "EventName": "PM_PARTIAL_ST_FIN",
     "BriefDescription": "Any store finished by an LSU slice"
   },
-  {,
+  {
     "EventCode": "0x5880",
     "EventName": "PM_THRD_PRIO_6_7_CYC",
     "BriefDescription": "Cycles thread running at priority level 6 or 7"
   },
-  {,
+  {
     "EventCode": "0x4898",
     "EventName": "PM_IC_DEMAND_L2_BR_REDIRECT",
     "BriefDescription": "L2 I cache demand request due to branch Mispredict ( 15 cycle path)"
   },
-  {,
+  {
     "EventCode": "0x4880",
     "EventName": "PM_BANK_CONFLICT",
     "BriefDescription": "Read blocked due to interleave conflict.  The ifar logic will detect an interleave conflict and kill the data that was read that cycle."
   },
-  {,
+  {
     "EventCode": "0x360B0",
     "EventName": "PM_L3_P0_SYS_PUMP",
     "BriefDescription": "L3 PF sent with sys scope port 0, counts even retried requests"
   },
-  {,
+  {
     "EventCode": "0x3006A",
     "EventName": "PM_IERAT_RELOAD_64K",
     "BriefDescription": "IERAT Reloaded (Miss) for a 64k page"
   },
-  {,
+  {
     "EventCode": "0xD8BC",
     "EventName": "PM_LSU2_3_LRQF_FULL_CYC",
     "BriefDescription": "Counts the number of cycles the LRQF is full.  LRQF is the queue that holds loads between finish and completion.  If it fills up, instructions stay in LRQ until completion, potentially backing up the LRQ"
   },
-  {,
+  {
     "EventCode": "0x46086",
     "EventName": "PM_L2_SN_M_RD_DONE",
     "BriefDescription": "Snoop dispatched for a read and was M (true M)"
   },
-  {,
+  {
     "EventCode": "0x40154",
     "EventName": "PM_MRK_FAB_RSP_BKILL",
     "BriefDescription": "Marked store had to do a bkill"
   },
-  {,
+  {
     "EventCode": "0xF094",
     "EventName": "PM_LSU2_L1_CAM_CANCEL",
     "BriefDescription": "ls2 l1 tm cam cancel"
   },
-  {,
+  {
     "EventCode": "0x2D014",
     "EventName": "PM_CMPLU_STALL_LRQ_FULL",
     "BriefDescription": "Finish stall because the NTF instruction was a load that was held in LSAQ (load-store address queue) because the LRQ (load-reorder queue) was full"
   },
-  {,
+  {
     "EventCode": "0x3E05E",
     "EventName": "PM_L3_CO_MEPF",
     "BriefDescription": "L3 CO of line in Mep state (includes casthrough to memory).  The Mepf state indicates that a line was brought in to satisfy an L3 prefetch request"
   },
-  {,
+  {
     "EventCode": "0x460A2",
     "EventName": "PM_L3_LAT_CI_HIT",
     "BriefDescription": "L3 Lateral Castins Hit"
   },
-  {,
+  {
     "EventCode": "0x3D14E",
     "EventName": "PM_MRK_DATA_FROM_DL2L3_MOD",
     "BriefDescription": "The processor's data cache was reloaded with Modified (M) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x3D15E",
     "EventName": "PM_MULT_MRK",
     "BriefDescription": "mult marked instr"
   },
-  {,
+  {
     "EventCode": "0x4084",
     "EventName": "PM_EAT_FULL_CYC",
     "BriefDescription": "Cycles No room in EAT"
   },
-  {,
+  {
     "EventCode": "0x5098",
     "EventName": "PM_LINK_STACK_WRONG_ADD_PRED",
     "BriefDescription": "Link stack predicts wrong address, because of link stack design limitation or software violating the coding conventions"
   },
-  {,
+  {
     "EventCode": "0x2C050",
     "EventName": "PM_DATA_GRP_PUMP_CPRED",
     "BriefDescription": "Initial and Final Pump Scope was group pump (prediction=correct) for a demand load"
   },
-  {,
+  {
     "EventCode": "0xC0A4",
     "EventName": "PM_LSU2_FALSE_LHS",
     "BriefDescription": "False LHS match detected"
   },
-  {,
+  {
     "EventCode": "0x58A0",
     "EventName": "PM_LINK_STACK_CORRECT",
     "BriefDescription": "Link stack predicts right address"
   },
-  {,
+  {
     "EventCode": "0x36886",
     "EventName": "PM_L2_SN_SX_I_DONE",
     "BriefDescription": "Snoop dispatched and went from Sx to Ix"
   },
-  {,
+  {
     "EventCode": "0x4E04A",
     "EventName": "PM_DPTEG_FROM_OFF_CHIP_CACHE",
     "BriefDescription": "A Page Table Entry was loaded into the TLB either shared or modified data from another core's L2/L3 on a different chip (remote or distant) due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x2C12C",
     "EventName": "PM_MRK_DATA_FROM_DL4_CYC",
     "BriefDescription": "Duration in cycles to reload from another chip's L4 on a different Node or Group (Distant) due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x4080",
     "EventName": "PM_INST_FROM_L1",
     "BriefDescription": "Instruction fetches from L1.  L1 instruction hit"
   },
-  {,
+  {
     "EventCode": "0xE898",
     "EventName": "PM_LSU3_TM_L1_HIT",
     "BriefDescription": "Load tm hit in L1"
   },
-  {,
+  {
     "EventCode": "0x260A0",
     "EventName": "PM_L3_CO_MEM",
     "BriefDescription": "L3 CO to memory OR of port 0 and 1 (lossy = may undercount if two cresp come in the same cyc)"
   },
-  {,
+  {
     "EventCode": "0x16082",
     "EventName": "PM_L2_CASTOUT_MOD",
     "BriefDescription": "L2 Castouts - Modified (M,Mu,Me)"
   },
-  {,
+  {
     "EventCode": "0xC09C",
     "EventName": "PM_LS0_LAUNCH_HELD_PREF",
     "BriefDescription": "Number of times a load or store instruction was unable to launch/relaunch because a high priority prefetch used that relaunch cycle"
   },
-  {,
+  {
     "EventCode": "0xC8B8",
     "EventName": "PM_LSU_FLUSH_LARX_STCX",
     "BriefDescription": "A larx is flushed because an older larx has an LMQ reservation for the same thread.  A stcx is flushed because an older stcx is in the LMQ.  The flush happens when the older larx/stcx relaunches"
   },
-  {,
+  {
     "EventCode": "0x260A6",
     "EventName": "PM_NON_TM_RST_SC",
     "BriefDescription": "Non-TM snoop hits line in L3 that is TM_SC state and causes it to be invalidated"
   },
-  {,
+  {
     "EventCode": "0x3608A",
     "EventName": "PM_L2_RTY_ST",
     "BriefDescription": "RC retries on PB for any store from core (excludes DCBFs)"
   },
-  {,
+  {
     "EventCode": "0x24040",
     "EventName": "PM_INST_FROM_L2_MEPF",
     "BriefDescription": "The processor's Instruction cache was reloaded from local core's L2 hit without dispatch conflicts on Mepf state. due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x209C",
     "EventName": "PM_TM_FAV_TBEGIN",
     "BriefDescription": "Dispatch time Favored tbegin"
   },
-  {,
+  {
     "EventCode": "0x2D01E",
     "EventName": "PM_ICT_NOSLOT_DISP_HELD_ISSQ",
     "BriefDescription": "Ict empty for this thread due to dispatch hold on this thread due to Issue q full, BRQ full, XVCF Full, Count cache, Link, Tar full"
   },
-  {,
+  {
     "EventCode": "0x50A4",
     "EventName": "PM_FLUSH_MPRED",
     "BriefDescription": "Branch mispredict flushes.  Includes target and address misprecition"
   },
-  {,
+  {
     "EventCode": "0x1504C",
     "EventName": "PM_IPTEG_FROM_LL4",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from the local chip's L4 cache due to a instruction side request"
   },
-  {,
+  {
     "EventCode": "0x268A4",
     "EventName": "PM_L3_LD_MISS",
     "BriefDescription": "L3 Misses for demand LDs"
   },
-  {,
+  {
     "EventCode": "0x26088",
     "EventName": "PM_L2_GRP_GUESS_CORRECT",
     "BriefDescription": "L2 guess grp (GS or NNS) and guess was correct (data intra-group AND ^on-chip)"
   },
-  {,
+  {
     "EventCode": "0xD088",
     "EventName": "PM_LSU0_LDMX_FIN",
     "BriefDescription": "New P9 instruction LDMX. The definition of this new PMU event is (from the ldmx RFC02491):  The thread has executed an ldmx instruction that accessed a doubleword that contains an effective address within an enabled section of the Load Monitored region.  This event, therefore, should not occur if the FSCR has disabled the load monitored facility (FSCR[52]) or disabled the EBB facility (FSCR[56])."
   },
-  {,
+  {
     "EventCode": "0xE8B4",
     "EventName": "PM_LS1_TM_DISALLOW",
     "BriefDescription": "A TM-ineligible instruction tries to execute inside a transaction and the LSU disallows it"
   },
-  {,
+  {
     "EventCode": "0x1688C",
     "EventName": "PM_RC_USAGE",
     "BriefDescription": "Continuous 16 cycle (2to1) window where this signals rotates thru sampling each RC machine busy. PMU uses this wave to then do 16 cyc count to sample total number of machs running"
   },
-  {,
+  {
     "EventCode": "0x3F054",
     "EventName": "PM_RADIX_PWC_L4_PTE_FROM_L3MISS",
     "BriefDescription": "A Page Table Entry was reloaded to a level 4 page walk cache from beyond the core's L3 data cache. This is the deepest level of PWC possible for a translation. The source could be local/remote/distant memory or another core's cache"
   },
-  {,
+  {
     "EventCode": "0x2608A",
     "EventName": "PM_ISIDE_DISP_FAIL_ADDR",
     "BriefDescription": "All I-side-instruction-fetch dispatch attempts for this thread that failed due to an address collision conflict with an L2 machine already working on this line (e.g. ld-hit-stq or RC/CO/SN machines)"
   },
-  {,
+  {
     "EventCode": "0x50B4",
     "EventName": "PM_TAGE_CORRECT_TAKEN_CMPL",
     "BriefDescription": "The TAGE overrode BHT direction prediction and it was correct.  Counted at completion for taken branches only"
   },
-  {,
+  {
     "EventCode": "0x2090",
     "EventName": "PM_DISP_CLB_HELD_SB",
     "BriefDescription": "Dispatch/CLB Hold: Scoreboard"
   },
-  {,
+  {
     "EventCode": "0xE0B0",
     "EventName": "PM_TM_FAIL_NON_TX_CONFLICT",
     "BriefDescription": "Non transactional conflict from LSU, gets reported to TEXASR"
   },
-  {,
+  {
     "EventCode": "0x201E0",
     "EventName": "PM_MRK_DATA_FROM_MEMORY",
     "BriefDescription": "The processor's data cache was reloaded from a memory location including L4 from local remote or distant due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x368A2",
     "EventName": "PM_L3_L2_CO_MISS",
     "BriefDescription": "L2 CO miss"
   },
-  {,
+  {
     "EventCode": "0x3608C",
     "EventName": "PM_CO0_BUSY",
     "BriefDescription": "CO mach 0 Busy. Used by PMU to sample ave CO lifetime (mach0 used as sample point)"
   },
-  {,
+  {
     "EventCode": "0x2C122",
     "EventName": "PM_MRK_DATA_FROM_L3_DISP_CONFLICT_CYC",
     "BriefDescription": "Duration in cycles to reload from local core's L3 with dispatch conflict due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x35154",
     "EventName": "PM_MRK_DATA_FROM_L3_CYC",
     "BriefDescription": "Duration in cycles to reload from local core's L3 due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x1D140",
     "EventName": "PM_MRK_DATA_FROM_L31_MOD_CYC",
     "BriefDescription": "Duration in cycles to reload with Modified (M) data from another core's L3 on the same chip due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x4404A",
     "EventName": "PM_INST_FROM_OFF_CHIP_CACHE",
     "BriefDescription": "The processor's Instruction cache was reloaded either shared or modified data from another core's L2/L3 on a different chip (remote or distant) due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x28AC",
     "EventName": "PM_TM_FAIL_SELF",
     "BriefDescription": "TM aborted because a self-induced conflict occurred in Suspended state, due to one of the following: a store to a storage location that was previously accessed transactionally; a dcbf, dcbi, or icbi specify- ing a block that was previously accessed transactionally; a dcbst specifying a block that was previously written transactionally; or a tlbie that specifies a translation that was pre- viously used transactionally"
   },
-  {,
+  {
     "EventCode": "0x45056",
     "EventName": "PM_SCALAR_FLOP_CMPL",
     "BriefDescription": "Scalar flop operation completed"
   },
-  {,
+  {
     "EventCode": "0x16092",
     "EventName": "PM_L2_LD_MISS_128B",
     "BriefDescription": "All successful D-side load dispatches that were an L2 miss (NOT Sx,Tx,Mx) for this thread and the RC calculated the request should be for 128B (i.e., M=0)"
   },
-  {,
+  {
     "EventCode": "0x2E014",
     "EventName": "PM_STCX_FIN",
     "BriefDescription": "Number of stcx instructions finished. This includes instructions in the speculative path of a branch that may be flushed"
   },
-  {,
+  {
     "EventCode": "0xD8AC",
     "EventName": "PM_LWSYNC",
     "BriefDescription": "An lwsync instruction was decoded and transferred"
   },
-  {,
+  {
     "EventCode": "0x2094",
     "EventName": "PM_TM_OUTER_TBEGIN",
     "BriefDescription": "Completion time outer tbegin"
   },
-  {,
+  {
     "EventCode": "0x160B4",
     "EventName": "PM_L3_P0_LCO_RTY",
     "BriefDescription": "L3 initiated LCO received retry on port 0 (can try 4 times)"
   },
-  {,
+  {
     "EventCode": "0x36892",
     "EventName": "PM_DSIDE_OTHER_64B_L2MEMACC",
     "BriefDescription": "Valid when first beat of data comes in for an D-side fetch where data came EXCLUSIVELY from memory that was for hpc_read64, (RC had to fetch other 64B of a line from MC) i.e., number of times RC had to go to memory to get 'missing' 64B"
   },
-  {,
+  {
     "EventCode": "0x20A8",
     "EventName": "PM_TM_FAIL_FOOTPRINT_OVERFLOW",
     "BriefDescription": "TM aborted because the tracking limit for transactional storage accesses was exceeded.. Asynchronous"
   },
-  {,
+  {
     "EventCode": "0x30018",
     "EventName": "PM_ICT_NOSLOT_DISP_HELD_HB_FULL",
     "BriefDescription": "Ict empty for this thread due to dispatch holds because the History Buffer was full. Could be GPR/VSR/VMR/FPR/CR/XVF; CR; XVF (XER/VSCR/FPSCR)"
   },
-  {,
+  {
     "EventCode": "0xC894",
     "EventName": "PM_LS1_UNALIGNED_LD",
     "BriefDescription": "Load instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the load of that size.  If the load wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
   },
-  {,
+  {
     "EventCode": "0x360A2",
     "EventName": "PM_L3_L2_CO_HIT",
     "BriefDescription": "L2 CO hits"
   },
-  {,
+  {
     "EventCode": "0x36092",
     "EventName": "PM_DSIDE_L2MEMACC",
     "BriefDescription": "Valid when first beat of data comes in for an D-side fetch where data came EXCLUSIVELY from memory (excluding hpcread64 accesses), i.e., total memory accesses by RCs"
   },
-  {,
+  {
     "EventCode": "0x10138",
     "EventName": "PM_MRK_BR_2PATH",
     "BriefDescription": "marked branches which are not strongly biased"
   },
-  {,
+  {
     "EventCode": "0x2884",
     "EventName": "PM_ISYNC",
     "BriefDescription": "Isync completion count per thread"
   },
-  {,
+  {
     "EventCode": "0x16882",
     "EventName": "PM_L2_CASTOUT_SHR",
     "BriefDescription": "L2 Castouts - Shared (Tx,Sx)"
   },
-  {,
+  {
     "EventCode": "0x26092",
     "EventName": "PM_L2_LD_MISS_64B",
     "BriefDescription": "All successful D-side load dispatches that were an L2 miss (NOT Sx,Tx,Mx) for this thread and the RC calculated the request should be for 64B(i.e., M=1)"
   },
-  {,
+  {
     "EventCode": "0x26080",
     "EventName": "PM_L2_LD_MISS",
     "BriefDescription": "All successful D-Side Load dispatches that were an L2 miss for this thread"
   },
-  {,
+  {
     "EventCode": "0x3D14C",
     "EventName": "PM_MRK_DATA_FROM_DMEM",
     "BriefDescription": "The processor's data cache was reloaded from another chip's memory on the same Node or Group (Distant) due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x100FA",
     "EventName": "PM_ANY_THRD_RUN_CYC",
     "BriefDescription": "Cycles in which at least one thread has the run latch set"
   },
-  {,
+  {
     "EventCode": "0x2C12A",
     "EventName": "PM_MRK_DATA_FROM_RMEM_CYC",
     "BriefDescription": "Duration in cycles to reload from another chip's memory on the same Node or Group ( Remote) due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x25048",
     "EventName": "PM_IPTEG_FROM_LMEM",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from the local chip's Memory due to a instruction side request"
   },
-  {,
+  {
     "EventCode": "0xD8A8",
     "EventName": "PM_ISLB_MISS",
     "BriefDescription": "Instruction SLB Miss - Total of all segment sizes"
   },
-  {,
+  {
     "EventCode": "0x368AE",
     "EventName": "PM_L3_P1_CO_RTY",
     "BriefDescription": "L3 CO received retry port 1 (memory only), every retry counted"
   },
-  {,
+  {
     "EventCode": "0x260A2",
     "EventName": "PM_L3_CI_HIT",
     "BriefDescription": "L3 Castins Hit (total count)"
   },
-  {,
+  {
     "EventCode": "0x44054",
     "EventName": "PM_VECTOR_LD_CMPL",
     "BriefDescription": "Number of vector load instructions completed"
   },
-  {,
+  {
     "EventCode": "0x1E05C",
     "EventName": "PM_CMPLU_STALL_NESTED_TBEGIN",
     "BriefDescription": "Completion stall because the ISU is updating the TEXASR to keep track of the nested tbegin. This is a short delay, and it includes ROT"
   },
-  {,
+  {
     "EventCode": "0xC084",
     "EventName": "PM_LS2_LD_VECTOR_FIN",
     "BriefDescription": "LS2 finished load vector op"
   },
-  {,
+  {
     "EventCode": "0x1608E",
     "EventName": "PM_ST_CAUSED_FAIL",
     "BriefDescription": "Non-TM Store caused any thread to fail"
   },
-  {,
+  {
     "EventCode": "0x3080",
     "EventName": "PM_ISU0_ISS_HOLD_ALL",
     "BriefDescription": "All ISU rejects"
   },
-  {,
+  {
     "EventCode": "0x1515A",
     "EventName": "PM_SYNC_MRK_L2MISS",
     "BriefDescription": "Marked L2 Miss that can throw a synchronous interrupt"
   },
-  {,
+  {
     "EventCode": "0x26892",
     "EventName": "PM_L2_ST_MISS_64B",
     "BriefDescription": "All successful D-side store dispatches that were an L2 miss (NOT Sx,Tx,Mx) for this thread and the RC calculated the request should be for 64B (i.e., M=1)"
   },
-  {,
+  {
     "EventCode": "0x2688C",
     "EventName": "PM_CO_USAGE",
     "BriefDescription": "Continuous 16 cycle (2to1) window where this signals rotates thru sampling each CO machine busy. PMU uses this wave to then do 16 cyc count to sample total number of machs running"
   },
-  {,
+  {
     "EventCode": "0x48B8",
     "EventName": "PM_BR_MPRED_TAKEN_TA",
     "BriefDescription": "Conditional Branch Completed that was Mispredicted due to the Target Address Prediction from the Count Cache or Link Stack.  Only XL-form branches that resolved Taken set this event."
   },
-  {,
+  {
     "EventCode": "0x50B0",
     "EventName": "PM_BTAC_BAD_RESULT",
     "BriefDescription": "BTAC thinks branch will be taken but it is either predicted not-taken by the BHT, or the target address is wrong (less common).  In both cases, a redirect will happen"
   },
-  {,
+  {
     "EventCode": "0xD888",
     "EventName": "PM_LSU1_LDMX_FIN",
     "BriefDescription": "New P9 instruction LDMX. The definition of this new PMU event is (from the ldmx RFC02491):  The thread has executed an ldmx instruction that accessed a doubleword that contains an effective address within an enabled section of the Load Monitored region.  This event, therefore, should not occur if the FSCR has disabled the load monitored facility (FSCR[52]) or disabled the EBB facility (FSCR[56])."
   },
-  {,
+  {
     "EventCode": "0x58B4",
     "EventName": "PM_TAGE_CORRECT",
     "BriefDescription": "The TAGE overrode BHT direction prediction and it was correct.   Includes taken and not taken and is counted at execution time"
   },
-  {,
+  {
     "EventCode": "0x3688C",
     "EventName": "PM_SN_USAGE",
     "BriefDescription": "Continuous 16 cycle (2to1) window where this signals rotates thru sampling each SN machine busy. PMU uses this wave to then do 16 cyc count to sample total number of machs running"
   },
-  {,
+  {
     "EventCode": "0x36084",
     "EventName": "PM_L2_RCST_DISP",
     "BriefDescription": "All D-side store dispatch attempts for this thread"
   },
-  {,
+  {
     "EventCode": "0x46084",
     "EventName": "PM_L2_RCST_DISP_FAIL_OTHER",
     "BriefDescription": "All D-side store dispatch attempts for this thread that failed due to reason other than address collision"
   },
-  {,
+  {
     "EventCode": "0xF0AC",
     "EventName": "PM_DC_PREF_STRIDED_CONF",
     "BriefDescription": "A demand load referenced a line in an active strided prefetch stream. The stream could have been allocated through the hardware prefetch mechanism or through software."
   },
-  {,
+  {
     "EventCode": "0x45054",
     "EventName": "PM_FMA_CMPL",
     "BriefDescription": "two flops operation completed (fmadd, fnmadd, fmsub, fnmsub) Scalar instructions only. "
   },
-  {,
+  {
     "EventCode": "0x201E8",
     "EventName": "PM_THRESH_EXC_512",
     "BriefDescription": "Threshold counter exceeded a value of 512"
   },
-  {,
+  {
     "EventCode": "0x36080",
     "EventName": "PM_L2_INST",
     "BriefDescription": "All successful I-side-instruction-fetch (e.g. i-demand, i-prefetch) dispatches for this thread"
   },
-  {,
+  {
     "EventCode": "0x3504C",
     "EventName": "PM_IPTEG_FROM_DL4",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from another chip's L4 on a different Node or Group (Distant) due to a instruction side request"
   },
-  {,
+  {
     "EventCode": "0xD890",
     "EventName": "PM_LS1_DC_COLLISIONS",
     "BriefDescription": "Read-write data cache collisions"
   },
-  {,
+  {
     "EventCode": "0x1688A",
     "EventName": "PM_ISIDE_DISP",
     "BriefDescription": "All I-side-instruction-fetch dispatch attempts for this thread"
   },
-  {,
+  {
     "EventCode": "0x468AA",
     "EventName": "PM_L3_P1_CO_L31",
     "BriefDescription": "L3 CO to L3.1 (LCO) port 1 with or without data"
   },
-  {,
+  {
     "EventCode": "0x28B0",
     "EventName": "PM_DISP_HELD_TBEGIN",
     "BriefDescription": "This outer tbegin transaction cannot be dispatched until the previous tend instruction completes"
   },
-  {,
+  {
     "EventCode": "0xE8A0",
     "EventName": "PM_LSU3_TM_L1_MISS",
     "BriefDescription": "Load tm L1 miss"
   },
-  {,
+  {
     "EventCode": "0x2C05E",
     "EventName": "PM_INST_GRP_PUMP_MPRED",
     "BriefDescription": "Final Pump Scope (Group) ended up either larger or smaller than Initial Pump Scope for an instruction fetch (demand only)"
   },
-  {,
+  {
     "EventCode": "0xC8BC",
     "EventName": "PM_STCX_SUCCESS_CMPL",
     "BriefDescription": "Number of stcx instructions that completed successfully"
   },
-  {,
+  {
     "EventCode": "0xE098",
     "EventName": "PM_LSU2_TM_L1_HIT",
     "BriefDescription": "Load tm hit in L1"
   },
-  {,
+  {
     "EventCode": "0xE0B8",
     "EventName": "PM_LS2_TM_DISALLOW",
     "BriefDescription": "A TM-ineligible instruction tries to execute inside a transaction and the LSU disallows it"
   },
-  {,
+  {
     "EventCode": "0x44044",
     "EventName": "PM_INST_FROM_L31_ECO_MOD",
     "BriefDescription": "The processor's Instruction cache was reloaded with Modified (M) data from another core's ECO L3 on the same chip due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x16886",
     "EventName": "PM_CO_DISP_FAIL",
     "BriefDescription": "CO dispatch failed due to all CO machines being busy"
   },
-  {,
+  {
     "EventCode": "0x3D146",
     "EventName": "PM_MRK_DATA_FROM_L3_NO_CONFLICT",
     "BriefDescription": "The processor's data cache was reloaded from local core's L3 without conflict due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x16892",
     "EventName": "PM_L2_ST_MISS_128B",
     "BriefDescription": "All successful D-side store dispatches that were an L2 miss (NOT Sx,Tx,Mx) for this thread and the RC calculated the request should be for 128B (i.e., M=0)"
   },
-  {,
+  {
     "EventCode": "0x26890",
     "EventName": "PM_ISIDE_L2MEMACC",
     "BriefDescription": "Valid when first beat of data comes in for an I-side fetch where data came from memory"
   },
-  {,
+  {
     "EventCode": "0xD094",
     "EventName": "PM_LS2_DC_COLLISIONS",
     "BriefDescription": "Read-write data cache collisions"
   },
-  {,
+  {
     "EventCode": "0x3C05E",
     "EventName": "PM_MEM_RWITM",
     "BriefDescription": "Memory Read With Intent to Modify for this thread"
   },
-  {,
+  {
     "EventCode": "0xC090",
     "EventName": "PM_LSU_STCX",
     "BriefDescription": "STCX sent to nest, i.e. total"
   },
-  {,
+  {
     "EventCode": "0x2C120",
     "EventName": "PM_MRK_DATA_FROM_L2_NO_CONFLICT",
     "BriefDescription": "The processor's data cache was reloaded from local core's L2 without conflict due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x36086",
     "EventName": "PM_L2_RC_ST_DONE",
     "BriefDescription": "Read-claim machine did store to line that was in Tx or Sx (Tagged or Shared state)"
   },
-  {,
+  {
     "EventCode": "0xE8AC",
     "EventName": "PM_TM_FAIL_TX_CONFLICT",
     "BriefDescription": "Transactional conflict from LSU, gets reported to TEXASR"
   },
-  {,
+  {
     "EventCode": "0x48A8",
     "EventName": "PM_DECODE_FUSION_LD_ST_DISP",
     "BriefDescription": "32-bit displacement D-form and 16-bit displacement X-form"
   },
-  {,
+  {
     "EventCode": "0x3D144",
     "EventName": "PM_MRK_DATA_FROM_L2_MEPF_CYC",
     "BriefDescription": "Duration in cycles to reload from local core's L2 hit without dispatch conflicts on Mepf state. due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x44046",
     "EventName": "PM_INST_FROM_L21_MOD",
     "BriefDescription": "The processor's Instruction cache was reloaded with Modified (M) data from another core's L2 on the same chip due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x40B0",
     "EventName": "PM_BR_PRED_TAKEN_CR",
     "BriefDescription": "Conditional Branch that had its direction predicted. I-form branches do not set this event.  In addition, B-form branches which do not use the BHT do not set this event - these are branches with BO-field set to 'always taken' and branches"
   },
-  {,
+  {
     "EventCode": "0x15040",
     "EventName": "PM_IPTEG_FROM_L2_NO_CONFLICT",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L2 without conflict due to a instruction side request"
   },
-  {,
+  {
     "EventCode": "0x460A6",
     "EventName": "PM_RD_FORMING_SC",
     "BriefDescription": "Doesn't occur"
   },
-  {,
+  {
     "EventCode": "0x35042",
     "EventName": "PM_IPTEG_FROM_L3_DISP_CONFLICT",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L3 with dispatch conflict due to a instruction side request"
   },
-  {,
+  {
     "EventCode": "0xF898",
     "EventName": "PM_XLATE_RADIX_MODE",
     "BriefDescription": "LSU reports every cycle the thread is in radix translation mode (as opposed to HPT mode)"
   },
-  {,
+  {
     "EventCode": "0x2D142",
     "EventName": "PM_MRK_DATA_FROM_L3_MEPF",
     "BriefDescription": "The processor's data cache was reloaded from local core's L3 without dispatch conflicts hit on Mepf state. due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x160B0",
     "EventName": "PM_L3_P0_NODE_PUMP",
     "BriefDescription": "L3 PF sent with nodal scope port 0, counts even retried requests"
   },
-  {,
+  {
     "EventCode": "0xD88C",
     "EventName": "PM_LSU3_LDMX_FIN",
     "BriefDescription": "New P9 instruction LDMX. The definition of this new PMU event is (from the ldmx RFC02491):  The thread has executed an ldmx instruction that accessed a doubleword that contains an effective address within an enabled section of the Load Monitored region.  This event, therefore, should not occur if the FSCR has disabled the load monitored facility (FSCR[52]) or disabled the EBB facility (FSCR[56])."
   },
-  {,
+  {
     "EventCode": "0x36882",
     "EventName": "PM_L2_LD_HIT",
     "BriefDescription": "All successful D-side-Ld or I-side-instruction-fetch dispatches for this thread that were L2 hits"
   },
-  {,
+  {
     "EventCode": "0x168AC",
     "EventName": "PM_L3_CI_USAGE",
     "BriefDescription": "Rotating sample of 16 CI or CO actives"
   },
-  {,
+  {
     "EventCode": "0x20134",
     "EventName": "PM_MRK_FXU_FIN",
     "BriefDescription": "fxu marked instr finish"
   },
-  {,
+  {
     "EventCode": "0x4608E",
     "EventName": "PM_TM_CAP_OVERFLOW",
     "BriefDescription": "TM Footprint Capacity Overflow"
   },
-  {,
+  {
     "EventCode": "0x4F05C",
     "EventName": "PM_RADIX_PWC_L2_PTE_FROM_L3MISS",
     "BriefDescription": "A Page Table Entry was reloaded to a level 2 page walk cache from beyond the core's L3 data cache. This implies that level 3 and level 4 PWC accesses were not necessary for this translation. The source could be local/remote/distant memory or another core's cache"
   },
-  {,
+  {
     "EventCode": "0x40014",
     "EventName": "PM_PROBE_NOP_DISP",
     "BriefDescription": "ProbeNops dispatched"
   },
-  {,
+  {
     "EventCode": "0x10052",
     "EventName": "PM_GRP_PUMP_MPRED_RTY",
     "BriefDescription": "Final Pump Scope (Group) ended up larger than Initial Pump Scope (Chip) for all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)"
   },
-  {,
+  {
     "EventCode": "0x2505E",
     "EventName": "PM_BACK_BR_CMPL",
     "BriefDescription": "Branch instruction completed with a target address less than current instruction address"
   },
-  {,
+  {
     "EventCode": "0x2688A",
     "EventName": "PM_ISIDE_DISP_FAIL_OTHER",
     "BriefDescription": "All I-side-instruction-fetch dispatch attempts for this thread that failed due to reasons other than an address collision conflict with an L2 machine (e.g. no available RC/CO machines)"
   },
-  {,
+  {
     "EventCode": "0x2001A",
     "EventName": "PM_NTC_ALL_FIN",
     "BriefDescription": "Cycles after instruction finished to instruction completed."
   },
-  {,
+  {
     "EventCode": "0x3005A",
     "EventName": "PM_ISQ_0_8_ENTRIES",
     "BriefDescription": "Cycles in which 8 or less Issue Queue entries are in use. This is a shared event, not per thread"
   },
-  {,
+  {
     "EventCode": "0x3515E",
     "EventName": "PM_MRK_BACK_BR_CMPL",
     "BriefDescription": "Marked branch instruction completed with a target address less than current instruction address"
   },
-  {,
+  {
     "EventCode": "0xF890",
     "EventName": "PM_LSU1_L1_CAM_CANCEL",
     "BriefDescription": "ls1 l1 tm cam cancel"
   },
-  {,
+  {
     "EventCode": "0x268AE",
     "EventName": "PM_L3_P3_PF_RTY",
     "BriefDescription": "L3 PF received retry port 3, every retry counted"
   },
-  {,
+  {
     "EventCode": "0xE884",
     "EventName": "PM_LS1_ERAT_MISS_PREF",
     "BriefDescription": "LS1 Erat miss due to prefetch"
   },
-  {,
+  {
     "EventCode": "0xE89C",
     "EventName": "PM_LSU1_TM_L1_MISS",
     "BriefDescription": "Load tm L1 miss"
   },
-  {,
+  {
     "EventCode": "0x28A8",
     "EventName": "PM_TM_FAIL_CONF_NON_TM",
     "BriefDescription": "TM aborted because a conflict occurred with a non-transactional access by another processor"
   },
-  {,
+  {
     "EventCode": "0x16890",
     "EventName": "PM_L1PF_L2MEMACC",
     "BriefDescription": "Valid when first beat of data comes in for an L1PF where data came from memory"
   },
-  {,
+  {
     "EventCode": "0x4504C",
     "EventName": "PM_IPTEG_FROM_DMEM",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from another chip's memory on the same Node or Group (Distant) due to a instruction side request"
   },
-  {,
+  {
     "EventCode": "0x1002E",
     "EventName": "PM_LMQ_MERGE",
     "BriefDescription": "A demand miss collides with a prefetch for the same line"
   },
-  {,
+  {
     "EventCode": "0x160B6",
     "EventName": "PM_L3_WI0_BUSY",
     "BriefDescription": "Rotating sample of 8 WI valid (duplicate)"
   },
-  {,
+  {
     "EventCode": "0x368AC",
     "EventName": "PM_L3_CO0_BUSY",
     "BriefDescription": "Lifetime, sample of CO machine 0 valid"
   },
-  {,
+  {
     "EventCode": "0x2E040",
     "EventName": "PM_DPTEG_FROM_L2_MEPF",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L2 hit without dispatch conflicts on Mepf state. due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x1D152",
     "EventName": "PM_MRK_DATA_FROM_DL4",
     "BriefDescription": "The processor's data cache was reloaded from another chip's L4 on a different Node or Group (Distant) due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x46880",
     "EventName": "PM_ISIDE_MRU_TOUCH",
     "BriefDescription": "I-side L2 MRU touch sent to L2 for this thread I-side L2 MRU touch commands sent to the L2 for this thread"
   },
-  {,
+  {
     "EventCode": "0x508C",
     "EventName": "PM_SHL_CREATED",
     "BriefDescription": "Store-Hit-Load Table Entry Created"
   },
-  {,
+  {
     "EventCode": "0x50B8",
     "EventName": "PM_TAGE_OVERRIDE_WRONG",
     "BriefDescription": "The TAGE overrode BHT direction prediction but it was incorrect.  Counted at completion for taken branches only"
   },
-  {,
+  {
     "EventCode": "0x160AE",
     "EventName": "PM_L3_P0_PF_RTY",
     "BriefDescription": "L3 PF received retry port 0, every retry counted"
   },
-  {,
+  {
     "EventCode": "0x268B2",
     "EventName": "PM_L3_LOC_GUESS_WRONG",
     "BriefDescription": "Prefetch scope predictor selected LNS, but was wrong"
   },
-  {,
+  {
     "EventCode": "0x36088",
     "EventName": "PM_L2_SYS_GUESS_CORRECT",
     "BriefDescription": "L2 guess system (VGS or RNS) and guess was correct (ie data beyond-group)"
   },
-  {,
+  {
     "EventCode": "0x260AE",
     "EventName": "PM_L3_P2_PF_RTY",
     "BriefDescription": "L3 PF received retry port 2, every retry counted"
   },
-  {,
+  {
     "EventCode": "0xD8B0",
     "EventName": "PM_PTESYNC",
     "BriefDescription": "A ptesync instruction was counted when the instruction is decoded and transmitted"
   },
-  {,
+  {
     "EventCode": "0x26086",
     "EventName": "PM_CO_TM_SC_FOOTPRINT",
     "BriefDescription": "L2 did a cleanifdirty CO to the L3 (ie created an SC line in the L3) OR L2 TM_store hit dirty HPC line and L3 indicated SC line formed in L3 on RDR bus"
   },
-  {,
+  {
     "EventCode": "0x1E05A",
     "EventName": "PM_CMPLU_STALL_ANY_SYNC",
     "BriefDescription": "Cycles in which the NTC sync instruction (isync, lwsync or hwsync) is not allowed to complete"
   },
-  {,
+  {
     "EventCode": "0xF090",
     "EventName": "PM_LSU0_L1_CAM_CANCEL",
     "BriefDescription": "ls0 l1 tm cam cancel"
   },
-  {,
+  {
     "EventCode": "0xC0A8",
     "EventName": "PM_LSU_FLUSH_CI",
     "BriefDescription": "Load was not issued to LSU as a cache inhibited (non-cacheable) load but it was later determined to be cache inhibited"
   },
-  {,
+  {
     "EventCode": "0x20AC",
     "EventName": "PM_TM_FAIL_CONF_TM",
     "BriefDescription": "TM aborted because a conflict occurred with another transaction."
   },
-  {,
+  {
     "EventCode": "0x588C",
     "EventName": "PM_SHL_ST_DEP_CREATED",
     "BriefDescription": "Store-Hit-Load Table Read Hit with entry Enabled"
   },
-  {,
+  {
     "EventCode": "0x46882",
     "EventName": "PM_L2_ST_HIT",
     "BriefDescription": "All successful D-side store dispatches for this thread that were L2 hits"
   },
-  {,
+  {
     "EventCode": "0x360AC",
     "EventName": "PM_L3_SN0_BUSY",
     "BriefDescription": "Lifetime, sample of snooper machine 0 valid"
   },
-  {,
+  {
     "EventCode": "0x3005C",
     "EventName": "PM_BFU_BUSY",
     "BriefDescription": "Cycles in which all 4 Binary Floating Point units are busy. The BFU is running at capacity"
   },
-  {,
+  {
     "EventCode": "0x48A0",
     "EventName": "PM_BR_PRED_PCACHE",
     "BriefDescription": "Conditional branch completed that used pattern cache prediction"
   },
-  {,
+  {
     "EventCode": "0x26880",
     "EventName": "PM_L2_ST_MISS",
     "BriefDescription": "All successful D-Side Store dispatches that were an L2 miss for this thread"
   },
-  {,
+  {
     "EventCode": "0xF8B4",
     "EventName": "PM_DC_PREF_XCONS_ALLOC",
     "BriefDescription": "Prefetch stream allocated in the Ultra conservative phase by either the hardware prefetch mechanism or software prefetch"
   },
-  {,
+  {
     "EventCode": "0x35048",
     "EventName": "PM_IPTEG_FROM_DL2L3_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to a instruction side request"
   },
-  {,
+  {
     "EventCode": "0x260A8",
     "EventName": "PM_L3_PF_HIT_L3",
     "BriefDescription": "L3 PF hit in L3 (abandoned)"
   },
-  {,
+  {
     "EventCode": "0x360B4",
     "EventName": "PM_L3_PF0_BUSY",
     "BriefDescription": "Lifetime, sample of PF machine 0 valid"
   },
-  {,
+  {
     "EventCode": "0xC0B0",
     "EventName": "PM_LSU_FLUSH_UE",
     "BriefDescription": "Correctable ECC error on reload data, reported at critical data forward time"
   },
-  {,
+  {
     "EventCode": "0x4013A",
     "EventName": "PM_MRK_IC_MISS",
     "BriefDescription": "Marked instruction experienced I cache miss"
   },
-  {,
+  {
     "EventCode": "0x2088",
     "EventName": "PM_FLUSH_DISP_SB",
     "BriefDescription": "Dispatch Flush: Scoreboard"
   },
-  {,
+  {
     "EventCode": "0x401E8",
     "EventName": "PM_MRK_DATA_FROM_L2MISS",
     "BriefDescription": "The processor's data cache was reloaded from a location other than the local core's L2 due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x3688E",
     "EventName": "PM_TM_ST_CAUSED_FAIL",
     "BriefDescription": "TM Store (fav or non-fav) caused another thread to fail"
   },
-  {,
+  {
     "EventCode": "0x460B2",
     "EventName": "PM_L3_SYS_GUESS_WRONG",
     "BriefDescription": "Prefetch scope predictor selected VGS or RNS, but was wrong"
   },
-  {,
+  {
     "EventCode": "0x58B8",
     "EventName": "PM_TAGE_OVERRIDE_WRONG_SPEC",
     "BriefDescription": "The TAGE overrode BHT direction prediction and it was correct.   Includes taken and not taken and is counted at execution time"
   },
-  {,
+  {
     "EventCode": "0xE890",
     "EventName": "PM_LSU3_ERAT_HIT",
     "BriefDescription": "Primary ERAT hit.  There is no secondary ERAT"
   },
-  {,
+  {
     "EventCode": "0x2898",
     "EventName": "PM_TM_TABORT_TRECLAIM",
     "BriefDescription": "Completion time tabortnoncd, tabortcd, treclaim"
   },
-  {,
+  {
     "EventCode": "0x268A0",
     "EventName": "PM_L3_CO_L31",
     "BriefDescription": "L3 CO to L3.1 OR of port 0 and 1 (lossy = may undercount if two cresps come in the same cyc)"
   },
-  {,
+  {
     "EventCode": "0x5080",
     "EventName": "PM_THRD_PRIO_4_5_CYC",
     "BriefDescription": "Cycles thread running at priority level 4 or 5"
   },
-  {,
+  {
     "EventCode": "0x2505C",
     "EventName": "PM_VSU_FIN",
     "BriefDescription": "VSU instruction finished. Up to 4 per cycle"
   },
-  {,
+  {
     "EventCode": "0x40A4",
     "EventName": "PM_BR_PRED_CCACHE",
     "BriefDescription": "Conditional Branch Completed that used the Count Cache for Target Prediction"
   },
-  {,
+  {
     "EventCode": "0x2E04A",
     "EventName": "PM_DPTEG_FROM_RL4",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from another chip's L4 on the same Node or Group ( Remote) due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x4D12E",
     "EventName": "PM_MRK_DATA_FROM_DL2L3_MOD_CYC",
     "BriefDescription": "Duration in cycles to reload with Modified (M) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to a marked load"
   },
-  {,
+  {
     "EventCode": "0xC8B4",
     "EventName": "PM_LSU_FLUSH_LHL_SHL",
     "BriefDescription": "The instruction was flushed because of a sequential load/store consistency.  If a load or store hits on an older load that has either been snooped (for loads) or has stale data (for stores)."
   },
-  {,
+  {
     "EventCode": "0x58A4",
     "EventName": "PM_FLUSH_LSU",
     "BriefDescription": "LSU flushes.  Includes all lsu flushes"
   },
-  {,
+  {
     "EventCode": "0x1D150",
     "EventName": "PM_MRK_DATA_FROM_DL2L3_SHR",
     "BriefDescription": "The processor's data cache was reloaded with Shared (S) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to a marked load"
   },
-  {,
+  {
     "EventCode": "0xC8A0",
     "EventName": "PM_LSU1_FALSE_LHS",
     "BriefDescription": "False LHS match detected"
   },
-  {,
+  {
     "EventCode": "0x48BC",
     "EventName": "PM_THRD_PRIO_2_3_CYC",
     "BriefDescription": "Cycles thread running at priority level 2 or 3"
   },
-  {,
+  {
     "EventCode": "0x368B2",
     "EventName": "PM_L3_GRP_GUESS_WRONG_HIGH",
     "BriefDescription": "Prefetch scope predictor selected GS or NNS, but was wrong because scope was VGS or RNS"
   },
-  {,
+  {
     "EventCode": "0xE8BC",
     "EventName": "PM_LS1_PTE_TABLEWALK_CYC",
     "BriefDescription": "Cycles when a tablewalk is pending on this thread on table 1"
   },
-  {,
+  {
     "EventCode": "0x1F152",
     "EventName": "PM_MRK_FAB_RSP_BKILL_CYC",
     "BriefDescription": "cycles L2 RC took for a bkill"
   },
-  {,
+  {
     "EventCode": "0x4C124",
     "EventName": "PM_MRK_DATA_FROM_L3_NO_CONFLICT_CYC",
     "BriefDescription": "Duration in cycles to reload from local core's L3 without conflict due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x2F14A",
     "EventName": "PM_MRK_DPTEG_FROM_RL4",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from another chip's L4 on the same Node or Group ( Remote) due to a marked data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x26888",
     "EventName": "PM_L2_GRP_GUESS_WRONG",
     "BriefDescription": "L2 guess grp (GS or NNS) and guess was not correct (ie data on-chip OR beyond-group)"
   },
-  {,
+  {
     "EventCode": "0xC0AC",
     "EventName": "PM_LSU_FLUSH_EMSH",
     "BriefDescription": "An ERAT miss was detected after a set-p hit. Erat tracker indicates fail due to tlbmiss and the instruction gets flushed because the instruction was working on the wrong address"
   },
-  {,
+  {
     "EventCode": "0x260B2",
     "EventName": "PM_L3_SYS_GUESS_CORRECT",
     "BriefDescription": "Prefetch scope predictor selected VGS or RNS and was correct"
   },
-  {,
+  {
     "EventCode": "0x1D146",
     "EventName": "PM_MRK_DATA_FROM_MEMORY_CYC",
     "BriefDescription": "Duration in cycles to reload from a memory location including L4 from local remote or distant due to a marked load"
   },
-  {,
+  {
     "EventCode": "0xE094",
     "EventName": "PM_LSU0_TM_L1_HIT",
     "BriefDescription": "Load tm hit in L1"
   },
-  {,
+  {
     "EventCode": "0x46888",
     "EventName": "PM_L2_GROUP_PUMP",
     "BriefDescription": "RC requests that were on group (aka nodel) pump attempts"
   },
-  {,
+  {
     "EventCode": "0xC08C",
     "EventName": "PM_LSU_DTLB_MISS_16M_2M",
     "BriefDescription": "Data TLB Miss page size 16M (HPT) or 2M (Radix)"
   },
-  {,
+  {
     "EventCode": "0x16080",
     "EventName": "PM_L2_LD",
     "BriefDescription": "All successful D-side Load dispatches for this thread (L2 miss + L2 hits)"
   },
-  {,
+  {
     "EventCode": "0x4505C",
     "EventName": "PM_MATH_FLOP_CMPL",
     "BriefDescription": "Math flop instruction completed"
   },
-  {,
+  {
     "EventCode": "0xC080",
     "EventName": "PM_LS0_LD_VECTOR_FIN",
     "BriefDescription": "LS0 finished load vector op"
   },
-  {,
+  {
     "EventCode": "0x368B0",
     "EventName": "PM_L3_P1_SYS_PUMP",
     "BriefDescription": "L3 PF sent with sys scope port 1, counts even retried requests"
   },
-  {,
+  {
     "EventCode": "0x1F146",
     "EventName": "PM_MRK_DPTEG_FROM_L31_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another core's L3 on the same chip due to a marked data side request.. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x2000C",
     "EventName": "PM_THRD_ALL_RUN_CYC",
     "BriefDescription": "Cycles in which all the threads have the run latch set"
   },
-  {,
+  {
     "EventCode": "0xC0BC",
     "EventName": "PM_LSU_FLUSH_OTHER",
     "BriefDescription": "Other LSU flushes including: Sync (sync ack from L2 caused search of LRQ for oldest snooped load, This will either signal a Precise Flush of the oldest snooped loa or a Flush Next PPC); Data Valid Flush Next (several cases of this, one example is store and reload are lined up such that a store-hit-reload scenario exists and the CDF has already launched and has gotten bad/stale data); Bad Data Valid Flush Next (might be a few cases of this, one example is a larxa (D$ hit) return data and dval but can't allocate to LMQ (LMQ full or other reason). Already gave dval but can't watch it for snoop_hit_larx. Need to take the “bad dval” back and flush all younger ops)"
   },
-  {,
+  {
     "EventCode": "0x5094",
     "EventName": "PM_IC_MISS_ICBI",
     "BriefDescription": "threaded version, IC Misses where we got EA dir hit but no sector valids were on. ICBI took line out"
   },
-  {,
+  {
     "EventCode": "0xC8A8",
     "EventName": "PM_LSU_FLUSH_ATOMIC",
     "BriefDescription": "Quad-word loads (lq) are considered atomic because they always span at least 2 slices.  If a snoop or store from another thread changes the data the load is accessing between the 2 or 3 pieces of the lq instruction, the lq will be flushed"
   },
-  {,
+  {
     "EventCode": "0x1E04E",
     "EventName": "PM_DPTEG_FROM_L2MISS",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from a location other than the local core's L2 due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x4D05E",
     "EventName": "PM_BR_CMPL",
     "BriefDescription": "Any Branch instruction completed"
   },
-  {,
+  {
     "EventCode": "0x260B0",
     "EventName": "PM_L3_P0_GRP_PUMP",
     "BriefDescription": "L3 PF sent with grp scope port 0, counts even retried requests"
   },
-  {,
+  {
     "EventCode": "0x30132",
     "EventName": "PM_MRK_VSU_FIN",
     "BriefDescription": "VSU marked instr finish"
   },
-  {,
+  {
     "EventCode": "0x2D120",
     "EventName": "PM_MRK_DATA_FROM_OFF_CHIP_CACHE",
     "BriefDescription": "The processor's data cache was reloaded either shared or modified data from another core's L2/L3 on a different chip (remote or distant) due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x1E048",
     "EventName": "PM_DPTEG_FROM_ON_CHIP_CACHE",
     "BriefDescription": "A Page Table Entry was loaded into the TLB either shared or modified data from another core's L2/L3 on the same chip due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x16086",
     "EventName": "PM_L2_SN_M_WR_DONE",
     "BriefDescription": "SNP dispatched for a write and was M (true M); for DMA cacheinj this will pulse if rty/push is required (won't pulse if cacheinj is accepted)"
   },
-  {,
+  {
     "EventCode": "0x489C",
     "EventName": "PM_BR_CORECT_PRED_TAKEN_CMPL",
     "BriefDescription": "Conditional Branch Completed in which the HW correctly predicted the direction as taken.  Counted at completion time"
   },
-  {,
+  {
     "EventCode": "0xF0B8",
     "EventName": "PM_LS0_UNALIGNED_ST",
     "BriefDescription": "Store instructions whose data crosses a double-word boundary, which causes it to require an additional slice than than what normally would be required of the Store of that size.  If the Store wraps from slice 3 to slice 0, thee is an additional 3-cycle penalty"
   },
-  {,
+  {
     "EventCode": "0x20132",
     "EventName": "PM_MRK_DFU_FIN",
     "BriefDescription": "Decimal Unit marked Instruction Finish"
   },
-  {,
+  {
     "EventCode": "0x160A6",
     "EventName": "PM_TM_SC_CO",
     "BriefDescription": "L3 castout of line that was StoreCopy (original value of speculatively written line) in a Transaction"
   },
-  {,
+  {
     "EventCode": "0xC8B0",
     "EventName": "PM_LSU_FLUSH_LHS",
     "BriefDescription": "Effective Address alias flush : no EA match but Real Address match.  If the data has not yet been returned for this load, the instruction will just be rejected, but if it has returned data, it will be flushed"
   },
-  {,
+  {
     "EventCode": "0x16084",
     "EventName": "PM_L2_RCLD_DISP",
     "BriefDescription": "All D-side-Ld or I-side-instruction-fetch dispatch attempts for this thread"
   },
-  {,
+  {
     "EventCode": "0x3F150",
     "EventName": "PM_MRK_ST_DRAIN_TO_L2DISP_CYC",
     "BriefDescription": "cycles to drain st from core to L2"
   },
-  {,
+  {
     "EventCode": "0x168A4",
     "EventName": "PM_L3_MISS",
     "BriefDescription": "L3 Misses (L2 miss also missing L3, including data/instrn/xlate)"
   },
-  {,
+  {
     "EventCode": "0xF080",
     "EventName": "PM_LSU_STCX_FAIL",
     "BriefDescription": "The LSU detects the condition that a stcx instruction failed. No requirement to wait for a response from the nest"
   },
-  {,
+  {
     "EventCode": "0x30038",
     "EventName": "PM_CMPLU_STALL_DMISS_LMEM",
     "BriefDescription": "Completion stall due to cache miss that resolves in local memory"
   },
-  {,
+  {
     "EventCode": "0x28A4",
     "EventName": "PM_MRK_TEND_FAIL",
     "BriefDescription": "Nested or not nested tend failed for a marked tend instruction"
   },
-  {,
+  {
     "EventCode": "0x100FC",
     "EventName": "PM_LD_REF_L1",
     "BriefDescription": "All L1 D cache load references counted at finish, gated by reject"
   },
-  {,
+  {
     "EventCode": "0xC0A0",
     "EventName": "PM_LSU0_FALSE_LHS",
     "BriefDescription": "False LHS match detected"
   },
-  {,
+  {
     "EventCode": "0x468A8",
     "EventName": "PM_SN_MISS",
     "BriefDescription": "Any port snooper L3 miss or collision.  Up to 4 can happen in a cycle but we only count 1"
   },
-  {,
+  {
     "EventCode": "0x36888",
     "EventName": "PM_L2_SYS_GUESS_WRONG",
     "BriefDescription": "L2 guess system (VGS or RNS) and guess was not correct (ie data ^beyond-group)"
   },
-  {,
+  {
     "EventCode": "0x2080",
     "EventName": "PM_EE_OFF_EXT_INT",
     "BriefDescription": "CyclesMSR[EE] is off and external interrupts are active"
   },
-  {,
+  {
     "EventCode": "0xE8B8",
     "EventName": "PM_LS3_TM_DISALLOW",
     "BriefDescription": "A TM-ineligible instruction tries to execute inside a transaction and the LSU disallows it"
   },
-  {,
+  {
     "EventCode": "0x2688E",
     "EventName": "PM_TM_FAV_CAUSED_FAIL",
     "BriefDescription": "TM Load (fav) caused another thread to fail"
   },
-  {,
+  {
     "EventCode": "0x16090",
     "EventName": "PM_SN0_BUSY",
     "BriefDescription": "SN mach 0 Busy. Used by PMU to sample ave SN lifetime (mach0 used as sample point)"
   },
-  {,
+  {
     "EventCode": "0x360AE",
     "EventName": "PM_L3_P0_CO_RTY",
     "BriefDescription": "L3 CO received retry port 0 (memory only), every retry counted"
   },
-  {,
+  {
     "EventCode": "0x168A8",
     "EventName": "PM_L3_WI_USAGE",
     "BriefDescription": "Lifetime, sample of Write Inject machine 0 valid"
   },
-  {,
+  {
     "EventCode": "0x468A2",
     "EventName": "PM_L3_LAT_CI_MISS",
     "BriefDescription": "L3 Lateral Castins Miss"
   },
-  {,
+  {
     "EventCode": "0x4090",
     "EventName": "PM_IC_PREF_CANCEL_PAGE",
     "BriefDescription": "Prefetch Canceled due to page boundary"
   },
-  {,
+  {
     "EventCode": "0x460AA",
     "EventName": "PM_L3_P0_CO_L31",
     "BriefDescription": "L3 CO to L3.1 (LCO) port 0 with or without data"
   },
-  {,
+  {
     "EventCode": "0x2880",
     "EventName": "PM_FLUSH_DISP",
     "BriefDescription": "Dispatch flush"
   },
-  {,
+  {
     "EventCode": "0x168AE",
     "EventName": "PM_L3_P1_PF_RTY",
     "BriefDescription": "L3 PF received retry port 1, every retry counted"
   },
-  {,
+  {
     "EventCode": "0x46082",
     "EventName": "PM_L2_ST_DISP",
     "BriefDescription": "All successful D-side store dispatches for this thread"
   },
-  {,
+  {
     "EventCode": "0x36880",
     "EventName": "PM_L2_INST_MISS",
     "BriefDescription": "All successful I-side-instruction-fetch (e.g. i-demand, i-prefetch) dispatches for this thread that were an L2 miss"
   },
-  {,
+  {
     "EventCode": "0xE084",
     "EventName": "PM_LS0_ERAT_MISS_PREF",
     "BriefDescription": "LS0 Erat miss due to prefetch"
   },
-  {,
+  {
     "EventCode": "0x409C",
     "EventName": "PM_BR_PRED",
     "BriefDescription": "Conditional Branch Executed in which the HW predicted the Direction or Target.  Includes taken and not taken and is counted at execution time"
   },
-  {,
+  {
     "EventCode": "0x2D144",
     "EventName": "PM_MRK_DATA_FROM_L31_MOD",
     "BriefDescription": "The processor's data cache was reloaded with Modified (M) data from another core's L3 on the same chip due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x360A4",
     "EventName": "PM_L3_CO_LCO",
     "BriefDescription": "Total L3 COs occurred on LCO L3.1 (good cresp, may end up in mem on a retry)"
   },
-  {,
+  {
     "EventCode": "0x4890",
     "EventName": "PM_IC_PREF_CANCEL_HIT",
     "BriefDescription": "Prefetch Canceled due to icache hit"
   },
-  {,
+  {
     "EventCode": "0x268A8",
     "EventName": "PM_RD_HIT_PF",
     "BriefDescription": "RD machine hit L3 PF machine"
   },
-  {,
+  {
     "EventCode": "0x16880",
     "EventName": "PM_L2_ST",
     "BriefDescription": "All successful D-side store dispatches for this thread (L2 miss + L2 hits)"
   },
-  {,
+  {
     "EventCode": "0x4098",
     "EventName": "PM_IC_DEMAND_L2_BHT_REDIRECT",
     "BriefDescription": "L2 I cache demand request due to BHT redirect, branch redirect ( 2 bubbles 3 cycles)"
   },
-  {,
+  {
     "EventCode": "0xD0B4",
     "EventName": "PM_LSU0_SRQ_S0_VALID_CYC",
     "BriefDescription": "Slot 0 of SRQ valid"
   },
-  {,
+  {
     "EventCode": "0x160AA",
     "EventName": "PM_L3_P0_LCO_NO_DATA",
     "BriefDescription": "Dataless L3 LCO sent port 0"
   },
-  {,
+  {
     "EventCode": "0x208C",
     "EventName": "PM_CLB_HELD",
     "BriefDescription": "CLB (control logic block - indicates quadword fetch block) Hold: Any Reason"
   },
-  {,
+  {
     "EventCode": "0xF88C",
     "EventName": "PM_LSU3_STORE_REJECT",
     "BriefDescription": "All internal store rejects cause the instruction to go back to the SRQ and go to sleep until woken up to try again after the condition has been met"
   },
-  {,
+  {
     "EventCode": "0x200F2",
     "EventName": "PM_INST_DISP",
     "BriefDescription": "# PPC Dispatched"
   },
-  {,
+  {
     "EventCode": "0x4E05E",
     "EventName": "PM_TM_OUTER_TBEGIN_DISP",
     "BriefDescription": "Number of outer tbegin instructions dispatched. The dispatch unit determines whether the tbegin instruction is outer or nested. This is a speculative count, which includes flushed instructions"
   },
-  {,
+  {
     "EventCode": "0x2D018",
     "EventName": "PM_CMPLU_STALL_EXEC_UNIT",
     "BriefDescription": "Completion stall due to execution units (FXU/VSU/CRU)"
   },
-  {,
+  {
     "EventCode": "0x20B0",
     "EventName": "PM_LSU_FLUSH_NEXT",
     "BriefDescription": "LSU flush next reported at flush time.  Sometimes these also come with an exception"
   },
-  {,
+  {
     "EventCode": "0x3880",
     "EventName": "PM_ISU2_ISS_HOLD_ALL",
     "BriefDescription": "All ISU rejects"
   },
-  {,
+  {
     "EventCode": "0xC884",
     "EventName": "PM_LS3_LD_VECTOR_FIN",
     "BriefDescription": "LS3 finished load vector op"
   },
-  {,
+  {
     "EventCode": "0x360A8",
     "EventName": "PM_L3_CO",
     "BriefDescription": "L3 castout occurring (does not include casthrough or log writes (cinj/dmaw))"
   },
-  {,
+  {
     "EventCode": "0x368A4",
     "EventName": "PM_L3_CINJ",
     "BriefDescription": "L3 castin of cache inject"
   },
-  {,
+  {
     "EventCode": "0xC890",
     "EventName": "PM_LSU_NCST",
     "BriefDescription": "Asserts when a i=1 store op is sent to the nest. No record of issue pipe (LS0/LS1) is maintained so this is for both pipes. Probably don't need separate LS0 and LS1"
   },
-  {,
+  {
     "EventCode": "0xD0B8",
     "EventName": "PM_LSU_LMQ_FULL_CYC",
     "BriefDescription": "Counts the number of cycles the LMQ is full"
   },
-  {,
+  {
     "EventCode": "0x168B2",
     "EventName": "PM_L3_GRP_GUESS_CORRECT",
     "BriefDescription": "Prefetch scope predictor selected GS or NNS and was correct"
   },
-  {,
+  {
     "EventCode": "0x48A4",
     "EventName": "PM_STOP_FETCH_PENDING_CYC",
     "BriefDescription": "Fetching is stopped due to an incoming instruction that will result in a flush"
   },
-  {,
+  {
     "EventCode": "0x36884",
     "EventName": "PM_L2_RCST_DISP_FAIL_ADDR",
     "BriefDescription": "All D-side store dispatch attempts for this thread that failed due to address collision with RC/CO/SN/SQ"
   },
-  {,
+  {
     "EventCode": "0x260AC",
     "EventName": "PM_L3_PF_USAGE",
     "BriefDescription": "Rotating sample of 32 PF actives"
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json b/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
index b4772f5..d0265f2 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
@@ -1,530 +1,530 @@
 [
-  {,
+  {
     "EventCode": "0x4D04C",
     "EventName": "PM_DFU_BUSY",
     "BriefDescription": "Cycles in which all 4 Decimal Floating Point units are busy. The DFU is running at capacity"
   },
-  {,
+  {
     "EventCode": "0x100F6",
     "EventName": "PM_IERAT_RELOAD",
     "BriefDescription": "Number of I-ERAT reloads"
   },
-  {,
+  {
     "EventCode": "0x201E2",
     "EventName": "PM_MRK_LD_MISS_L1",
     "BriefDescription": "Marked DL1 Demand Miss counted at exec time. Note that this count is per slice, so if a load spans multiple slices this event will increment multiple times for a single load."
   },
-  {,
+  {
     "EventCode": "0x40010",
     "EventName": "PM_PMC3_OVERFLOW",
     "BriefDescription": "Overflow from counter 3"
   },
-  {,
+  {
     "EventCode": "0x1005A",
     "EventName": "PM_CMPLU_STALL_DFLONG",
     "BriefDescription": "Finish stall because the NTF instruction was a multi-cycle instruction issued to the Decimal Floating Point execution pipe and waiting to finish. Includes decimal floating point instructions + 128 bit binary floating point instructions. Qualified by multicycle"
   },
-  {,
+  {
     "EventCode": "0x4D140",
     "EventName": "PM_MRK_DATA_FROM_ON_CHIP_CACHE",
     "BriefDescription": "The processor's data cache was reloaded either shared or modified data from another core's L2/L3 on the same chip due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x3F14C",
     "EventName": "PM_MRK_DPTEG_FROM_DL4",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from another chip's L4 on a different Node or Group (Distant) due to a marked data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x1E040",
     "EventName": "PM_DPTEG_FROM_L2_NO_CONFLICT",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L2 without conflict due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x24052",
     "EventName": "PM_FXU_IDLE",
     "BriefDescription": "Cycles in which FXU0, FXU1, FXU2, and FXU3 are all idle"
   },
-  {,
+  {
     "EventCode": "0x1E054",
     "EventName": "PM_CMPLU_STALL",
     "BriefDescription": "Nothing completed and ICT not empty"
   },
-  {,
+  {
     "EventCode": "0x2",
     "EventName": "PM_INST_CMPL",
     "BriefDescription": "Number of PowerPC Instructions that completed."
   },
-  {,
+  {
     "EventCode": "0x3D058",
     "EventName": "PM_VSU_DP_FSQRT_FDIV",
     "BriefDescription": "vector versions of fdiv,fsqrt"
   },
-  {,
+  {
     "EventCode": "0x10006",
     "EventName": "PM_DISP_HELD",
     "BriefDescription": "Dispatch Held"
   },
-  {,
+  {
     "EventCode": "0x200F8",
     "EventName": "PM_EXT_INT",
     "BriefDescription": "external interrupt"
   },
-  {,
+  {
     "EventCode": "0x20008",
     "EventName": "PM_ICT_EMPTY_CYC",
     "BriefDescription": "Cycles in which the ICT is completely empty. No itags are assigned to any thread"
   },
-  {,
+  {
     "EventCode": "0x4F146",
     "EventName": "PM_MRK_DPTEG_FROM_L21_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another core's L2 on the same chip due to a marked data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x10056",
     "EventName": "PM_MEM_READ",
     "BriefDescription": "Reads from Memory from this thread (includes data/inst/xlate/l1prefetch/inst prefetch). Includes L4"
   },
-  {,
+  {
     "EventCode": "0x3C04C",
     "EventName": "PM_DATA_FROM_DL4",
     "BriefDescription": "The processor's data cache was reloaded from another chip's L4 on a different Node or Group (Distant) due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x4E046",
     "EventName": "PM_DPTEG_FROM_L21_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another core's L2 on the same chip due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x2E016",
     "EventName": "PM_NTC_ISSUE_HELD_ARB",
     "BriefDescription": "The NTC instruction is being held at dispatch because it lost arbitration onto the issue pipe to another instruction (from the same thread or a different thread)"
   },
-  {,
+  {
     "EventCode": "0x15156",
     "EventName": "PM_SYNC_MRK_FX_DIVIDE",
     "BriefDescription": "Marked fixed point divide that can cause a synchronous interrupt"
   },
-  {,
+  {
     "EventCode": "0x1C056",
     "EventName": "PM_DERAT_MISS_4K",
     "BriefDescription": "Data ERAT Miss (Data TLB Access) page size 4K"
   },
-  {,
+  {
     "EventCode": "0x2F142",
     "EventName": "PM_MRK_DPTEG_FROM_L3_MEPF",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L3 without dispatch conflicts hit on Mepf state. due to a marked data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x4C15C",
     "EventName": "PM_MRK_DERAT_MISS_16G_1G",
     "BriefDescription": "Marked Data ERAT Miss (Data TLB Access) page size 16G (hpt mode) and 1G (radix mode)"
   },
-  {,
+  {
     "EventCode": "0x10024",
     "EventName": "PM_PMC5_OVERFLOW",
     "BriefDescription": "Overflow from counter 5"
   },
-  {,
+  {
     "EventCode": "0x4505E",
     "EventName": "PM_FLOP_CMPL",
     "BriefDescription": "Floating Point Operation Finished"
   },
-  {,
+  {
     "EventCode": "0x2C018",
     "EventName": "PM_CMPLU_STALL_DMISS_L21_L31",
     "BriefDescription": "Completion stall by Dcache miss which resolved on chip ( excluding local L2/L3)"
   },
-  {,
+  {
     "EventCode": "0x4006A",
     "EventName": "PM_IERAT_RELOAD_16M",
     "BriefDescription": "IERAT Reloaded (Miss) for a 16M page"
   },
-  {,
+  {
     "EventCode": "0x4E010",
     "EventName": "PM_ICT_NOSLOT_IC_L3MISS",
     "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from beyond the local L3. The source could be local/remote/distant memory or another core's cache"
   },
-  {,
+  {
     "EventCode": "0x4D01C",
     "EventName": "PM_ICT_NOSLOT_DISP_HELD_SYNC",
     "BriefDescription": "Dispatch held due to a synchronizing instruction at dispatch"
   },
-  {,
+  {
     "EventCode": "0x2D01A",
     "EventName": "PM_ICT_NOSLOT_IC_MISS",
     "BriefDescription": "Ict empty for this thread due to Icache Miss"
   },
-  {,
+  {
     "EventCode": "0x4F14A",
     "EventName": "PM_MRK_DPTEG_FROM_OFF_CHIP_CACHE",
     "BriefDescription": "A Page Table Entry was loaded into the TLB either shared or modified data from another core's L2/L3 on a different chip (remote or distant) due to a marked data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x30058",
     "EventName": "PM_TLBIE_FIN",
     "BriefDescription": "tlbie finished"
   },
-  {,
+  {
     "EventCode": "0x100F8",
     "EventName": "PM_ICT_NOSLOT_CYC",
     "BriefDescription": "Number of cycles the ICT has no itags assigned to this thread"
   },
-  {,
+  {
     "EventCode": "0x3E042",
     "EventName": "PM_DPTEG_FROM_L3_DISP_CONFLICT",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L3 with dispatch conflict due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x1F140",
     "EventName": "PM_MRK_DPTEG_FROM_L2_NO_CONFLICT",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L2 without conflict due to a marked data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x1F058",
     "EventName": "PM_RADIX_PWC_L2_PTE_FROM_L2",
     "BriefDescription": "A Page Table Entry was reloaded to a level 2 page walk cache from the core's L2 data cache. This implies that level 3 and level 4 PWC accesses were not necessary for this translation"
   },
-  {,
+  {
     "EventCode": "0x1D14A",
     "EventName": "PM_MRK_DATA_FROM_RL2L3_MOD",
     "BriefDescription": "The processor's data cache was reloaded with Modified (M) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x10050",
     "EventName": "PM_CHIP_PUMP_CPRED",
     "BriefDescription": "Initial and Final Pump Scope was chip pump (prediction=correct) for all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)"
   },
-  {,
+  {
     "EventCode": "0x45058",
     "EventName": "PM_IC_MISS_CMPL",
     "BriefDescription": "Non-speculative icache miss, counted at completion"
   },
-  {,
+  {
     "EventCode": "0x2D150",
     "EventName": "PM_MRK_DERAT_MISS_4K",
     "BriefDescription": "Marked Data ERAT Miss (Data TLB Access) page size 4K"
   },
-  {,
+  {
     "EventCode": "0x34058",
     "EventName": "PM_ICT_NOSLOT_BR_MPRED_ICMISS",
     "BriefDescription": "Ict empty for this thread due to Icache Miss and branch mispred"
   },
-  {,
+  {
     "EventCode": "0x10022",
     "EventName": "PM_PMC2_SAVED",
     "BriefDescription": "PMC2 Rewind Value saved"
   },
-  {,
+  {
     "EventCode": "0x2000A",
     "EventName": "PM_HV_CYC",
     "BriefDescription": "Cycles in which msr_hv is high. Note that this event does not take msr_pr into consideration"
   },
-  {,
+  {
     "EventCode": "0x1F144",
     "EventName": "PM_MRK_DPTEG_FROM_L3_NO_CONFLICT",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L3 without conflict due to a marked data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x300FC",
     "EventName": "PM_DTLB_MISS",
     "BriefDescription": "Data PTEG reload"
   },
-  {,
+  {
     "EventCode": "0x2C046",
     "EventName": "PM_DATA_FROM_RL2L3_MOD",
     "BriefDescription": "The processor's data cache was reloaded with Modified (M) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x20052",
     "EventName": "PM_GRP_PUMP_MPRED",
     "BriefDescription": "Final Pump Scope (Group) ended up either larger or smaller than Initial Pump Scope for all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)"
   },
-  {,
+  {
     "EventCode": "0x3F05A",
     "EventName": "PM_RADIX_PWC_L2_PDE_FROM_L3",
     "BriefDescription": "A Page Directory Entry was reloaded to a level 2 page walk cache from the core's L3 data cache"
   },
-  {,
+  {
     "EventCode": "0x1E04A",
     "EventName": "PM_DPTEG_FROM_RL2L3_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x10064",
     "EventName": "PM_ICT_NOSLOT_DISP_HELD_TBEGIN",
     "BriefDescription": "the NTC instruction is being held at dispatch because it is a tbegin instruction and there is an older tbegin in the pipeline that must complete before the younger tbegin can dispatch"
   },
-  {,
+  {
     "EventCode": "0x2E046",
     "EventName": "PM_DPTEG_FROM_RL2L3_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x4F14C",
     "EventName": "PM_MRK_DPTEG_FROM_DMEM",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from another chip's memory on the same Node or Group (Distant) due to a marked data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x2E042",
     "EventName": "PM_DPTEG_FROM_L3_MEPF",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L3 without dispatch conflicts hit on Mepf state. due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x2D012",
     "EventName": "PM_CMPLU_STALL_DFU",
     "BriefDescription": "Finish stall because the NTF instruction was issued to the Decimal Floating Point execution pipe and waiting to finish. Includes decimal floating point instructions + 128 bit binary floating point instructions. Not qualified by multicycle"
   },
-  {,
+  {
     "EventCode": "0x3C054",
     "EventName": "PM_DERAT_MISS_16M_2M",
     "BriefDescription": "Data ERAT Miss (Data TLB Access) page size 16M (HPT mode) or 2M (Radix mode)"
   },
-  {,
+  {
     "EventCode": "0x4C04C",
     "EventName": "PM_DATA_FROM_DMEM",
     "BriefDescription": "The processor's data cache was reloaded from another chip's memory on the same Node or Group (Distant) due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x30022",
     "EventName": "PM_PMC4_SAVED",
     "BriefDescription": "PMC4 Rewind Value saved (matched condition)"
   },
-  {,
+  {
     "EventCode": "0x200F4",
     "EventName": "PM_RUN_CYC",
     "BriefDescription": "Run_cycles"
   },
-  {,
+  {
     "EventCode": "0x400F2",
     "EventName": "PM_1PLUS_PPC_DISP",
     "BriefDescription": "Cycles at least one Instr Dispatched"
   },
-  {,
+  {
     "EventCode": "0x3D148",
     "EventName": "PM_MRK_DATA_FROM_L21_MOD_CYC",
     "BriefDescription": "Duration in cycles to reload with Modified (M) data from another core's L2 on the same chip due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x2F146",
     "EventName": "PM_MRK_DPTEG_FROM_RL2L3_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to a marked data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x4E01A",
     "EventName": "PM_ICT_NOSLOT_DISP_HELD",
     "BriefDescription": "Cycles in which the NTC instruction is held at dispatch for any reason"
   },
-  {,
+  {
     "EventCode": "0x401EC",
     "EventName": "PM_THRESH_EXC_2048",
     "BriefDescription": "Threshold counter exceeded a value of 2048"
   },
-  {,
+  {
     "EventCode": "0x35150",
     "EventName": "PM_MRK_DATA_FROM_RL2L3_SHR",
     "BriefDescription": "The processor's data cache was reloaded with Shared (S) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x3E052",
     "EventName": "PM_ICT_NOSLOT_IC_L3",
     "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from the local L3"
   },
-  {,
+  {
     "EventCode": "0x2405A",
     "EventName": "PM_NTC_FIN",
     "BriefDescription": "Cycles in which the oldest instruction in the pipeline (NTC) finishes. This event is used to account for cycles in which work is being completed in the CPI stack"
   },
-  {,
+  {
     "EventCode": "0x40052",
     "EventName": "PM_PUMP_MPRED",
     "BriefDescription": "Pump misprediction. Counts across all types of pumps for all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)"
   },
-  {,
+  {
     "EventCode": "0x30056",
     "EventName": "PM_TM_ABORTS",
     "BriefDescription": "Number of TM transactions aborted"
   },
-  {,
+  {
     "EventCode": "0x2404C",
     "EventName": "PM_INST_FROM_MEMORY",
     "BriefDescription": "The processor's Instruction cache was reloaded from a memory location including L4 from local remote or distant due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x30024",
     "EventName": "PM_PMC6_OVERFLOW",
     "BriefDescription": "Overflow from counter 6"
   },
-  {,
+  {
     "EventCode": "0x10068",
     "EventName": "PM_BRU_FIN",
     "BriefDescription": "Branch Instruction Finished"
   },
-  {,
+  {
     "EventCode": "0x3D154",
     "EventName": "PM_MRK_DERAT_MISS_16M_2M",
     "BriefDescription": "Marked Data ERAT Miss (Data TLB Access) page size 16M (hpt mode) or 2M (radix mode)"
   },
-  {,
+  {
     "EventCode": "0x30020",
     "EventName": "PM_PMC2_REWIND",
     "BriefDescription": "PMC2 Rewind Event (did not match condition)"
   },
-  {,
+  {
     "EventCode": "0x40064",
     "EventName": "PM_DUMMY2_REMOVE_ME",
     "BriefDescription": "Space holder for LS_PC_RELOAD_RA"
   },
-  {,
+  {
     "EventCode": "0x3F148",
     "EventName": "PM_MRK_DPTEG_FROM_DL2L3_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to a marked data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x4D01E",
     "EventName": "PM_ICT_NOSLOT_BR_MPRED",
     "BriefDescription": "Ict empty for this thread due to branch mispred"
   },
-  {,
+  {
     "EventCode": "0x1F148",
     "EventName": "PM_MRK_DPTEG_FROM_ON_CHIP_CACHE",
     "BriefDescription": "A Page Table Entry was loaded into the TLB either shared or modified data from another core's L2/L3 on the same chip due to a marked data side request.. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x3E046",
     "EventName": "PM_DPTEG_FROM_L21_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another core's L2 on the same chip due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x2F144",
     "EventName": "PM_MRK_DPTEG_FROM_L31_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another core's L3 on the same chip due to a marked data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x14052",
     "EventName": "PM_INST_GRP_PUMP_MPRED_RTY",
     "BriefDescription": "Final Pump Scope (Group) ended up larger than Initial Pump Scope (Chip) for an instruction fetch"
   },
-  {,
+  {
     "EventCode": "0xD0A8",
     "EventName": "PM_DSLB_MISS",
     "BriefDescription": "gate_and(sd_pc_c0_comp_valid AND sd_pc_c0_comp_thread(0:1)=tid,sd_pc_c0_comp_ppc_count(0:3)) + gate_and(sd_pc_c1_comp_valid AND sd_pc_c1_comp_thread(0:1)=tid,sd_pc_c1_comp_ppc_count(0:3))"
   },
-  {,
+  {
     "EventCode": "0x4C058",
     "EventName": "PM_MEM_CO",
     "BriefDescription": "Memory castouts from this thread"
   },
-  {,
+  {
     "EventCode": "0x40004",
     "EventName": "PM_FXU_FIN",
     "BriefDescription": "The fixed point unit Unit finished an instruction. Instructions that finish may not necessary complete."
   },
-  {,
+  {
     "EventCode": "0x2C054",
     "EventName": "PM_DERAT_MISS_64K",
     "BriefDescription": "Data ERAT Miss (Data TLB Access) page size 64K"
   },
-  {,
+  {
     "EventCode": "0x10018",
     "EventName": "PM_IC_DEMAND_CYC",
     "BriefDescription": "Icache miss demand cycles"
   },
-  {,
+  {
     "EventCode": "0x2D14E",
     "EventName": "PM_MRK_DATA_FROM_L21_SHR",
     "BriefDescription": "The processor's data cache was reloaded with Shared (S) data from another core's L2 on the same chip due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x3405C",
     "EventName": "PM_CMPLU_STALL_DPLONG",
     "BriefDescription": "Finish stall because the NTF instruction was a scalar multi-cycle instruction issued to the Double Precision execution pipe and waiting to finish. Includes binary floating point instructions in 32 and 64 bit binary floating point format. Qualified by NOT vector AND multicycle"
   },
-  {,
+  {
     "EventCode": "0x4D052",
     "EventName": "PM_2FLOP_CMPL",
     "BriefDescription": "DP vector version of fmul, fsub, fcmp, fsel, fabs, fnabs, fres ,fsqrte, fneg "
   },
-  {,
+  {
     "EventCode": "0x1F142",
     "EventName": "PM_MRK_DPTEG_FROM_L2",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L2 due to a marked data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x40062",
     "EventName": "PM_DUMMY1_REMOVE_ME",
     "BriefDescription": "Space holder for L2_PC_PM_MK_LDST_SCOPE_PRED_STATUS"
   },
-  {,
+  {
     "EventCode": "0x4C012",
     "EventName": "PM_CMPLU_STALL_ERAT_MISS",
     "BriefDescription": "Finish stall because the NTF instruction was a load or store that suffered a translation miss"
   },
-  {,
+  {
     "EventCode": "0x4D050",
     "EventName": "PM_VSU_NON_FLOP_CMPL",
     "BriefDescription": "Non FLOP operation completed"
   },
-  {,
+  {
     "EventCode": "0x2E012",
     "EventName": "PM_TM_TX_PASS_RUN_CYC",
     "BriefDescription": "cycles spent in successful transactions"
   },
-  {,
+  {
     "EventCode": "0x4D04E",
     "EventName": "PM_VSU_FSQRT_FDIV",
     "BriefDescription": "four flops operation (fdiv,fsqrt) Scalar Instructions only"
   },
-  {,
+  {
     "EventCode": "0x4C120",
     "EventName": "PM_MRK_DATA_FROM_L2_MEPF",
     "BriefDescription": "The processor's data cache was reloaded from local core's L2 hit without dispatch conflicts on Mepf state. due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x10062",
     "EventName": "PM_LD_L3MISS_PEND_CYC",
     "BriefDescription": "Cycles L3 miss was pending for this thread"
   },
-  {,
+  {
     "EventCode": "0x2F14C",
     "EventName": "PM_MRK_DPTEG_FROM_MEMORY",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from a memory location including L4 from local remote or distant due to a marked data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x14050",
     "EventName": "PM_INST_CHIP_PUMP_CPRED",
     "BriefDescription": "Initial and Final Pump Scope was chip pump (prediction=correct) for an instruction fetch"
   },
-  {,
+  {
     "EventCode": "0x2000E",
     "EventName": "PM_FXU_BUSY",
     "BriefDescription": "Cycles in which all 4 FXUs are busy. The FXU is running at capacity"
   },
-  {,
+  {
     "EventCode": "0x20066",
     "EventName": "PM_TLB_MISS",
     "BriefDescription": "TLB Miss (I + D)"
   },
-  {,
+  {
     "EventCode": "0x10054",
     "EventName": "PM_PUMP_CPRED",
     "BriefDescription": "Pump prediction correct. Counts across all types of pumps for all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)"
   },
-  {,
+  {
     "EventCode": "0x4D124",
     "EventName": "PM_MRK_DATA_FROM_L31_SHR",
     "BriefDescription": "The processor's data cache was reloaded with Shared (S) data from another core's L3 on the same chip due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x400F8",
     "EventName": "PM_FLUSH",
     "BriefDescription": "Flush (any type)"
   },
-  {,
+  {
     "EventCode": "0x30004",
     "EventName": "PM_CMPLU_STALL_EMQ_FULL",
     "BriefDescription": "Finish stall because the next to finish instruction suffered an ERAT miss and the EMQ was full"
   },
-  {,
+  {
     "EventCode": "0x1D154",
     "EventName": "PM_MRK_DATA_FROM_L21_SHR_CYC",
     "BriefDescription": "Duration in cycles to reload with Shared (S) data from another core's L2 on the same chip due to a marked load"
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/pmc.json b/tools/perf/pmu-events/arch/powerpc/power9/pmc.json
index 8b3b0f3..9edab15 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/pmc.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/pmc.json
@@ -1,117 +1,117 @@
 [
-  {,
+  {
     "EventCode": "0x20036",
     "EventName": "PM_BR_2PATH",
     "BriefDescription": "Branches that are not strongly biased"
   },
-  {,
+  {
     "EventCode": "0x40056",
     "EventName": "PM_MEM_LOC_THRESH_LSU_HIGH",
     "BriefDescription": "Local memory above threshold for LSU medium"
   },
-  {,
+  {
     "EventCode": "0x40118",
     "EventName": "PM_MRK_DCACHE_RELOAD_INTV",
     "BriefDescription": "Combined Intervention event"
   },
-  {,
+  {
     "EventCode": "0x4F148",
     "EventName": "PM_MRK_DPTEG_FROM_DL2L3_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to a marked data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x301E8",
     "EventName": "PM_THRESH_EXC_64",
     "BriefDescription": "Threshold counter exceeded a value of 64"
   },
-  {,
+  {
     "EventCode": "0x4E04E",
     "EventName": "PM_DPTEG_FROM_L3MISS",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from a location other than the local core's L3 due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x40050",
     "EventName": "PM_SYS_PUMP_MPRED_RTY",
     "BriefDescription": "Final Pump Scope (system) ended up larger than Initial Pump Scope (Chip/Group) for all data types excluding data prefetch (demand load,inst prefetch,inst fetch,xlate)"
   },
-  {,
+  {
     "EventCode": "0x1F14E",
     "EventName": "PM_MRK_DPTEG_FROM_L2MISS",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from a location other than the local core's L2 due to a marked data side request.. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x4D018",
     "EventName": "PM_CMPLU_STALL_BRU",
     "BriefDescription": "Completion stall due to a Branch Unit"
   },
-  {,
+  {
     "EventCode": "0x45052",
     "EventName": "PM_4FLOP_CMPL",
     "BriefDescription": "4 FLOP instruction completed"
   },
-  {,
+  {
     "EventCode": "0x3D142",
     "EventName": "PM_MRK_DATA_FROM_LMEM",
     "BriefDescription": "The processor's data cache was reloaded from the local chip's Memory due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x4C01E",
     "EventName": "PM_CMPLU_STALL_CRYPTO",
     "BriefDescription": "Finish stall because the NTF instruction was routed to the crypto execution pipe and was waiting to finish"
   },
-  {,
+  {
     "EventCode": "0x3000C",
     "EventName": "PM_FREQ_DOWN",
     "BriefDescription": "Power Management: Below Threshold B"
   },
-  {,
+  {
     "EventCode": "0x4D128",
     "EventName": "PM_MRK_DATA_FROM_LMEM_CYC",
     "BriefDescription": "Duration in cycles to reload from the local chip's Memory due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x4D054",
     "EventName": "PM_8FLOP_CMPL",
     "BriefDescription": "8 FLOP instruction completed"
   },
-  {,
+  {
     "EventCode": "0x10026",
     "EventName": "PM_TABLEWALK_CYC",
     "BriefDescription": "Cycles when an instruction tablewalk is active"
   },
-  {,
+  {
     "EventCode": "0x2C012",
     "EventName": "PM_CMPLU_STALL_DCACHE_MISS",
     "BriefDescription": "Finish stall because the NTF instruction was a load that missed the L1 and was waiting for the data to return from the nest"
   },
-  {,
+  {
     "EventCode": "0x2E04C",
     "EventName": "PM_DPTEG_FROM_MEMORY",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from a memory location including L4 from local remote or distant due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x3F142",
     "EventName": "PM_MRK_DPTEG_FROM_L3_DISP_CONFLICT",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L3 with dispatch conflict due to a marked data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x4F142",
     "EventName": "PM_MRK_DPTEG_FROM_L3",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from local core's L3 due to a marked data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x10060",
     "EventName": "PM_TM_TRANS_RUN_CYC",
     "BriefDescription": "run cycles in transactional state"
   },
-  {,
+  {
     "EventCode": "0x1E04C",
     "EventName": "PM_DPTEG_FROM_LL4",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from the local chip's L4 cache due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x45050",
     "EventName": "PM_1FLOP_CMPL",
     "BriefDescription": "one flop (fadd, fmul, fsub, fcmp, fsel, fabs, fnabs, fres, fsqrte, fneg) operation completed"
   }
-]
\ No newline at end of file
+]
diff --git a/tools/perf/pmu-events/arch/powerpc/power9/translation.json b/tools/perf/pmu-events/arch/powerpc/power9/translation.json
index b276426..2360b5a 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/translation.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/translation.json
@@ -1,227 +1,227 @@
 [
-  {,
+  {
     "EventCode": "0x1E",
     "EventName": "PM_CYC",
     "BriefDescription": "Processor cycles"
   },
-  {,
+  {
     "EventCode": "0x30010",
     "EventName": "PM_PMC2_OVERFLOW",
     "BriefDescription": "Overflow from counter 2"
   },
-  {,
+  {
     "EventCode": "0x3C046",
     "EventName": "PM_DATA_FROM_L21_SHR",
     "BriefDescription": "The processor's data cache was reloaded with Shared (S) data from another core's L2 on the same chip due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x4D05C",
     "EventName": "PM_DP_QP_FLOP_CMPL",
     "BriefDescription": "Double-Precion or Quad-Precision instruction completed"
   },
-  {,
+  {
     "EventCode": "0x4E04C",
     "EventName": "PM_DPTEG_FROM_DMEM",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from another chip's memory on the same Node or Group (Distant) due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x20016",
     "EventName": "PM_ST_FIN",
     "BriefDescription": "Store finish count. Includes speculative activity"
   },
-  {,
+  {
     "EventCode": "0x1504A",
     "EventName": "PM_IPTEG_FROM_RL2L3_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to a instruction side request"
   },
-  {,
+  {
     "EventCode": "0x40132",
     "EventName": "PM_MRK_LSU_FIN",
     "BriefDescription": "lsu marked instr PPC finish"
   },
-  {,
+  {
     "EventCode": "0x3C05C",
     "EventName": "PM_CMPLU_STALL_VFXU",
     "BriefDescription": "Finish stall due to a vector fixed point instruction in the execution pipeline. These instructions get routed to the ALU, ALU2, and DIV pipes"
   },
-  {,
+  {
     "EventCode": "0x30066",
     "EventName": "PM_LSU_FIN",
     "BriefDescription": "LSU Finished a PPC instruction (up to 4 per cycle)"
   },
-  {,
+  {
     "EventCode": "0x2011C",
     "EventName": "PM_MRK_NTC_CYC",
     "BriefDescription": "Cycles during which the marked instruction is next to complete (completion is held up because the marked instruction hasn't completed yet)"
   },
-  {,
+  {
     "EventCode": "0x3E048",
     "EventName": "PM_DPTEG_FROM_DL2L3_SHR",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Shared (S) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x2E018",
     "EventName": "PM_CMPLU_STALL_VFXLONG",
     "BriefDescription": "Completion stall due to a long latency vector fixed point instruction (division, square root)"
   },
-  {,
+  {
     "EventCode": "0x1C04E",
     "EventName": "PM_DATA_FROM_L2MISS_MOD",
     "BriefDescription": "The processor's data cache was reloaded from a location other than the local core's L2 due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x15048",
     "EventName": "PM_IPTEG_FROM_ON_CHIP_CACHE",
     "BriefDescription": "A Page Table Entry was loaded into the TLB either shared or modified data from another core's L2/L3 on the same chip due to a instruction side request"
   },
-  {,
+  {
     "EventCode": "0x34046",
     "EventName": "PM_INST_FROM_L21_SHR",
     "BriefDescription": "The processor's Instruction cache was reloaded with Shared (S) data from another core's L2 on the same chip due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x1E058",
     "EventName": "PM_STCX_FAIL",
     "BriefDescription": "stcx failed"
   },
-  {,
+  {
     "EventCode": "0x300F0",
     "EventName": "PM_ST_MISS_L1",
     "BriefDescription": "Store Missed L1"
   },
-  {,
+  {
     "EventCode": "0x4C046",
     "EventName": "PM_DATA_FROM_L21_MOD",
     "BriefDescription": "The processor's data cache was reloaded with Modified (M) data from another core's L2 on the same chip due to a demand load"
   },
-  {,
+  {
     "EventCode": "0x2504A",
     "EventName": "PM_IPTEG_FROM_RL4",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from another chip's L4 on the same Node or Group ( Remote) due to a instruction side request"
   },
-  {,
+  {
     "EventCode": "0x2003E",
     "EventName": "PM_LSU_LMQ_SRQ_EMPTY_CYC",
     "BriefDescription": "Cycles in which the LSU is empty for all threads (lmq and srq are completely empty)"
   },
-  {,
+  {
     "EventCode": "0x201E6",
     "EventName": "PM_THRESH_EXC_32",
     "BriefDescription": "Threshold counter exceeded a value of 32"
   },
-  {,
+  {
     "EventCode": "0x4405C",
     "EventName": "PM_CMPLU_STALL_VDP",
     "BriefDescription": "Finish stall because the NTF instruction was a vector instruction issued to the Double Precision execution pipe and waiting to finish. Includes binary floating point instructions in 32 and 64 bit binary floating point format. Not qualified multicycle. Qualified by vector"
   },
-  {,
+  {
     "EventCode": "0x4D010",
     "EventName": "PM_PMC1_SAVED",
     "BriefDescription": "PMC1 Rewind Value saved"
   },
-  {,
+  {
     "EventCode": "0x44042",
     "EventName": "PM_INST_FROM_L3",
     "BriefDescription": "The processor's Instruction cache was reloaded from local core's L3 due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x200FE",
     "EventName": "PM_DATA_FROM_L2MISS",
     "BriefDescription": "Demand LD - L2 Miss (not L2 hit)"
   },
-  {,
+  {
     "EventCode": "0x2D14A",
     "EventName": "PM_MRK_DATA_FROM_RL2L3_MOD_CYC",
     "BriefDescription": "Duration in cycles to reload with Modified (M) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x10028",
     "EventName": "PM_STALL_END_ICT_EMPTY",
     "BriefDescription": "The number a times the core transitioned from a stall to ICT-empty for this thread"
   },
-  {,
+  {
     "EventCode": "0x2504C",
     "EventName": "PM_IPTEG_FROM_MEMORY",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from a memory location including L4 from local remote or distant due to a instruction side request"
   },
-  {,
+  {
     "EventCode": "0x4504A",
     "EventName": "PM_IPTEG_FROM_OFF_CHIP_CACHE",
     "BriefDescription": "A Page Table Entry was loaded into the TLB either shared or modified data from another core's L2/L3 on a different chip (remote or distant) due to a instruction side request"
   },
-  {,
+  {
     "EventCode": "0x1404E",
     "EventName": "PM_INST_FROM_L2MISS",
     "BriefDescription": "The processor's Instruction cache was reloaded from a location other than the local core's L2 due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x34042",
     "EventName": "PM_INST_FROM_L3_DISP_CONFLICT",
     "BriefDescription": "The processor's Instruction cache was reloaded from local core's L3 with dispatch conflict due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x4E048",
     "EventName": "PM_DPTEG_FROM_DL2L3_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another chip's L2 or L3 on a different Node or Group (Distant), as this chip due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x200F0",
     "EventName": "PM_ST_CMPL",
     "BriefDescription": "Stores completed from S2Q (2nd-level store queue)."
   },
-  {,
+  {
     "EventCode": "0x4E05C",
     "EventName": "PM_LSU_REJECT_LHS",
     "BriefDescription": "LSU Reject due to LHS (up to 4 per cycle)"
   },
-  {,
+  {
     "EventCode": "0x14044",
     "EventName": "PM_INST_FROM_L3_NO_CONFLICT",
     "BriefDescription": "The processor's Instruction cache was reloaded from local core's L3 without conflict due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x3E04C",
     "EventName": "PM_DPTEG_FROM_DL4",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from another chip's L4 on a different Node or Group (Distant) due to a data side request. When using Radix Page Translation, this count excludes PDE reloads. Only PTE reloads are included"
   },
-  {,
+  {
     "EventCode": "0x1F15E",
     "EventName": "PM_MRK_PROBE_NOP_CMPL",
     "BriefDescription": "Marked probeNops completed"
   },
-  {,
+  {
     "EventCode": "0x20018",
     "EventName": "PM_ST_FWD",
     "BriefDescription": "Store forwards that finished"
   },
-  {,
+  {
     "EventCode": "0x1D142",
     "EventName": "PM_MRK_DATA_FROM_L31_ECO_SHR_CYC",
     "BriefDescription": "Duration in cycles to reload with Shared (S) data from another core's ECO L3 on the same chip due to a marked load"
   },
-  {,
+  {
     "EventCode": "0x24042",
     "EventName": "PM_INST_FROM_L3_MEPF",
     "BriefDescription": "The processor's Instruction cache was reloaded from local core's L3 without dispatch conflicts hit on Mepf state. due to an instruction fetch (not prefetch)"
   },
-  {,
+  {
     "EventCode": "0x25046",
     "EventName": "PM_IPTEG_FROM_RL2L3_MOD",
     "BriefDescription": "A Page Table Entry was loaded into the TLB with Modified (M) data from another chip's L2 or L3 on the same Node or Group (Remote), as this chip due to a instruction side request"
   },
-  {,
+  {
     "EventCode": "0x3504A",
     "EventName": "PM_IPTEG_FROM_RMEM",
     "BriefDescription": "A Page Table Entry was loaded into the TLB from another chip's memory on the same Node or Group ( Remote) due to a instruction side request"
   },
-  {,
+  {
     "EventCode": "0x3C05A",
     "EventName": "PM_CMPLU_STALL_VDPLONG",
     "BriefDescription": "Finish stall because the NTF instruction was a scalar multi-cycle instruction issued to the Double Precision execution pipe and waiting to finish. Includes binary floating point instructions in 32 and 64 bit binary floating point format. Qualified by NOT vector AND multicycle"
   },
-  {,
+  {
     "EventCode": "0x2E01C",
     "EventName": "PM_CMPLU_STALL_TLBIE",
     "BriefDescription": "Finish stall because the NTF instruction was a tlbie waiting for response from L2"
   }
-]
\ No newline at end of file
+]
