Return-Path: <linux-tip-commits+bounces-3556-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B0EA3EF7A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 10:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE99703737
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 09:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1FC20550C;
	Fri, 21 Feb 2025 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vM1ujvsd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YcTda7EL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D194204C03;
	Fri, 21 Feb 2025 09:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128599; cv=none; b=hwV0MrllO+Ef2kiFg0Qa7CxkmNcJOXjUB6LdiRRkL+gEdnvF8bSpATPGBJsqXrRhpfgxnWMTxoW0HBvYSyd5z0mIs72Pts3OSFGSyl/EqkOGE+WRV38rr8V4ngYKhZSNnZO9IQIz3zHPhLhKzBZ3bdnuaBLChhhacSe1hOAsI70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128599; c=relaxed/simple;
	bh=JYZXIwZCrLsLi2kxUEoQAo9/cShPAgchfHJTKMCbihw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=azfV0va7sQLZSWLhRDMMNUdzJMcfBzQce9hSwUuHlMFs131CUVgyDW9iUmUhG45QdEv4MhNGAHN2KVzqBAh9MFU+pOfR/E+ifSKyccf+h8eWwEfyiWGAFkyemzX9H3CY/Hgw1CnYRl2CqL8XotJEqSZXT4uy7TG5VeDo8w41+90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vM1ujvsd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YcTda7EL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 09:03:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740128595;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0lT7VFfkh1HtK3vq5w31PiDZOnk+DcjylWeIHH/Sm8s=;
	b=vM1ujvsdS8pU3ls71ESODbVIUF5DQNeK9hwJY3QFf/Gx41aTah6MyImAPCpxT6QFD1r35x
	nGKFtrJgVrVoC9+FnMytgTR6OlFSkwamBdc3+p4ov2H/T4Kmg4BErAk5mjqcfKPQNFHE9r
	YR88YYZjNT2ihfEuK7wj5owugUGEvR2cwFuV9o5aM+wej/pa0JWDI/jTy6xKaCmj+/jCWd
	rvk2ll9OLrxnaiOYaYqNv32bTYj3qxjrfXjH8/K9KEr99ZJBfZSkIwblPTdYguTdnDMF1R
	tlpK6S2NuLS4uldrCygDgWkMguKse8WUD+x6t9eyDR3OqUJl9mS9moVTz3mPwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740128595;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0lT7VFfkh1HtK3vq5w31PiDZOnk+DcjylWeIHH/Sm8s=;
	b=YcTda7ELAtTyJpVQFoFhry47Tj2nIjAcdKXbeSatCjYe9UkPuRCeYAD8HbpmG2pO0OCWce
	i0PandO9YDpBoCDw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso: Add generic time data storage
Cc: Nam Cao <namcao@linutronix.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250204-vdso-store-rng-v3-5-13a4669dfc8c@linutronix.de>
References: <20250204-vdso-store-rng-v3-5-13a4669dfc8c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174012859478.10177.10181284205475901429.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     df7fcbefa71090a276fb841ffe19b8e5f12b4767
Gitweb:        https://git.kernel.org/tip/df7fcbefa71090a276fb841ffe19b8e5f12=
b4767
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 04 Feb 2025 13:05:37 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Feb 2025 09:54:01 +01:00

vdso: Add generic time data storage

Historically each architecture defined their own way to store the vDSO
data page. Add a generic mechanism to provide storage for that page.

Furthermore this generic storage will be extended to also provide
uniform storage for *non*-time-related data, like the random state or
architecture-specific data. These will have their own pages and data
structures, so rename 'vdso_data' into 'vdso_time_data' to make that
split clear from the name.

Also introduce a new consistent naming scheme for the symbols related to
the vDSO, which makes it clear if the symbol is accessible from
userspace or kernel space and the type of data behind the symbol.

The generic fault handler contains an optimization to prefault the vvar
page when the timens page is accessed. This was lifted from s390 and x86.

Co-developed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250204-vdso-store-rng-v3-5-13a4669dfc8c@l=
inutronix.de

