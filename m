Return-Path: <linux-tip-commits+bounces-7139-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85446C286E9
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8EB1A20D23
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A424930596A;
	Sat,  1 Nov 2025 19:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u/eBAwND";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RdHBdcD9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B223303A15;
	Sat,  1 Nov 2025 19:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026467; cv=none; b=AcUpFfP87ddqbXJeGrKsd+Tofl+z5t0OdN6dBz4X9M6/pYt9QRfdSJiD3U7Alg6PS/nCOFLKbQjwm3LK71cG2DbvEhh+OCEv6IKIijAlAv9M0kYHRsGINmlXp/6pJi3VgplXwrhHeT6wEzbDQJbrNwkKFVtfwQk7W/EwSv8VeBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026467; c=relaxed/simple;
	bh=L99PDFO7ADWQuIV37or47NQqyeFEuE5lzgo7Tyoa4h8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rvyrveUujKwngdFIXdU9//gV6pF+yo7Hg9kavHqL+SehzRD/+EjgWEaZTA4l4vkyHRMmn5S3qJswEx7Vf3M7Tyd8lpNIK1VRJuO4RGKZPsCueUxXv0zJJbOa1rLg1/gQEPjwRAXyGR6gGOhCdnYMY1qHJzafCFy5Ko6woeY6F7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u/eBAwND; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RdHBdcD9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:47:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026460;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vlA93gdDbOy9e2nHy5KR9VVC3qTl+oc61Xc+QuPWU2M=;
	b=u/eBAwNDzdnfsRHVtKPb240+0EHVQQn4MwoFeW8EOR0HTG1IFvoO08QCb2YNHVpRHQ6r7/
	H2/Ccr4/4mlBF4LMuxtcRSOAxAHLI43N1MGmqRfrNYNbCqSipuItMQ6jiOZJ+wMQpgHNyB
	z6m3Tt1td5OSgN66YDxRjkCOmOlgiTMkli0y/+fcHc+rYGWQ9hDSgTEeZVUaH1oWmjLDT/
	em0IO0aZohezb4Q/qCFq9trwDuC89Ae6468Hh6u66L6xMb9lm74rlX10W6R4yyfslE1SHQ
	Oeeis9Oo/QYc2igibUpeJwp//+pNJgapjNdKFlcSYThd4x4Alatuzv6E9DnaFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026460;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vlA93gdDbOy9e2nHy5KR9VVC3qTl+oc61Xc+QuPWU2M=;
	b=RdHBdcD9zsgAMaP0yEbUno36fQ/EApJTwDdD/vq9Y/oHUKmnwpNcDXSWuCCgGITQ4TfZs1
	u3rm1OeE++zxohDw==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] sparc64: vdso: Replace code patching with runtime
 conditional
Cc: Thomas Gleixner <tglx@linutronix.de>, thomas.weissschuh@linutronix.de,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20251014-vdso-sparc64-generic-2-v4-27-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-27-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202645935.2601451.18090397675824023670.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     05aac329b1c78b9c6b17133c2f4550f641666d1b
Gitweb:        https://git.kernel.org/tip/05aac329b1c78b9c6b17133c2f4550f6416=
66d1b
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:49:13 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:07 +01:00

sparc64: vdso: Replace code patching with runtime conditional

The patching logic is unnecessarily complicated and stands in the way of
the adoption of the generic vDSO framework.

Replace it by a simple runtime switch, similar to other architectures.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Acked-by: Andreas Larsson <andreas@gaisler.com>
Link: https://lore.kernel.org/lkml/87ecu9tfhw.ffs@tglx/
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-27-e0607bf4=
9dea@linutronix.de
---
 arch/sparc/vdso/vclock_gettime.c    | 112 +---------------
 arch/sparc/vdso/vdso.lds.S          |   2 +-
 arch/sparc/vdso/vdso32/vdso32.lds.S |   2 +-
 arch/sparc/vdso/vma.c               | 204 +---------------------------
 4 files changed, 4 insertions(+), 316 deletions(-)

diff --git a/arch/sparc/vdso/vclock_gettime.c b/arch/sparc/vdso/vclock_gettim=
e.c
index 7960780..643608b 100644
--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -148,17 +148,11 @@ notrace static __always_inline u64 vgetsns(struct vvar_=
data *vvar)
 	u64 v;
 	u64 cycles;
=20
-	cycles =3D vread_tick();
-	v =3D (cycles - vvar->clock.cycle_last) & vvar->clock.mask;
-	return v * vvar->clock.mult;
-}
-
-notrace static __always_inline u64 vgetsns_stick(struct vvar_data *vvar)
-{
-	u64 v;
-	u64 cycles;
+	if (likely(vvar->vclock_mode =3D=3D VCLOCK_STICK))
+		cycles =3D vread_tick_stick();
+	else
+		cycles =3D vread_tick();
=20
-	cycles =3D vread_tick_stick();
 	v =3D (cycles - vvar->clock.cycle_last) & vvar->clock.mask;
 	return v * vvar->clock.mult;
 }
