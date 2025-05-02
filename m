Return-Path: <linux-tip-commits+bounces-5177-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F0CAA6DB5
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 11:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598DE16BFC9
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 09:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB15126B96A;
	Fri,  2 May 2025 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gVrG4uNU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oE6+nyQz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3282526772A;
	Fri,  2 May 2025 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176676; cv=none; b=WM2RGJLFfW3hMqqEm2KIO4WcYEI9S5iaLOmuxb00MY+msKAlCzVDJEs0c/TIbH9qvunq3E83rQh1icTw4DK6zVCWNwIaQYCH15WH2JeUyruAVrKRW5x7VnP9ayM1YGLUzvz/2rCaWz9XOAbTxTEmp9eaAHJv+Dn4yuWz011I2n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176676; c=relaxed/simple;
	bh=zn1qyOHV5KOECORbCgncGsjLWhjaYERlVO1V00VQrDE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iEIzutWSamJSZC3Jmk6TYiomAI2lmtZoMedJNfwiuyWLfnqxMsmONZ8UZ4ICoW6N3sCOQY1GDCGLXHGPIkGXuCOSYVbG5dr8BtKPZWMIsHch+GgPEJNsLDKlW7GKwJq//YBWWoFiq7SYXxLmIOMACOQQDntmoZika/BFx2sXLlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gVrG4uNU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oE6+nyQz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 09:04:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746176669;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbwFodEl5J9L8rb/oBa5P/D2/0pKGv8IEwDgiGK3oMs=;
	b=gVrG4uNU+xfJkQf+1c6fMLdKZBIoS2HXXndmJrCftI2iRcyJ7mNj8K1BDjC+9B8QAoDgzA
	mAwHNg6XxwRPgCm2lws5c3pfeOOkeVkYxikfGFU7/6Xb+lXZZfG0ShE6GK+SYSYC2CtE36
	imqmaNLkbUURqx7ya34UOHJv8ut+6QjhseU0E/eR3fXgjDBgdTYwC98poqOq1F98QeLR0c
	0I1v9Lq3nkOqM7wJ3CKJzckQ2oqi0GY0NOBe05K9g4r+HCK+5/MRofYaxh6TGFHervG5MW
	KYXcLQfbYwmlVMvte3Hzcm+bQWME9vqMH0mP5HAPKjl7vtMv0iZeRbrNscxKww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746176669;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbwFodEl5J9L8rb/oBa5P/D2/0pKGv8IEwDgiGK3oMs=;
	b=oE6+nyQzy/VH066U4N3hcLOZ7hzM5SxpUmu4L6URHg3ahQ0CSJc9IK53oAzVjj2SNpFcBc
	YwLYYowDhmPZySBQ==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/msr: Add explicit includes of <asm/msr.h>
Cc: "Xin Li (Intel)" <xin@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 ilpo.jarvinen@linux.intel.com, Andy Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250501054241.1245648-1-xin@zytor.com>
References: <20250501054241.1245648-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174617666840.22196.9029681254138237731.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     efef7f184f2eaf29a1ca676712d0e6e851cd0191
Gitweb:        https://git.kernel.org/tip/efef7f184f2eaf29a1ca676712d0e6e851c=
d0191
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Wed, 30 Apr 2025 22:42:41 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 May 2025 10:23:47 +02:00

x86/msr: Add explicit includes of <asm/msr.h>

For historic reasons there are some TSC-related functions in the
<asm/msr.h> header, even though there's an <asm/tsc.h> header.

To facilitate the relocation of rdtsc{,_ordered}() from <asm/msr.h>
to <asm/tsc.h> and to eventually eliminate the inclusion of
<asm/msr.h> in <asm/tsc.h>, add an explicit <asm/msr.h> dependency
to the source files that reference definitions from <asm/msr.h>.

