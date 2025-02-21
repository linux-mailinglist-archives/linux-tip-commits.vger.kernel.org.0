Return-Path: <linux-tip-commits+bounces-3554-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC7AA3EF73
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 10:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC593B8D69
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 09:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA68202C2D;
	Fri, 21 Feb 2025 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="keMLvI96";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WJgfRPXV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C8B2046A5;
	Fri, 21 Feb 2025 09:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128598; cv=none; b=YQORo6JsYWvJBRFJD819LPqBBq3UU9XY1nms0xJNI3FaaeHJNQjSeeSgHI5QnBAS+XSKZU2akHkhMdLqNmoXtMhlNCKSVSOukrX/eykfY9Vu3y9I7cEv2iMAkoMgBkIUFSSxVOFOMpiOQ2FcpyFtl6mUuybgXNlnjbJKZ2TSzmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128598; c=relaxed/simple;
	bh=MRc65aZJxEWWt6kIRzXe6aV4w5Ip31bnXI2lOCp//t4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rHnJX0QjPIv5yfUmOfzC8jY5s9T3Hr26Q8pnSWRBXVcve0cGuwXyQNZPVdXwGB6AOX8kOO0ZTYXZ9QgD1dIN47yEkxHX6RnMB65IiVutPWZSfb+ucxZIJL9c2gUaGLfc3LSoLHrlIUotd7nH6112I/TNxWGeqbb+xyRj4axQvzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=keMLvI96; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WJgfRPXV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 09:03:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740128594;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hG2SZ0AewhtwXdhv9NUYuA2hIlS8OPuDUqZVD8g0r+w=;
	b=keMLvI964QTuG85382X4VNvcoS8RHRsoABc1pL4yw7DgH/J3MAA7KndNkC6KTHSVa1efUN
	2L0uUiNIoyJ59X4gC9N/aa+4gl9tHjtlkcymTTn0MujYn8iQN/20XV7XeQp4CAH8EhZJQs
	8oU+WcmAWAa86sF8Dle1F364Mz0D2uK6ytMEm4Vq3C4HbM/+mVIlKQvoU8zJBQYr8gwLUW
	OJx/6knKNeBTgoAsjsbwAoAdn3ZW617AxlwX52nvoF6bh8blzQ7NtpznQTHJLz5aDSPmWQ
	0UeShuFY00f7EX53KdBhAki4pnR70qvdL4zTFxAidKXS8pR65Yt3p5qPWFrQQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740128594;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hG2SZ0AewhtwXdhv9NUYuA2hIlS8OPuDUqZVD8g0r+w=;
	b=WJgfRPXV/3Z7uwBHnnSmuMJaS/Hv6sFTIbjqoBTg4AoIaZs7VuxMiggB/S5miubpfgdIxq
	sSdtF2ROUtJsrEAg==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso: Add generic random data storage
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250204-vdso-store-rng-v3-6-13a4669dfc8c@linutronix.de>
References: <20250204-vdso-store-rng-v3-6-13a4669dfc8c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174012859410.10177.5161727261224241718.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     51d6ca373f459fa6c91743e14ae69854d844aa38
Gitweb:        https://git.kernel.org/tip/51d6ca373f459fa6c91743e14ae69854d84=
4aa38
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 04 Feb 2025 13:05:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Feb 2025 09:54:01 +01:00

vdso: Add generic random data storage

Extend the generic vDSO data storage with a page for the random state data.
The random state data is stored in a dedicated page, as the existing
storage page is only meant for time-related, time-namespace-aware data.
This simplifies to access logic to not need to handle time namespaces
anymore and also frees up more space in the time-related page.

In case further generic vDSO data store is required it can be added to
the random state page.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250204-vdso-store-rng-v3-6-13a4669dfc8c@l=
inutronix.de

