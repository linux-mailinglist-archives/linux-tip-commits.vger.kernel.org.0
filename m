Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4119513A9EE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Jan 2020 14:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgANNCb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Jan 2020 08:02:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43162 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbgANNCa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Jan 2020 08:02:30 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irLpw-0004eL-3k; Tue, 14 Jan 2020 14:02:24 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B0E0D1C07EC;
        Tue, 14 Jan 2020 14:02:16 +0100 (CET)
Date:   Tue, 14 Jan 2020 13:02:16 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] lib/vdso: Prepare for time namespace support
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191112012724.250792-21-dima@arista.com>
References: <20191112012724.250792-21-dima@arista.com>
MIME-Version: 1.0
Message-ID: <157900693651.396.8969796045884740782.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     660fd04f9317172ae90f414c68b18a26ae88a829
Gitweb:        https://git.kernel.org/tip/660fd04f9317172ae90f414c68b18a26ae88a829
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 12 Nov 2019 01:27:09 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 14 Jan 2020 12:20:57 +01:00

lib/vdso: Prepare for time namespace support

To support time namespaces in the vdso with a minimal impact on regular non
time namespace affected tasks, the namespace handling needs to be hidden in
a slow path.

The most obvious place is vdso_seq_begin(). If a task belongs to a time
namespace then the VVAR page which contains the system wide vdso data is
replaced with a namespace specific page which has the same layout as the
VVAR page. That page has vdso_data->seq set to 1 to enforce the slow path
and vdso_data->clock_mode set to VCLOCK_TIMENS to enforce the time
namespace handling path.

The extra check in the case that vdso_data->seq is odd, e.g. a concurrent
update of the vdso data is in progress, is not really affecting regular
tasks which are not part of a time namespace as the task is spin waiting
for the update to finish and vdso_data->seq to become even again.

If a time namespace task hits that code path, it invokes the corresponding
time getter function which retrieves the real VVAR page, reads host time
and then adds the offset for the requested clock which is stored in the
special VVAR page.

If VDSO time namespace support is disabled the whole magic is compiled out.

Initial testing shows that the disabled case is almost identical to the
host case which does not take the slow timens path. With the special timens
page installed the performance hit is constant time and in the range of
5-7%.

For the vdso functions which are not using the sequence count an
unconditional check for vdso_data->clock_mode is added which switches to
the real vdso when the clock_mode is VCLOCK_TIMENS.

[avagin: Make do_hres_timens() work with raw clocks too: choose vdso_data
 pointer by CS_RAW offset.]

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20191112012724.250792-21-dima@arista.com


---
 include/linux/time.h    |   6 ++-
 include/vdso/datapage.h |  19 ++++-
 init/Kconfig            |   1 +-
 lib/vdso/Kconfig        |   6 ++-
 lib/vdso/gettimeofday.c | 142 +++++++++++++++++++++++++++++++++++++--
 5 files changed, 169 insertions(+), 5 deletions(-)

diff --git a/include/linux/time.h b/include/linux/time.h
index 8e10b9d..8ef5e5c 100644
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -110,4 +110,10 @@ static inline bool itimerspec64_valid(const struct itimerspec64 *its)
  * Equivalent to !(time_before32(@t, @l) || time_after32(@t, @h)).
  */
 #define time_between32(t, l, h) ((u32)(h) - (u32)(l) >= (u32)(t) - (u32)(l))
+
+struct timens_offset {
+	s64	sec;
+	u64	nsec;
+};
+
 #endif
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 2e302c0..c5f347c 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -21,6 +21,8 @@
 #define CS_RAW		1
 #define CS_BASES	(CS_RAW + 1)
 
