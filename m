Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFB2119E3B2
	for <lists+linux-tip-commits@lfdr.de>; Sat,  4 Apr 2020 10:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgDDImg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 4 Apr 2020 04:42:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41769 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgDDIm1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 4 Apr 2020 04:42:27 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeNR-0001Fg-4S; Sat, 04 Apr 2020 10:42:05 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9F9751C07FA;
        Sat,  4 Apr 2020 10:41:59 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:59 -0000
From:   "tip-bot2 for Vijay Thakkar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf vendor events amd: Add Zen2 events
Cc:     Vijay Thakkar <vijaythakkar@me.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Jon Grimm <jon.grimm@amd.com>,
        mliska@suse.cz, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200318190002.307290-3-vijaythakkar@me.com>
References: <20200318190002.307290-3-vijaythakkar@me.com>
MIME-Version: 1.0
Message-ID: <158598971923.28353.16248793755306011282.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     2079f7aa0a49d3ae83a82f70785a28b07bb9b16b
Gitweb:        https://git.kernel.org/tip/2079f7aa0a49d3ae83a82f70785a28b07bb9b16b
Author:        Vijay Thakkar <vijaythakkar@me.com>
AuthorDate:    Wed, 18 Mar 2020 15:00:01 -04:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 24 Mar 2020 10:35:58 -03:00

perf vendor events amd: Add Zen2 events

This patch adds PMU events for AMD Zen2 core based processors, namely,
Matisse (model 71h), Castle Peak (model 31h) and Rome (model 2xh), as
documented in the AMD Processor Programming Reference for Matisse [1].
The model number regex has been set to detect all the models under
family 17 that do not match those of Zen1, as the range is larger for
zen2.

Zen2 adds some additional counters that are not present in Zen1 and
events for them have been added in this patch. Some counters have also
been removed for Zen2 thatwere previously present in Zen1 and have been
confirmed to always sample zero on zen2. These added/removed counters
have been omitted for brevity but can be found here:
https://gist.github.com/thakkarV/5b12ca5fd7488eb2c42e451e40bdd5f3

Note that PPR for Zen2 [1] does not include some counters that were
documented in the PPR for Zen1 based processors [2]. After having tested
these counters, some of them that still work for zen2 systems have been
preserved in the events for zen2. The counters that are omitted in [1]
but are still measurable and non-zero on zen2 (tested on a Ryzen 3900X
system) are the following:

  PMC 0x000 fpu_pipe_assignment.{total|total0|total1|total2|total3}
  PMC 0x004 fp_num_mov_elim_scal_op.*
  PMC 0x046 ls_tablewalker.*
  PMC 0x062 l2_latency.l2_cycles_waiting_on_fills
  PMC 0x063 l2_wcb_req.*
  PMC 0x06D l2_fill_pending.l2_fill_busy
  PMC 0x080 ic_fw32
  PMC 0x081 ic_fw32_miss
  PMC 0x086 bp_snp_re_sync
  PMC 0x087 ic_fetch_stall.*
  PMC 0x08C ic_cache_inval.*
  PMC 0x099 bp_tlb_rel
  PMC 0x0C7 ex_ret_brn_resync
  PMC 0x28A ic_oc_mode_switch.*
  L3PMC 0x001 l3_request_g1.*
  L3PMC 0x006 l3_comb_clstr_state.*

[1]: Processor Programming Reference (PPR) for AMD Family 17h Model 71h,
Revision B0 Processors, 56176 Rev 3.06 - Jul 17, 2019

[2]: Processor Programming Reference (PPR) for AMD Family 17h Models
01h,08h, Revision B2 Processors, 54945 Rev 3.03 - Jun 14, 2019

All of the PPRs can be found at:

https://bugzilla.kernel.org/show_bug.cgi?id=206537

Here are the results of running "fpu_pipe_assignment.total" events on my
Ryzen 3900X family 17h model 71h system:

Before this patch:

  $> perf list *fpu_pipe_assignment*

List of pre-defined events (to be used in -e):

After:

  $> perf list *fpu_pipe_assignment*

  floating point:
  fpu_pipe_assignment.total
      [Total number of fp uOps]
  fpu_pipe_assignment.total0
      [Total number uOps assigned to pipe 0]
  fpu_pipe_assignment.total1
      [Total number uOps assigned to pipe 1]
  fpu_pipe_assignment.total2
      [Total number uOps assigned to pipe 2]
  fpu_pipe_assignment.total3
      [Total number uOps assigned to pipe 3]

  Metric Groups:

  $> perf stat -e fpu_pipe_assignment.total sleep 1

  Performance counter stats for 'sleep 1':

              25,883      fpu_pipe_assignment.total

         1.004145868 seconds time elapsed

         0.001805000 seconds user
         0.000000000 seconds sys

