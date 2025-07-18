Return-Path: <linux-tip-commits+bounces-6132-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E801FB0A3AD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jul 2025 13:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A047A8080B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jul 2025 11:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EE92D97B4;
	Fri, 18 Jul 2025 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M4bzwoFn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XUycdV1Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493BD29824B;
	Fri, 18 Jul 2025 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752839787; cv=none; b=lVkfyHkMBQkfORb3Omos8xYY7gjA4j91Ie080uj3nMUDVlM7TpQqtSljvEHqzTv0oLTCqCnVEf52oF9j7b80mAPrL/9kdWRMxj4JiAaG3SbYxYJRWkxiQV2aNFZE7904S4s+4rIq5ip4bWMs2X+c2VCDwe+uan8jgf00MxJn6qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752839787; c=relaxed/simple;
	bh=7xm7d8HOadHiopHEhQfScjxhEX0qAzX6XDjyd1DDFOc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AmoYhNvFehQbZs1WkHUAr6O+Y8SfbL41JDGmiONVQ0g3evLyJNLa2xYgnPxO3snzCfG5QdY6OJgDmRe9CVkbaburVO2rWt5nuZyODeeN6fIPlHXZui9zVFoKNXUv6ePV+NJlteMXLDQ7VNxGgHXFcaoRylx7k9LNeEihjj4scCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M4bzwoFn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XUycdV1Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Jul 2025 11:56:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752839784;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d5+aRtIlHW3mgOzoLMVcpfPDPexLf8eNtR92PNz4mCU=;
	b=M4bzwoFnt/5xE3iQisju0+Ch5sJgI3/5PbcCVzU35LekIC5hNbl0c+i96BWgOPDGTFOPSE
	JL6rfr0PE444kcbrm+fRAdnKPO+eh/LSaRUBk+hiW7UVguKUY/eSioZYz6HwO+Lj7eMYMJ
	ucEGhbTEKFpatJfFey9F8M2KTrQV8l92aOdITQkqpUACz+5cC7eSDAo/BSrYaEfmRD/ll1
	qMazUPWE7fch+jNmUopAiQfbZ+PTRTW1Nk3Rt/wE2Oqdszx5mwaoZwjZwo/WupjjAp5hr3
	yBVUnLSh5Dteaw5ZCQn9qey434cCJSv3iIVlFEGU4+Nxunhc7rTsVocmFOavmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752839784;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d5+aRtIlHW3mgOzoLMVcpfPDPexLf8eNtR92PNz4mCU=;
	b=XUycdV1YkbD8IgTlWUyduxaZJd08NCf7jPMGTJDTOF7oX4z6oSuEmrYlM+w5++VvIbq8XY
	WE0bF7shASEG6FBg==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/ptp] vdso/vsyscall: Update auxiliary clock data in the datapage
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250701-vdso-auxclock-v1-11-df7d9f87b9b8@linutronix.de>
References: <20250701-vdso-auxclock-v1-11-df7d9f87b9b8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175283978326.406.7698924529339590205.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     380b84e168e57c54d0a9e053a5558fddc43f0c1a
Gitweb:        https://git.kernel.org/tip/380b84e168e57c54d0a9e053a5558fddc43=
f0c1a
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 01 Jul 2025 10:58:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 18 Jul 2025 13:45:33 +02:00

vdso/vsyscall: Update auxiliary clock data in the datapage

Expose the auxiliary clock data so it can be read from the vDSO.

Architectures not using the generic vDSO time framework,
namely SPARC64, are not supported.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250701-vdso-auxclock-v1-11-df7d9f87b9b8@l=
inutronix.de

---
 include/linux/timekeeper_internal.h |  6 ++++-
 include/vdso/datapage.h             |  3 ++-
 kernel/time/namespace.c             |  5 ++++-
 kernel/time/timekeeping.c           | 12 ++++++++-
 kernel/time/vsyscall.c              | 40 ++++++++++++++++++++++++++++-
 5 files changed, 66 insertions(+)

diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_i=
nternal.h
index ca79938..c27aac6 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -190,4 +190,10 @@ static inline void update_vsyscall_tz(void)
 }
 #endif
