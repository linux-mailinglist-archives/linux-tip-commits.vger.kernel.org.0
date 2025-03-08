Return-Path: <linux-tip-commits+bounces-4075-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D94A57A9C
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 14:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD02316D136
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 13:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CF61D5AC3;
	Sat,  8 Mar 2025 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z33uWXnC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K/KknDYj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACA21B0420;
	Sat,  8 Mar 2025 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441501; cv=none; b=ILCowHNhikratNki4Ml1/a+fGmJmVTnd0OLRp0XRLExjXVnCaCpVFawPByMKcsOwBNqPcOaENw+SMaa0HVv4P8nKFHOswQzRefrvrc6r8sFkaGEx70GBxU+02DbZTFpxgqoeuP8mA+nQXR9TStzNfSnK0EoCn3z0MEXyByPIibk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441501; c=relaxed/simple;
	bh=RldzaNX3dV50LprPR6YNc/V1B/q2RCLguNql7WpQgEQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qVcc/4e7a6IQBQk/K7Y6TVQLiTa0rVq3Mjr8CmtxGleHJbHDwxHmbB/b4lzAG3vO3TFs95Oua5cuBPyzQ6LRZcdUP82y4aTOF6HWgWTgExv/6XY28avM0wtUsikTjMSXC6is7OOWlkIzODJlVKpxZVEu+F0AbNVVJ51LehyOw8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z33uWXnC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K/KknDYj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 13:44:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741441497;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=16dLjAks4CSehjLf6/bHLvU0nS0CHPATjT2SRhoQlkk=;
	b=z33uWXnC4U02hGo2pJaMO/+GE9mqqRQEDLqY7MGQvGiWQieo5bVeY5lcxX8G60TsNsC1/n
	1a9p9IygFUOdYot2lbxRqIglKqrpKXdaUav1BlJNP2aJiY4R0s3PG+LAOFPY2yJlak4kHl
	T7kbmim67OR+NCK5SyFGlo+Ph0xY1I8fx/usMHVdhSsD+TrC6Lp+Xo8Bphotndi1cMtWgn
	qRp/5SFbIB16umBoZNBjT/9bBqUHaCV8KfZUHYlYXHyNK29Xa51jWsIgg0aue4435JaJcf
	cwPt4LbyM0Yo/ethJlhF2AGJHuZa+XE4MB2rfduMqoYxOG7Vz1E/FU3FtuCaOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741441497;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=16dLjAks4CSehjLf6/bHLvU0nS0CHPATjT2SRhoQlkk=;
	b=K/KknDYj98n5G8k7l5O3jprKdHS3z0RrAbPEGFtk7fZNquehQ1EYGNc4hmqLb42XTuQGyZ
	1tBf8/IVR+lSm+Aw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso: Rework struct vdso_time_data and introduce
 struct vdso_clock
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Nam Cao <namcao@linutronix.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303-vdso-clock-v1-19-c1b5c69a166f@linutronix.de>
References: <20250303-vdso-clock-v1-19-c1b5c69a166f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174144149365.14745.6291994648693816962.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     886653e36639177dd3ec2e7a4f0dc843d7def3f4
Gitweb:        https://git.kernel.org/tip/886653e36639177dd3ec2e7a4f0dc843d7d=
ef3f4
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 03 Mar 2025 12:11:21 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 08 Mar 2025 14:37:41 +01:00

vdso: Rework struct vdso_time_data and introduce struct vdso_clock

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be an array of VDSO clocks.

Now that all preparatory changes are in place:

Split the clock related struct members into a separate struct
vdso_clock. Make sure all users are aware, that vdso_time_data is no longer
initialized as an array and vdso_clock is now the array inside
vdso_data. Remove the vdso_clock define, which mapped it to vdso_time_data
for the transition.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250303-vdso-clock-v1-19-c1b5c69a166f@linu=
tronix.de