[ mingo: Clarified the changelog. ]

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Link: https://lore.kernel.org/r/20250501054241.1245648-1-xin@zytor.com
---
 arch/x86/coco/sev/core.c                                         | 1 +
 arch/x86/events/amd/core.c                                       | 1 +
 arch/x86/events/amd/ibs.c                                        | 1 +
 arch/x86/events/amd/iommu.c                                      | 2 ++
 arch/x86/events/amd/lbr.c                                        | 1 +
 arch/x86/events/amd/power.c                                      | 1 +
 arch/x86/events/core.c                                           | 1 +
 arch/x86/events/intel/bts.c                                      | 1 +
 arch/x86/events/intel/core.c                                     | 1 +
 arch/x86/events/intel/cstate.c                                   | 1 +
 arch/x86/events/intel/ds.c                                       | 1 +
 arch/x86/events/intel/knc.c                                      | 1 +
 arch/x86/events/intel/p4.c                                       | 1 +
 arch/x86/events/intel/p6.c                                       | 1 +
 arch/x86/events/intel/pt.c                                       | 1 +
 arch/x86/events/intel/uncore.c                                   | 1 +
 arch/x86/events/intel/uncore_discovery.c                         | 1 +
 arch/x86/events/intel/uncore_nhmex.c                             | 1 +
 arch/x86/events/intel/uncore_snb.c                               | 1 +
 arch/x86/events/intel/uncore_snbep.c                             | 1 +
 arch/x86/events/msr.c                                            | 2 ++
 arch/x86/events/perf_event.h                                     | 1 +
 arch/x86/events/probe.c                                          | 2 ++
 arch/x86/events/rapl.c                                           | 1 +
 arch/x86/events/utils.c                                          | 1 +
 arch/x86/events/zhaoxin/core.c                                   | 1 +
 arch/x86/hyperv/hv_apic.c                                        | 1 +
 arch/x86/hyperv/hv_init.c                                        | 1 +
 arch/x86/hyperv/hv_spinlock.c                                    | 1 +
 arch/x86/hyperv/hv_vtl.c                                         | 1 +
 arch/x86/hyperv/ivm.c                                            | 1 +
 arch/x86/include/asm/fred.h                                      | 1 +
 arch/x86/include/asm/kvm_host.h                                  | 1 +
 arch/x86/include/asm/microcode.h                                 | 2 ++
 arch/x86/include/asm/mshyperv.h                                  | 1 +
 arch/x86/include/asm/msr.h                                       | 1 +
 arch/x86/include/asm/resctrl.h                                   | 2 ++
 arch/x86/include/asm/suspend_32.h                                | 1 +
 arch/x86/include/asm/suspend_64.h                                | 1 +
 arch/x86/include/asm/switch_to.h                                 | 2 ++
 arch/x86/kernel/acpi/sleep.c                                     | 1 +
 arch/x86/kernel/apic/apic.c                                      | 1 +
 arch/x86/kernel/apic/apic_numachip.c                             | 1 +
 arch/x86/kernel/cet.c                                            | 1 +
 arch/x86/kernel/cpu/amd.c                                        | 1 +
 arch/x86/kernel/cpu/aperfmperf.c                                 | 1 +
 arch/x86/kernel/cpu/bus_lock.c                                   | 1 +
 arch/x86/kernel/cpu/feat_ctl.c                                   | 1 +
 arch/x86/kernel/cpu/hygon.c                                      | 1 +
 arch/x86/kernel/cpu/mce/inject.c                                 | 1 +
 arch/x86/kernel/cpu/microcode/core.c                             | 1 +
 arch/x86/kernel/cpu/mshyperv.c                                   | 1 +
 arch/x86/kernel/cpu/resctrl/core.c                               | 1 +
 arch/x86/kernel/cpu/resctrl/monitor.c                            | 1 +
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c                        | 1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c                           | 1 +
 arch/x86/kernel/cpu/sgx/main.c                                   | 1 +
 arch/x86/kernel/cpu/topology.c                                   | 1 +
 arch/x86/kernel/cpu/topology_amd.c                               | 1 +
 arch/x86/kernel/cpu/tsx.c                                        | 1 +
 arch/x86/kernel/cpu/zhaoxin.c                                    | 1 +
 arch/x86/kernel/fpu/core.c                                       | 1 +
 arch/x86/kernel/fpu/xstate.c                                     | 1 +
 arch/x86/kernel/fpu/xstate.h                                     | 1 +
 arch/x86/kernel/fred.c                                           | 1 +
 arch/x86/kernel/hpet.c                                           | 1 +
 arch/x86/kernel/kvm.c                                            | 1 +
 arch/x86/kernel/paravirt.c                                       | 1 +
 arch/x86/kernel/process.c                                        | 1 +
 arch/x86/kernel/process_64.c                                     | 1 +
 arch/x86/kernel/trace_clock.c                                    | 2 +-
 arch/x86/kernel/traps.c                                          | 1 +
 arch/x86/kernel/tsc.c                                            | 1 +
 arch/x86/kernel/tsc_sync.c                                       | 1 +
 arch/x86/kvm/svm/avic.c                                          | 1 +
 arch/x86/kvm/svm/sev.c                                           | 1 +
 arch/x86/kvm/svm/svm.c                                           | 1 +
 arch/x86/kvm/vmx/nested.c                                        | 1 +
 arch/x86/kvm/vmx/pmu_intel.c                                     | 1 +
 arch/x86/kvm/vmx/sgx.c                                           | 1 +
 arch/x86/kvm/vmx/vmx.c                                           | 1 +
 arch/x86/lib/insn-eval.c                                         | 1 +
 arch/x86/lib/kaslr.c                                             | 2 +-
 arch/x86/mm/tlb.c                                                | 1 +
 arch/x86/pci/mmconfig-shared.c                                   | 3 ++-
 arch/x86/power/cpu.c                                             | 1 +
 arch/x86/realmode/init.c                                         | 1 +
 arch/x86/virt/svm/sev.c                                          | 1 +
 arch/x86/xen/enlighten_pv.c                                      | 1 +
 arch/x86/xen/pmu.c                                               | 1 +
 arch/x86/xen/suspend.c                                           | 1 +
 drivers/accel/habanalabs/common/habanalabs_ioctl.c               | 2 --
 drivers/acpi/acpi_extlog.c                                       | 1 +
 drivers/acpi/processor_perflib.c                                 | 1 +
 drivers/acpi/processor_throttling.c                              | 6 +++++-
 drivers/char/agp/nvidia-agp.c                                    | 1 +
 drivers/cpufreq/amd-pstate-ut.c                                  | 2 ++
 drivers/cpufreq/elanfreq.c                                       | 1 -
 drivers/cpufreq/sc520_freq.c                                     | 1 -
 drivers/crypto/ccp/sev-dev.c                                     | 1 +
 drivers/edac/ie31200_edac.c                                      | 1 +
 drivers/edac/mce_amd.c                                           | 1 +
 drivers/hwmon/hwmon-vid.c                                        | 4 ++++
 drivers/idle/intel_idle.c                                        | 1 +
 drivers/misc/cs5535-mfgpt.c                                      | 1 +
 drivers/net/vmxnet3/vmxnet3_drv.c                                | 4 ++++
 drivers/platform/x86/intel/ifs/core.c                            | 1 +
 drivers/platform/x86/intel/ifs/load.c                            | 1 +
 drivers/platform/x86/intel/ifs/runtest.c                         | 1 +
 drivers/platform/x86/intel/pmc/cnp.c                             | 1 +
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c      | 1 +
 drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c    | 1 +
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c      | 1 +
 drivers/platform/x86/intel/turbo_max_3.c                         | 1 +
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c   | 1 +
 drivers/powercap/intel_rapl_common.c                             | 1 +
 drivers/powercap/intel_rapl_msr.c                                | 1 +
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.c | 1 +
 drivers/thermal/intel/intel_tcc_cooling.c                        | 1 +
 drivers/thermal/intel/x86_pkg_temp_thermal.c                     | 1 +
 drivers/video/fbdev/geode/display_gx.c                           | 1 +
 drivers/video/fbdev/geode/gxfb_core.c                            | 1 +
 drivers/video/fbdev/geode/lxfb_ops.c                             | 1 +
 123 files changed, 138 insertions(+), 8 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index b18a33f..85b16a0 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -43,6 +43,7 @@
 #include <asm/apic.h>
 #include <asm/cpuid.h>
 #include <asm/cmdline.h>
+#include <asm/msr.h>
=20
 #define DR7_RESET_VALUE        0x400
=20
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index cb62b6d..79e8453 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -9,6 +9,7 @@
 #include <linux/jiffies.h>
 #include <asm/apicdef.h>
 #include <asm/apic.h>
+#include <asm/msr.h>
 #include <asm/nmi.h>
=20
 #include "../perf_event.h"
diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 82fa755..2087792 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -15,6 +15,7 @@
 #include <linux/sched/clock.h>
=20
 #include <asm/apic.h>
+#include <asm/msr.h>
=20
 #include "../perf_event.h"
=20
diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index f8228d8..a721da9 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -16,6 +16,8 @@
 #include <linux/slab.h>
 #include <linux/amd-iommu.h>