=20
+#if defined(CONFIG_GENERIC_GETTIMEOFDAY) && defined(CONFIG_POSIX_AUX_CLOCKS)
+extern void vdso_time_update_aux(struct timekeeper *tk);
+#else
+static inline void vdso_time_update_aux(struct timekeeper *tk) { }
+#endif
+
 #endif /* _LINUX_TIMEKEEPER_INTERNAL_H */
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 1864e76..f4c96d9 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -38,6 +38,7 @@ struct vdso_arch_data {
 #endif
=20
 #define VDSO_BASES	(CLOCK_TAI + 1)
+#define VDSO_BASE_AUX	0
 #define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
 			 BIT(CLOCK_MONOTONIC)		| \
 			 BIT(CLOCK_BOOTTIME)		| \
@@ -117,6 +118,7 @@ struct vdso_clock {
  * @arch_data:		architecture specific data (optional, defaults
  *			to an empty struct)
  * @clock_data:		clocksource related data (array)
+ * @aux_clock_data:	auxiliary clocksource related data (array)
  * @tz_minuteswest:	minutes west of Greenwich
  * @tz_dsttime:		type of DST correction
  * @hrtimer_res:	hrtimer resolution
@@ -133,6 +135,7 @@ struct vdso_time_data {
 	struct arch_vdso_time_data	arch_data;
=20
 	struct vdso_clock		clock_data[CS_BASES];
+	struct vdso_clock		aux_clock_data[MAX_AUX_CLOCKS];
=20
 	s32				tz_minuteswest;
 	s32				tz_dsttime;
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index e364227..6674527 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -242,6 +242,11 @@ static void timens_set_vvar_page(struct task_struct *tas=
k,
 	for (i =3D 0; i < CS_BASES; i++)
 		timens_setup_vdso_clock_data(&vc[i], ns);
=20
+	if (IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS)) {
+		for (i =3D 0; i < ARRAY_SIZE(vdata->aux_clock_data); i++)
+			timens_setup_vdso_clock_data(&vdata->aux_clock_data[i], ns);
+	}
+
 out:
 	mutex_unlock(&offset_lock);
 }
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index cbcf090..243fe25 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -66,11 +66,21 @@ static inline bool tk_get_aux_ts64(unsigned int tkid, str=
uct timespec64 *ts)
 {
 	return ktime_get_aux_ts64(CLOCK_AUX + tkid - TIMEKEEPER_AUX_FIRST, ts);
 }
+
+static inline bool tk_is_aux(const struct timekeeper *tk)
+{
+	return tk->id >=3D TIMEKEEPER_AUX_FIRST && tk->id <=3D TIMEKEEPER_AUX_LAST;
+}
 #else
 static inline bool tk_get_aux_ts64(unsigned int tkid, struct timespec64 *ts)
 {
 	return false;
 }
+
+static inline bool tk_is_aux(const struct timekeeper *tk)
+{
+	return false;
+}
 #endif
=20
 /* flag for if timekeeping is suspended */
@@ -719,6 +729,8 @@ static void timekeeping_update_from_shadow(struct tk_data=
 *tkd, unsigned int act
=20
 		update_fast_timekeeper(&tk->tkr_mono, &tk_fast_mono);
 		update_fast_timekeeper(&tk->tkr_raw,  &tk_fast_raw);
+	} else if (tk_is_aux(tk)) {
+		vdso_time_update_aux(tk);
 	}
=20
 	if (action & TK_CLOCK_WAS_SET)
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index df6bada..8ba8b0d 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -136,6 +136,46 @@ void update_vsyscall_tz(void)
 	__arch_sync_vdso_time_data(vdata);
 }
=20
+#ifdef CONFIG_POSIX_AUX_CLOCKS
+void vdso_time_update_aux(struct timekeeper *tk)
+{
+	struct vdso_time_data *vdata =3D vdso_k_time_data;
+	struct vdso_timestamp *vdso_ts;
+	struct vdso_clock *vc;
+	s32 clock_mode;
+	u64 nsec;
+
+	vc =3D &vdata->aux_clock_data[tk->id - TIMEKEEPER_AUX_FIRST];
+	vdso_ts =3D &vc->basetime[VDSO_BASE_AUX];
+	clock_mode =3D tk->tkr_mono.clock->vdso_clock_mode;
+	if (!tk->clock_valid)
+		clock_mode =3D VDSO_CLOCKMODE_NONE;
+
+	/* copy vsyscall data */
+	vdso_write_begin_clock(vc);
+
+	vc->clock_mode =3D clock_mode;
+
+	if (clock_mode !=3D VDSO_CLOCKMODE_NONE) {
+		fill_clock_configuration(vc, &tk->tkr_mono);
+
+		vdso_ts->sec	=3D tk->xtime_sec;
+
+		nsec =3D tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
+		nsec +=3D tk->offs_aux;
+		vdso_ts->sec +=3D __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
+		nsec =3D nsec << tk->tkr_mono.shift;
+		vdso_ts->nsec =3D nsec;
+	}
+
+	__arch_update_vdso_clock(vc);
+
+	vdso_write_end_clock(vc);
+
+	__arch_sync_vdso_time_data(vdata);
+}
+#endif
+
 /**
  * vdso_update_begin - Start of a VDSO update section
  *