Usage tests while running Linpackin the background:

  $> perf stat -I1000 -e fpu_pipe_assignment.total
       1.000266796     79,313,191,516      fpu_pipe_assignment.total
       2.000809630     68,091,474,430      fpu_pipe_assignment.total
       3.001028115     52,925,023,174      fpu_pipe_assignment.total

  $> perf record -e fpu_pipe_assignment.total,fpu_pipe_assignment.total0 -a sleep 1
  [ perf record: Woken up 9 times to write data ]
  [ perf record: Captured and wrote 4.031 MB perf.data (64764 samples) ]

  $> perf report --stdio --no-header | head -30
      98.33%  xhpl             xhpl                          [.] dgemm_kernel
       0.28%  xhpl             xhpl                          [.] dtrsm_kernel_LT
       0.10%  xhpl             [kernel.kallsyms]             [k] entry_SYSCALL_64
       0.08%  xhpl             xhpl                          [.] idamax_k
       0.07%  baloo_file_extr  liblmdb.so                    [.] mdb_mid2l_insert
       0.06%  xhpl             xhpl                          [.] dgemm_itcopy
       0.06%  xhpl             xhpl                          [.] dgemm_oncopy
       0.06%  xhpl             [kernel.kallsyms]             [k] __schedule
       0.06%  xhpl             [kernel.kallsyms]             [k] syscall_trace_enter
       0.06%  xhpl             [kernel.kallsyms]             [k] native_sched_clock
       0.06%  xhpl             [kernel.kallsyms]             [k] pick_next_task_fair
       0.05%  xhpl             xhpl                          [.] blas_thread_server.llvm.15009391670273914865
       0.04%  xhpl             [kernel.kallsyms]             [k] do_syscall_64
       0.04%  xhpl             [kernel.kallsyms]             [k] yield_task_fair
       0.04%  xhpl             libpthread-2.31.so            [.] __pthread_mutex_unlock_usercnt
       0.03%  xhpl             [kernel.kallsyms]             [k] cpuacct_charge
       0.03%  xhpl             [kernel.kallsyms]             [k] syscall_return_via_sysret
       0.03%  xhpl             libc-2.31.so                  [.] __sched_yield
       0.03%  xhpl             [kernel.kallsyms]             [k] __calc_delta

  $> perf annotate --stdio2 dgemm_kernel | egrep '^ {0,2}[0-9]+' -B2 -A2
                  sub          $0x60,%rsp
                  mov          %rbx,(%rsp)
    0.00          mov          %rbp,0x8(%rsp)
                  mov          %r12,0x10(%rsp)
    0.00          mov          %r13,0x18(%rsp)
                  mov          %r14,0x20(%rsp)
                  mov          %r15,0x28(%rsp)
  --
                  mov          %rdi,%r13
                  mov          %rsi,0x28(%rsp)
    0.00          mov          %rdx,%r12
                  vmovsd       %xmm0,0x30(%rsp)
                  shl          $0x3,%r10
                  mov          0x28(%rsp),%rax
    0.00          xor          %rdx,%rdx
                  mov          $0x18,%rdi
                  div          %rdi
  --
                  nop
            a0:   mov          %r12,%rax
    0.00          shl          $0x3,%rax
                  mov          %r8,%rdi
                  lea          (%r8,%rax,8),%r15
  --
                  mov          %r12,%rax
                  nop
    0.00    c0:   vmovups      (%rdi),%ymm1
    0.09          vmovups      0x20(%rdi),%ymm2
    0.02          vmovups      (%r15),%ymm3
    0.10          vmovups      %ymm1,(%rsi)
    0.07          vmovups      %ymm2,0x20(%rsi)
    0.07          vmovups      %ymm3,0x40(%rsi)
    0.06          add          $0x40,%rdi
                  add          $0x40,%r15
                  add          $0x60,%rsi
    0.00          dec          %rax
                ↑ jne          c0
                  mov          %r9,%r15
  --
                  nop
           110:   lea          0x80(%rsp),%rsi
    0.01          add          $0x60,%rsi
    0.03          mov          %r12,%rax
    0.00          sar          $0x3,%rax
                  cmp          $0x2,%rax
                ↓ jl           d26
                  prefetcht0   0x200(%rdi)
    0.01          vmovups      -0x60(%rsi),%ymm1
    0.02          prefetcht0   0xa0(%rsi)
    0.00          vbroadcastsd -0x80(%rdi),%ymm0
    0.00          prefetcht0   0xe0(%rsi)
    0.03          vmovups      -0x40(%rsi),%ymm2
    0.00          prefetcht0   0x120(%rsi)
                  vmovups      -0x20(%rsi),%ymm3
                  vmulpd       %ymm0,%ymm1,%ymm4
    0.01          prefetcht0   0x160(%rsi)
                  vmulpd       %ymm0,%ymm2,%ymm8
    0.01          vmulpd       %ymm0,%ymm3,%ymm12
    0.02          prefetcht0   0x1a0(%rsi)
    0.01          vbroadcastsd -0x78(%rdi),%ymm0
                  vmulpd       %ymm0,%ymm1,%ymm5
    0.01          vmulpd       %ymm0,%ymm2,%ymm9
                  vmulpd       %ymm0,%ymm3,%ymm13
    0.01          vbroadcastsd -0x70(%rdi),%ymm0
                  vmulpd       %ymm0,%ymm1,%ymm6
    0.00          vmulpd       %ymm0,%ymm2,%ymm10
    0.00          add          $0x60,%rsi

  ... snip ...

                  nop
          65e0:   vmovddup     -0x60(%rsi),%xmm2
    0.00          vmovups      -0x80(%rdi),%xmm0
                  vmovups      -0x70(%rdi),%xmm1
    0.00          vmovddup     -0x58(%rsi),%xmm3
                  vfmadd231pd  %xmm0,%xmm2,%xmm4
    0.00          vfmadd231pd  %xmm1,%xmm2,%xmm5
    0.00          vfmadd231pd  %xmm0,%xmm3,%xmm6
    0.00          vfmadd231pd  %xmm1,%xmm3,%xmm7
    0.00          add          $0x10,%rsi
                  add          $0x20,%rdi
    0.00          dec          %rax
                ↑ jne          65e0
                  nop
                  nop
          6620:   vmovddup     0x30(%rsp),%xmm0
    0.00          vmulpd       %xmm0,%xmm4,%xmm4
    0.00          vmulpd       %xmm0,%xmm5,%xmm5
                  vmulpd       %xmm0,%xmm6,%xmm6
                  vmulpd       %xmm0,%xmm7,%xmm7
                  vaddpd       (%r15),%xmm4,%xmm4
                  vaddpd       0x10(%r15),%xmm5,%xmm5
    0.00          vaddpd       (%r15,%r10,1),%xmm6,%xmm6
    0.00          vaddpd       0x10(%r15,%r10,1),%xmm7,%xmm7
    0.00          vmovups      %xmm4,(%r15)
                  vmovups      %xmm5,0x10(%r15)
    0.00          vmovups      %xmm6,(%r15,%r10,1)
                  vmovups      %xmm7,0x10(%r15,%r10,1)
                  add          $0x20,%r15
  --
                  lea          (%r8,%rax,8),%r8
          69d8:   mov          0x20(%rsp),%r14
    0.00          test         $0x1,%r14
                ↓ je           6d84
                  mov          %r9,%r15
  --
                  vbroadcastsd -0x28(%rsi),%ymm3
                  vfmadd231pd  (%rdi),%ymm0,%ymm4
    0.00          vfmadd231pd  0x20(%rdi),%ymm1,%ymm5
                  vfmadd231pd  0x40(%rdi),%ymm2,%ymm6
                  vfmadd231pd  0x60(%rdi),%ymm3,%ymm7
  --
                  vmulpd       %ymm0,%ymm4,%ymm4
                  vaddpd       (%r15),%ymm4,%ymm4
    0.00          vmovups      %ymm4,(%r15)
                  add          $0x20,%r15
                  dec          %r11
  --
                  mov          %rbx,%rsp
                  mov          (%rsp),%rbx
    0.01          mov          0x8(%rsp),%rbp
                  mov          0x10(%rsp),%r12
                  mov          0x18(%rsp),%r13

