Return-Path: <linux-tip-commits+bounces-3555-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F04A5A3EF75
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 10:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876024211D4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 09:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED78B204F8A;
	Fri, 21 Feb 2025 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CsypoZ/o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+6+Wxxan"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786E0200110;
	Fri, 21 Feb 2025 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128598; cv=none; b=TVi6AHCl5rxhHN/nGnqYxQbTZSlPGkZbk5cVQ8pRpywKdvgnjxYHu9ZN3FgPP7n3dRvKiFudTk8m9lYSPmsM6ksrmQdV3YBokbjbVOQtReZg35272QkaUZHNm30h+m4Ij2bq5CG12+JhCAMYeZ0XogvaKKvbF4T+FUMuxx0qdeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128598; c=relaxed/simple;
	bh=Xnn9wRRwU+mrL8zNAjD3scLRj5RpI4OUGMr4zpUIjRc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NP32z4OrCzcGrkZqHEPHF46TWTuR5TYChhBQNjYU+9cF6LBrnxGqcAPkriexG9+lrfbdYSGDQzvWA2Jr2podKgqqK6Rbvee4UfOnXscGCrihe+DvJ8OjKHIA9nKhmq7c5e2Vf1Ip1ccrefMZ2aeq8cPcpKAAFURj2qYIoBItIN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CsypoZ/o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+6+Wxxan; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 09:03:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740128594;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qVQckus1uMLbDTjc28y6tuf0DospFOuOCRUE9UzZqS4=;
	b=CsypoZ/ouc0jFlCVdJN2LWKJ3HXId44zYY/gfZIaDXVrCD9PrL5475YiBhic81yFQGe1ws
	8fEmkHsFIYyO7cAAxh9PnU7SCbOgJ5VJsP5TMJyyFtkEO57hDI8Y+gfL4XtOs6PB3wHGOi
	poCBs221JR21cK0CYECngl4Qpz4WbSKNS74mlMMRjMDjJPoVN9eg8lxdpfp085YEYk+akO
	zg5427JQOgtNXw/GI0d/9JanUMGbDmdi6lleAgI3cqszT1oVNvQZZIu3T4J195YTt/UV5c
	5lycuMug+1zHV7VhVx+8kw5/gr1jiHxzNiGQVNNSxkbxfUF+bYUxJ30yZ3EQ/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740128594;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qVQckus1uMLbDTjc28y6tuf0DospFOuOCRUE9UzZqS4=;
	b=+6+WxxanGFmodXf8W7mAsasMj+6VlWpBTDJk0VBF1ofnzkjih5zlMw83vOOvxEQOvyoU74
	LCVXlWjhAY6xKYCw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] vdso: Add generic architecture-specific data storage
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250204-vdso-store-rng-v3-7-13a4669dfc8c@linutronix.de>
References: <20250204-vdso-store-rng-v3-7-13a4669dfc8c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174012859339.10177.3175677520706874318.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     365841e1557ace6e8b4d5ba06a6cf53f699bc684
Gitweb:        https://git.kernel.org/tip/365841e1557ace6e8b4d5ba06a6cf53f699=
bc684
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 04 Feb 2025 13:05:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Feb 2025 09:54:01 +01:00

vdso: Add generic architecture-specific data storage

Some architectures need to expose architecture-specific data to the vDSO.

Enable the generic vDSO storage mechanism to both store and map this
data. Some architectures require more than a single page, like LoongArch,
so prepare for that usecase, too.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250204-vdso-store-rng-v3-7-13a4669dfc8c@l=
inutronix.de

---
 arch/Kconfig            |  4 ++++
 include/vdso/datapage.h | 25 +++++++++++++++++++++++++
 lib/vdso/datastore.c    | 14 ++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index b8a4ff3..9f6eb09 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1584,6 +1584,10 @@ config HAVE_SPARSE_SYSCALL_NR
 	  entries at 4000, 5000 and 6000 locations. This option turns on syscall
 	  related optimizations for a given architecture.
=20
+config ARCH_HAS_VDSO_ARCH_DATA
+	depends on GENERIC_VDSO_DATA_STORE
+	bool
+
 config ARCH_HAS_VDSO_TIME_DATA
 	bool
=20
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 7dbc879..46658b3 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -9,11 +9,13 @@
 #include <uapi/linux/types.h>
 #include <uapi/asm-generic/errno-base.h>
=20
+#include <vdso/align.h>
 #include <vdso/bits.h>
 #include <vdso/clocksource.h>
 #include <vdso/ktime.h>
 #include <vdso/limits.h>
 #include <vdso/math64.h>
+#include <vdso/page.h>
 #include <vdso/processor.h>
 #include <vdso/time.h>
 #include <vdso/time32.h>