---
 drivers/char/random.c               |  6 +++---
 include/asm-generic/vdso/vsyscall.h | 12 ++++++++++++
 include/vdso/datapage.h             | 10 ++++++++++
 lib/vdso/datastore.c                | 14 ++++++++++++++
 lib/vdso/getrandom.c                |  8 ++++++--
 5 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 2581186..92cbd24 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -278,7 +278,7 @@ static void crng_reseed(struct work_struct *work)
 	WRITE_ONCE(base_crng.generation, next_gen);
 #ifdef CONFIG_VDSO_GETRANDOM
 	/* base_crng.generation's invalid value is ULONG_MAX, while
-	 * _vdso_rng_data.generation's invalid value is 0, so add one to the
+	 * vdso_k_rng_data->generation's invalid value is 0, so add one to the
 	 * former to arrive at the latter. Use smp_store_release so that this
 	 * is ordered with the write above to base_crng.generation. Pairs with
 	 * the smp_rmb() before the syscall in the vDSO code.
@@ -290,7 +290,7 @@ static void crng_reseed(struct work_struct *work)
 	 * because the vDSO side only checks whether the value changed, without
 	 * actually using or interpreting the value.
 	 */
-	smp_store_release((unsigned long *)&__arch_get_k_vdso_rng_data()->generatio=
n, next_gen + 1);
+	smp_store_release((unsigned long *)&vdso_k_rng_data->generation, next_gen +=
 1);
 #endif
 	if (!static_branch_likely(&crng_is_ready))
 		crng_init =3D CRNG_READY;
@@ -743,7 +743,7 @@ static void __cold _credit_init_bits(size_t bits)
 			queue_work(system_unbound_wq, &set_ready);
 		atomic_notifier_call_chain(&random_ready_notifier, 0, NULL);
 #ifdef CONFIG_VDSO_GETRANDOM
-		WRITE_ONCE(__arch_get_k_vdso_rng_data()->is_ready, true);
+		WRITE_ONCE(vdso_k_rng_data->is_ready, true);
 #endif
 		wake_up_interruptible(&crng_init_wait);
 		kill_fasync(&fasync, SIGIO, POLL_IN);
diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/v=
syscall.h
index ac5b93b..a5f973e 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -13,6 +13,13 @@ static __always_inline const struct vdso_time_data *__arch=
_get_vdso_u_time_data(
 }
 #endif
=20
+#ifndef __arch_get_vdso_u_rng_data
+static __always_inline const struct vdso_rng_data *__arch_get_vdso_u_rng_dat=
a(void)
+{
+	return &vdso_u_rng_data;
+}
+#endif
+
 #else  /* !CONFIG_GENERIC_VDSO_DATA_STORE */
=20
 #ifndef __arch_get_k_vdso_data
@@ -25,6 +32,11 @@ static __always_inline struct vdso_data *__arch_get_k_vdso=
_data(void)
=20
 #define __arch_get_vdso_u_time_data __arch_get_vdso_data
=20
+#ifndef __arch_get_vdso_u_rng_data
+#define __arch_get_vdso_u_rng_data() __arch_get_vdso_rng_data()
+#endif
+#define vdso_k_rng_data __arch_get_k_vdso_rng_data()
+
 #endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
