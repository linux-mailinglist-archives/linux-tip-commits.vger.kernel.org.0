Return-Path: <linux-tip-commits+bounces-7142-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CAFC2870A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77DE189C01D
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67A93090CF;
	Sat,  1 Nov 2025 19:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4uvjdPDH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vcE+aJVv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99579306B38;
	Sat,  1 Nov 2025 19:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026471; cv=none; b=CujBGIv9Mz8L6IChd2KfhJ+nGmIKaG0HuU+4YLFRAYOH/WUCjUgpT1Dh5VwFWo95nIm/svI+owrkX6wXDBU99iSOcy37TaYzNF8KD5lCmUbLfwg3dhNpIGR6tRoCYdiZfnSDgVhrIKurIdRJTzyTkdGrtA8nLICpXbNIIAKATmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026471; c=relaxed/simple;
	bh=spZ/KVOnPawUXvgb1uwCsd9rT4FqVaWyKfpXgGah5ks=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tGJkpoCv1zQ9gX+iUwJ7bHpwb8rSFcW55nwCvxesG/9e6t+1gXcGkRsRpsV2wsA3jPwoZEAX1hRXDhkGNgYq0OoUdB+OYu5qA15dTpnvQoWLQkrx2S9qc7NaJ8f6JmI/WoMNhndmqyI9/u6Il3/wm+iND9AKJtF23DZIAeHqHXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4uvjdPDH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vcE+aJVv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:47:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026468;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KC+JfvQkoiR1bWRq86atXh2FFHdLaM5f0fv1CSEf858=;
	b=4uvjdPDHRE7XFmOaqyCEaMbR3p3vKNNxoPsPiYDVqJIYJZtv4cDT5k78DJvPjYmWanZAQ6
	I314UnxCwpO//ebpuTkbK+LDpuURlHAm422abJ4Ph1BNP2Kw+FnRFpedtYsccJPsYZM5/4
	BVLXGSJ0LGdFFpLOydk1DRhMYOGrMJrticqYvd6RrqxvOtaxvN/I6B01AaUX2yk1dx7TvO
	QM+WIvrUeLDwTYlnaFkfPwF/jGEgG9sndz2jOiWJsEfls8/lO2Bgu2HoX8tWi1DuOBy+5K
	EmLTRJ0eou9fhzMYgf5+kquP90xD8S/IbzI+vRoRvfH6qkkFGuWSp4rT3q1tUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026468;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KC+JfvQkoiR1bWRq86atXh2FFHdLaM5f0fv1CSEf858=;
	b=vcE+aJVv6rflhL709S5QfIswgQHZHomUtvFcl7fKI30HhmC0yXAO3kJn2piXiwgydpRQSI
	G136wSlIvpAptuBg==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso/datastore: Allocate data pages dynamically
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20251014-vdso-sparc64-generic-2-v4-24-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-24-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202646672.2601451.370747723118589654.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     10d91dac2ea5ddf04e647cf862430d1051adb839
Gitweb:        https://git.kernel.org/tip/10d91dac2ea5ddf04e647cf862430d1051a=
db839
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:49:10 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:06 +01:00

vdso/datastore: Allocate data pages dynamically

Allocating the datapages as part of the kernel image does not work on
SPARC. It is also problematic with regards to dcache aliasing as there is
no guarantee that the virtual addresses used by the kernel are compatible
with those used by userspace.

Allocate the data pages through the page allocator instead.
Unused pages in the vDSO VMA are still allocated to keep the virtual
addresses aligned.

These pages are used by both the timekeeping, random pool and architecture
initialization code. Introduce a new early initialization step, to make
sure they are available when needed.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-24-e0607bf4=
9dea@linutronix.de
---
 include/linux/vdso_datastore.h |  6 +++++-
 init/main.c                    |  2 ++-
 lib/vdso/datastore.c           | 44 +++++++++++++++++----------------
 3 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/include/linux/vdso_datastore.h b/include/linux/vdso_datastore.h
index a91fa24..0b53042 100644
--- a/include/linux/vdso_datastore.h
+++ b/include/linux/vdso_datastore.h
@@ -2,9 +2,15 @@
 #ifndef _LINUX_VDSO_DATASTORE_H
 #define _LINUX_VDSO_DATASTORE_H
=20
+#ifdef CONFIG_HAVE_GENERIC_VDSO
 #include <linux/mm_types.h>