---
 include/asm-generic/vdso/vsyscall.h |  16 ++++-
 include/linux/time_namespace.h      |   1 +-
 include/linux/vdso_datastore.h      |  10 +++-
 include/vdso/datapage.h             |  41 ++++++++---
 kernel/time/vsyscall.c              |   8 +-
 lib/Makefile                        |   2 +-
 lib/vdso/Kconfig                    |   5 +-
 lib/vdso/Makefile                   |   3 +-
 lib/vdso/datastore.c                | 103 +++++++++++++++++++++++++++-
 lib/vdso/gettimeofday.c             |  25 +++++--
 10 files changed, 195 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/vdso_datastore.h
 create mode 100644 lib/vdso/Makefile
 create mode 100644 lib/vdso/datastore.c

diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/v=
syscall.h
index 01dafd6..ac5b93b 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -4,12 +4,28 @@
=20
 #ifndef __ASSEMBLY__
=20
+#ifdef CONFIG_GENERIC_VDSO_DATA_STORE
+
+#ifndef __arch_get_vdso_u_time_data
+static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_d=
ata(void)
+{
+	return vdso_u_time_data;
+}
+#endif
+
+#else  /* !CONFIG_GENERIC_VDSO_DATA_STORE */
+
 #ifndef __arch_get_k_vdso_data
 static __always_inline struct vdso_data *__arch_get_k_vdso_data(void)
 {
 	return NULL;
 }
 #endif /* __arch_get_k_vdso_data */
+#define vdso_k_time_data __arch_get_k_vdso_data()
+
+#define __arch_get_vdso_u_time_data __arch_get_vdso_data
+
+#endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
=20
 #ifndef __arch_update_vsyscall
 static __always_inline void __arch_update_vsyscall(struct vdso_data *vdata)
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 876e31b..4b81db2 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -8,6 +8,7 @@
 #include <linux/ns_common.h>
 #include <linux/err.h>
 #include <linux/time64.h>
+#include <vdso/datapage.h>
=20
 struct user_namespace;
 extern struct user_namespace init_user_ns;
diff --git a/include/linux/vdso_datastore.h b/include/linux/vdso_datastore.h
new file mode 100644
index 0000000..a91fa24
--- /dev/null
+++ b/include/linux/vdso_datastore.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_VDSO_DATASTORE_H
+#define _LINUX_VDSO_DATASTORE_H
+
+#include <linux/mm_types.h>
+
+extern const struct vm_special_mapping vdso_vvar_mapping;
+struct vm_area_struct *vdso_install_vvar_mapping(struct mm_struct *mm, unsig=
ned long addr);
+
+#endif /* _LINUX_VDSO_DATASTORE_H */
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index d967baa..b3d8087 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -45,11 +45,11 @@ struct arch_vdso_time_data {};
  *
  * There is one vdso_timestamp object in vvar for each vDSO-accelerated
  * clock_id. For high-resolution clocks, this encodes the time
- * corresponding to vdso_data.cycle_last. For coarse clocks this encodes
+ * corresponding to vdso_time_data.cycle_last. For coarse clocks this encodes
  * the actual time.
  *
  * To be noticed that for highres clocks nsec is left-shifted by