---
 arch/arm64/include/asm/vdso/compat_gettimeofday.h |  2 +-
 arch/arm64/include/asm/vdso/vsyscall.h            |  4 +-
 arch/s390/kernel/time.c                           | 11 +---
 include/asm-generic/vdso/vsyscall.h               |  2 +-
 include/vdso/datapage.h                           | 55 ++++++++------
 include/vdso/helpers.h                            |  4 +-
 kernel/time/namespace.c                           |  2 +-
 kernel/time/vsyscall.c                            | 11 +--
 lib/vdso/datastore.c                              |  4 +-
 lib/vdso/gettimeofday.c                           | 16 ++--
 10 files changed, 57 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/i=
nclude/asm/vdso/compat_gettimeofday.h
index 2c6b90d..d60ea7a 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -149,7 +149,7 @@ static __always_inline const struct vdso_time_data *__arc=
h_get_vdso_u_time_data(
 	 * where __aarch64_get_vdso_u_time_data() is called, and then keep the
 	 * result in a register.
 	 */
-	asm volatile("mov %0, %1" : "=3Dr"(ret) : "r"(vdso_u_time_data));
+	asm volatile("mov %0, %1" : "=3Dr"(ret) : "r"(&vdso_u_time_data));
=20
 	return ret;
 }
diff --git a/arch/arm64/include/asm/vdso/vsyscall.h b/arch/arm64/include/asm/=
vdso/vsyscall.h
index 3f65cbd..de58951 100644
--- a/arch/arm64/include/asm/vdso/vsyscall.h
+++ b/arch/arm64/include/asm/vdso/vsyscall.h
@@ -15,8 +15,8 @@
 static __always_inline
 void __arm64_update_vsyscall(struct vdso_time_data *vdata)
 {
-	vdata[CS_HRES_COARSE].mask	=3D VDSO_PRECISION_MASK;
-	vdata[CS_RAW].mask		=3D VDSO_PRECISION_MASK;
+	vdata->clock_data[CS_HRES_COARSE].mask	=3D VDSO_PRECISION_MASK;
+	vdata->clock_data[CS_RAW].mask		=3D VDSO_PRECISION_MASK;
 }
 #define __arch_update_vsyscall __arm64_update_vsyscall