@@ -183,26 +177,6 @@ notrace static __always_inline int do_realtime(struct vv=
ar_data *vvar,
 	return 0;
 }
=20
-notrace static __always_inline int do_realtime_stick(struct vvar_data *vvar,
-						     struct __kernel_old_timespec *ts)
-{
-	unsigned long seq;
-	u64 ns;
-
-	do {
-		seq =3D vvar_read_begin(vvar);
-		ts->tv_sec =3D vvar->wall_time_sec;
-		ns =3D vvar->wall_time_snsec;
-		ns +=3D vgetsns_stick(vvar);
-		ns =3D __shr64(ns, vvar->clock.shift);
-	} while (unlikely(vvar_read_retry(vvar, seq)));
-
-	ts->tv_sec +=3D __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec =3D ns;
-
-	return 0;
-}
-
 notrace static __always_inline int do_monotonic(struct vvar_data *vvar,
 						struct __kernel_old_timespec *ts)
 {
@@ -223,26 +197,6 @@ notrace static __always_inline int do_monotonic(struct v=
var_data *vvar,
 	return 0;
 }
=20
-notrace static __always_inline int do_monotonic_stick(struct vvar_data *vvar,
-						      struct __kernel_old_timespec *ts)
-{
-	unsigned long seq;
-	u64 ns;
-
-	do {
-		seq =3D vvar_read_begin(vvar);
-		ts->tv_sec =3D vvar->monotonic_time_sec;
-		ns =3D vvar->monotonic_time_snsec;
-		ns +=3D vgetsns_stick(vvar);
-		ns =3D __shr64(ns, vvar->clock.shift);
-	} while (unlikely(vvar_read_retry(vvar, seq)));
-
-	ts->tv_sec +=3D __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec =3D ns;
-
-	return 0;
-}
-
 notrace static int do_realtime_coarse(struct vvar_data *vvar,
 				      struct __kernel_old_timespec *ts)
 {
@@ -299,31 +253,6 @@ clock_gettime(clockid_t, struct __kernel_old_timespec *)
 	__attribute__((weak, alias("__vdso_clock_gettime")));
=20
 notrace int
-__vdso_clock_gettime_stick(clockid_t clock, struct __kernel_old_timespec *ts)
-{
-	struct vvar_data *vvd =3D get_vvar_data();
-
-	switch (clock) {
-	case CLOCK_REALTIME:
-		if (unlikely(vvd->vclock_mode =3D=3D VCLOCK_NONE))
-			break;
-		return do_realtime_stick(vvd, ts);
-	case CLOCK_MONOTONIC:
-		if (unlikely(vvd->vclock_mode =3D=3D VCLOCK_NONE))
-			break;
-		return do_monotonic_stick(vvd, ts);
-	case CLOCK_REALTIME_COARSE:
-		return do_realtime_coarse(vvd, ts);
-	case CLOCK_MONOTONIC_COARSE:
-		return do_monotonic_coarse(vvd, ts);
-	}
-	/*
-	 * Unknown clock ID ? Fall back to the syscall.
-	 */
-	return vdso_fallback_gettime(clock, ts);
-}
-
-notrace int
 __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 {
 	struct vvar_data *vvd =3D get_vvar_data();
@@ -358,36 +287,3 @@ __vdso_gettimeofday(struct __kernel_old_timeval *tv, str=
uct timezone *tz)
 int
 gettimeofday(struct __kernel_old_timeval *, struct timezone *)
 	__attribute__((weak, alias("__vdso_gettimeofday")));
-
-notrace int
-__vdso_gettimeofday_stick(struct __kernel_old_timeval *tv, struct timezone *=
tz)
-{
-	struct vvar_data *vvd =3D get_vvar_data();
-
-	if (likely(vvd->vclock_mode !=3D VCLOCK_NONE)) {
-		if (likely(tv !=3D NULL)) {
-			union tstv_t {
-				struct __kernel_old_timespec ts;
-				struct __kernel_old_timeval tv;
-			} *tstv =3D (union tstv_t *) tv;
-			do_realtime_stick(vvd, &tstv->ts);
-			/*
-			 * Assign before dividing to ensure that the division is
-			 * done in the type of tv_usec, not tv_nsec.
-			 *
-			 * There cannot be > 1 billion usec in a second:
-			 * do_realtime() has already distributed such overflow
-			 * into tv_sec.  So we can assign it to an int safely.
-			 */
-			tstv->tv.tv_usec =3D tstv->ts.tv_nsec;
-			tstv->tv.tv_usec /=3D 1000;
-		}
-		if (unlikely(tz !=3D NULL)) {
-			/* Avoid memcpy. Some old compilers fail to inline it */
-			tz->tz_minuteswest =3D vvd->tz_minuteswest;
-			tz->tz_dsttime =3D vvd->tz_dsttime;
-		}
-		return 0;
-	}
-	return vdso_fallback_gettimeofday(tv, tz);
-}
diff --git a/arch/sparc/vdso/vdso.lds.S b/arch/sparc/vdso/vdso.lds.S
index 629ab69..f3caa29 100644
--- a/arch/sparc/vdso/vdso.lds.S
+++ b/arch/sparc/vdso/vdso.lds.S
@@ -18,10 +18,8 @@ VERSION {
 	global:
 		clock_gettime;
 		__vdso_clock_gettime;
-		__vdso_clock_gettime_stick;
 		gettimeofday;
 		__vdso_gettimeofday;
-		__vdso_gettimeofday_stick;
 	local: *;
 	};
 }
diff --git a/arch/sparc/vdso/vdso32/vdso32.lds.S b/arch/sparc/vdso/vdso32/vds=
o32.lds.S
index 218930f..53575ee 100644
--- a/arch/sparc/vdso/vdso32/vdso32.lds.S
+++ b/arch/sparc/vdso/vdso32/vdso32.lds.S
@@ -17,10 +17,8 @@ VERSION {
 	global:
 		clock_gettime;
 		__vdso_clock_gettime;
-		__vdso_clock_gettime_stick;
 		gettimeofday;
 		__vdso_gettimeofday;
-		__vdso_gettimeofday_stick;
 	local: *;
 	};
 }
diff --git a/arch/sparc/vdso/vma.c b/arch/sparc/vdso/vma.c
index bab7a59..582d84e 100644
--- a/arch/sparc/vdso/vma.c
+++ b/arch/sparc/vdso/vma.c
@@ -42,203 +42,6 @@ static struct vm_special_mapping vdso_mapping32 =3D {
=20
 struct vvar_data *vvar_data;
=20
-struct vdso_elfinfo32 {
-	Elf32_Ehdr	*hdr;
-	Elf32_Sym	*dynsym;
-	unsigned long	dynsymsize;
-	const char	*dynstr;
-	unsigned long	text;
-};
-
-struct vdso_elfinfo64 {
-	Elf64_Ehdr	*hdr;
-	Elf64_Sym	*dynsym;
-	unsigned long	dynsymsize;
-	const char	*dynstr;
-	unsigned long	text;
-};
-
-struct vdso_elfinfo {
-	union {
-		struct vdso_elfinfo32 elf32;
-		struct vdso_elfinfo64 elf64;
-	} u;
-};
-
-static void *one_section64(struct vdso_elfinfo64 *e, const char *name,
-			   unsigned long *size)
-{
-	const char *snames;
-	Elf64_Shdr *shdrs;
-	unsigned int i;
-
-	shdrs =3D (void *)e->hdr + e->hdr->e_shoff;
-	snames =3D (void *)e->hdr + shdrs[e->hdr->e_shstrndx].sh_offset;
-	for (i =3D 1; i < e->hdr->e_shnum; i++) {
-		if (!strcmp(snames+shdrs[i].sh_name, name)) {
-			if (size)
-				*size =3D shdrs[i].sh_size;
-			return (void *)e->hdr + shdrs[i].sh_offset;
-		}
-	}
-	return NULL;
-}
-
-static int find_sections64(const struct vdso_image *image, struct vdso_elfin=
fo *_e)
-{
-	struct vdso_elfinfo64 *e =3D &_e->u.elf64;
-
-	e->hdr =3D image->data;
-	e->dynsym =3D one_section64(e, ".dynsym", &e->dynsymsize);
-	e->dynstr =3D one_section64(e, ".dynstr", NULL);
-
-	if (!e->dynsym || !e->dynstr) {
-		pr_err("VDSO64: Missing symbol sections.\n");
-		return -ENODEV;
-	}
-	return 0;
-}
-
-static Elf64_Sym *find_sym64(const struct vdso_elfinfo64 *e, const char *nam=
e)
-{
-	unsigned int i;
-
-	for (i =3D 0; i < (e->dynsymsize / sizeof(Elf64_Sym)); i++) {
-		Elf64_Sym *s =3D &e->dynsym[i];
-		if (s->st_name =3D=3D 0)
-			continue;
-		if (!strcmp(e->dynstr + s->st_name, name))
-			return s;
-	}
-	return NULL;
-}
-
-static int patchsym64(struct vdso_elfinfo *_e, const char *orig,
-		      const char *new)
-{
-	struct vdso_elfinfo64 *e =3D &_e->u.elf64;
-	Elf64_Sym *osym =3D find_sym64(e, orig);
-	Elf64_Sym *nsym =3D find_sym64(e, new);
-
-	if (!nsym || !osym) {
-		pr_err("VDSO64: Missing symbols.\n");
-		return -ENODEV;
-	}
-	osym->st_value =3D nsym->st_value;
-	osym->st_size =3D nsym->st_size;
-	osym->st_info =3D nsym->st_info;
-	osym->st_other =3D nsym->st_other;
-	osym->st_shndx =3D nsym->st_shndx;
-
-	return 0;
-}
-
-static void *one_section32(struct vdso_elfinfo32 *e, const char *name,
-			   unsigned long *size)
-{
-	const char *snames;
-	Elf32_Shdr *shdrs;
-	unsigned int i;
-
-	shdrs =3D (void *)e->hdr + e->hdr->e_shoff;
-	snames =3D (void *)e->hdr + shdrs[e->hdr->e_shstrndx].sh_offset;
-	for (i =3D 1; i < e->hdr->e_shnum; i++) {
-		if (!strcmp(snames+shdrs[i].sh_name, name)) {
-			if (size)
-				*size =3D shdrs[i].sh_size;
-			return (void *)e->hdr + shdrs[i].sh_offset;
-		}
-	}
-	return NULL;
-}
-
-static int find_sections32(const struct vdso_image *image, struct vdso_elfin=
fo *_e)
-{
-	struct vdso_elfinfo32 *e =3D &_e->u.elf32;
-
-	e->hdr =3D image->data;
-	e->dynsym =3D one_section32(e, ".dynsym", &e->dynsymsize);
-	e->dynstr =3D one_section32(e, ".dynstr", NULL);
-
-	if (!e->dynsym || !e->dynstr) {
-		pr_err("VDSO32: Missing symbol sections.\n");
-		return -ENODEV;
-	}
-	return 0;
-}
-
-static Elf32_Sym *find_sym32(const struct vdso_elfinfo32 *e, const char *nam=
e)
-{
-	unsigned int i;
-
-	for (i =3D 0; i < (e->dynsymsize / sizeof(Elf32_Sym)); i++) {
-		Elf32_Sym *s =3D &e->dynsym[i];
-		if (s->st_name =3D=3D 0)
-			continue;
-		if (!strcmp(e->dynstr + s->st_name, name))
-			return s;
-	}
-	return NULL;
-}
-
-static int patchsym32(struct vdso_elfinfo *_e, const char *orig,
-		      const char *new)
-{
-	struct vdso_elfinfo32 *e =3D &_e->u.elf32;
-	Elf32_Sym *osym =3D find_sym32(e, orig);
-	Elf32_Sym *nsym =3D find_sym32(e, new);
-
-	if (!nsym || !osym) {
-		pr_err("VDSO32: Missing symbols.\n");
-		return -ENODEV;
-	}
-	osym->st_value =3D nsym->st_value;
-	osym->st_size =3D nsym->st_size;
-	osym->st_info =3D nsym->st_info;
-	osym->st_other =3D nsym->st_other;
-	osym->st_shndx =3D nsym->st_shndx;
-
-	return 0;
-}
-
-static int find_sections(const struct vdso_image *image, struct vdso_elfinfo=
 *e,
-			 bool elf64)
-{
-	if (elf64)
-		return find_sections64(image, e);
-	else
-		return find_sections32(image, e);
-}
-
-static int patch_one_symbol(struct vdso_elfinfo *e, const char *orig,
-			    const char *new_target, bool elf64)
-{
-	if (elf64)
-		return patchsym64(e, orig, new_target);
-	else
-		return patchsym32(e, orig, new_target);
-}
-
-static int stick_patch(const struct vdso_image *image, struct vdso_elfinfo *=
e, bool elf64)
-{
-	int err;
-
-	err =3D find_sections(image, e, elf64);
-	if (err)
-		return err;
-
-	err =3D patch_one_symbol(e,
-			       "__vdso_gettimeofday",
-			       "__vdso_gettimeofday_stick", elf64);
-	if (err)
-		return err;
-
-	return patch_one_symbol(e,
-				"__vdso_clock_gettime",
-				"__vdso_clock_gettime_stick", elf64);
-	return 0;
-}
-
 /*
  * Allocate pages for the vdso and vvar, and copy in the vdso text from the
  * kernel image.
@@ -250,15 +53,8 @@ static int __init init_vdso_image(const struct vdso_image=
 *image,
 	int cnpages =3D (image->size) / PAGE_SIZE;
 	struct page *dp, **dpp =3D NULL;
 	struct page *cp, **cpp =3D NULL;
-	struct vdso_elfinfo ei;
 	int i, dnpages =3D 0;
=20
-	if (tlb_type !=3D spitfire) {
-		int err =3D stick_patch(image, &ei, elf64);
-		if (err)
-			return err;
-	}
-
 	/*
 	 * First, the vdso text.  This is initialied data, an integral number of
 	 * pages long.