+#define VCLOCK_TIMENS	UINT_MAX
+
 /**
  * struct vdso_timestamp - basetime per clock_id
  * @sec:	seconds
@@ -48,6 +50,7 @@ struct vdso_timestamp {
  * @mult:		clocksource multiplier
  * @shift:		clocksource shift
  * @basetime[clock_id]:	basetime per clock_id
+ * @offset[clock_id]:	time namespace offset per clock_id
  * @tz_minuteswest:	minutes west of Greenwich
  * @tz_dsttime:		type of DST correction
  * @hrtimer_res:	hrtimer resolution
@@ -55,6 +58,17 @@ struct vdso_timestamp {
  *
  * vdso_data will be accessed by 64 bit and compat code at the same time
  * so we should be careful before modifying this structure.
+ *
+ * @basetime is used to store the base time for the system wide time getter
+ * VVAR page.
+ *
+ * @offset is used by the special time namespace VVAR pages which are
+ * installed instead of the real VVAR page. These namespace pages must set
+ * @seq to 1 and @clock_mode to VLOCK_TIMENS to force the code into the
+ * time namespace slow path. The namespace aware functions retrieve the
+ * real system wide VVAR page, read host time and add the per clock offset.
+ * For clocks which are not affected by time namespace adjustment the
+ * offset must be zero.
  */
 struct vdso_data {
 	u32			seq;
@@ -65,7 +79,10 @@ struct vdso_data {
 	u32			mult;
 	u32			shift;
 
-	struct vdso_timestamp	basetime[VDSO_BASES];
+	union {
+		struct vdso_timestamp	basetime[VDSO_BASES];
+		struct timens_offset	offset[VDSO_BASES];
+	};
 
 	s32			tz_minuteswest;
 	s32			tz_dsttime;
diff --git a/init/Kconfig b/init/Kconfig
index b34314f..9b7f144 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1082,6 +1082,7 @@ config UTS_NS
 
 config TIME_NS
 	bool "TIME namespace"
+	depends on GENERIC_VDSO_TIME_NS
 	default y
 	help
 	  In this namespace boottime and monotonic clocks can be set.
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index 9fe698f..d883ac2 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -24,4 +24,10 @@ config GENERIC_COMPAT_VDSO
 	help
 	  This config option enables the compat VDSO layer.
 
+config GENERIC_VDSO_TIME_NS
+	bool
+	help
+	  Selected by architectures which support time namespaces in the
+	  VDSO
+
 endif
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index b453d24..f342ac1 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -38,15 +38,89 @@ u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
 }
 #endif
 
+#ifdef CONFIG_TIME_NS
+static int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
+			  struct __kernel_timespec *ts)
+{
+	const struct vdso_data *vd = __arch_get_timens_vdso_data();
+	const struct timens_offset *offs = &vdns->offset[clk];
+	const struct vdso_timestamp *vdso_ts;
+	u64 cycles, last, ns;
+	u32 seq;
+	s64 sec;
+
+	if (clk != CLOCK_MONOTONIC_RAW)
+		vd = &vd[CS_HRES_COARSE];
+	else
+		vd = &vd[CS_RAW];
+	vdso_ts = &vd->basetime[clk];
+
+	do {
+		seq = vdso_read_begin(vd);
+		cycles = __arch_get_hw_counter(vd->clock_mode);
+		ns = vdso_ts->nsec;
+		last = vd->cycle_last;
+		if (unlikely((s64)cycles < 0))
+			return -1;
+
+		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
+		ns >>= vd->shift;
+		sec = vdso_ts->sec;
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	/* Add the namespace offset */
+	sec += offs->sec;
+	ns += offs->nsec;
+
+	/*
+	 * Do this outside the loop: a race inside the loop could result
+	 * in __iter_div_u64_rem() being extremely slow.
+	 */
+	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
+
+	return 0;
+}
+#else
+static __always_inline const struct vdso_data *__arch_get_timens_vdso_data(void)
+{
+	return NULL;
+}
+
+static int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
+			  struct __kernel_timespec *ts)
+{
+	return -EINVAL;
+}
+#endif
+
 static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