Signed-off-by: Vijay Thakkar <vijaythakkar@me.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Kim Phillips <kim.phillips@amd.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Jon Grimm <jon.grimm@amd.com>
Cc: Martin Liška <mliska@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200318190002.307290-3-vijaythakkar@me.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/x86/amdzen2/branch.json         |  52 +-
 tools/perf/pmu-events/arch/x86/amdzen2/cache.json          | 338 +++++++-
 tools/perf/pmu-events/arch/x86/amdzen2/core.json           | 130 +++-
 tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json | 140 +++-
 tools/perf/pmu-events/arch/x86/amdzen2/memory.json         | 341 +++++++-
 tools/perf/pmu-events/arch/x86/amdzen2/other.json          | 115 ++-
 tools/perf/pmu-events/arch/x86/mapfile.csv                 |   1 +-
 7 files changed, 1117 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/core.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/other.json

diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/branch.json b/tools/perf/pmu-events/arch/x86/amdzen2/branch.json
new file mode 100644
index 0000000..ef4166a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/branch.json
@@ -0,0 +1,52 @@
+[
+  {
+    "EventName": "bp_l1_btb_correct",
+    "EventCode": "0x8a",
+    "BriefDescription": "L1 Branch Prediction Overrides Existing Prediction (speculative)."
+  },
+  {
+    "EventName": "bp_l2_btb_correct",
+    "EventCode": "0x8b",
+    "BriefDescription": "L2 Branch Prediction Overrides Existing Prediction (speculative)."
+  },
+  {
+    "EventName": "bp_dyn_ind_pred",
+    "EventCode": "0x8e",
+    "BriefDescription": "Dynamic Indirect Predictions.",
+    "PublicDescription": "Indirect Branch Prediction for potential multi-target branch (speculative)."
+  },
+  {
+    "EventName": "bp_de_redirect",
+    "EventCode": "0x91",
+    "BriefDescription": "Decoder Overrides Existing Branch Prediction (speculative)."
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit",
+    "EventCode": "0x94",
+    "BriefDescription": "The number of instruction fetches that hit in the L1 ITLB.",
+    "UMask": "0xFF"
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit.if1g",
+    "EventCode": "0x94",
+    "BriefDescription": "The number of instruction fetches that hit in the L1 ITLB. Instruction fetches to a 1GB page.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit.if2m",
+    "EventCode": "0x94",
+    "BriefDescription": "The number of instruction fetches that hit in the L1 ITLB. Instruction fetches to a 2MB page.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit.if4k",
+    "EventCode": "0x94",
+    "BriefDescription": "The number of instruction fetches that hit in the L1 ITLB. Instruction fetches to a 4KB page.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "bp_tlb_rel",
+    "EventCode": "0x99",
+    "BriefDescription": "The number of ITLB reload requests."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/cache.json b/tools/perf/pmu-events/arch/x86/amdzen2/cache.json
new file mode 100644
index 0000000..1c60bfa
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/cache.json
@@ -0,0 +1,338 @@
+[
+  {
+    "EventName": "l2_request_g1.rd_blk_l",
+    "EventCode": "0x60",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). Data cache reads (including hardware and software prefetch).",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_request_g1.rd_blk_x",
+    "EventCode": "0x60",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). Data cache stores.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_request_g1.ls_rd_blk_c_s",
+    "EventCode": "0x60",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). Data cache shared reads.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_request_g1.cacheable_ic_read",
+    "EventCode": "0x60",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). Instruction cache reads.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_request_g1.change_to_x",
+    "EventCode": "0x60",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). Data cache state change requests. Request change to writable, check L2 for current state.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "l2_request_g1.prefetch_l2_cmd",
+    "EventCode": "0x60",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). PrefetchL2Cmd.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "l2_request_g1.l2_hw_pf",
+    "EventCode": "0x60",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 1 - Common). L2 Prefetcher. All prefetches accepted by L2 pipeline, hit or miss. Types of PF and L2 hit/miss broken out in a separate perfmon event.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "l2_request_g1.group2",
+    "EventCode": "0x60",
+    "BriefDescription": "Miscellaneous events covered in more detail by l2_request_g2 (PMCx061).",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_request_g2.group1",
+    "EventCode": "0x61",
+    "BriefDescription": "Miscellaneous events covered in more detail by l2_request_g1 (PMCx060).",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_request_g2.ls_rd_sized",
+    "EventCode": "0x61",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Data cache read sized.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_request_g2.ls_rd_sized_nc",
+    "EventCode": "0x61",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Data cache read sized non-cacheable.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_request_g2.ic_rd_sized",
+    "EventCode": "0x61",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Instruction cache read sized.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_request_g2.ic_rd_sized_nc",
+    "EventCode": "0x61",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Instruction cache read sized non-cacheable.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "l2_request_g2.smc_inval",
+    "EventCode": "0x61",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Self-modifying code invalidates.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "l2_request_g2.bus_locks_originator",
+    "EventCode": "0x61",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Bus locks.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "l2_request_g2.bus_locks_responses",
+    "EventCode": "0x61",
+    "BriefDescription": "All L2 Cache Requests (Breakdown 2 - Rare). Bus lock response.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_latency.l2_cycles_waiting_on_fills",
+    "EventCode": "0x62",
+    "BriefDescription": "Total cycles spent waiting for L2 fills to complete from L3 or memory, divided by four. Event counts are for both threads. To calculate average latency, the number of fills from both threads must be used.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_wcb_req.wcb_write",
+    "EventCode": "0x63",
+    "BriefDescription": "LS to L2 WCB write requests. LS (Load/Store unit) to L2 WCB (Write Combining Buffer) write requests.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_wcb_req.wcb_close",
+    "EventCode": "0x63",
+    "BriefDescription": "LS to L2 WCB close requests. LS (Load/Store unit) to L2 WCB (Write Combining Buffer) close requests.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_wcb_req.zero_byte_store",
+    "EventCode": "0x63",
+    "BriefDescription": "LS to L2 WCB zero byte store requests. LS (Load/Store unit) to L2 WCB (Write Combining Buffer) zero byte store requests.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "l2_wcb_req.cl_zero",
+    "EventCode": "0x63",
+    "BriefDescription": "LS to L2 WCB cache line zeroing requests. LS (Load/Store unit) to L2 WCB (Write Combining Buffer) cache line zeroing requests.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_cs",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Data cache shared read hit in L2",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_l_hit_x",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Data cache read hit in L2.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_l_hit_s",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Data cache read hit on shared line in L2.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_x",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Data cache store or state change hit in L2.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_c",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Data cache request miss in L2 (all types).",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_fill_hit_x",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache hit modifiable line in L2.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_fill_hit_s",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache hit clean line in L2.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_fill_miss",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache request miss in L2.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_fill_pending.l2_fill_busy",
+    "EventCode": "0x6d",
+    "BriefDescription": "Cycles with fill pending from L2. Total cycles spent with one or more fill requests in flight from L2.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l2_pf_hit_l2",
+    "EventCode": "0x70",
+    "BriefDescription": "L2 prefetch hit in L2.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_hit_l3",
+    "EventCode": "0x71",
+    "BriefDescription": "L2 prefetcher hits in L3. Counts all L2 prefetches accepted by the L2 pipeline which miss the L2 cache and hit the L3.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_l3",
+    "EventCode": "0x72",
+    "BriefDescription": "L2 prefetcher misses in L3. All L2 prefetches accepted by the L2 pipeline which miss the L2 and the L3 caches.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "ic_fw32",
+    "EventCode": "0x80",
+    "BriefDescription": "The number of 32B fetch windows transferred from IC pipe to DE instruction decoder (includes non-cacheable and cacheable fill responses)."
+  },
+  {
+    "EventName": "ic_fw32_miss",
+    "EventCode": "0x81",
+    "BriefDescription": "The number of 32B fetch windows tried to read the L1 IC and missed in the full tag."
+  },
+  {
+    "EventName": "ic_cache_fill_l2",
+    "EventCode": "0x82",
+    "BriefDescription": "The number of 64 byte instruction cache line was fulfilled from the L2 cache."
+  },
+  {
+    "EventName": "ic_cache_fill_sys",
+    "EventCode": "0x83",
+    "BriefDescription": "The number of 64 byte instruction cache line fulfilled from system memory or another cache."
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_hit",
+    "EventCode": "0x84",
+    "BriefDescription": "The number of instruction fetches that miss in the L1 ITLB but hit in the L2 ITLB."
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss",
+    "EventCode": "0x85",
+    "BriefDescription": "The number of instruction fetches that miss in both the L1 and L2 TLBs.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.if1g",
+    "EventCode": "0x85",
+    "BriefDescription": "The number of instruction fetches that miss in both the L1 and L2 TLBs. Instruction fetches to a 1GB page.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.if2m",
+    "EventCode": "0x85",
+    "BriefDescription": "The number of instruction fetches that miss in both the L1 and L2 TLBs. Instruction fetches to a 2MB page.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.if4k",
+    "EventCode": "0x85",
+    "BriefDescription": "The number of instruction fetches that miss in both the L1 and L2 TLBs. Instruction fetches to a 4KB page.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "bp_snp_re_sync",
+    "EventCode": "0x86",
+    "BriefDescription": "The number of pipeline restarts caused by invalidating probes that hit on the instruction stream currently being executed. This would happen if the active instruction stream was being modified by another processor in an MP system - typically a highly unlikely event."
+  },
+  {
+    "EventName": "ic_fetch_stall.ic_stall_any",
+    "EventCode": "0x87",
+    "BriefDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle for any reason (nothing valid in pipe ICM1).",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ic_fetch_stall.ic_stall_dq_empty",
+    "EventCode": "0x87",
+    "BriefDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle (including IC to OC fetches) due to DQ empty.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ic_fetch_stall.ic_stall_back_pressure",
+    "EventCode": "0x87",
+    "BriefDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle (including IC to OC fetches) due to back-pressure.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ic_cache_inval.l2_invalidating_probe",
+    "EventCode": "0x8c",
+    "BriefDescription": "IC line invalidated due to L2 invalidating probe (external or LS). The number of instruction cache lines invalidated. A non-SMC event is CMC (cross modifying code), either from the other thread of the core or another core.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ic_cache_inval.fill_invalidated",
+    "EventCode": "0x8c",
+    "BriefDescription": "IC line invalidated due to overwriting fill response. The number of instruction cache lines invalidated. A non-SMC event is CMC (cross modifying code), either from the other thread of the core or another core.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ic_oc_mode_switch.oc_ic_mode_switch",
+    "EventCode": "0x28a",
+    "BriefDescription": "OC Mode Switch. OC to IC mode switch.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ic_oc_mode_switch.ic_oc_mode_switch",
+    "EventCode": "0x28a",
+    "BriefDescription": "OC Mode Switch. IC to OC mode switch.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "l3_request_g1.caching_l3_cache_accesses",
+    "EventCode": "0x01",
+    "BriefDescription": "Caching: L3 cache accesses",
+    "UMask": "0x80",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_lookup_state.all_l3_req_typs",
+    "EventCode": "0x04",
+    "BriefDescription": "All L3 Request Types",
+    "UMask": "0xff",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_comb_clstr_state.other_l3_miss_typs",
+    "EventCode": "0x06",
+    "BriefDescription": "Other L3 Miss Request Types",
+    "UMask": "0xfe",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_comb_clstr_state.request_miss",
+    "EventCode": "0x06",
+    "BriefDescription": "L3 cache misses",
+    "UMask": "0x01",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "xi_sys_fill_latency",
+    "EventCode": "0x90",
+    "BriefDescription": "L3 Cache Miss Latency. Total cycles for all transactions divided by 16. Ignores SliceMask and ThreadMask.",
+    "UMask": "0x00",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "xi_ccx_sdp_req1.all_l3_miss_req_typs",
+    "EventCode": "0x9A",
+    "BriefDescription": "All L3 Miss Request Types. Ignores SliceMask and ThreadMask.",
+    "UMask": "0x3f",
+    "Unit": "L3PMC"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/core.json b/tools/perf/pmu-events/arch/x86/amdzen2/core.json
new file mode 100644
index 0000000..de89e5a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/core.json
@@ -0,0 +1,130 @@
+[
+  {
+    "EventName": "ex_ret_instr",
+    "EventCode": "0xc0",
+    "BriefDescription": "Retired Instructions."
+  },
+  {
+    "EventName": "ex_ret_cops",
+    "EventCode": "0xc1",
+    "BriefDescription": "Retired Uops.",
+    "PublicDescription": "The number of micro-ops retired. This count includes all processor activity (instructions, exceptions, interrupts, microcode assists, etc.). The number of events logged per cycle can vary from 0 to 8."
+  },
+  {
+    "EventName": "ex_ret_brn",
+    "EventCode": "0xc2",
+    "BriefDescription": "Retired Branch Instructions.",
+    "PublicDescription": "The number of branch instructions retired. This includes all types of architectural control flow changes, including exceptions and interrupts."
+  },
+  {
+    "EventName": "ex_ret_brn_misp",
+    "EventCode": "0xc3",
+    "BriefDescription": "Retired Branch Instructions Mispredicted.",
+    "PublicDescription": "The number of branch instructions retired, of any type, that were not correctly predicted. This includes those for which prediction is not attempted (far control transfers, exceptions and interrupts)."
+  },
+  {
+    "EventName": "ex_ret_brn_tkn",
+    "EventCode": "0xc4",
+    "BriefDescription": "Retired Taken Branch Instructions.",
+    "PublicDescription": "The number of taken branches that were retired. This includes all types of architectural control flow changes, including exceptions and interrupts."
+  },
+  {
+    "EventName": "ex_ret_brn_tkn_misp",
+    "EventCode": "0xc5",
+    "BriefDescription": "Retired Taken Branch Instructions Mispredicted.",
+    "PublicDescription": "The number of retired taken branch instructions that were mispredicted."
+  },
+  {
+    "EventName": "ex_ret_brn_far",
+    "EventCode": "0xc6",
+    "BriefDescription": "Retired Far Control Transfers.",
+    "PublicDescription": "The number of far control transfers retired including far call/jump/return, IRET, SYSCALL and SYSRET, plus exceptions and interrupts. Far control transfers are not subject to branch prediction."
+  },
+  {
+    "EventName": "ex_ret_brn_resync",
+    "EventCode": "0xc7",
+    "BriefDescription": "Retired Branch Resyncs.",
+    "PublicDescription": "The number of resync branches. These reflect pipeline restarts due to certain microcode assists and events such as writes to the active instruction stream, among other things. Each occurrence reflects a restart penalty similar to a branch mispredict. This is relatively rare."
+  },
+  {
+    "EventName": "ex_ret_near_ret",
+    "EventCode": "0xc8",
+    "BriefDescription": "Retired Near Returns.",
+    "PublicDescription": "The number of near return instructions (RET or RET Iw) retired."
+  },
+  {
+    "EventName": "ex_ret_near_ret_mispred",
+    "EventCode": "0xc9",
+    "BriefDescription": "Retired Near Returns Mispredicted.",
+    "PublicDescription": "The number of near returns retired that were not correctly predicted by the return address predictor. Each such mispredict incurs the same penalty as a mispredicted conditional branch instruction."
+  },
+  {
+    "EventName": "ex_ret_brn_ind_misp",
+    "EventCode": "0xca",
+    "BriefDescription": "Retired Indirect Branch Instructions Mispredicted."
+  },
+  {
+    "EventName": "ex_ret_mmx_fp_instr.sse_instr",
+    "EventCode": "0xcb",
+    "BriefDescription": "SSE instructions (SSE, SSE2, SSE3, SSSE3, SSE4A, SSE41, SSE42, AVX).",
+    "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. SSE instructions (SSE, SSE2, SSE3, SSSE3, SSE4A, SSE41, SSE42, AVX).",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ex_ret_mmx_fp_instr.mmx_instr",
+    "EventCode": "0xcb",
+    "BriefDescription": "MMX instructions.",
+    "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. MMX instructions.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ex_ret_mmx_fp_instr.x87_instr",
+    "EventCode": "0xcb",
+    "BriefDescription": "x87 instructions.",
+    "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. x87 instructions.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ex_ret_cond",
+    "EventCode": "0xd1",
+    "BriefDescription": "Retired Conditional Branch Instructions."
+  },
+  {
+    "EventName": "ex_ret_cond_misp",
+    "EventCode": "0xd2",
+    "BriefDescription": "Retired Conditional Branch Instructions Mispredicted."
+  },
+  {
+    "EventName": "ex_div_busy",
+    "EventCode": "0xd3",
+    "BriefDescription": "Div Cycles Busy count."
+  },
+  {
+    "EventName": "ex_div_count",
+    "EventCode": "0xd4",
+    "BriefDescription": "Div Op Count."
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.ibs_count_rollover",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Tagged IBS Ops. Number of times an op could not be tagged by IBS because of a previous tagged op that has not retired.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.ibs_tagged_ops_ret",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Tagged IBS Ops. Number of Ops tagged by IBS that retired.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.ibs_tagged_ops",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Tagged IBS Ops. Number of Ops tagged by IBS.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ex_ret_fus_brnch_inst",
+    "EventCode": "0x1d0",
+    "BriefDescription": "Retired Fused Instructions. The number of fuse-branch instructions retired per cycle. The number of events logged per cycle can vary from 0-8.",
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json b/tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
new file mode 100644
index 0000000..622a0c4
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
@@ -0,0 +1,140 @@
+[
+  {
+    "EventName": "fpu_pipe_assignment.total",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number of fp uOps.",
+    "PublicDescription": "Total number of fp uOps. The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS.",
+    "UMask": "0xf"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.total3",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number uOps assigned to pipe 3.",
+    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one-cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to pipe 3.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.total2",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number uOps assigned to pipe 2.",
+    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to pipe 2.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.total1",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number uOps assigned to pipe 1.",
+    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to pipe 1.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "fpu_pipe_assignment.total0",
+    "EventCode": "0x00",
+    "BriefDescription": "Total number of fp uOps  on pipe 0.",
+    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS. Total number uOps assigned to pipe 0.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.all",
+    "EventCode": "0x03",
+    "BriefDescription": "All FLOPS. This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.mac_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Multiply-add FLOPS. Multiply-add counts as 2 FLOPS. This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15.",
+    "PublicDescription": "",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.div_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Divide/square root FLOPS. This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.mult_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Multiply FLOPS. This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.add_sub_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Add/subtract FLOPS. This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "fp_num_mov_elim_scal_op.optimized",
+    "EventCode": "0x04",
+    "BriefDescription": "Number of Scalar Ops optimized. This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "fp_num_mov_elim_scal_op.opt_potential",
+    "EventCode": "0x04",
+    "BriefDescription": "Number of Ops that are candidates for optimization (have Z-bit either set or pass). This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "fp_num_mov_elim_scal_op.sse_mov_ops_elim",
+    "EventCode": "0x04",
+    "BriefDescription": "Number of SSE Move Ops eliminated. This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "fp_num_mov_elim_scal_op.sse_mov_ops",
+    "EventCode": "0x04",
+    "BriefDescription": "Number of SSE Move Ops. This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.sse_bot_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "SSE bottom-executing uOps retired. The number of serializing Ops retired.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.sse_ctrl_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "The number of serializing Ops retired. SSE control word mispredict traps due to mispredictions in RC, FTZ or DAZ, or changes in mask bits.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.x87_bot_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "x87 bottom-executing uOps retired. The number of serializing Ops retired.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "fp_retired_ser_ops.x87_ctrl_ret",
+    "EventCode": "0x05",
+    "BriefDescription": "x87 control word mispredict traps due to mispredictions in RC or PC, or changes in mask bits. The number of serializing Ops retired.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "fp_disp_faults.ymm_spill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating Point Dispatch Faults. YMM spill fault.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "fp_disp_faults.ymm_fill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating Point Dispatch Faults. YMM fill fault.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "fp_disp_faults.xmm_fill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating Point Dispatch Faults. XMM fill fault.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "fp_disp_faults.x87_fill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating Point Dispatch Faults. x87 fill fault.",
+    "UMask": "0x1"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/memory.json b/tools/perf/pmu-events/arch/x86/amdzen2/memory.json
new file mode 100644
index 0000000..715046b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/memory.json
@@ -0,0 +1,341 @@
+[
+  {
+    "EventName": "ls_bad_status2.stli_other",
+    "EventCode": "0x24",
+    "BriefDescription": "Non-forwardable conflict; used to reduce STLI's via software. All reasons. Store To Load Interlock (STLI) are loads that were unable to complete because of a possible match with an older store, and the older store could not do STLF for some reason.",
+    "PublicDescription" : "Store-to-load conflicts: A load was unable to complete due to a non-forwardable conflict with an older store. Most commonly, a load's address range partially but not completely overlaps with an uncompleted older store. Software can avoid this problem by using same-size and same-alignment loads and stores when accessing the same data. Vector/SIMD code is particularly susceptible to this problem; software should construct wide vector stores by manipulating vector elements in registers using shuffle/blend/swap instructions prior to storing to memory, instead of using narrow element-by-element stores.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_locks.spec_lock_hi_spec",
+    "EventCode": "0x25",
+    "BriefDescription": "Retired lock instructions. High speculative cacheable lock speculation succeeded.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "ls_locks.spec_lock_lo_spec",
+    "EventCode": "0x25",
+    "BriefDescription": "Retired lock instructions. Low speculative cacheable lock speculation succeeded.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ls_locks.non_spec_lock",
+    "EventCode": "0x25",
+    "BriefDescription": "Retired lock instructions. Non-speculative lock succeeded.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_locks.bus_lock",
+    "EventCode": "0x25",
+    "BriefDescription": "Retired lock instructions. Bus lock when a locked operations crosses a cache boundary or is done on an uncacheable memory type. Comparable to legacy bus lock.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_ret_cl_flush",
+    "EventCode": "0x26",
+    "BriefDescription": "Number of retired CLFLUSH instructions."
+  },
+  {
+    "EventName": "ls_ret_cpuid",
+    "EventCode": "0x27",
+    "BriefDescription": "Number of retired CPUID instructions."
+  },
+  {
+    "EventName": "ls_dispatch.ld_st_dispatch",
+    "EventCode": "0x29",
+    "BriefDescription": "Dispatch of a single op that performs a load from and store to the same memory address. Number of single ops that do load/store to an address.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ls_dispatch.store_dispatch",
+    "EventCode": "0x29",
+    "BriefDescription": "Number of stores dispatched. Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_dispatch.ld_dispatch",
+    "EventCode": "0x29",
+    "BriefDescription": "Number of loads dispatched. Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_smi_rx",
+    "EventCode": "0x2B",
+    "BriefDescription": "Number of SMIs received."
+  },
+  {
+    "EventName": "ls_int_taken",
+    "EventCode": "0x2C",
+    "BriefDescription": "Number of interrupts taken."
+  },
+  {
+    "EventName": "ls_rdtsc",
+    "EventCode": "0x2D",
+    "BriefDescription": "Number of reads of the TSC (RDTSC instructions). The count is speculative."
+  },
+  {
+    "EventName": "ls_stlf",
+    "EventCode": "0x35",
+    "BriefDescription": "Number of STLF hits."
+  },
+  {
+    "EventName": "ls_st_commit_cancel2.st_commit_cancel_wcb_full",
+    "EventCode": "0x37",
+    "BriefDescription": "A non-cacheable store and the non-cacheable commit buffer is full."
+  },
+  {
+    "EventName": "ls_dc_accesses",
+    "EventCode": "0x40",
+    "BriefDescription": "Number of accesses to the dcache for load/store references.",
+    "PublicDescription": "The number of accesses to the data cache for load and store references. This may include certain microcode scratchpad accesses, although these are generally rare. Each increment represents an eight-byte access, although the instruction may only be accessing a portion of that. This event is a speculative event."
+  },
+  {
+    "EventName": "ls_mab_alloc.dc_prefetcher",
+    "EventCode": "0x41",
+    "BriefDescription": "LS MAB Allocates by Type. DC prefetcher.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "ls_mab_alloc.stores",
+    "EventCode": "0x41",
+    "BriefDescription": "LS MAB Allocates by Type. Stores.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_mab_alloc.loads",
+    "EventCode": "0x41",
+    "BriefDescription": "LS MAB Allocates by Type. Loads.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_refills_from_sys.ls_mabresp_rmt_dram",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand Data Cache Fills by Data Source. DRAM or IO from different die.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_refills_from_sys.ls_mabresp_rmt_cache",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand Data Cache Fills by Data Source. Hit in cache; Remote CCX and the address's Home Node is on a different die.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_refills_from_sys.ls_mabresp_lcl_dram",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand Data Cache Fills by Data Source. DRAM or IO from this thread's die.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "ls_refills_from_sys.ls_mabresp_lcl_cache",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand Data Cache Fills by Data Source. Hit in cache; local CCX (not Local L2), or Remote CCX and the address's Home Node is on this thread's die.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_refills_from_sys.ls_mabresp_lcl_l2",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand Data Cache Fills by Data Source. Local L2 hit.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.all",
+    "EventCode": "0x45",
+    "BriefDescription": "All L1 DTLB Misses or Reloads.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss. DTLB reload to a 1G page that miss in the L2 TLB.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss. DTLB reload to a 2M page that miss in the L2 TLB.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_coalesced_page_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss. DTLB reload coalesced page miss.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss. DTLB reload to a 4K page that miss the L2 TLB.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss. DTLB reload to a 1G page that hit in the L2 TLB.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss. DTLB reload to a 2M page that hit in the L2 TLB.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_coalesced_page_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss. DTLB reload hit a coalesced page.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Miss. DTLB reload to a 4K page that hit in the L2 TLB.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_tablewalker.iside",
+    "EventCode": "0x46",
+    "BriefDescription": "Total Page Table Walks on I-side.",
+    "UMask": "0xc"
+  },
+  {
+    "EventName": "ls_tablewalker.ic_type1",
+    "EventCode": "0x46",
+    "BriefDescription": "Total Page Table Walks IC Type 1.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "ls_tablewalker.ic_type0",
+    "EventCode": "0x46",
+    "BriefDescription": "Total Page Table Walks IC Type 0.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ls_tablewalker.dside",
+    "EventCode": "0x46",
+    "BriefDescription": "Total Page Table Walks on D-side.",
+    "UMask": "0x3"
+  },
+  {
+    "EventName": "ls_tablewalker.dc_type1",
+    "EventCode": "0x46",
+    "BriefDescription": "Total Page Table Walks DC Type 1.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_tablewalker.dc_type0",
+    "EventCode": "0x46",
+    "BriefDescription": "Total Page Table Walks DC Type 0.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_misal_accesses",
+    "EventCode": "0x47",
+    "BriefDescription": "Misaligned loads."
+  },
+  {
+    "EventName": "ls_pref_instr_disp",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software Prefetch Instructions Dispatched (Speculative).",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "ls_pref_instr_disp.prefetch_nta",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software Prefetch Instructions Dispatched (Speculative). PrefetchNTA instruction. See docAPM3 PREFETCHlevel.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "ls_pref_instr_disp.prefetch_w",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software Prefetch Instructions Dispatched (Speculative). See docAPM3 PREFETCHW.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_pref_instr_disp.prefetch",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software Prefetch Instructions Dispatched (Speculative). Prefetch_T0_T1_T2. PrefetchT0, T1 and T2 instructions. See docAPM3 PREFETCHlevel.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_inef_sw_pref.mab_mch_cnt",
+    "EventCode": "0x52",
+    "BriefDescription": "The number of software prefetches that did not fetch data outside of the processor core. Software PREFETCH instruction saw a match on an already-allocated miss request buffer.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_inef_sw_pref.data_pipe_sw_pf_dc_hit",
+    "EventCode": "0x52",
+    "BriefDescription": "The number of software prefetches that did not fetch data outside of the processor core. Software PREFETCH instruction saw a DC hit.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fill.ls_mabresp_rmt_dram",
+    "EventCode": "0x59",
+    "BriefDescription": "Software Prefetch Data Cache Fills by Data Source. >From DRAM (home node remote).",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fill.ls_mabresp_rmt_cache",
+    "EventCode": "0x59",
+    "BriefDescription": "Software Prefetch Data Cache Fills by Data Source. >From another cache (home node remote).",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fill.ls_mabresp_lcl_dram",
+    "EventCode": "0x59",
+    "BriefDescription": "Software Prefetch Data Cache Fills by Data Source. DRAM or IO from this thread's die.  From DRAM (home node local).",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fill.ls_mabresp_lcl_cache",
+    "EventCode": "0x59",
+    "BriefDescription": "Software Prefetch Data Cache Fills by Data Source. >From another cache (home node local).",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fill.ls_mabresp_lcl_l2",
+    "EventCode": "0x59",
+    "BriefDescription": "Software Prefetch Data Cache Fills by Data Source. Local L2 hit.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fill.ls_mabresp_rmt_dram",
+    "EventCode": "0x5A",
+    "BriefDescription": "Hardware Prefetch Data Cache Fills by Data Source. >From DRAM (home node remote).",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fill.ls_mabresp_rmt_cache",
+    "EventCode": "0x5A",
+    "BriefDescription": "Hardware Prefetch Data Cache Fills by Data Source. >From another cache (home node remote).",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fill.ls_mabresp_lcl_dram",
+    "EventCode": "0x5A",
+    "BriefDescription": "Hardware Prefetch Data Cache Fills by Data Source. >From DRAM (home node local).",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fill.ls_mabresp_lcl_cache",
+    "EventCode": "0x5A",
+    "BriefDescription": "Hardware Prefetch Data Cache Fills by Data Source. >From another cache (home node local).",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fill.ls_mabresp_lcl_l2",
+    "EventCode": "0x5A",
+    "BriefDescription": "Hardware Prefetch Data Cache Fills by Data Source. Local L2 hit.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "ls_not_halted_cyc",
+    "EventCode": "0x76",
+    "BriefDescription": "Cycles not in Halt."
+  },
+  {
+    "EventName": "ls_tlb_flush",
+    "EventCode": "0x78",
+    "BriefDescription": "All TLB Flushes"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/other.json b/tools/perf/pmu-events/arch/x86/amdzen2/other.json
new file mode 100644
index 0000000..e94994d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/other.json
@@ -0,0 +1,115 @@
+[
+  {
+    "EventName": "de_dis_uop_queue_empty_di0",
+    "EventCode": "0xa9",
+    "BriefDescription": "Cycles where the Micro-Op Queue is empty."
+  },
+  {
+    "EventName": "de_dis_uops_from_decoder",
+    "EventCode": "0xaa",
+    "BriefDescription": "Ops dispatched from either the decoders, OpCache or both.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "de_dis_uops_from_decoder.opcache_dispatched",
+    "EventCode": "0xaa",
+    "BriefDescription": "Count of dispatched Ops from OpCache.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "de_dis_uops_from_decoder.decoder_dispatched",
+    "EventCode": "0xaa",
+    "BriefDescription": "Count of dispatched Ops from Decoder.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.fp_misc_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. FP Miscellaneous resource unavailable. Applies to the recovery of mispredicts with FP ops.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.fp_sch_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. FP scheduler resource stall. Applies to ops that use the FP scheduler.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.fp_reg_file_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. Floating point register file resource stall. Applies to all FP ops that have a destination register.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.taken_branch_buffer_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. Taken branch buffer resource stall.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.int_sched_misc_token_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. Integer Scheduler miscellaneous resource stall.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.store_queue_token_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. Store queue resource stall. Applies to all ops with store semantics.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.load_queue_token_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. Load queue resource stall. Applies to all ops with load semantics.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls1.int_phy_reg_file_token_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. Integer Physical Register File resource stall. Applies to all ops that have an integer destination register.",
+    "UMask": "0x1"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.sc_agu_dispatch_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. SC AGU dispatch stall.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.retire_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.agsq_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. AGSQ Tokens unavailable.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.alu_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALU tokens total unavailable.",
+    "UMask": "0x8"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.alsq3_0_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ3_0_TokenStall.",
+    "UMask": "0x4"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.alsq2_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 2 Tokens unavailable.",
+    "UMask": "0x2"
+  },
+  {
+    "EventName": "de_dis_dispatch_token_stalls0.alsq1_token_stall",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 1 Tokens unavailable.",
+    "UMask": "0x1"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 82a9db0..244a36e 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -37,3 +37,4 @@ GenuineIntel-6-7D,v1,icelake,core
 GenuineIntel-6-7E,v1,icelake,core
 GenuineIntel-6-86,v1,tremontx,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v1,amdzen1,core
+AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