=20
+#include <asm/msr.h>
+
 #include "../perf_event.h"
 #include "iommu.h"
=20
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 1988519..d24da37 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/perf_event.h>
+#include <asm/msr.h>
 #include <asm/perf_event.h>
=20
 #include "../perf_event.h"
diff --git a/arch/x86/events/amd/power.c b/arch/x86/events/amd/power.c
index 598a727..dad4279 100644
--- a/arch/x86/events/amd/power.c
+++ b/arch/x86/events/amd/power.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/perf_event.h>
 #include <asm/cpu_device_id.h>
+#include <asm/msr.h>
 #include "../perf_event.h"
=20
 /* Event code: LSB 8 bits, passed in attr->config any other bit is reserved.=
 */
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 64943e5..7cfd376 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -32,6 +32,7 @@
=20
 #include <asm/apic.h>
 #include <asm/stacktrace.h>
+#include <asm/msr.h>
 #include <asm/nmi.h>
 #include <asm/smp.h>
 #include <asm/alternative.h>
diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index a95e6c9..ca9f574 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -17,6 +17,7 @@
=20
 #include <linux/sizes.h>
 #include <asm/perf_event.h>
+#include <asm/msr.h>
=20
 #include "../perf_event.h"
=20
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 9ef3577..3d80ffb 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -23,6 +23,7 @@
 #include <asm/intel_pt.h>
 #include <asm/apic.h>
 #include <asm/cpu_device_id.h>
+#include <asm/msr.h>
=20
 #include "../perf_event.h"
=20
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 56b1c39..ec753e3 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -111,6 +111,7 @@
 #include <linux/nospec.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
+#include <asm/msr.h>
 #include "../perf_event.h"
 #include "../probe.h"
=20
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index b6b486d..00a0a85 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -10,6 +10,7 @@
 #include <asm/tlbflush.h>
 #include <asm/insn.h>
 #include <asm/io.h>
+#include <asm/msr.h>
 #include <asm/timer.h>
=20
 #include "../perf_event.h"
diff --git a/arch/x86/events/intel/knc.c b/arch/x86/events/intel/knc.c
index 425f6e6..38904a5 100644
--- a/arch/x86/events/intel/knc.c
+++ b/arch/x86/events/intel/knc.c
@@ -5,6 +5,7 @@
 #include <linux/types.h>
=20
 #include <asm/hardirq.h>
+#include <asm/msr.h>
=20
 #include "../perf_event.h"
=20
diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index 24d811a..aa52021 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -13,6 +13,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/hardirq.h>
 #include <asm/apic.h>
+#include <asm/msr.h>
=20
 #include "../perf_event.h"
=20
diff --git a/arch/x86/events/intel/p6.c b/arch/x86/events/intel/p6.c
index 35917a7..6e41de3 100644
--- a/arch/x86/events/intel/p6.c
+++ b/arch/x86/events/intel/p6.c
@@ -3,6 +3,7 @@
 #include <linux/types.h>
=20
 #include <asm/cpu_device_id.h>
+#include <asm/msr.h>
=20
 #include "../perf_event.h"
=20
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index d579f10..f37cce2 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -24,6 +24,7 @@
 #include <asm/io.h>
 #include <asm/intel_pt.h>
 #include <asm/cpu_device_id.h>
+#include <asm/msr.h>
=20
 #include "../perf_event.h"
 #include "pt.h"
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index d607052..c24d219 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -3,6 +3,7 @@
=20
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
+#include <asm/msr.h>
 #include "uncore.h"
 #include "uncore_discovery.h"
=20
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel=
/uncore_discovery.c
index 4fc3eec..18a3022 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -5,6 +5,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
=20
+#include <asm/msr.h>
 #include "uncore.h"
 #include "uncore_discovery.h"
=20
diff --git a/arch/x86/events/intel/uncore_nhmex.c b/arch/x86/events/intel/unc=
ore_nhmex.c
index bef9c78..8962e7c 100644
--- a/arch/x86/events/intel/uncore_nhmex.c
+++ b/arch/x86/events/intel/uncore_nhmex.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Nehalem-EX/Westmere-EX uncore support */
 #include <asm/cpu_device_id.h>
+#include <asm/msr.h>
 #include "uncore.h"
=20
 /* NHM-EX event control */
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncor=
e_snb.c
index afc8ef0..a1a9683 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Nehalem/SandBridge/Haswell/Broadwell/Skylake uncore support */
+#include <asm/msr.h>
 #include "uncore.h"
 #include "uncore_discovery.h"
=20
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/unc=
ore_snbep.c
index a330053..2824dc9 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* SandyBridge-EP/IvyTown uncore support */
 #include <asm/cpu_device_id.h>
+#include <asm/msr.h>
 #include "uncore.h"
 #include "uncore_discovery.h"
=20
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 8970ece..7f5007a 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -3,6 +3,8 @@
 #include <linux/sysfs.h>
 #include <linux/nospec.h>
 #include <asm/cpu_device_id.h>
+#include <asm/msr.h>
+
 #include "probe.h"
