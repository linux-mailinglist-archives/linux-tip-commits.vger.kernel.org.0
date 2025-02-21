Return-Path: <linux-tip-commits+bounces-3543-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDA7A3EF5E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 10:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025C016B8F3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 09:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC80E200BB8;
	Fri, 21 Feb 2025 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DWZ3/mSf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mwVICBom"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8815F1DC991;
	Fri, 21 Feb 2025 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128589; cv=none; b=U//KXqurQNPY+exe3p5EXrXEXtENIMrouvLohUnCsnHO+7rC+rrXbyLQts4Ua/5ZL82NzVzNEs1QQnMhm+KXAcbRtI2h7ZM3OOynTvLXmn/XsjGEINfy+FNohk0YXaWqW1bTOmpFpBSMLLAaO/vuuxWNRvMCqvUQ0F1OnoJtkdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128589; c=relaxed/simple;
	bh=i6z7v93C6vcUWB/QciNq9qbVBKTrrbMrLOH4rm2AXaw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rWXBHtRl/ZtgfsqLuWIEjzb8xrNZuZyVmNENfC2zpLQWv7Iu9Thu8KsfL7CjlyV315Uku8gilUvjayxN0pOAk3xfra+7B236zhU0tk4omfCPCJZcFV1dmhjt93F4M9QVuerfBkLp4DELivAs2Or3kTYEBJJ97lorueNeNnkjUL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DWZ3/mSf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mwVICBom; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 09:03:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740128585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ptUhR6WOamnBFxT8bvvgzPnF7nEr6R9JE4q8+Cn/gtE=;
	b=DWZ3/mSfMIR8A4vdbgsJ79v9T3Ku2GWoll8TAGv99IWhuvqq3tiMOhEji+i0qzeL4EzvH7
	yfmWgZ45vKjGM13JDf+aY/QaWohxS8PHadkLj3bOGlJ9cccOrFZ/xhTjao88vYOvKwHa7C
	CRVFFIUC1s4UF4mzgk3ushXnJHyXHybsFnoN0mhsW27s/72QqCPhWzQA6fbMN/83G1GoQv
	lJLfcfZKbb335Q//FXQrcvR7wTvu5OEHJMVWB1alljTm4bou4Lusk0QlxWEnRrxv8OzmUb
	kSj7warB7oqXBmkCjCVFSvQSknPp0uLl2EYVyEmn9FjxTaJ4ffVmJvsvMpOKJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740128585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ptUhR6WOamnBFxT8bvvgzPnF7nEr6R9JE4q8+Cn/gtE=;
	b=mwVICBomW6Z4130r0UGMBN2jZ6KVHzZaMTR+POrj+yvxKzkYOxcOMmTFcfd3EYXgD0CjyO
	rje11yZ8f75z4oBw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso: Remove remnants of architecture-specific
 time storage
Cc: Nam Cao <namcao@linutronix.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250204-vdso-store-rng-v3-18-13a4669dfc8c@linutronix.de>
References: <20250204-vdso-store-rng-v3-18-13a4669dfc8c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174012858488.10177.4935224380992757699.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     ac1a42f4e4e296b5ba5fdb39444f65d6e5196240
Gitweb:        https://git.kernel.org/tip/ac1a42f4e4e296b5ba5fdb39444f65d6e51=
96240
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 04 Feb 2025 13:05:50 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Feb 2025 09:54:03 +01:00

vdso: Remove remnants of architecture-specific time storage

All users of the time releated parts of the vDSO are now using the generic
storage implementation. Remove the therefore unnecessary compatibility
accessor functions and symbols.

Co-developed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250204-vdso-store-rng-v3-18-13a4669dfc8c@=
linutronix.de