=20
 #ifndef __arch_update_vsyscall
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index b3d8087..7dbc879 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -144,8 +144,10 @@ extern struct vdso_time_data _timens_data[CS_BASES] __at=
tribute__((visibility("h
 extern struct vdso_rng_data _vdso_rng_data __attribute__((visibility("hidden=
")));
 #else
 extern struct vdso_time_data vdso_u_time_data[CS_BASES] __attribute__((visib=
ility("hidden")));
+extern struct vdso_rng_data vdso_u_rng_data __attribute__((visibility("hidde=
n")));
=20
 extern struct vdso_time_data *vdso_k_time_data;
+extern struct vdso_rng_data *vdso_k_rng_data;
 #endif
=20
 /**
@@ -161,6 +163,7 @@ union vdso_data_store {
 enum vdso_pages {
 	VDSO_TIME_PAGE_OFFSET,
 	VDSO_TIMENS_PAGE_OFFSET,
+	VDSO_RNG_PAGE_OFFSET,
 	VDSO_NR_PAGES
 };
=20
@@ -184,9 +187,16 @@ enum vdso_pages {
=20
 #else /* !__ASSEMBLY__ */
=20
+#ifdef CONFIG_VDSO_GETRANDOM
+#define __vdso_u_rng_data	PROVIDE(vdso_u_rng_data =3D vdso_u_data + 2 * PAGE=
_SIZE);
+#else
+#define __vdso_u_rng_data
+#endif
+
 #define VDSO_VVAR_SYMS						\
 	PROVIDE(vdso_u_data =3D . - __VDSO_PAGES * PAGE_SIZE);	\
 	PROVIDE(vdso_u_time_data =3D vdso_u_data);		\
+	__vdso_u_rng_data					\
=20
=20
 #endif /* !__ASSEMBLY__ */
diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index d318176..9260b00 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -17,6 +17,15 @@ struct vdso_time_data *vdso_k_time_data =3D vdso_time_data=
_store.data;
 static_assert(sizeof(vdso_time_data_store) =3D=3D PAGE_SIZE);
 #endif /* CONFIG_HAVE_GENERIC_VDSO */
=20
+#ifdef CONFIG_VDSO_GETRANDOM
+static union {
+	struct vdso_rng_data	data;
+	u8			page[PAGE_SIZE];
+} vdso_rng_data_store __page_aligned_data;
+struct vdso_rng_data *vdso_k_rng_data =3D &vdso_rng_data_store.data;
+static_assert(sizeof(vdso_rng_data_store) =3D=3D PAGE_SIZE);
+#endif /* CONFIG_VDSO_GETRANDOM */
+
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 			     struct vm_area_struct *vma, struct vm_fault *vmf)
 {
@@ -53,6 +62,11 @@ static vm_fault_t vvar_fault(const struct vm_special_mappi=
ng *sm,
 			return VM_FAULT_SIGBUS;
 		pfn =3D __phys_to_pfn(__pa_symbol(vdso_k_time_data));
 		break;
+	case VDSO_RNG_PAGE_OFFSET:
+		if (!IS_ENABLED(CONFIG_VDSO_GETRANDOM))
+			return VM_FAULT_SIGBUS;
+		pfn =3D __phys_to_pfn(__pa_symbol(vdso_k_rng_data));
+		break;
 	default:
 		return VM_FAULT_SIGBUS;
 	}
diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
index 938ca53..440f8a6 100644
--- a/lib/vdso/getrandom.c
+++ b/lib/vdso/getrandom.c
@@ -12,6 +12,9 @@
 #include <uapi/linux/mman.h>
 #include <uapi/linux/random.h>
=20
+/* Bring in default accessors */
+#include <vdso/vsyscall.h>
+
 #undef PAGE_SIZE
 #undef PAGE_MASK
 #define PAGE_SIZE (1UL << CONFIG_PAGE_SHIFT)
@@ -152,7 +155,7 @@ retry_generation:
=20
 		/*
 		 * Prevent the syscall from being reordered wrt current_generation. Pairs =
with the
-		 * smp_store_release(&_vdso_rng_data.generation) in random.c.
+		 * smp_store_release(&vdso_k_rng_data->generation) in random.c.
 		 */
 		smp_rmb();
=20
@@ -256,5 +259,6 @@ fallback_syscall:
 static __always_inline ssize_t
 __cvdso_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque=
_state, size_t opaque_len)
 {
-	return __cvdso_getrandom_data(__arch_get_vdso_rng_data(), buffer, len, flag=
s, opaque_state, opaque_len);
+	return __cvdso_getrandom_data(__arch_get_vdso_u_rng_data(), buffer, len, fl=
ags,
+				      opaque_state, opaque_len);
 }