=20
 enum perf_msr_id {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a5166fa..a8d4e82 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -17,6 +17,7 @@
 #include <asm/fpu/xstate.h>
 #include <asm/intel_ds.h>
 #include <asm/cpu.h>
+#include <asm/msr.h>
=20
 /* To enable MSR tracing please use the generic trace points. */
=20
diff --git a/arch/x86/events/probe.c b/arch/x86/events/probe.c
index fda35cf..bb719d0 100644
--- a/arch/x86/events/probe.c
+++ b/arch/x86/events/probe.c
@@ -2,6 +2,8 @@
 #include <linux/export.h>
 #include <linux/types.h>
 #include <linux/bits.h>
+
+#include <asm/msr.h>
 #include "probe.h"
=20
 static umode_t
diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 7ff52c2..defd861 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -65,6 +65,7 @@
 #include <linux/nospec.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
+#include <asm/msr.h>
 #include "perf_event.h"
 #include "probe.h"
=20
diff --git a/arch/x86/events/utils.c b/arch/x86/events/utils.c
index dab4ed1..77fd00b 100644
--- a/arch/x86/events/utils.c
+++ b/arch/x86/events/utils.c
@@ -2,6 +2,7 @@
 #include <asm/insn.h>
 #include <linux/mm.h>
=20
+#include <asm/msr.h>
 #include "perf_event.h"
=20
 static int decode_branch_type(struct insn *insn)
diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index e299364..91443ab 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -15,6 +15,7 @@
 #include <asm/cpufeature.h>
 #include <asm/hardirq.h>
 #include <asm/apic.h>
+#include <asm/msr.h>
=20
 #include "../perf_event.h"
=20
diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index c450e67..a079a14 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -28,6 +28,7 @@
 #include <asm/hypervisor.h>
 #include <asm/mshyperv.h>
 #include <asm/apic.h>
+#include <asm/msr.h>
=20
 #include <asm/trace/hyperv.h>
=20
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index ed89867..5d27194 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -21,6 +21,7 @@
 #include <asm/hypervisor.h>
 #include <hyperv/hvhdk.h>
 #include <asm/mshyperv.h>
+#include <asm/msr.h>
 #include <asm/idtentry.h>
 #include <asm/set_memory.h>
 #include <linux/kexec.h>
diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
index 626f6d4..81b0066 100644
--- a/arch/x86/hyperv/hv_spinlock.c
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -15,6 +15,7 @@
 #include <asm/mshyperv.h>
 #include <asm/paravirt.h>
 #include <asm/apic.h>
+#include <asm/msr.h>
=20
 static bool hv_pvspin __initdata =3D true;
=20
diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 13242ed..079b276 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -11,6 +11,7 @@
 #include <asm/desc.h>
 #include <asm/i8259.h>
 #include <asm/mshyperv.h>
+#include <asm/msr.h>
 #include <asm/realmode.h>
 #include <asm/reboot.h>
 #include <../kernel/smpboot.h>
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 1b8a241..8209de7 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -22,6 +22,7 @@
 #include <asm/realmode.h>
 #include <asm/e820/api.h>
 #include <asm/desc.h>
+#include <asm/msr.h>
 #include <uapi/asm/vmx.h>
=20
 #ifdef CONFIG_AMD_MEM_ENCRYPT
diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
index 2a29e52..12b34d5 100644
--- a/arch/x86/include/asm/fred.h
+++ b/arch/x86/include/asm/fred.h
@@ -9,6 +9,7 @@
 #include <linux/const.h>
=20
 #include <asm/asm.h>
+#include <asm/msr.h>
 #include <asm/trapnr.h>
=20
 /*
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3131abc..9c971f8 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -34,6 +34,7 @@
 #include <asm/desc.h>
 #include <asm/mtrr.h>
 #include <asm/msr-index.h>
+#include <asm/msr.h>
 #include <asm/asm.h>
 #include <asm/irq_remapping.h>
 #include <asm/kvm_page_track.h>
diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcod=
e.h
index 263ea3d..107a1aa 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_MICROCODE_H
 #define _ASM_X86_MICROCODE_H
=20
+#include <asm/msr.h>
+
 struct cpu_signature {
 	unsigned int sig;
 	unsigned int pf;
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index bab5ccf..15d00da 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -8,6 +8,7 @@
 #include <linux/io.h>
 #include <asm/nospec-branch.h>
 #include <asm/paravirt.h>
+#include <asm/msr.h>
 #include <hyperv/hvhdk.h>
=20
 /*
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 856d660..35a78d2 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -12,6 +12,7 @@
 #include <uapi/asm/msr.h>
 #include <asm/shared/msr.h>
=20
+#include <linux/types.h>
 #include <linux/percpu.h>
=20
 struct msr_info {
diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 011bf67..bd6afe8 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -9,6 +9,8 @@
 #include <linux/resctrl_types.h>
 #include <linux/sched.h>
=20
+#include <asm/msr.h>
+
 /*
  * This value can never be a valid CLOSID, and is used when mapping a
  * (closid, rmid) pair to an index and back. On x86 only the RMID is
diff --git a/arch/x86/include/asm/suspend_32.h b/arch/x86/include/asm/suspend=
_32.h
index d8416b3..e8e5aab 100644
--- a/arch/x86/include/asm/suspend_32.h
+++ b/arch/x86/include/asm/suspend_32.h
@@ -9,6 +9,7 @@
=20
 #include <asm/desc.h>
 #include <asm/fpu/api.h>
+#include <asm/msr.h>
=20
 /* image of the saved processor state */
 struct saved_context {
diff --git a/arch/x86/include/asm/suspend_64.h b/arch/x86/include/asm/suspend=
_64.h
index 54df066..b512f96 100644
--- a/arch/x86/include/asm/suspend_64.h
+++ b/arch/x86/include/asm/suspend_64.h
@@ -9,6 +9,7 @@
=20
 #include <asm/desc.h>
 #include <asm/fpu/api.h>
+#include <asm/msr.h>
=20
 /*
  * Image of the saved processor state, used by the low level ACPI suspend to
diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_t=
o.h
index 7524854..4f21df7 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -52,6 +52,8 @@ do {									\
 } while (0)
=20
 #ifdef CONFIG_X86_32
+#include <asm/msr.h>
+
 static inline void refresh_sysenter_cs(struct thread_struct *thread)
 {
 	/* Only happens when SEP is enabled, no need to test "SEP"arately: */
diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 6dfecb2..91fa262 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -16,6 +16,7 @@
 #include <asm/cacheflush.h>
 #include <asm/realmode.h>
 #include <asm/hypervisor.h>
+#include <asm/msr.h>
 #include <asm/smp.h>
=20
 #include <linux/ftrace.h>
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index a05871c..d73ba5a 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -59,6 +59,7 @@
 #include <asm/time.h>
 #include <asm/smp.h>
 #include <asm/mce.h>
+#include <asm/msr.h>
 #include <asm/tsc.h>
 #include <asm/hypervisor.h>
 #include <asm/cpu_device_id.h>
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic=
_numachip.c
index fcfef70..e272bc7 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/pgtable.h>
=20
+#include <asm/msr.h>
 #include <asm/numachip/numachip.h>
 #include <asm/numachip/numachip_csr.h>
=20
diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
index d897aad..9944440 100644
--- a/arch/x86/kernel/cet.c
+++ b/arch/x86/kernel/cet.c
@@ -2,6 +2,7 @@
=20
 #include <linux/ptrace.h>
 #include <asm/bugs.h>
+#include <asm/msr.h>
 #include <asm/traps.h>
=20
 enum cp_error_code {
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 1f7925e..e153cd1 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -21,6 +21,7 @@
 #include <asm/delay.h>
 #include <asm/debugreg.h>
 #include <asm/resctrl.h>
+#include <asm/msr.h>
 #include <asm/sev.h>
=20
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmper=
f.c
index e99892a..a315b06 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -20,6 +20,7 @@
 #include <asm/cpu.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
+#include <asm/msr.h>
=20
 #include "cpu.h"
=20
diff --git a/arch/x86/kernel/cpu/bus_lock.c b/arch/x86/kernel/cpu/bus_lock.c
index a18d0f2..981f8b1 100644
--- a/arch/x86/kernel/cpu/bus_lock.c
+++ b/arch/x86/kernel/cpu/bus_lock.c
@@ -10,6 +10,7 @@
 #include <asm/cmdline.h>
 #include <asm/traps.h>
 #include <asm/cpu.h>
+#include <asm/msr.h>
=20
 enum split_lock_detect_state {
 	sld_off =3D 0,
diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index 4411748..d697572 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -4,6 +4,7 @@
 #include <asm/cpu.h>
 #include <asm/cpufeature.h>
 #include <asm/msr-index.h>
+#include <asm/msr.h>
 #include <asm/processor.h>
 #include <asm/vmx.h>
=20
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index 21541e3..2154f12 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -15,6 +15,7 @@
 #include <asm/cacheinfo.h>
 #include <asm/spec-ctrl.h>
 #include <asm/delay.h>
+#include <asm/msr.h>
=20
 #include "cpu.h"
=20
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/injec=
t.c
index 338aeee..e13f533 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -28,6 +28,7 @@
 #include <asm/apic.h>
 #include <asm/irq_vectors.h>
 #include <asm/mce.h>
+#include <asm/msr.h>
 #include <asm/nmi.h>
 #include <asm/smp.h>
=20
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/micro=
code/core.c
index b3658d1..793e292 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -37,6 +37,7 @@
 #include <asm/perf_event.h>
 #include <asm/processor.h>
 #include <asm/cmdline.h>
+#include <asm/msr.h>
 #include <asm/setup.h>
=20
 #include "internal.h"
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index b924bef..c78f860 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -30,6 +30,7 @@
 #include <asm/reboot.h>
 #include <asm/nmi.h>
 #include <clocksource/hyperv_timer.h>
+#include <asm/msr.h>
 #include <asm/numa.h>
 #include <asm/svm.h>
=20
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index 280d690..d987b11 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -22,6 +22,7 @@
 #include <linux/cpuhotplug.h>
=20
 #include <asm/cpu_device_id.h>
+#include <asm/msr.h>
 #include <asm/resctrl.h>
 #include "internal.h"
=20
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resc=
trl/monitor.c
index f73a749..591b0b4 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
=20
 #include <asm/cpu_device_id.h>
+#include <asm/msr.h>
 #include <asm/resctrl.h>
=20
 #include "internal.h"
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/=
resctrl/pseudo_lock.c
index 2a82eb6..26c354b 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -25,6 +25,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/resctrl.h>
 #include <asm/perf_event.h>
+#include <asm/msr.h>
=20
 #include "../../events/perf_event.h" /* For X86_CONFIG() */
 #include "internal.h"
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/res=
ctrl/rdtgroup.c
index f4a2ee2..f724b8f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -28,6 +28,7 @@
=20
 #include <uapi/linux/magic.h>
=20
+#include <asm/msr.h>
 #include <asm/resctrl.h>
 #include "internal.h"
=20
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 40967d8..6722b2f 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/vmalloc.h>
+#include <asm/msr.h>
 #include <asm/sgx.h>
 #include "driver.h"
 #include "encl.h"
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 6e1885d..e35ccdc 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -30,6 +30,7 @@
 #include <asm/hypervisor.h>
 #include <asm/io_apic.h>
 #include <asm/mpspec.h>
+#include <asm/msr.h>
 #include <asm/smp.h>
=20
 #include "cpu.h"
diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topolog=
y_amd.c
index 535dcf5..f78d385 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -3,6 +3,7 @@
=20
 #include <asm/apic.h>
 #include <asm/memtype.h>
+#include <asm/msr.h>
 #include <asm/processor.h>
=20
 #include "cpu.h"
diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
index b0a9c9e..4978272 100644
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -12,6 +12,7 @@
=20
 #include <asm/cmdline.h>
 #include <asm/cpu.h>
+#include <asm/msr.h>
=20
 #include "cpu.h"
=20
diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
index 90eba7e..89b1c8a 100644
--- a/arch/x86/kernel/cpu/zhaoxin.c
+++ b/arch/x86/kernel/cpu/zhaoxin.c
@@ -4,6 +4,7 @@
=20
 #include <asm/cpu.h>
 #include <asm/cpufeature.h>
+#include <asm/msr.h>
=20
 #include "cpu.h"
=20
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 985dfff..e92d273 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -11,6 +11,7 @@
 #include <asm/fpu/sched.h>
 #include <asm/fpu/signal.h>
 #include <asm/fpu/types.h>
+#include <asm/msr.h>
 #include <asm/traps.h>
 #include <asm/irq_regs.h>
=20
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 2bd87b7..86d690a 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -21,6 +21,7 @@
 #include <asm/fpu/xcr.h>
=20
 #include <asm/cpuid.h>
+#include <asm/msr.h>
 #include <asm/tlbflush.h>
 #include <asm/prctl.h>
 #include <asm/elf.h>
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 5e5d350..f705bd3 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -5,6 +5,7 @@
 #include <asm/cpufeature.h>
 #include <asm/fpu/xstate.h>
 #include <asm/fpu/xcr.h>
+#include <asm/msr.h>
=20
 #ifdef CONFIG_X86_64
 DECLARE_PER_CPU(u64, xfd_state);
diff --git a/arch/x86/kernel/fred.c b/arch/x86/kernel/fred.c
index 10b0169..816187d 100644
--- a/arch/x86/kernel/fred.c
+++ b/arch/x86/kernel/fred.c
@@ -3,6 +3,7 @@
=20
 #include <asm/desc.h>
 #include <asm/fred.h>
+#include <asm/msr.h>
 #include <asm/tlbflush.h>
 #include <asm/traps.h>
=20
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index cc5d122..c9982a7 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -12,6 +12,7 @@
 #include <asm/hpet.h>
 #include <asm/time.h>
 #include <asm/mwait.h>
+#include <asm/msr.h>
=20
 #undef  pr_fmt
 #define pr_fmt(fmt) "hpet: " fmt
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 44a45df..27f7192 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -40,6 +40,7 @@
 #include <asm/mtrr.h>
 #include <asm/tlb.h>
 #include <asm/cpuidle_haltpoll.h>
+#include <asm/msr.h>
 #include <asm/ptrace.h>
 #include <asm/reboot.h>
 #include <asm/svm.h>
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 1ccd05d..015bf29 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -33,6 +33,7 @@
 #include <asm/tlb.h>
 #include <asm/io_bitmap.h>
 #include <asm/gsseg.h>
+#include <asm/msr.h>
=20
 /* stub always returning 0. */
 DEFINE_ASM_FUNC(paravirt_ret0, "xor %eax,%eax", .entry.text);
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index c168f99..bd50249 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -52,6 +52,7 @@
 #include <asm/unwind.h>
 #include <asm/tdx.h>
 #include <asm/mmu_context.h>
+#include <asm/msr.h>
 #include <asm/shstk.h>
=20
 #include "process.h"
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 24e1ccf..cfa9c03 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -57,6 +57,7 @@
 #include <asm/unistd.h>
 #include <asm/fsgsbase.h>
 #include <asm/fred.h>
+#include <asm/msr.h>
 #ifdef CONFIG_IA32_EMULATION
 /* Not included via unistd.h */
 #include <asm/unistd_32_ia32.h>
diff --git a/arch/x86/kernel/trace_clock.c b/arch/x86/kernel/trace_clock.c
index b8e7abe..708d617 100644
--- a/arch/x86/kernel/trace_clock.c
+++ b/arch/x86/kernel/trace_clock.c
@@ -4,7 +4,7 @@
  */
 #include <asm/trace_clock.h>
 #include <asm/barrier.h>
-#include <asm/msr.h>
+#include <asm/tsc.h>
=20
 /*
  * trace_clock_x86_tsc(): A clock that is just the cycle counter.
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 823410a..ca43eb5 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -68,6 +68,7 @@
 #include <asm/vdso.h>
 #include <asm/tdx.h>
 #include <asm/cfi.h>
+#include <asm/msr.h>
=20
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 160fef7..5d3a764 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -29,6 +29,7 @@
 #include <asm/apic.h>
 #include <asm/cpu_device_id.h>
 #include <asm/i8259.h>
+#include <asm/msr.h>
 #include <asm/topology.h>
 #include <asm/uv/uv.h>
 #include <asm/sev.h>
diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index f1c7a86..ec3aa34 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/smp.h>
 #include <linux/nmi.h>
+#include <asm/msr.h>
 #include <asm/tsc.h>
=20
 struct tsc_adjust {
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index d0f28f6..067f8e3 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -20,6 +20,7 @@
 #include <linux/kvm_host.h>
=20
 #include <asm/irq_remapping.h>
+#include <asm/msr.h>
=20
 #include "trace.h"
 #include "lapic.h"
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index a4aabd6..4b607cc 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -26,6 +26,7 @@
 #include <asm/fpu/xcr.h>
 #include <asm/fpu/xstate.h>
 #include <asm/debugreg.h>
+#include <asm/msr.h>
 #include <asm/sev.h>
=20
 #include "mmu.h"
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 67657b3..c23f620 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -31,6 +31,7 @@
 #include <linux/string_choices.h>
=20
 #include <asm/apic.h>
+#include <asm/msr.h>
 #include <asm/perf_event.h>
 #include <asm/tlbflush.h>
 #include <asm/desc.h>
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index a7fea62..d268224 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6,6 +6,7 @@
=20
 #include <asm/debugreg.h>
 #include <asm/mmu_context.h>
+#include <asm/msr.h>
=20
 #include "x86.h"
 #include "cpuid.h"
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 5e0bb82..231a963 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -13,6 +13,7 @@
 #include <linux/types.h>
 #include <linux/kvm_host.h>
 #include <linux/perf_event.h>
+#include <asm/msr.h>
 #include <asm/perf_event.h>
 #include "x86.h"
 #include "cpuid.h"
diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
index 9498642..df1d0cf 100644
--- a/arch/x86/kvm/vmx/sgx.c
+++ b/arch/x86/kvm/vmx/sgx.c
@@ -2,6 +2,7 @@
 /*  Copyright(c) 2021 Intel Corporation. */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
=20
+#include <asm/msr.h>
 #include <asm/sgx.h>
=20
 #include "x86.h"
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index cd0d6c1..d8412cf 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -46,6 +46,7 @@
 #include <asm/perf_event.h>
 #include <asm/mmu_context.h>
 #include <asm/mshyperv.h>
+#include <asm/msr.h>
 #include <asm/mwait.h>
 #include <asm/spec-ctrl.h>
 #include <asm/vmx.h>
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index da5af3c..dbe0fbf 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -13,6 +13,7 @@
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/ldt.h>
+#include <asm/msr.h>
 #include <asm/vm86.h>
=20
 #undef pr_fmt
diff --git a/arch/x86/lib/kaslr.c b/arch/x86/lib/kaslr.c
index a58f451..b589392 100644
--- a/arch/x86/lib/kaslr.c
+++ b/arch/x86/lib/kaslr.c
@@ -8,7 +8,7 @@
  */
 #include <asm/asm.h>
 #include <asm/kaslr.h>
-#include <asm/msr.h>
+#include <asm/tsc.h>
 #include <asm/archrandom.h>
 #include <asm/e820/api.h>
 #include <asm/shared/io.h>
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 7c35b50..33645dd 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -19,6 +19,7 @@
 #include <asm/cache.h>
 #include <asm/cacheflush.h>
 #include <asm/apic.h>
+#include <asm/msr.h>
 #include <asm/perf_event.h>
 #include <asm/tlb.h>
=20
diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 39255f0..1f45223 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -22,9 +22,10 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/rculist.h>
+#include <asm/acpi.h>
 #include <asm/e820/api.h>
+#include <asm/msr.h>
 #include <asm/pci_x86.h>
-#include <asm/acpi.h>
=20
 /* Indicate if the ECAM resources have been placed into the resource table */
 static bool pci_mmcfg_running_state;
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index d5a7b3b..916441f 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -27,6 +27,7 @@
 #include <asm/mmu_context.h>
 #include <asm/cpu_device_id.h>
 #include <asm/microcode.h>
+#include <asm/msr.h>
 #include <asm/fred.h>
=20
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 263787b..ed5c63c 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -9,6 +9,7 @@
 #include <asm/realmode.h>
 #include <asm/tlbflush.h>
 #include <asm/crash.h>
+#include <asm/msr.h>
 #include <asm/sev.h>
=20
 struct real_mode_header *real_mode_header;
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 334177c..76926f7 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -30,6 +30,7 @@
 #include <asm/cpuid.h>
 #include <asm/cmdline.h>
 #include <asm/iommu.h>
+#include <asm/msr.h>
=20
 /*
  * The RMP entry information as returned by the RMPREAD instruction.
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 846b573..8ddd9e5 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -61,6 +61,7 @@
 #include <asm/processor.h>
 #include <asm/proto.h>
 #include <asm/msr-index.h>
+#include <asm/msr.h>
 #include <asm/traps.h>
 #include <asm/setup.h>
 #include <asm/desc.h>
diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
index f06987b..3cb566d 100644
--- a/arch/x86/xen/pmu.c
+++ b/arch/x86/xen/pmu.c
@@ -2,6 +2,7 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
=20
+#include <asm/msr.h>
 #include <asm/xen/hypercall.h>
 #include <xen/xen.h>
 #include <xen/page.h>
diff --git a/arch/x86/xen/suspend.c b/arch/x86/xen/suspend.c
index 7bb3ac2..ba2f17e 100644
--- a/arch/x86/xen/suspend.c
+++ b/arch/x86/xen/suspend.c
@@ -13,6 +13,7 @@
 #include <asm/xen/hypercall.h>
 #include <asm/xen/page.h>
 #include <asm/fixmap.h>
+#include <asm/msr.h>
=20
 #include "xen-ops.h"
=20
diff --git a/drivers/accel/habanalabs/common/habanalabs_ioctl.c b/drivers/acc=
el/habanalabs/common/habanalabs_ioctl.c
index 8729a0c..dc80ca9 100644
--- a/drivers/accel/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/accel/habanalabs/common/habanalabs_ioctl.c
@@ -17,8 +17,6 @@
 #include <linux/uaccess.h>
 #include <linux/vmalloc.h>
=20
-#include <asm/msr.h>
-
 /* make sure there is space for all the signed info */
 static_assert(sizeof(struct cpucp_info) <=3D SEC_DEV_INFO_BUF_SZ);
=20
diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 8465822..f6b9562 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -15,6 +15,7 @@
 #include <acpi/ghes.h>
 #include <asm/cpu.h>
 #include <asm/mce.h>
+#include <asm/msr.h>
=20
 #include "apei/apei-internal.h"
 #include <ras/ras_event.h>
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perfli=
b.c
index 53996f1..64b8d1e 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -20,6 +20,7 @@
 #include <acpi/processor.h>
 #ifdef CONFIG_X86
 #include <asm/cpufeature.h>
+#include <asm/msr.h>
 #endif
=20
 #define ACPI_PROCESSOR_FILE_PERFORMANCE	"performance"
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_thr=
ottling.c
index 00d045e..ecd7fe2 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -18,9 +18,13 @@
 #include <linux/sched.h>
 #include <linux/cpufreq.h>
 #include <linux/acpi.h>
+#include <linux/uaccess.h>
 #include <acpi/processor.h>
 #include <asm/io.h>
-#include <linux/uaccess.h>
+#include <asm/asm.h>
+#ifdef CONFIG_X86
+#include <asm/msr.h>
+#endif
=20
 /* ignore_tpc:
  *  0 -> acpi processor driver doesn't ignore _TPC values
diff --git a/drivers/char/agp/nvidia-agp.c b/drivers/char/agp/nvidia-agp.c
index e424360..4787391 100644
--- a/drivers/char/agp/nvidia-agp.c
+++ b/drivers/char/agp/nvidia-agp.c
@@ -11,6 +11,7 @@
 #include <linux/page-flags.h>
 #include <linux/mm.h>
 #include <linux/jiffies.h>
+#include <asm/msr.h>
 #include "agp.h"
=20
 /* NVIDIA registers */
diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 707fa81..c8d031b 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -31,6 +31,8 @@
=20
 #include <acpi/cppc_acpi.h>
=20
+#include <asm/msr.h>
+
 #include "amd-pstate.h"
=20
=20
diff --git a/drivers/cpufreq/elanfreq.c b/drivers/cpufreq/elanfreq.c
index 36494b8..fc5a580 100644
--- a/drivers/cpufreq/elanfreq.c
+++ b/drivers/cpufreq/elanfreq.c
@@ -21,7 +21,6 @@
 #include <linux/cpufreq.h>
=20
 #include <asm/cpu_device_id.h>
-#include <asm/msr.h>
 #include <linux/timex.h>
 #include <linux/io.h>
=20
diff --git a/drivers/cpufreq/sc520_freq.c b/drivers/cpufreq/sc520_freq.c
index 103d251..b360f03 100644
--- a/drivers/cpufreq/sc520_freq.c
+++ b/drivers/cpufreq/sc520_freq.c
@@ -21,7 +21,6 @@
 #include <linux/io.h>
=20
 #include <asm/cpu_device_id.h>
-#include <asm/msr.h>
=20
 #define MMCR_BASE	0xfffef000	/* The default base address */
 #define OFFS_CPUCTL	0x2   /* CPU Control Register */
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index bb8a25e..ec8b37a 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -33,6 +33,7 @@
 #include <asm/cacheflush.h>
 #include <asm/e820/types.h>
 #include <asm/sev.h>
+#include <asm/msr.h>
=20
 #include "psp-dev.h"
 #include "sev-dev.h"
diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 2048341..5ddd83d 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -52,6 +52,7 @@
=20
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <asm/mce.h>
+#include <asm/msr.h>
 #include "edac_module.h"
=20
 #define EDAC_MOD_STR "ie31200_edac"
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 50d74d3..af3c122 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -3,6 +3,7 @@
 #include <linux/slab.h>
=20
 #include <asm/cpu.h>
+#include <asm/msr.h>
=20
 #include "mce_amd.h"
=20
diff --git a/drivers/hwmon/hwmon-vid.c b/drivers/hwmon/hwmon-vid.c
index 6d1175a..2df4956 100644
--- a/drivers/hwmon/hwmon-vid.c
+++ b/drivers/hwmon/hwmon-vid.c
@@ -15,6 +15,10 @@
 #include <linux/kernel.h>
 #include <linux/hwmon-vid.h>
=20
+#ifdef CONFIG_X86
+#include <asm/msr.h>
+#endif
+
 /*
  * Common code for decoding VID pins.
  *
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 517b28a..6a1712b 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -56,6 +56,7 @@
 #include <asm/intel-family.h>
 #include <asm/mwait.h>
 #include <asm/spec-ctrl.h>
+#include <asm/msr.h>
 #include <asm/tsc.h>
 #include <asm/fpu/api.h>
 #include <asm/smp.h>
diff --git a/drivers/misc/cs5535-mfgpt.c b/drivers/misc/cs5535-mfgpt.c
index 18fc1aa..2b6778d 100644
--- a/drivers/misc/cs5535-mfgpt.c
+++ b/drivers/misc/cs5535-mfgpt.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/cs5535.h>
 #include <linux/slab.h>
+#include <asm/msr.h>
=20
 #define DRV_NAME "cs5535-mfgpt"
=20
diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_=
drv.c
index 3df6aab..7edd0b5 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -27,6 +27,10 @@
 #include <linux/module.h>
 #include <net/ip6_checksum.h>
=20
+#ifdef CONFIG_X86
+#include <asm/msr.h>
+#endif
+
 #include "vmxnet3_int.h"
 #include "vmxnet3_xdp.h"
=20
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/int=
el/ifs/core.c
index c4328a7..b73e582 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
=20
 #include <asm/cpu_device_id.h>
+#include <asm/msr.h>
=20
 #include "ifs.h"
=20
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/int=
el/ifs/load.c
index 0289391..50f1fdf 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -5,6 +5,7 @@
 #include <linux/sizes.h>
 #include <asm/cpu.h>
 #include <asm/microcode.h>
+#include <asm/msr.h>
=20
 #include "ifs.h"
=20
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/=
intel/ifs/runtest.c
index 6b6ed7b..dfc119d 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -7,6 +7,7 @@
 #include <linux/nmi.h>
 #include <linux/slab.h>
 #include <linux/stop_machine.h>
+#include <asm/msr.h>
=20
 #include "ifs.h"
=20
diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/inte=
l/pmc/cnp.c
index 547bdf1..efea4e1 100644
--- a/drivers/platform/x86/intel/pmc/cnp.c
+++ b/drivers/platform/x86/intel/pmc/cnp.c
@@ -10,6 +10,7 @@
=20
 #include <linux/smp.h>
 #include <linux/suspend.h>
+#include <asm/msr.h>
 #include "core.h"
=20
 /* Cannon Lake: PGD PFET Enable Ack Status Register(s) bitmap */
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/dr=
ivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 44dcd16..8a57135 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -21,6 +21,7 @@
=20
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
+#include <asm/msr.h>
=20
 #include "isst_if_common.h"
=20
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c b/=
drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
index 78989f6..22745b2 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_mbox_msr.c
@@ -18,6 +18,7 @@
 #include <uapi/linux/isst_if.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
+#include <asm/msr.h>
=20
 #include "isst_if_common.h"
=20
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/dr=
ivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 0b8ef0c..4d30d53 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -27,6 +27,7 @@
 #include <linux/kernel.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
+#include <asm/msr.h>
 #include <uapi/linux/isst_if.h>
=20
 #include "isst_tpmi_core.h"
diff --git a/drivers/platform/x86/intel/turbo_max_3.c b/drivers/platform/x86/=
intel/turbo_max_3.c
index 7e538bb..b5af3e9 100644
--- a/drivers/platform/x86/intel/turbo_max_3.c
+++ b/drivers/platform/x86/intel/turbo_max_3.c
@@ -17,6 +17,7 @@
=20
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
+#include <asm/msr.h>
=20
 #define MSR_OC_MAILBOX			0x150
 #define MSR_OC_MAILBOX_CMD_OFFSET	32
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c b=
/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
index 6f87376..96f854c 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
@@ -21,6 +21,7 @@
 #include <linux/suspend.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
+#include <asm/msr.h>
=20
 #include "uncore-frequency-common.h"
=20
diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_ra=
pl_common.c
index 5ab3feb..e3be40a 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -28,6 +28,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/iosf_mbi.h>
+#include <asm/msr.h>
=20
 /* bitmasks for RAPL MSRs, used by primitive access functions */
 #define ENERGY_STATUS_MASK      0xffffffff
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_=
msr.c
index 6d5853d..8ad2115 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -24,6 +24,7 @@
=20
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
+#include <asm/msr.h>
=20
 /* Local defines */
 #define MSR_PLATFORM_POWER_LIMIT	0x0000065C
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c=
 b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index b024946..57cf46f 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/thermal.h>
+#include <asm/msr.h>
 #include "int340x_thermal_zone.h"
 #include "processor_thermal_device.h"
 #include "../intel_soc_dts_iosf.h"
diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/inte=
l/intel_tcc_cooling.c
index 0394897..f352eca 100644
--- a/drivers/thermal/intel/intel_tcc_cooling.c
+++ b/drivers/thermal/intel/intel_tcc_cooling.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/thermal.h>
 #include <asm/cpu_device_id.h>
+#include <asm/msr.h>
=20
 #define TCC_PROGRAMMABLE	BIT(30)
 #define TCC_LOCKED		BIT(31)
diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/i=
ntel/x86_pkg_temp_thermal.c
index 496abf8..4894a26 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -20,6 +20,7 @@
 #include <linux/debugfs.h>
=20
 #include <asm/cpu_device_id.h>
+#include <asm/msr.h>
=20
 #include "thermal_interrupt.h"
=20
diff --git a/drivers/video/fbdev/geode/display_gx.c b/drivers/video/fbdev/geo=
de/display_gx.c
index b5f25df..099322c 100644
--- a/drivers/video/fbdev/geode/display_gx.c
+++ b/drivers/video/fbdev/geode/display_gx.c
@@ -13,6 +13,7 @@
 #include <asm/io.h>
 #include <asm/div64.h>
 #include <asm/delay.h>
+#include <asm/msr.h>
 #include <linux/cs5535.h>
=20
 #include "gxfb.h"
diff --git a/drivers/video/fbdev/geode/gxfb_core.c b/drivers/video/fbdev/geod=
e/gxfb_core.c
index 2b27d65..8d69be7 100644
--- a/drivers/video/fbdev/geode/gxfb_core.c
+++ b/drivers/video/fbdev/geode/gxfb_core.c
@@ -29,6 +29,7 @@
 #include <linux/pci.h>
 #include <linux/cs5535.h>
=20
+#include <asm/msr.h>
 #include <asm/olpc.h>
=20
 #include "gxfb.h"
diff --git a/drivers/video/fbdev/geode/lxfb_ops.c b/drivers/video/fbdev/geode=
/lxfb_ops.c
index a27531b..2e33da9 100644
--- a/drivers/video/fbdev/geode/lxfb_ops.c
+++ b/drivers/video/fbdev/geode/lxfb_ops.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 #include <linux/cs5535.h>
=20
+#include <asm/msr.h>
 #include "lxfb.h"
=20
 /* TODO

