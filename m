Return-Path: <linux-tip-commits+bounces-2437-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B969099F21D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BC6283A37
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8D51F667B;
	Tue, 15 Oct 2024 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CC9hd5WR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ug8KGtmD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C901E6339;
	Tue, 15 Oct 2024 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007881; cv=none; b=ko5S2yVm/aF5q1PYsrHAv6uFnQ4Z4qDJ2YGNDusVc9G9lpvDEjiNoRACNlDx+6fx86tS3ZhjNVIxj19gkmWWRw6qIKjyd5spfv+wQsHaZD1McF/zZJSPgl4oQkm4veOFANLQH5xKIKf3pqpFZkz3Z1bEMkfYfKKkpd7qT5p8vEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007881; c=relaxed/simple;
	bh=jjNBQx8+aDp24/jMeNkr9bSEemHRo+VrDqPfJrlG0q0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CjkFMZYJXEDPIICwl06WZCE9pylEjSeDprBf8kgKA3laKUv8oVTSMLYYXFpK/eSfoeRa0kpiNcLt2iv4SWrm1cMCrrFwydSp1MJ1svVme5CCFM4yA3nT64Da6cnEu+k1VhQVvxY68YL72ChI1klecGwff09x+u/IIpf3JAWoY+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CC9hd5WR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ug8KGtmD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:57:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729007878;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n9VIyQEcwy6UZ4pH6ZOO0B9Ft6nHAnBBEitYtzrfwR8=;
	b=CC9hd5WRQ8opcPSzWYWVPapCUuZAiOwABF8Pqeln2qxfmhIDvdCvrAIQPwNf+59HCSW+cQ
	d8oQ+nJDcrGcCRV5KoQWF+fmtz1ApJZNfJgEdZcWfx+2NCaV/ecoYA4UudIP4eZbsZEc6N
	c2vu1NoYyd4yqdxoV0FQm+41wrobPJtPwfAovjeUYmjUK8vKWHvfhch2vN/WSYCLOuuvAc
	5WccBFX53H7RCo+O8fx60eD2Jm+iLcVEE2sry4+4AX3dvWy8MKo1Mdatja4+vZxHhUqa2E
	g+fkg6K5lBEmTVN6YCn8bCe4yuqp+ayQmBF59w/NRFiy7fzafFpuuJ/WLbPyMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729007878;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n9VIyQEcwy6UZ4pH6ZOO0B9Ft6nHAnBBEitYtzrfwR8=;
	b=Ug8KGtmD/TyiaKLcUG9dJJV1ux4mgDVQ3SAilglTe4o770tERlgmJ244ZGLhGZd2bxW+yk
	CHuKGkpPHDJlG9Aw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] s390/vdso: Remove timekeeper includes
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20241010-vdso-generic-arch_update_vsyscall-v1-6-7fe5a3ea4382@linutronix.de>
References:
 <20241010-vdso-generic-arch_update_vsyscall-v1-6-7fe5a3ea4382@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900787748.1442.6057222001005792891.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     3aa8881ebd1e673fd21785352bf5e78c2597b18f
Gitweb:        https://git.kernel.org/tip/3aa8881ebd1e673fd21785352bf5e78c259=
7b18f
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 17:44:49 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:50:29 +02:00

s390/vdso: Remove timekeeper includes

Since the generic VDSO clock mode storage is used, this header file is
unused and can be removed.

This avoids including a non-VDSO header while building the VDSO,
which can lead to compilation errors.

Also drop the comment which is out of date and in the wrong place.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Link: https://lore.kernel.org/all/20241010-vdso-generic-arch_update_vsyscall-=
v1-6-7fe5a3ea4382@linutronix.de

---
 arch/s390/include/asm/vdso/vsyscall.h | 5 -----
 arch/s390/kernel/time.c               | 1 -
 2 files changed, 6 deletions(-)

diff --git a/arch/s390/include/asm/vdso/vsyscall.h b/arch/s390/include/asm/vd=
so/vsyscall.h
index 3c5d5e4..3eb576e 100644
--- a/arch/s390/include/asm/vdso/vsyscall.h
+++ b/arch/s390/include/asm/vdso/vsyscall.h
@@ -7,7 +7,6 @@
 #ifndef __ASSEMBLY__
=20
 #include <linux/hrtimer.h>
-#include <linux/timekeeper_internal.h>
 #include <vdso/datapage.h>
 #include <asm/vdso.h>
=20
@@ -17,10 +16,6 @@ enum vvar_pages {
 	VVAR_NR_PAGES
 };
=20
-/*
- * Update the vDSO data page to keep in sync with kernel timekeeping.
- */
-
 static __always_inline struct vdso_data *__s390_get_k_vdso_data(void)
 {
 	return vdso_data;
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index b713eff..4fae6c7 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -36,7 +36,6 @@
 #include <linux/profile.h>
 #include <linux/timex.h>
 #include <linux/notifier.h>
-#include <linux/timekeeper_internal.h>
 #include <linux/clockchips.h>
 #include <linux/gfp.h>
 #include <linux/kprobes.h>