---
 include/asm-generic/vdso/vsyscall.h | 20 ++---------
 include/linux/time_namespace.h      |  3 +--
 include/vdso/datapage.h             | 19 +----------
 include/vdso/helpers.h              |  8 ++--
 kernel/time/namespace.c             | 12 +++----
 kernel/time/vsyscall.c              | 19 ++++------
 lib/vdso/datastore.c                | 10 ++---
 lib/vdso/gettimeofday.c             | 51 +++++++++++++---------------
 8 files changed, 53 insertions(+), 89 deletions(-)

diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/v=
syscall.h
index 13e2ac3..1fb3000 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -20,31 +20,19 @@ static __always_inline const struct vdso_rng_data *__arch=
_get_vdso_u_rng_data(vo
 }
 #endif
=20
-#else  /* !CONFIG_GENERIC_VDSO_DATA_STORE */
-
-#ifndef __arch_get_k_vdso_data
-static __always_inline struct vdso_data *__arch_get_k_vdso_data(void)
-{
-	return NULL;
-}
-#endif /* __arch_get_k_vdso_data */
-#define vdso_k_time_data __arch_get_k_vdso_data()
-
-#define __arch_get_vdso_u_time_data __arch_get_vdso_data
-
 #endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
=20
 #ifndef __arch_update_vsyscall
-static __always_inline void __arch_update_vsyscall(struct vdso_data *vdata)
+static __always_inline void __arch_update_vsyscall(struct vdso_time_data *vd=
ata)
 {
 }
 #endif /* __arch_update_vsyscall */
=20
-#ifndef __arch_sync_vdso_data
-static __always_inline void __arch_sync_vdso_data(struct vdso_data *vdata)
+#ifndef __arch_sync_vdso_time_data
+static __always_inline void __arch_sync_vdso_time_data(struct vdso_time_data=
 *vdata)
 {
 }
-#endif /* __arch_sync_vdso_data */
+#endif /* __arch_sync_vdso_time_data */
=20
 #endif /* !__ASSEMBLY__ */
=20
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 4b81db2..0b8b32b 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -8,7 +8,6 @@
 #include <linux/ns_common.h>
 #include <linux/err.h>
 #include <linux/time64.h>
-#include <vdso/datapage.h>
=20
 struct user_namespace;
 extern struct user_namespace init_user_ns;
@@ -166,6 +165,4 @@ static inline ktime_t timens_ktime_to_host(clockid_t cloc=
kid, ktime_t tim)
 }
 #endif
=20
-struct vdso_data *arch_get_vdso_data(void *vvar_page);
-
 #endif /* _LINUX_TIMENS_H */
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 497907c..ed4fb4c 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -128,8 +128,6 @@ struct vdso_time_data {
 	struct arch_vdso_time_data arch_data;
 };
=20
-#define vdso_data vdso_time_data
-
 /**
  * struct vdso_rng_data - vdso RNG state information
  * @generation:	counter representing the number of RNG reseeds
@@ -149,10 +147,7 @@ struct vdso_rng_data {
  * With the hidden visibility, the compiler simply generates a PC-relative
  * relocation, and this is what we need.
  */