@@ -25,6 +27,15 @@
 struct arch_vdso_time_data {};
 #endif
=20
+#if defined(CONFIG_ARCH_HAS_VDSO_ARCH_DATA)
+#include <asm/vdso/arch_data.h>
+#elif defined(CONFIG_GENERIC_VDSO_DATA_STORE)
+struct vdso_arch_data {
+	/* Needed for the generic code, never actually used at runtime */
+	char __unused;
+};
+#endif
+
 #define VDSO_BASES	(CLOCK_TAI + 1)
 #define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
 			 BIT(CLOCK_MONOTONIC)		| \
@@ -145,9 +156,11 @@ extern struct vdso_rng_data _vdso_rng_data __attribute__=
((visibility("hidden")))
 #else
 extern struct vdso_time_data vdso_u_time_data[CS_BASES] __attribute__((visib=
ility("hidden")));
 extern struct vdso_rng_data vdso_u_rng_data __attribute__((visibility("hidde=
n")));
+extern struct vdso_arch_data vdso_u_arch_data __attribute__((visibility("hid=
den")));
=20
 extern struct vdso_time_data *vdso_k_time_data;
 extern struct vdso_rng_data *vdso_k_rng_data;
+extern struct vdso_arch_data *vdso_k_arch_data;
 #endif
=20
 /**
@@ -160,10 +173,15 @@ union vdso_data_store {
=20
 #ifdef CONFIG_GENERIC_VDSO_DATA_STORE
=20
+#define VDSO_ARCH_DATA_SIZE ALIGN(sizeof(struct vdso_arch_data), PAGE_SIZE)
+#define VDSO_ARCH_DATA_PAGES (VDSO_ARCH_DATA_SIZE >> PAGE_SHIFT)
+
 enum vdso_pages {
 	VDSO_TIME_PAGE_OFFSET,
 	VDSO_TIMENS_PAGE_OFFSET,
 	VDSO_RNG_PAGE_OFFSET,
+	VDSO_ARCH_PAGES_START,
+	VDSO_ARCH_PAGES_END =3D VDSO_ARCH_PAGES_START + VDSO_ARCH_DATA_PAGES - 1,
 	VDSO_NR_PAGES
 };
=20
@@ -193,10 +211,17 @@ enum vdso_pages {
 #define __vdso_u_rng_data
 #endif
=20
+#ifdef CONFIG_ARCH_HAS_VDSO_ARCH_DATA
+#define __vdso_u_arch_data	PROVIDE(vdso_u_arch_data =3D vdso_u_data + 3 * PA=
GE_SIZE);
+#else
+#define __vdso_u_arch_data
+#endif
+
 #define VDSO_VVAR_SYMS						\
 	PROVIDE(vdso_u_data =3D . - __VDSO_PAGES * PAGE_SIZE);	\
 	PROVIDE(vdso_u_time_data =3D vdso_u_data);		\
 	__vdso_u_rng_data					\
+	__vdso_u_arch_data					\
=20
=20
 #endif /* !__ASSEMBLY__ */
diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index 9260b00..0959d62 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -26,6 +26,14 @@ struct vdso_rng_data *vdso_k_rng_data =3D &vdso_rng_data_s=
tore.data;
 static_assert(sizeof(vdso_rng_data_store) =3D=3D PAGE_SIZE);
 #endif /* CONFIG_VDSO_GETRANDOM */
=20
+#ifdef CONFIG_ARCH_HAS_VDSO_ARCH_DATA
+static union {
+	struct vdso_arch_data	data;
+	u8			page[VDSO_ARCH_DATA_SIZE];
+} vdso_arch_data_store __page_aligned_data;
+struct vdso_arch_data *vdso_k_arch_data =3D &vdso_arch_data_store.data;
+#endif /* CONFIG_ARCH_HAS_VDSO_ARCH_DATA */
+
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 			     struct vm_area_struct *vma, struct vm_fault *vmf)
 {
@@ -67,6 +75,12 @@ static vm_fault_t vvar_fault(const struct vm_special_mappi=
ng *sm,
 			return VM_FAULT_SIGBUS;
 		pfn =3D __phys_to_pfn(__pa_symbol(vdso_k_rng_data));
 		break;
+	case VDSO_ARCH_PAGES_START ... VDSO_ARCH_PAGES_END:
+		if (!IS_ENABLED(CONFIG_ARCH_HAS_VDSO_ARCH_DATA))
+			return VM_FAULT_SIGBUS;
+		pfn =3D __phys_to_pfn(__pa_symbol(vdso_k_arch_data)) +
+			vmf->pgoff - VDSO_ARCH_PAGES_START;
+		break;
 	default:
 		return VM_FAULT_SIGBUS;
 	}

