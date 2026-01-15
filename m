Return-Path: <linux-tip-commits+bounces-8016-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CECE9D28CD9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 22:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB29C3011446
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 21:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D92A329E61;
	Thu, 15 Jan 2026 21:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TLGQh5vR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qwoHZX9n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4F730DEDC;
	Thu, 15 Jan 2026 21:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513445; cv=none; b=ABNbdrR/Fkz92Ljwg0JwlZoM02lYiSWcgcwoQjs4op+qnXlFnpguxGPjkrFHUmkazk0pT5FUMovA4OWkar7sp2UpuZlflWXV21u8Z1f7eGDhTQ9ZC02f/6WICYHWb/L6S6SDvdTlvHbMRu26c95fd9GAPcx2GXCHGFiMIdCVe2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513445; c=relaxed/simple;
	bh=UMrFgNvwkWrehBWBd/DDWMMIQsGSS5sKAg/B6qvqCQk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gxLzsmbIfOH9+4Hj3wOte7isqs1kQWnYVgNuaQST65KtKIcF5YHyjpGoFM48vKMpUbPYV/uv1oLmxCHSVJxrnfC7fMnIhnFRcughSbFIMIiYcWgHnsA1vah8pOFwKi5m9wdX21WPSgknFE4nj9ZPY6nhIlEyYOTX5J1A19mshew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TLGQh5vR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qwoHZX9n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Jan 2026 21:44:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768513442;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2o4x30d2i6Lb1LiqT6WgXqDaxUIUVjfiaMmNEi83kM=;
	b=TLGQh5vRdjYjpvN+aSCBeHk01rCgDGNs5zbeT1shfaGU+Ahm1O8OFFLetSiC+dXTtK432O
	rNMdE9iA+eRvmkBfKfYxY9nNF0ORbTbWPPEfM9q7KG/r0OkYMiTGRZGKY4LTCR6KTjO9AE
	IiRgMOr/YGif+eP4KJnZdCq6nDNz9Xsca5KRl3QIKl7bvEgJ6kZ6VGvVb99HGYgZ6UcDVO
	14dGrP2wuNc0xSkVuUsBmZ4YcELf+n6iX7okEF3V/sgeG9V3eCBKK9pjWsp0Lkasfkm+EN
	Cqnk+Ktk7PkE1vGFSJhsT4ZWSmpW5rGMJL61AGgqDxJSJZ/Qi5qnVeoTiwkbRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768513442;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2o4x30d2i6Lb1LiqT6WgXqDaxUIUVjfiaMmNEi83kM=;
	b=qwoHZX9n6S8PnPK1DDbNmqhsT/v12qY91C1gQhUcv5sC1XoDh8gaEHmFLChZ4ov0nHKNMD
	n9X/tdw+1D5xuzDA==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel: Add support for rdpmc user disable feature
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260114011750.350569-8-dapeng1.mi@linux.intel.com>
References: <20260114011750.350569-8-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176851344112.510.12053920619762009719.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     59af95e028d4114991b9bd96a39ad855b399cc07
Gitweb:        https://git.kernel.org/tip/59af95e028d4114991b9bd96a39ad855b39=
9cc07
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 14 Jan 2026 09:17:50 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Jan 2026 10:04:28 +01:00

perf/x86/intel: Add support for rdpmc user disable feature

Starting with Panther Cove, the rdpmc user disable feature is supported.
This feature allows the perf system to disable user space rdpmc reads at
the counter level.

Currently, when a global counter is active, any user with rdpmc rights
can read it, even if perf access permissions forbid it (e.g., disallow
reading ring 0 counters). The rdpmc user disable feature mitigates this
security concern.

Details:

- A new RDPMC_USR_DISABLE bit (bit 37) in each EVNTSELx MSR indicates
  that the GP counter cannot be read by RDPMC in ring 3.
- New RDPMC_USR_DISABLE bits in IA32_FIXED_CTR_CTRL MSR (bits 33, 37,
  41, 45, etc.) for fixed counters 0, 1, 2, 3, etc.
- When calling rdpmc instruction for counter x, the following pseudo
  code demonstrates how the counter value is obtained:
  	If (!CPL0 && RDPMC_USR_DISABLE[x] =3D=3D 1) ? 0 : counter_value;
- RDPMC_USR_DISABLE is enumerated by CPUID.0x23.0.EBX[2].

This patch extends the current global user space rdpmc control logic via
the sysfs interface (/sys/devices/cpu/rdpmc) as follows:

- rdpmc =3D 0:
  Global user space rdpmc and counter-level user space rdpmc for all
  counters are both disabled.
- rdpmc =3D 1:
  Global user space rdpmc is enabled during the mmap-enabled time window,
  and counter-level user space rdpmc is enabled only for non-system-wide
  events. This prevents counter data leaks as count data is cleared
  during context switches.
- rdpmc =3D 2:
  Global user space rdpmc and counter-level user space rdpmc for all
  counters are enabled unconditionally.