=20
 extern const struct vm_special_mapping vdso_vvar_mapping;
 struct vm_area_struct *vdso_install_vvar_mapping(struct mm_struct *mm, unsig=
ned long addr);
=20
+void __init vdso_setup_data_pages(void);
+#else /* !CONFIG_HAVE_GENERIC_VDSO */
+static inline void vdso_setup_data_pages(void) { }
+#endif /* CONFIG_HAVE_GENERIC_VDSO */
+
 #endif /* _LINUX_VDSO_DATASTORE_H */
diff --git a/init/main.c b/init/main.c
index 07a3116..01fa389 100644
--- a/init/main.c
+++ b/init/main.c
@@ -104,6 +104,7 @@
 #include <linux/pidfs.h>
 #include <linux/ptdump.h>
 #include <linux/time_namespace.h>
+#include <linux/vdso_datastore.h>
 #include <net/net_namespace.h>
=20
 #include <asm/io.h>
@@ -1020,6 +1021,7 @@ void start_kernel(void)
 	srcu_init();
 	hrtimers_init();
 	softirq_init();
+	vdso_setup_data_pages();
 	timekeeping_init();
 	time_init();
=20
diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index 6e5feb4..67799e8 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -1,41 +1,43 @@
 // SPDX-License-Identifier: GPL-2.0-only
=20
-#include <linux/linkage.h>
 #include <linux/mm.h>
 #include <linux/time_namespace.h>
 #include <linux/types.h>
 #include <linux/vdso_datastore.h>
 #include <vdso/datapage.h>
=20
-/*
- * The vDSO data page.
- */
 #ifdef CONFIG_GENERIC_GETTIMEOFDAY
-static union {
-	struct vdso_time_data	data;
-	u8			page[PAGE_SIZE];
-} vdso_time_data_store __page_aligned_data;
-struct vdso_time_data *vdso_k_time_data =3D &vdso_time_data_store.data;
-static_assert(sizeof(vdso_time_data_store) =3D=3D PAGE_SIZE);
+struct vdso_time_data *vdso_k_time_data;
+static_assert(sizeof(struct vdso_time_data) <=3D PAGE_SIZE);
 #endif /* CONFIG_GENERIC_GETTIMEOFDAY */
=20
 #ifdef CONFIG_VDSO_GETRANDOM
-static union {
-	struct vdso_rng_data	data;
-	u8			page[PAGE_SIZE];
-} vdso_rng_data_store __page_aligned_data;
-struct vdso_rng_data *vdso_k_rng_data =3D &vdso_rng_data_store.data;
-static_assert(sizeof(vdso_rng_data_store) =3D=3D PAGE_SIZE);
+struct vdso_rng_data *vdso_k_rng_data;
+static_assert(sizeof(struct vdso_rng_data) <=3D PAGE_SIZE);
 #endif /* CONFIG_VDSO_GETRANDOM */
=20
 #ifdef CONFIG_ARCH_HAS_VDSO_ARCH_DATA
-static union {
-	struct vdso_arch_data	data;
-	u8			page[VDSO_ARCH_DATA_SIZE];
-} vdso_arch_data_store __page_aligned_data;
-struct vdso_arch_data *vdso_k_arch_data =3D &vdso_arch_data_store.data;
+struct vdso_arch_data *vdso_k_arch_data;
 #endif /* CONFIG_ARCH_HAS_VDSO_ARCH_DATA */
=20
+void __init vdso_setup_data_pages(void)
+{
+	unsigned int order =3D get_order(VDSO_NR_PAGES * PAGE_SIZE);
+	struct folio *folio =3D folio_alloc(GFP_KERNEL, order);
+
+	if (!folio)
+		panic("Unable to allocate VDSO storage pages");
+
+	if (IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY))
+		vdso_k_time_data =3D page_address(folio_page(folio, VDSO_TIME_PAGE_OFFSET)=
);
+
+	if (IS_ENABLED(CONFIG_VDSO_GETRANDOM))
+		vdso_k_rng_data =3D page_address(folio_page(folio, VDSO_RNG_PAGE_OFFSET));
+
+	if (IS_ENABLED(CONFIG_ARCH_HAS_VDSO_ARCH_DATA))
+		vdso_k_arch_data =3D page_address(folio_page(folio, VDSO_ARCH_PAGES_START)=
);
+}
+
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 			     struct vm_area_struct *vma, struct vm_fault *vmf)
 {