- * vdso_data.cs[x].shift.
+ * vdso_time_data[x].shift.
  */
 struct vdso_timestamp {
 	u64	sec;
@@ -57,7 +57,7 @@ struct vdso_timestamp {
 };
=20
 /**
- * struct vdso_data - vdso datapage representation
+ * struct vdso_time_data - vdso datapage representation
  * @seq:		timebase sequence counter
  * @clock_mode:		clock mode
  * @cycle_last:		timebase at clocksource init
@@ -74,7 +74,7 @@ struct vdso_timestamp {
  * @arch_data:		architecture specific data (optional, defaults
  *			to an empty struct)
  *
- * vdso_data will be accessed by 64 bit and compat code at the same time
+ * vdso_time_data will be accessed by 64 bit and compat code at the same time
  * so we should be careful before modifying this structure.
  *
  * The ordering of the struct members is optimized to have fast access to the
@@ -92,7 +92,7 @@ struct vdso_timestamp {
  * For clocks which are not affected by time namespace adjustment the
  * offset must be zero.
  */
-struct vdso_data {
+struct vdso_time_data {
 	u32			seq;
=20
 	s32			clock_mode;
@@ -117,6 +117,8 @@ struct vdso_data {
 	struct arch_vdso_time_data arch_data;
 };
=20
+#define vdso_data vdso_time_data
+
 /**
  * struct vdso_rng_data - vdso RNG state information
  * @generation:	counter representing the number of RNG reseeds
@@ -136,18 +138,34 @@ struct vdso_rng_data {
  * With the hidden visibility, the compiler simply generates a PC-relative
  * relocation, and this is what we need.
  */
-extern struct vdso_data _vdso_data[CS_BASES] __attribute__((visibility("hidd=
en")));
-extern struct vdso_data _timens_data[CS_BASES] __attribute__((visibility("hi=
dden")));
+#ifndef CONFIG_GENERIC_VDSO_DATA_STORE
+extern struct vdso_time_data _vdso_data[CS_BASES] __attribute__((visibility(=
"hidden")));
+extern struct vdso_time_data _timens_data[CS_BASES] __attribute__((visibilit=
y("hidden")));
 extern struct vdso_rng_data _vdso_rng_data __attribute__((visibility("hidden=
")));
+#else
+extern struct vdso_time_data vdso_u_time_data[CS_BASES] __attribute__((visib=
ility("hidden")));
+
+extern struct vdso_time_data *vdso_k_time_data;
+#endif
=20
 /**
  * union vdso_data_store - Generic vDSO data page
  */
 union vdso_data_store {
-	struct vdso_data	data[CS_BASES];
+	struct vdso_time_data	data[CS_BASES];
 	u8			page[1U << CONFIG_PAGE_SHIFT];
 };
=20
+#ifdef CONFIG_GENERIC_VDSO_DATA_STORE
+
+enum vdso_pages {
+	VDSO_TIME_PAGE_OFFSET,
+	VDSO_TIMENS_PAGE_OFFSET,
+	VDSO_NR_PAGES
+};
+
+#endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
+
 /*
  * The generic vDSO implementation requires that gettimeofday.h
  * provides:
@@ -164,6 +182,13 @@ union vdso_data_store {
 #include <asm/vdso/gettimeofday.h>
 #endif /* ENABLE_COMPAT_VDSO */
=20
+#else /* !__ASSEMBLY__ */
+
+#define VDSO_VVAR_SYMS						\
+	PROVIDE(vdso_u_data =3D . - __VDSO_PAGES * PAGE_SIZE);	\
+	PROVIDE(vdso_u_time_data =3D vdso_u_data);		\
+
+
 #endif /* !__ASSEMBLY__ */
=20
 #endif /* __VDSO_DATAPAGE_H */
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 05d3831..09c1e39 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -77,7 +77,7 @@ static inline void update_vdso_data(struct vdso_data *vdata,
=20
 void update_vsyscall(struct timekeeper *tk)
 {
-	struct vdso_data *vdata =3D __arch_get_k_vdso_data();
+	struct vdso_data *vdata =3D vdso_k_time_data;
 	struct vdso_timestamp *vdso_ts;
 	s32 clock_mode;
 	u64 nsec;
@@ -128,7 +128,7 @@ void update_vsyscall(struct timekeeper *tk)
=20
 void update_vsyscall_tz(void)
 {
-	struct vdso_data *vdata =3D __arch_get_k_vdso_data();
+	struct vdso_data *vdata =3D vdso_k_time_data;
=20
 	vdata[CS_HRES_COARSE].tz_minuteswest =3D sys_tz.tz_minuteswest;
 	vdata[CS_HRES_COARSE].tz_dsttime =3D sys_tz.tz_dsttime;
@@ -150,7 +150,7 @@ void update_vsyscall_tz(void)
  */
 unsigned long vdso_update_begin(void)
 {
-	struct vdso_data *vdata =3D __arch_get_k_vdso_data();
+	struct vdso_data *vdata =3D vdso_k_time_data;
 	unsigned long flags =3D timekeeper_lock_irqsave();
=20
 	vdso_write_begin(vdata);
@@ -167,7 +167,7 @@ unsigned long vdso_update_begin(void)
  */
 void vdso_update_end(unsigned long flags)
 {
-	struct vdso_data *vdata =3D __arch_get_k_vdso_data();
+	struct vdso_data *vdata =3D vdso_k_time_data;
=20
 	vdso_write_end(vdata);
 	__arch_sync_vdso_data(vdata);
diff --git a/lib/Makefile b/lib/Makefile
index d5cfc7a..fcdee83 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -132,7 +132,7 @@ endif
 obj-$(CONFIG_DEBUG_INFO_REDUCED) +=3D debug_info.o
 CFLAGS_debug_info.o +=3D $(call cc-option, -femit-struct-debug-detailed=3Dan=
y)
=20
-obj-y +=3D math/ crypto/
+obj-y +=3D math/ crypto/ vdso/
=20
 obj-$(CONFIG_GENERIC_IOMAP) +=3D iomap.o
 obj-$(CONFIG_HAS_IOMEM) +=3D iomap_copy.o devres.o
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index 82fe827..45df764 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -43,3 +43,8 @@ config VDSO_GETRANDOM
 	bool
 	help
 	  Selected by architectures that support vDSO getrandom().
+
+config GENERIC_VDSO_DATA_STORE
+	bool
+	help
+	  Selected by architectures that use the generic vDSO data store.
diff --git a/lib/vdso/Makefile b/lib/vdso/Makefile
new file mode 100644
index 0000000..aedd40a
--- /dev/null
+++ b/lib/vdso/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_GENERIC_VDSO_DATA_STORE) +=3D datastore.o
diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
new file mode 100644
index 0000000..d318176
--- /dev/null
+++ b/lib/vdso/datastore.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/linkage.h>
+#include <linux/mmap_lock.h>
+#include <linux/mm.h>
+#include <linux/time_namespace.h>
+#include <linux/types.h>
+#include <linux/vdso_datastore.h>
+#include <vdso/datapage.h>
+
+/*
+ * The vDSO data page.
+ */
+#ifdef CONFIG_HAVE_GENERIC_VDSO
+static union vdso_data_store vdso_time_data_store __page_aligned_data;
+struct vdso_time_data *vdso_k_time_data =3D vdso_time_data_store.data;
+static_assert(sizeof(vdso_time_data_store) =3D=3D PAGE_SIZE);
+#endif /* CONFIG_HAVE_GENERIC_VDSO */
+
+static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
+			     struct vm_area_struct *vma, struct vm_fault *vmf)
+{
+	struct page *timens_page =3D find_timens_vvar_page(vma);
+	unsigned long addr, pfn;
+	vm_fault_t err;
+
+	switch (vmf->pgoff) {
+	case VDSO_TIME_PAGE_OFFSET:
+		if (!IS_ENABLED(CONFIG_HAVE_GENERIC_VDSO))
+			return VM_FAULT_SIGBUS;
+		pfn =3D __phys_to_pfn(__pa_symbol(vdso_k_time_data));
+		if (timens_page) {
+			/*
+			 * Fault in VVAR page too, since it will be accessed
+			 * to get clock data anyway.
+			 */
+			addr =3D vmf->address + VDSO_TIMENS_PAGE_OFFSET * PAGE_SIZE;
+			err =3D vmf_insert_pfn(vma, addr, pfn);
+			if (unlikely(err & VM_FAULT_ERROR))
+				return err;
+			pfn =3D page_to_pfn(timens_page);
+		}
+		break;
+	case VDSO_TIMENS_PAGE_OFFSET:
+		/*
+		 * If a task belongs to a time namespace then a namespace
+		 * specific VVAR is mapped with the VVAR_DATA_PAGE_OFFSET and
+		 * the real VVAR page is mapped with the VVAR_TIMENS_PAGE_OFFSET
+		 * offset.
+		 * See also the comment near timens_setup_vdso_data().
+		 */
+		if (!IS_ENABLED(CONFIG_TIME_NS) || !timens_page)
+			return VM_FAULT_SIGBUS;
+		pfn =3D __phys_to_pfn(__pa_symbol(vdso_k_time_data));
+		break;
+	default:
+		return VM_FAULT_SIGBUS;
+	}
+
+	return vmf_insert_pfn(vma, vmf->address, pfn);
+}
+
+const struct vm_special_mapping vdso_vvar_mapping =3D {
+	.name	=3D "[vvar]",
+	.fault	=3D vvar_fault,
+};
+
+struct vm_area_struct *vdso_install_vvar_mapping(struct mm_struct *mm, unsig=
ned long addr)
+{
+	return _install_special_mapping(mm, addr, VDSO_NR_PAGES * PAGE_SIZE,
+					VM_READ | VM_MAYREAD | VM_IO | VM_DONTDUMP | VM_PFNMAP,
+					&vdso_vvar_mapping);
+}
+
+#ifdef CONFIG_TIME_NS
+/*
+ * The vvar page layout depends on whether a task belongs to the root or
+ * non-root time namespace. Whenever a task changes its namespace, the VVAR
+ * page tables are cleared and then they will be re-faulted with a
+ * corresponding layout.
+ * See also the comment near timens_setup_vdso_data() for details.
+ */
+int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
+{
+	struct mm_struct *mm =3D task->mm;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
+
+	mmap_read_lock(mm);
+	for_each_vma(vmi, vma) {
+		if (vma_is_special_mapping(vma, &vdso_vvar_mapping))
+			zap_vma_pages(vma);
+	}
+	mmap_read_unlock(mm);
+
+	return 0;
+}
+
+struct vdso_time_data *arch_get_vdso_data(void *vvar_page)
+{
+	return (struct vdso_time_data *)vvar_page;
+}
+#endif
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index c01eaaf..20c5b87 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -5,6 +5,9 @@
 #include <vdso/datapage.h>
 #include <vdso/helpers.h>
=20
+/* Bring in default accessors */
+#include <vdso/vsyscall.h>
+
 #ifndef vdso_calc_ns
=20
 #ifdef VDSO_DELTA_NOMASK
@@ -69,6 +72,16 @@ static inline bool vdso_cycles_ok(u64 cycles)
 #endif
=20
 #ifdef CONFIG_TIME_NS
+
+#ifdef CONFIG_GENERIC_VDSO_DATA_STORE
+static __always_inline
+const struct vdso_time_data *__arch_get_vdso_u_timens_data(const struct vdso=
_time_data *vd)
+{
+	return (void *)vd + PAGE_SIZE;
+}
+#define __arch_get_timens_vdso_data(vd) __arch_get_vdso_u_timens_data(vd)
+#endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
+
 static __always_inline int do_hres_timens(const struct vdso_data *vdns, cloc=
kid_t clk,
 					  struct __kernel_timespec *ts)
 {
@@ -282,7 +295,7 @@ __cvdso_clock_gettime_data(const struct vdso_data *vd, cl=
ockid_t clock,
 static __maybe_unused int
 __cvdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
 {
-	return __cvdso_clock_gettime_data(__arch_get_vdso_data(), clock, ts);
+	return __cvdso_clock_gettime_data(__arch_get_vdso_u_time_data(), clock, ts);
 }
=20
 #ifdef BUILD_VDSO32
@@ -308,7 +321,7 @@ __cvdso_clock_gettime32_data(const struct vdso_data *vd, =
clockid_t clock,
 static __maybe_unused int
 __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
 {
-	return __cvdso_clock_gettime32_data(__arch_get_vdso_data(), clock, res);
+	return __cvdso_clock_gettime32_data(__arch_get_vdso_u_time_data(), clock, r=
es);
 }
 #endif /* BUILD_VDSO32 */
=20
@@ -342,7 +355,7 @@ __cvdso_gettimeofday_data(const struct vdso_data *vd,
 static __maybe_unused int
 __cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 {
-	return __cvdso_gettimeofday_data(__arch_get_vdso_data(), tv, tz);
+	return __cvdso_gettimeofday_data(__arch_get_vdso_u_time_data(), tv, tz);
 }
=20
 #ifdef VDSO_HAS_TIME
@@ -365,7 +378,7 @@ __cvdso_time_data(const struct vdso_data *vd, __kernel_ol=
d_time_t *time)
=20
 static __maybe_unused __kernel_old_time_t __cvdso_time(__kernel_old_time_t *=
time)
 {
-	return __cvdso_time_data(__arch_get_vdso_data(), time);
+	return __cvdso_time_data(__arch_get_vdso_u_time_data(), time);
 }
 #endif /* VDSO_HAS_TIME */
=20
@@ -425,7 +438,7 @@ int __cvdso_clock_getres_data(const struct vdso_data *vd,=
 clockid_t clock,
 static __maybe_unused
 int __cvdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
 {
-	return __cvdso_clock_getres_data(__arch_get_vdso_data(), clock, res);
+	return __cvdso_clock_getres_data(__arch_get_vdso_u_time_data(), clock, res);
 }
=20
 #ifdef BUILD_VDSO32
@@ -451,7 +464,7 @@ __cvdso_clock_getres_time32_data(const struct vdso_data *=
vd, clockid_t clock,
 static __maybe_unused int
 __cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
 {
-	return __cvdso_clock_getres_time32_data(__arch_get_vdso_data(),
+	return __cvdso_clock_getres_time32_data(__arch_get_vdso_u_time_data(),
 						clock, res);
 }
 #endif /* BUILD_VDSO32 */