The new rdpmc settings only affect newly activated perf events; currently
active perf events remain unaffected. This simplifies and cleans up the
code. The default value of rdpmc remains unchanged at 1.

For more details about rdpmc user disable, please refer to chapter 15
"RDPMC USER DISABLE" in ISE documentation.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260114011750.350569-8-dapeng1.mi@linux.intel=
.com
---
 Documentation/ABI/testing/sysfs-bus-event_source-devices-rdpmc | 44 +++++++-
 arch/x86/events/core.c                                         | 21 +++-
 arch/x86/events/intel/core.c                                   | 27 ++++-
 arch/x86/events/perf_event.h                                   |  6 +-
 arch/x86/include/asm/perf_event.h                              |  8 +-
 5 files changed, 104 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-=
rdpmc

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-rdpmc b=
/Documentation/ABI/testing/sysfs-bus-event_source-devices-rdpmc
new file mode 100644
index 0000000..59ec18b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-rdpmc
@@ -0,0 +1,44 @@
+What:           /sys/bus/event_source/devices/cpu.../rdpmc
+Date:           November 2011
+KernelVersion:  3.10
+Contact:        Linux kernel mailing list linux-kernel@vger.kernel.org
+Description:    The /sys/bus/event_source/devices/cpu.../rdpmc attribute
+                is used to show/manage if rdpmc instruction can be
+                executed in user space. This attribute supports 3 numbers.
+                - rdpmc =3D 0
+                user space rdpmc is globally disabled for all PMU
+                counters.
+                - rdpmc =3D 1
+                user space rdpmc is globally enabled only in event mmap
+                ioctl called time window. If the mmap region is unmapped,
+                user space rdpmc is disabled again.
+                - rdpmc =3D 2
+                user space rdpmc is globally enabled for all PMU
+                counters.
+
+                In the Intel platforms supporting counter level's user
+                space rdpmc disable feature (CPUID.23H.EBX[2] =3D 1), the
+                meaning of 3 numbers is extended to
+                - rdpmc =3D 0
+                global user space rdpmc and counter level's user space
+                rdpmc of all counters are both disabled.
+                - rdpmc =3D 1
+                No changes on behavior of global user space rdpmc.
+                counter level's rdpmc of system-wide events is disabled
+                but counter level's rdpmc of non-system-wide events is
+                enabled.
+                - rdpmc =3D 2
+                global user space rdpmc and counter level's user space
+                rdpmc of all counters are both enabled unconditionally.
+
+                The default value of rdpmc is 1.
+
+                Please notice:
+                - global user space rdpmc's behavior would change
+                immediately along with the rdpmc value's change,
+                but the behavior of counter level's user space rdpmc
+                won't take effect immediately until the event is
+                reactivated or recreated.
+                - The rdpmc attribute is global, even for x86 hybrid
+                platforms. For example, changing cpu_core/rdpmc will
+                also change cpu_atom/rdpmc.
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index c2717cb..6df73e8 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2616,6 +2616,27 @@ static ssize_t get_attr_rdpmc(struct device *cdev,
 	return snprintf(buf, 40, "%d\n", x86_pmu.attr_rdpmc);
 }
=20
+/*
+ * Behaviors of rdpmc value:
+ * - rdpmc =3D 0
+ *    global user space rdpmc and counter level's user space rdpmc of all
+ *    counters are both disabled.
+ * - rdpmc =3D 1
+ *    global user space rdpmc is enabled in mmap enabled time window and
+ *    counter level's user space rdpmc is enabled for only non system-wide
+ *    events. Counter level's user space rdpmc of system-wide events is
+ *    still disabled by default. This won't introduce counter data leak for
+ *    non system-wide events since their count data would be cleared when
+ *    context switches.
+ * - rdpmc =3D 2
+ *    global user space rdpmc and counter level's user space rdpmc of all
+ *    counters are enabled unconditionally.
+ *
+ * Suppose the rdpmc value won't be changed frequently, don't dynamically
+ * reschedule events to make the new rpdmc value take effect on active perf
+ * events immediately, the new rdpmc value would only impact the new
+ * activated perf events. This makes code simpler and cleaner.
+ */
 static ssize_t set_attr_rdpmc(struct device *cdev,
 			      struct device_attribute *attr,
 			      const char *buf, size_t count)
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index d6bdbb7..f3ae1f8 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3128,6 +3128,8 @@ static void intel_pmu_enable_fixed(struct perf_event *e=
vent)
 		bits |=3D INTEL_FIXED_0_USER;
 	if (hwc->config & ARCH_PERFMON_EVENTSEL_OS)
 		bits |=3D INTEL_FIXED_0_KERNEL;