-		   struct __kernel_timespec *ts)
+				   struct __kernel_timespec *ts)
 {
 	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
 	u64 cycles, last, sec, ns;
 	u32 seq;
 
 	do {
-		seq = vdso_read_begin(vd);
+		/*
+		 * Open coded to handle VCLOCK_TIMENS. Time namespace
+		 * enabled tasks have a special VVAR page installed which
+		 * has vd->seq set to 1 and vd->clock_mode set to
+		 * VCLOCK_TIMENS. For non time namespace affected tasks
+		 * this does not affect performance because if vd->seq is
+		 * odd, i.e. a concurrent update is in progress the extra
+		 * check for vd->clock_mode is just a few extra
+		 * instructions while spin waiting for vd->seq to become
+		 * even again.
+		 */
+		while (unlikely((seq = READ_ONCE(vd->seq)) & 1)) {
+			if (IS_ENABLED(CONFIG_TIME_NS) &&
+			    vd->clock_mode == VCLOCK_TIMENS)
+				return do_hres_timens(vd, clk, ts);
+			cpu_relax();
+		}
+		smp_rmb();
+
 		cycles = __arch_get_hw_counter(vd->clock_mode);
 		ns = vdso_ts->nsec;
 		last = vd->cycle_last;
@@ -68,6 +142,43 @@ static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
 	return 0;
 }
 
+#ifdef CONFIG_TIME_NS
+static int do_coarse_timens(const struct vdso_data *vdns, clockid_t clk,
+			    struct __kernel_timespec *ts)
+{
+	const struct vdso_data *vd = __arch_get_timens_vdso_data();
+	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
+	const struct timens_offset *offs = &vdns->offset[clk];
+	u64 nsec;
+	s64 sec;
+	s32 seq;
+
+	do {
+		seq = vdso_read_begin(vd);
+		sec = vdso_ts->sec;
+		nsec = vdso_ts->nsec;
+	} while (unlikely(vdso_read_retry(vd, seq)));
+
+	/* Add the namespace offset */
+	sec += offs->sec;
+	nsec += offs->nsec;
+
+	/*
+	 * Do this outside the loop: a race inside the loop could result
+	 * in __iter_div_u64_rem() being extremely slow.
+	 */
+	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
+	ts->tv_nsec = nsec;
+	return 0;
+}
+#else
+static int do_coarse_timens(const struct vdso_data *vdns, clockid_t clk,
+			    struct __kernel_timespec *ts)
+{
+	return -1;
+}
+#endif
+
 static __always_inline int do_coarse(const struct vdso_data *vd, clockid_t clk,
 				     struct __kernel_timespec *ts)
 {
@@ -75,7 +186,18 @@ static __always_inline int do_coarse(const struct vdso_data *vd, clockid_t clk,
 	u32 seq;
 
 	do {
-		seq = vdso_read_begin(vd);
+		/*
+		 * Open coded to handle VCLOCK_TIMENS. See comment in
+		 * do_hres().
+		 */
+		while ((seq = READ_ONCE(vd->seq)) & 1) {
+			if (IS_ENABLED(CONFIG_TIME_NS) &&
+			    vd->clock_mode == VCLOCK_TIMENS)
+				return do_coarse_timens(vd, clk, ts);
+			cpu_relax();
+		}
+		smp_rmb();
+
 		ts->tv_sec = vdso_ts->sec;
 		ts->tv_nsec = vdso_ts->nsec;
 	} while (unlikely(vdso_read_retry(vd, seq)));
@@ -156,6 +278,10 @@ __cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 	}
 
 	if (unlikely(tz != NULL)) {
+		if (IS_ENABLED(CONFIG_TIME_NS) &&
+		    vd->clock_mode == VCLOCK_TIMENS)
+			vd = __arch_get_timens_vdso_data();
+
 		tz->tz_minuteswest = vd[CS_HRES_COARSE].tz_minuteswest;
 		tz->tz_dsttime = vd[CS_HRES_COARSE].tz_dsttime;
 	}
@@ -167,7 +293,12 @@ __cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 static __maybe_unused __kernel_old_time_t __cvdso_time(__kernel_old_time_t *time)
 {
 	const struct vdso_data *vd = __arch_get_vdso_data();
-	__kernel_old_time_t t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
+	__kernel_old_time_t t;
+
+	if (IS_ENABLED(CONFIG_TIME_NS) && vd->clock_mode == VCLOCK_TIMENS)
+		vd = __arch_get_timens_vdso_data();
+
+	t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
 
 	if (time)
 		*time = t;
@@ -189,6 +320,9 @@ int __cvdso_clock_getres_common(clockid_t clock, struct __kernel_timespec *res)
 	if (unlikely((u32) clock >= MAX_CLOCKS))
 		return -1;
 
+	if (IS_ENABLED(CONFIG_TIME_NS) && vd->clock_mode == VCLOCK_TIMENS)
+		vd = __arch_get_timens_vdso_data();
+
 	hrtimer_res = READ_ONCE(vd[CS_HRES_COARSE].hrtimer_res);
 	/*
 	 * Convert the clockid to a bitmask and use it to check which