=20
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 41ca358..699a18f 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -79,12 +79,10 @@ void __init time_early_init(void)
 {
 	struct ptff_qto qto;
 	struct ptff_qui qui;
-	int cs;
=20
 	/* Initialize TOD steering parameters */
 	tod_steering_end =3D tod_clock_base.tod;
-	for (cs =3D 0; cs < CS_BASES; cs++)
-		vdso_k_time_data[cs].arch_data.tod_steering_end =3D tod_steering_end;
+	vdso_k_time_data->arch_data.tod_steering_end =3D tod_steering_end;
=20
 	if (!test_facility(28))
 		return;
@@ -373,7 +371,6 @@ static void clock_sync_global(long delta)
 {
 	unsigned long now, adj;
 	struct ptff_qto qto;
-	int cs;
=20
 	/* Fixup the monotonic sched clock. */
 	tod_clock_base.eitod +=3D delta;
@@ -389,10 +386,8 @@ static void clock_sync_global(long delta)
 		panic("TOD clock sync offset %li is too large to drift\n",
 		      tod_steering_delta);
 	tod_steering_end =3D now + (abs(tod_steering_delta) << 15);
-	for (cs =3D 0; cs < CS_BASES; cs++) {
-		vdso_k_time_data[cs].arch_data.tod_steering_end =3D tod_steering_end;
-		vdso_k_time_data[cs].arch_data.tod_steering_delta =3D tod_steering_delta;
-	}
+	vdso_k_time_data->arch_data.tod_steering_end =3D tod_steering_end;
+	vdso_k_time_data->arch_data.tod_steering_delta =3D tod_steering_delta;
=20
 	/* Update LPAR offset. */
 	if (ptff_query(PTFF_QTO) && ptff(&qto, sizeof(qto), PTFF_QTO) =3D=3D 0)
diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/v=
syscall.h
index 1fb3000..b550afa 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -9,7 +9,7 @@
 #ifndef __arch_get_vdso_u_time_data
 static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_d=
ata(void)
 {
-	return vdso_u_time_data;
+	return &vdso_u_time_data;
 }
 #endif
=20
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index bcd19c2..1864e76 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -69,9 +69,7 @@ struct vdso_timestamp {
 };
=20
 /**
- * struct vdso_time_data - vdso datapage representation
- * @arch_data:		architecture specific data (optional, defaults
- *			to an empty struct)
+ * struct vdso_clock - vdso per clocksource datapage representation
  * @seq:		timebase sequence counter
  * @clock_mode:		clock mode
  * @cycle_last:		timebase at clocksource init
@@ -81,17 +79,9 @@ struct vdso_timestamp {
  * @shift:		clocksource shift
  * @basetime[clock_id]:	basetime per clock_id
  * @offset[clock_id]:	time namespace offset per clock_id
- * @tz_minuteswest:	minutes west of Greenwich
- * @tz_dsttime:		type of DST correction
- * @hrtimer_res:	hrtimer resolution
- * @__unused:		unused
  *
- * vdso_time_data will be accessed by 64 bit and compat code at the same time
- * so we should be careful before modifying this structure.
- *
- * The ordering of the struct members is optimized to have fast access to the
- * often required struct members which are related to CLOCK_REALTIME and
- * CLOCK_MONOTONIC. This information is stored in the first cache lines.
+ * See also struct vdso_time_data for basic access and ordering information =
as
+ * struct vdso_clock is used there.
  *
  * @basetime is used to store the base time for the system wide time getter
  * VVAR page.
@@ -104,9 +94,7 @@ struct vdso_timestamp {
  * For clocks which are not affected by time namespace adjustment the
  * offset must be zero.
  */
-struct vdso_time_data {
-	struct arch_vdso_time_data arch_data;
-
+struct vdso_clock {
 	u32			seq;
=20
 	s32			clock_mode;
@@ -122,14 +110,35 @@ struct vdso_time_data {
 		struct vdso_timestamp	basetime[VDSO_BASES];
 		struct timens_offset	offset[VDSO_BASES];
 	};
+};
=20
-	s32			tz_minuteswest;
-	s32			tz_dsttime;
-	u32			hrtimer_res;
-	u32			__unused;
-} ____cacheline_aligned;
+/**
+ * struct vdso_time_data - vdso datapage representation
+ * @arch_data:		architecture specific data (optional, defaults
+ *			to an empty struct)
+ * @clock_data:		clocksource related data (array)
+ * @tz_minuteswest:	minutes west of Greenwich
+ * @tz_dsttime:		type of DST correction
+ * @hrtimer_res:	hrtimer resolution
+ * @__unused:		unused
+ *
+ * vdso_time_data will be accessed by 64 bit and compat code at the same time
+ * so we should be careful before modifying this structure.
+ *
+ * The ordering of the struct members is optimized to have fast acces to the
+ * often required struct members which are related to CLOCK_REALTIME and
+ * CLOCK_MONOTONIC. This information is stored in the first cache lines.
+ */
+struct vdso_time_data {
+	struct arch_vdso_time_data	arch_data;
=20
-#define vdso_clock vdso_time_data
+	struct vdso_clock		clock_data[CS_BASES];
+
+	s32				tz_minuteswest;
+	s32				tz_dsttime;
+	u32				hrtimer_res;
+	u32				__unused;
+} ____cacheline_aligned;
=20
 /**
  * struct vdso_rng_data - vdso RNG state information
@@ -151,7 +160,7 @@ struct vdso_rng_data {
  * relocation, and this is what we need.
  */
 #ifdef CONFIG_GENERIC_VDSO_DATA_STORE
-extern struct vdso_time_data vdso_u_time_data[CS_BASES] __attribute__((visib=
ility("hidden")));
+extern struct vdso_time_data vdso_u_time_data __attribute__((visibility("hid=
den")));
 extern struct vdso_rng_data vdso_u_rng_data __attribute__((visibility("hidde=
n")));
 extern struct vdso_arch_data vdso_u_arch_data __attribute__((visibility("hid=
den")));
=20
diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
index 28f0707..0a98fed 100644
--- a/include/vdso/helpers.h
+++ b/include/vdso/helpers.h
@@ -30,7 +30,7 @@ static __always_inline u32 vdso_read_retry(const struct vds=
o_clock *vc,
=20
 static __always_inline void vdso_write_begin(struct vdso_time_data *vd)
 {
-	struct vdso_clock *vc =3D vd;
+	struct vdso_clock *vc =3D vd->clock_data;
=20
 	/*
 	 * WRITE_ONCE() is required otherwise the compiler can validly tear
@@ -44,7 +44,7 @@ static __always_inline void vdso_write_begin(struct vdso_ti=
me_data *vd)
=20
 static __always_inline void vdso_write_end(struct vdso_time_data *vd)
 {
-	struct vdso_clock *vc =3D vd;
+	struct vdso_clock *vc =3D vd->clock_data;
=20
 	smp_wmb();
 	/*
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 09bc4fb..e364227 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -237,7 +237,7 @@ static void timens_set_vvar_page(struct task_struct *task,
=20
 	ns->frozen_offsets =3D true;
 	vdata =3D page_address(ns->vvar_page);
-	vc =3D vdata;
+	vc =3D vdata->clock_data;
=20
 	for (i =3D 0; i < CS_BASES; i++)
 		timens_setup_vdso_clock_data(&vc[i], ns);
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index dd85b41..01c2ab1 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -17,8 +17,8 @@
=20
 static inline void update_vdso_time_data(struct vdso_time_data *vdata, struc=
t timekeeper *tk)
 {
+	struct vdso_clock *vc =3D vdata->clock_data;
 	struct vdso_timestamp *vdso_ts;
-	struct vdso_clock *vc =3D vdata;
 	u64 nsec, sec;
=20
 	vc[CS_HRES_COARSE].cycle_last	=3D tk->tkr_mono.cycle_last;
@@ -78,8 +78,8 @@ static inline void update_vdso_time_data(struct vdso_time_d=
ata *vdata, struct ti
 void update_vsyscall(struct timekeeper *tk)
 {
 	struct vdso_time_data *vdata =3D vdso_k_time_data;
+	struct vdso_clock *vc =3D vdata->clock_data;
 	struct vdso_timestamp *vdso_ts;
-	struct vdso_clock *vc =3D vdata;
 	s32 clock_mode;
 	u64 nsec;
=20
@@ -109,9 +109,8 @@ void update_vsyscall(struct timekeeper *tk)
=20
 	/*
 	 * Read without the seqlock held by clock_getres().
-	 * Note: No need to have a second copy.
 	 */
-	WRITE_ONCE(vdata[CS_HRES_COARSE].hrtimer_res, hrtimer_resolution);
+	WRITE_ONCE(vdata->hrtimer_res, hrtimer_resolution);
=20
 	/*
 	 * If the current clocksource is not VDSO capable, then spare the
@@ -131,8 +130,8 @@ void update_vsyscall_tz(void)
 {
 	struct vdso_time_data *vdata =3D vdso_k_time_data;
=20
-	vdata[CS_HRES_COARSE].tz_minuteswest =3D sys_tz.tz_minuteswest;
-	vdata[CS_HRES_COARSE].tz_dsttime =3D sys_tz.tz_dsttime;
+	vdata->tz_minuteswest =3D sys_tz.tz_minuteswest;
+	vdata->tz_dsttime =3D sys_tz.tz_dsttime;
=20
 	__arch_sync_vdso_time_data(vdata);
 }
diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index 4e350f5..c715e21 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -13,10 +13,10 @@
  */
 #ifdef CONFIG_HAVE_GENERIC_VDSO
 static union {
-	struct vdso_time_data	data[CS_BASES];
+	struct vdso_time_data	data;
 	u8			page[PAGE_SIZE];
 } vdso_time_data_store __page_aligned_data;
-struct vdso_time_data *vdso_k_time_data =3D vdso_time_data_store.data;
+struct vdso_time_data *vdso_k_time_data =3D &vdso_time_data_store.data;
 static_assert(sizeof(vdso_time_data_store) =3D=3D PAGE_SIZE);
 #endif /* CONFIG_HAVE_GENERIC_VDSO */
=20
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index c6ff693..93ef801 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -87,8 +87,8 @@ int do_hres_timens(const struct vdso_time_data *vdns, const=
 struct vdso_clock *v
 {
 	const struct vdso_time_data *vd =3D __arch_get_vdso_u_timens_data(vdns);
 	const struct timens_offset *offs =3D &vcns->offset[clk];
+	const struct vdso_clock *vc =3D vd->clock_data;
 	const struct vdso_timestamp *vdso_ts;
-	const struct vdso_clock *vc =3D vd;
 	u64 cycles, ns;
 	u32 seq;
 	s64 sec;
@@ -199,8 +199,8 @@ int do_coarse_timens(const struct vdso_time_data *vdns, c=
onst struct vdso_clock=20
 {
 	const struct vdso_time_data *vd =3D __arch_get_vdso_u_timens_data(vdns);
 	const struct timens_offset *offs =3D &vcns->offset[clk];
+	const struct vdso_clock *vc =3D vd->clock_data;
 	const struct vdso_timestamp *vdso_ts;
-	const struct vdso_clock *vc =3D vd;
 	u64 nsec;
 	s64 sec;
 	s32 seq;
@@ -265,7 +265,7 @@ static __always_inline int
 __cvdso_clock_gettime_common(const struct vdso_time_data *vd, clockid_t cloc=
k,
 			     struct __kernel_timespec *ts)
 {
-	const struct vdso_clock *vc =3D vd;
+	const struct vdso_clock *vc =3D vd->clock_data;
 	u32 msk;
=20
 	/* Check for negative values or invalid clocks */
@@ -337,7 +337,7 @@ static __maybe_unused int
 __cvdso_gettimeofday_data(const struct vdso_time_data *vd,
 			  struct __kernel_old_timeval *tv, struct timezone *tz)
 {
-	const struct vdso_clock *vc =3D vd;
+	const struct vdso_clock *vc =3D vd->clock_data;
=20
 	if (likely(tv !=3D NULL)) {
 		struct __kernel_timespec ts;
@@ -371,13 +371,13 @@ __cvdso_gettimeofday(struct __kernel_old_timeval *tv, s=
truct timezone *tz)
 static __maybe_unused __kernel_old_time_t
 __cvdso_time_data(const struct vdso_time_data *vd, __kernel_old_time_t *time)
 {
-	const struct vdso_clock *vc =3D vd;
+	const struct vdso_clock *vc =3D vd->clock_data;
 	__kernel_old_time_t t;
=20
 	if (IS_ENABLED(CONFIG_TIME_NS) &&
 	    vc->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS) {
 		vd =3D __arch_get_vdso_u_timens_data(vd);
-		vc =3D vd;
+		vc =3D vd->clock_data;
 	}
=20
 	t =3D READ_ONCE(vc[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
@@ -399,7 +399,7 @@ static __maybe_unused
 int __cvdso_clock_getres_common(const struct vdso_time_data *vd, clockid_t c=
lock,
 				struct __kernel_timespec *res)
 {
-	const struct vdso_clock *vc =3D vd;
+	const struct vdso_clock *vc =3D vd->clock_data;
 	u32 msk;
 	u64 ns;
=20
@@ -420,7 +420,7 @@ int __cvdso_clock_getres_common(const struct vdso_time_da=
ta *vd, clockid_t clock
 		/*
 		 * Preserves the behaviour of posix_get_hrtimer_res().
 		 */
-		ns =3D READ_ONCE(vd[CS_HRES_COARSE].hrtimer_res);
+		ns =3D READ_ONCE(vd->hrtimer_res);
 	} else if (msk & VDSO_COARSE) {
 		/*
 		 * Preserves the behaviour of posix_get_coarse_res().