+	if (hwc->config & ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE)
+		bits |=3D INTEL_FIXED_0_RDPMC_USER_DISABLE;
=20
 	/*
 	 * ANY bit is supported in v3 and up
@@ -3263,6 +3265,27 @@ static void intel_pmu_enable_event_ext(struct perf_eve=
nt *event)
 		__intel_pmu_update_event_ext(hwc->idx, ext);
 }
=20
+static void intel_pmu_update_rdpmc_user_disable(struct perf_event *event)
+{
+	if (!x86_pmu_has_rdpmc_user_disable(event->pmu))
+		return;
+
+	/*
+	 * Counter scope's user-space rdpmc is disabled by default
+	 * except two cases.
+	 * a. rdpmc =3D 2 (user space rdpmc enabled unconditionally)
+	 * b. rdpmc =3D 1 and the event is not a system-wide event.
+	 *    The count of non-system-wide events would be cleared when
+	 *    context switches, so no count data is leaked.
+	 */
+	if (x86_pmu.attr_rdpmc =3D=3D X86_USER_RDPMC_ALWAYS_ENABLE ||
+	    (x86_pmu.attr_rdpmc =3D=3D X86_USER_RDPMC_CONDITIONAL_ENABLE &&
+	     event->ctx->task))
+		event->hw.config &=3D ~ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE;
+	else
+		event->hw.config |=3D ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE;
+}
+
 DEFINE_STATIC_CALL_NULL(intel_pmu_enable_event_ext, intel_pmu_enable_event_e=
xt);
=20
 static void intel_pmu_enable_event(struct perf_event *event)
@@ -3271,6 +3294,8 @@ static void intel_pmu_enable_event(struct perf_event *e=
vent)
 	struct hw_perf_event *hwc =3D &event->hw;
 	int idx =3D hwc->idx;
=20
+	intel_pmu_update_rdpmc_user_disable(event);
+
 	if (unlikely(event->attr.precise_ip))
 		static_call(x86_pmu_pebs_enable)(event);
=20
@@ -5869,6 +5894,8 @@ static void update_pmu_cap(struct pmu *pmu)
 		hybrid(pmu, config_mask) |=3D ARCH_PERFMON_EVENTSEL_UMASK2;
 	if (ebx_0.split.eq)
 		hybrid(pmu, config_mask) |=3D ARCH_PERFMON_EVENTSEL_EQ;
+	if (ebx_0.split.rdpmc_user_disable)
+		hybrid(pmu, config_mask) |=3D ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE;
=20
 	if (eax_0.split.cntr_subleaf) {
 		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 24a81d2..cd337f3 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1333,6 +1333,12 @@ static inline u64 x86_pmu_get_event_config(struct perf=
_event *event)
 	return event->attr.config & hybrid(event->pmu, config_mask);
 }
=20
+static inline bool x86_pmu_has_rdpmc_user_disable(struct pmu *pmu)
+{
+	return !!(hybrid(pmu, config_mask) &
+		 ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE);
+}
+
 extern struct event_constraint emptyconstraint;
=20
 extern struct event_constraint unconstrained;
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_ev=
ent.h
index 0d9af41..ff5acb8 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -33,6 +33,7 @@
 #define ARCH_PERFMON_EVENTSEL_CMASK			0xFF000000ULL
 #define ARCH_PERFMON_EVENTSEL_BR_CNTR			(1ULL << 35)
 #define ARCH_PERFMON_EVENTSEL_EQ			(1ULL << 36)
+#define ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE	(1ULL << 37)
 #define ARCH_PERFMON_EVENTSEL_UMASK2			(0xFFULL << 40)
=20
 #define INTEL_FIXED_BITS_STRIDE			4
@@ -40,6 +41,7 @@
 #define INTEL_FIXED_0_USER				(1ULL << 1)
 #define INTEL_FIXED_0_ANYTHREAD			(1ULL << 2)
 #define INTEL_FIXED_0_ENABLE_PMI			(1ULL << 3)
+#define INTEL_FIXED_0_RDPMC_USER_DISABLE		(1ULL << 33)
 #define INTEL_FIXED_3_METRICS_CLEAR			(1ULL << 2)
=20
 #define HSW_IN_TX					(1ULL << 32)
@@ -50,7 +52,7 @@
 #define INTEL_FIXED_BITS_MASK					\
 	(INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER |		\
 	 INTEL_FIXED_0_ANYTHREAD | INTEL_FIXED_0_ENABLE_PMI |	\
-	 ICL_FIXED_0_ADAPTIVE)
+	 ICL_FIXED_0_ADAPTIVE | INTEL_FIXED_0_RDPMC_USER_DISABLE)
=20
 #define intel_fixed_bits_by_idx(_idx, _bits)			\
 	((_bits) << ((_idx) * INTEL_FIXED_BITS_STRIDE))
@@ -226,7 +228,9 @@ union cpuid35_ebx {
 		unsigned int    umask2:1;
 		/* EQ-bit Supported */
 		unsigned int    eq:1;
-		unsigned int	reserved:30;
+		/* rdpmc user disable Supported */
+		unsigned int    rdpmc_user_disable:1;
+		unsigned int	reserved:29;
 	} split;
 	unsigned int            full;
 };