-#ifndef CONFIG_GENERIC_VDSO_DATA_STORE
-extern struct vdso_time_data _vdso_data[CS_BASES] __attribute__((visibility(=
"hidden")));
-extern struct vdso_time_data _timens_data[CS_BASES] __attribute__((visibilit=
y("hidden")));
-#else
+#ifdef CONFIG_GENERIC_VDSO_DATA_STORE
 extern struct vdso_time_data vdso_u_time_data[CS_BASES] __attribute__((visib=
ility("hidden")));
 extern struct vdso_rng_data vdso_u_rng_data __attribute__((visibility("hidde=
n")));
 extern struct vdso_arch_data vdso_u_arch_data __attribute__((visibility("hid=
den")));
@@ -160,17 +155,6 @@ extern struct vdso_arch_data vdso_u_arch_data __attribut=
e__((visibility("hidden"
 extern struct vdso_time_data *vdso_k_time_data;
 extern struct vdso_rng_data *vdso_k_rng_data;
 extern struct vdso_arch_data *vdso_k_arch_data;
-#endif
-
-/**
- * union vdso_data_store - Generic vDSO data page
- */
-union vdso_data_store {
-	struct vdso_time_data	data[CS_BASES];
-	u8			page[1U << CONFIG_PAGE_SHIFT];
-};
-
-#ifdef CONFIG_GENERIC_VDSO_DATA_STORE
=20
 #define VDSO_ARCH_DATA_SIZE ALIGN(sizeof(struct vdso_arch_data), PAGE_SIZE)
 #define VDSO_ARCH_DATA_PAGES (VDSO_ARCH_DATA_SIZE >> PAGE_SHIFT)
@@ -189,7 +173,6 @@ enum vdso_pages {
 /*
  * The generic vDSO implementation requires that gettimeofday.h
  * provides:
- * - __arch_get_vdso_data(): to get the vdso datapage.
  * - __arch_get_hw_counter(): to get the hw counter based on the
  *   clock_mode.
  * - gettimeofday_fallback(): fallback for gettimeofday.
diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
index 3ddb03b..41c3087 100644
--- a/include/vdso/helpers.h
+++ b/include/vdso/helpers.h
@@ -7,7 +7,7 @@
 #include <asm/barrier.h>
 #include <vdso/datapage.h>
=20
-static __always_inline u32 vdso_read_begin(const struct vdso_data *vd)
+static __always_inline u32 vdso_read_begin(const struct vdso_time_data *vd)
 {
 	u32 seq;
=20
@@ -18,7 +18,7 @@ static __always_inline u32 vdso_read_begin(const struct vds=
o_data *vd)
 	return seq;
 }
=20
-static __always_inline u32 vdso_read_retry(const struct vdso_data *vd,
+static __always_inline u32 vdso_read_retry(const struct vdso_time_data *vd,
 					   u32 start)
 {
 	u32 seq;
@@ -28,7 +28,7 @@ static __always_inline u32 vdso_read_retry(const struct vds=
o_data *vd,
 	return seq !=3D start;
 }
=20
-static __always_inline void vdso_write_begin(struct vdso_data *vd)
+static __always_inline void vdso_write_begin(struct vdso_time_data *vd)
 {
 	/*
 	 * WRITE_ONCE() is required otherwise the compiler can validly tear
@@ -40,7 +40,7 @@ static __always_inline void vdso_write_begin(struct vdso_da=
ta *vd)
 	smp_wmb();
 }
=20
-static __always_inline void vdso_write_end(struct vdso_data *vd)
+static __always_inline void vdso_write_end(struct vdso_time_data *vd)
 {
 	smp_wmb();
 	/*
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 0775b9e..12f55aa 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -165,18 +165,18 @@ static struct timens_offset offset_from_ts(struct times=
pec64 off)
  *     HVCLOCK
  *     VVAR
  *
- * The check for vdso_data->clock_mode is in the unlikely path of
+ * The check for vdso_time_data->clock_mode is in the unlikely path of
  * the seq begin magic. So for the non-timens case most of the time
  * 'seq' is even, so the branch is not taken.
  *
  * If 'seq' is odd, i.e. a concurrent update is in progress, the extra check
- * for vdso_data->clock_mode is a non-issue. The task is spin waiting for the
+ * for vdso_time_data->clock_mode is a non-issue. The task is spin waiting f=
or the
  * update to finish and for 'seq' to become even anyway.
  *
- * Timens page has vdso_data->clock_mode set to VDSO_CLOCKMODE_TIMENS which
+ * Timens page has vdso_time_data->clock_mode set to VDSO_CLOCKMODE_TIMENS w=
hich
  * enforces the time namespace handling path.
  */
-static void timens_setup_vdso_data(struct vdso_data *vdata,
+static void timens_setup_vdso_data(struct vdso_time_data *vdata,
 				   struct time_namespace *ns)
 {
 	struct timens_offset *offset =3D vdata->offset;
@@ -219,7 +219,7 @@ static DEFINE_MUTEX(offset_lock);
 static void timens_set_vvar_page(struct task_struct *task,
 				struct time_namespace *ns)
 {
-	struct vdso_data *vdata;
+	struct vdso_time_data *vdata;
 	unsigned int i;
=20
 	if (ns =3D=3D &init_time_ns)
@@ -235,7 +235,7 @@ static void timens_set_vvar_page(struct task_struct *task,
 		goto out;
=20
 	ns->frozen_offsets =3D true;
-	vdata =3D arch_get_vdso_data(page_address(ns->vvar_page));
+	vdata =3D page_address(ns->vvar_page);
=20
 	for (i =3D 0; i < CS_BASES; i++)
 		timens_setup_vdso_data(&vdata[i], ns);
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 09c1e39..4181922 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -15,8 +15,7 @@
=20
 #include "timekeeping_internal.h"
=20
-static inline void update_vdso_data(struct vdso_data *vdata,
-				    struct timekeeper *tk)
+static inline void update_vdso_time_data(struct vdso_time_data *vdata, struc=
t timekeeper *tk)
 {
 	struct vdso_timestamp *vdso_ts;
 	u64 nsec, sec;
@@ -77,7 +76,7 @@ static inline void update_vdso_data(struct vdso_data *vdata,
=20
 void update_vsyscall(struct timekeeper *tk)
 {
-	struct vdso_data *vdata =3D vdso_k_time_data;
+	struct vdso_time_data *vdata =3D vdso_k_time_data;
 	struct vdso_timestamp *vdso_ts;
 	s32 clock_mode;
 	u64 nsec;
@@ -117,23 +116,23 @@ void update_vsyscall(struct timekeeper *tk)
 	 * update of the high resolution parts.
 	 */
 	if (clock_mode !=3D VDSO_CLOCKMODE_NONE)
-		update_vdso_data(vdata, tk);
+		update_vdso_time_data(vdata, tk);
=20
 	__arch_update_vsyscall(vdata);
=20
 	vdso_write_end(vdata);
=20
-	__arch_sync_vdso_data(vdata);
+	__arch_sync_vdso_time_data(vdata);
 }
=20
 void update_vsyscall_tz(void)
 {
-	struct vdso_data *vdata =3D vdso_k_time_data;
+	struct vdso_time_data *vdata =3D vdso_k_time_data;
=20
 	vdata[CS_HRES_COARSE].tz_minuteswest =3D sys_tz.tz_minuteswest;
 	vdata[CS_HRES_COARSE].tz_dsttime =3D sys_tz.tz_dsttime;
=20
-	__arch_sync_vdso_data(vdata);
+	__arch_sync_vdso_time_data(vdata);
 }
=20
 /**
@@ -150,7 +149,7 @@ void update_vsyscall_tz(void)
  */
 unsigned long vdso_update_begin(void)
 {
-	struct vdso_data *vdata =3D vdso_k_time_data;
+	struct vdso_time_data *vdata =3D vdso_k_time_data;
 	unsigned long flags =3D timekeeper_lock_irqsave();
=20
 	vdso_write_begin(vdata);
@@ -167,9 +166,9 @@ unsigned long vdso_update_begin(void)
  */
 void vdso_update_end(unsigned long flags)
 {
-	struct vdso_data *vdata =3D vdso_k_time_data;
+	struct vdso_time_data *vdata =3D vdso_k_time_data;
=20
 	vdso_write_end(vdata);
-	__arch_sync_vdso_data(vdata);
+	__arch_sync_vdso_time_data(vdata);
 	timekeeper_unlock_irqrestore(flags);
 }
diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index 0959d62..e227fbb 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -12,7 +12,10 @@
  * The vDSO data page.
  */
 #ifdef CONFIG_HAVE_GENERIC_VDSO
-static union vdso_data_store vdso_time_data_store __page_aligned_data;
+static union {
+	struct vdso_time_data	data[CS_BASES];
+	u8			page[PAGE_SIZE];
+} vdso_time_data_store __page_aligned_data;
 struct vdso_time_data *vdso_k_time_data =3D vdso_time_data_store.data;
 static_assert(sizeof(vdso_time_data_store) =3D=3D PAGE_SIZE);
 #endif /* CONFIG_HAVE_GENERIC_VDSO */
@@ -123,9 +126,4 @@ int vdso_join_timens(struct task_struct *task, struct tim=
e_namespace *ns)
=20
 	return 0;
 }
-
-struct vdso_time_data *arch_get_vdso_data(void *vvar_page)
-{
-	return (struct vdso_time_data *)vvar_page;
-}
 #endif
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 20c5b87..299f027 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -17,12 +17,12 @@
 #endif
=20
 #ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
-static __always_inline bool vdso_delta_ok(const struct vdso_data *vd, u64 de=
lta)
+static __always_inline bool vdso_delta_ok(const struct vdso_time_data *vd, u=
64 delta)
 {
 	return delta < vd->max_cycles;
 }
 #else
-static __always_inline bool vdso_delta_ok(const struct vdso_data *vd, u64 de=
lta)
+static __always_inline bool vdso_delta_ok(const struct vdso_time_data *vd, u=
64 delta)
 {
 	return true;
 }
@@ -39,7 +39,7 @@ static __always_inline u64 vdso_shift_ns(u64 ns, u32 shift)
  * Default implementation which works for all sane clocksources. That
  * obviously excludes x86/TSC.
  */
-static __always_inline u64 vdso_calc_ns(const struct vdso_data *vd, u64 cycl=
es, u64 base)
+static __always_inline u64 vdso_calc_ns(const struct vdso_time_data *vd, u64=
 cycles, u64 base)
 {
 	u64 delta =3D (cycles - vd->cycle_last) & VDSO_DELTA_MASK(vd);
=20
@@ -58,7 +58,7 @@ static inline bool __arch_vdso_hres_capable(void)
 #endif
=20
 #ifndef vdso_clocksource_ok
-static inline bool vdso_clocksource_ok(const struct vdso_data *vd)
+static inline bool vdso_clocksource_ok(const struct vdso_time_data *vd)
 {
 	return vd->clock_mode !=3D VDSO_CLOCKMODE_NONE;
 }
@@ -79,21 +79,20 @@ const struct vdso_time_data *__arch_get_vdso_u_timens_dat=
a(const struct vdso_tim
 {
 	return (void *)vd + PAGE_SIZE;
 }
-#define __arch_get_timens_vdso_data(vd) __arch_get_vdso_u_timens_data(vd)
 #endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
=20
-static __always_inline int do_hres_timens(const struct vdso_data *vdns, cloc=
kid_t clk,
+static __always_inline int do_hres_timens(const struct vdso_time_data *vdns,=
 clockid_t clk,
 					  struct __kernel_timespec *ts)
 {
 	const struct timens_offset *offs =3D &vdns->offset[clk];
 	const struct vdso_timestamp *vdso_ts;
-	const struct vdso_data *vd;
+	const struct vdso_time_data *vd;
 	u64 cycles, ns;
 	u32 seq;
 	s64 sec;
=20
 	vd =3D vdns - (clk =3D=3D CLOCK_MONOTONIC_RAW ? CS_RAW : CS_HRES_COARSE);
-	vd =3D __arch_get_timens_vdso_data(vd);
+	vd =3D __arch_get_vdso_u_timens_data(vd);
 	if (clk !=3D CLOCK_MONOTONIC_RAW)
 		vd =3D &vd[CS_HRES_COARSE];
 	else
@@ -128,19 +127,19 @@ static __always_inline int do_hres_timens(const struct =
vdso_data *vdns, clockid_
 }
 #else
 static __always_inline
-const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *=
vd)
+const struct vdso_time_data *__arch_get_vdso_u_timens_data(const struct vdso=
_time_data *vd)
 {
 	return NULL;
 }
=20
-static __always_inline int do_hres_timens(const struct vdso_data *vdns, cloc=
kid_t clk,
+static __always_inline int do_hres_timens(const struct vdso_time_data *vdns,=
 clockid_t clk,
 					  struct __kernel_timespec *ts)
 {
 	return -EINVAL;
 }
 #endif
=20
-static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
+static __always_inline int do_hres(const struct vdso_time_data *vd, clockid_=
t clk,
 				   struct __kernel_timespec *ts)
 {
 	const struct vdso_timestamp *vdso_ts =3D &vd->basetime[clk];
@@ -192,10 +191,10 @@ static __always_inline int do_hres(const struct vdso_da=
ta *vd, clockid_t clk,
 }
=20
 #ifdef CONFIG_TIME_NS
-static __always_inline int do_coarse_timens(const struct vdso_data *vdns, cl=
ockid_t clk,
+static __always_inline int do_coarse_timens(const struct vdso_time_data *vdn=
s, clockid_t clk,
 					    struct __kernel_timespec *ts)
 {
-	const struct vdso_data *vd =3D __arch_get_timens_vdso_data(vdns);
+	const struct vdso_time_data *vd =3D __arch_get_vdso_u_timens_data(vdns);
 	const struct vdso_timestamp *vdso_ts =3D &vd->basetime[clk];
 	const struct timens_offset *offs =3D &vdns->offset[clk];
 	u64 nsec;
@@ -221,14 +220,14 @@ static __always_inline int do_coarse_timens(const struc=
t vdso_data *vdns, clocki
 	return 0;
 }
 #else
-static __always_inline int do_coarse_timens(const struct vdso_data *vdns, cl=
ockid_t clk,
+static __always_inline int do_coarse_timens(const struct vdso_time_data *vdn=
s, clockid_t clk,
 					    struct __kernel_timespec *ts)
 {
 	return -1;
 }
 #endif
=20
-static __always_inline int do_coarse(const struct vdso_data *vd, clockid_t c=
lk,
+static __always_inline int do_coarse(const struct vdso_time_data *vd, clocki=
d_t clk,
 				     struct __kernel_timespec *ts)
 {
 	const struct vdso_timestamp *vdso_ts =3D &vd->basetime[clk];
@@ -255,7 +254,7 @@ static __always_inline int do_coarse(const struct vdso_da=
ta *vd, clockid_t clk,
 }
=20
 static __always_inline int
-__cvdso_clock_gettime_common(const struct vdso_data *vd, clockid_t clock,
+__cvdso_clock_gettime_common(const struct vdso_time_data *vd, clockid_t cloc=
k,
 			     struct __kernel_timespec *ts)
 {
 	u32 msk;
@@ -282,7 +281,7 @@ __cvdso_clock_gettime_common(const struct vdso_data *vd, =
clockid_t clock,
 }
=20
 static __maybe_unused int
-__cvdso_clock_gettime_data(const struct vdso_data *vd, clockid_t clock,
+__cvdso_clock_gettime_data(const struct vdso_time_data *vd, clockid_t clock,
 			   struct __kernel_timespec *ts)
 {
 	int ret =3D __cvdso_clock_gettime_common(vd, clock, ts);
@@ -300,7 +299,7 @@ __cvdso_clock_gettime(clockid_t clock, struct __kernel_ti=
mespec *ts)
=20
 #ifdef BUILD_VDSO32
 static __maybe_unused int
-__cvdso_clock_gettime32_data(const struct vdso_data *vd, clockid_t clock,
+__cvdso_clock_gettime32_data(const struct vdso_time_data *vd, clockid_t cloc=
k,
 			     struct old_timespec32 *res)
 {
 	struct __kernel_timespec ts;
@@ -326,7 +325,7 @@ __cvdso_clock_gettime32(clockid_t clock, struct old_times=
pec32 *res)
 #endif /* BUILD_VDSO32 */
=20
 static __maybe_unused int
-__cvdso_gettimeofday_data(const struct vdso_data *vd,
+__cvdso_gettimeofday_data(const struct vdso_time_data *vd,
 			  struct __kernel_old_timeval *tv, struct timezone *tz)
 {
=20
@@ -343,7 +342,7 @@ __cvdso_gettimeofday_data(const struct vdso_data *vd,
 	if (unlikely(tz !=3D NULL)) {
 		if (IS_ENABLED(CONFIG_TIME_NS) &&
 		    vd->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
-			vd =3D __arch_get_timens_vdso_data(vd);
+			vd =3D __arch_get_vdso_u_timens_data(vd);
=20
 		tz->tz_minuteswest =3D vd[CS_HRES_COARSE].tz_minuteswest;
 		tz->tz_dsttime =3D vd[CS_HRES_COARSE].tz_dsttime;
@@ -360,13 +359,13 @@ __cvdso_gettimeofday(struct __kernel_old_timeval *tv, s=
truct timezone *tz)
=20
 #ifdef VDSO_HAS_TIME
 static __maybe_unused __kernel_old_time_t
-__cvdso_time_data(const struct vdso_data *vd, __kernel_old_time_t *time)
+__cvdso_time_data(const struct vdso_time_data *vd, __kernel_old_time_t *time)
 {
 	__kernel_old_time_t t;
=20
 	if (IS_ENABLED(CONFIG_TIME_NS) &&
 	    vd->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
-		vd =3D __arch_get_timens_vdso_data(vd);
+		vd =3D __arch_get_vdso_u_timens_data(vd);
=20
 	t =3D READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
=20
@@ -384,7 +383,7 @@ static __maybe_unused __kernel_old_time_t __cvdso_time(__=
kernel_old_time_t *time
=20
 #ifdef VDSO_HAS_CLOCK_GETRES
 static __maybe_unused
-int __cvdso_clock_getres_common(const struct vdso_data *vd, clockid_t clock,
+int __cvdso_clock_getres_common(const struct vdso_time_data *vd, clockid_t c=
lock,
 				struct __kernel_timespec *res)
 {
 	u32 msk;
@@ -396,7 +395,7 @@ int __cvdso_clock_getres_common(const struct vdso_data *v=
d, clockid_t clock,
=20
 	if (IS_ENABLED(CONFIG_TIME_NS) &&
 	    vd->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
-		vd =3D __arch_get_timens_vdso_data(vd);
+		vd =3D __arch_get_vdso_u_timens_data(vd);
=20
 	/*
 	 * Convert the clockid to a bitmask and use it to check which
@@ -425,7 +424,7 @@ int __cvdso_clock_getres_common(const struct vdso_data *v=
d, clockid_t clock,
 }
=20
 static __maybe_unused
-int __cvdso_clock_getres_data(const struct vdso_data *vd, clockid_t clock,
+int __cvdso_clock_getres_data(const struct vdso_time_data *vd, clockid_t clo=
ck,
 			      struct __kernel_timespec *res)
 {
 	int ret =3D __cvdso_clock_getres_common(vd, clock, res);
@@ -443,7 +442,7 @@ int __cvdso_clock_getres(clockid_t clock, struct __kernel=
_timespec *res)
=20
 #ifdef BUILD_VDSO32
 static __maybe_unused int
-__cvdso_clock_getres_time32_data(const struct vdso_data *vd, clockid_t clock,
+__cvdso_clock_getres_time32_data(const struct vdso_time_data *vd, clockid_t =
clock,
 				 struct old_timespec32 *res)
 {
 	struct __kernel_timespec ts;

