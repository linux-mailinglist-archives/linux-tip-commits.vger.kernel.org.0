Return-Path: <linux-tip-commits+bounces-2747-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EB29B9FC1
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 12:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 433DCB22298
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD5A1B3929;
	Sat,  2 Nov 2024 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VEn+QVYl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/tfoYC7a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD731B218A;
	Sat,  2 Nov 2024 11:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548233; cv=none; b=TuDds9cDH4DMkbIxfZzOtoX/V3ib+GAh1AV/ZzOTukEZbzfVkOChXseTfoXRs9CR7eIoJJwkPne5fR8nC5AYxOzO4smnqx9wSaH6/XP52u32NfEjq8ual1FziwQ0gUhUSEyzalCeksG5ERgF+oHfnZaUZnKtca9bExcSxOSa3UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548233; c=relaxed/simple;
	bh=wTdealsDTko9SekjX9xNbF0QMUUPgjT4TSToPoZwxaQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nGbMcBt4cbCdy+UX9X1UvaOQmn2wQ33kn+rsI/BELCXoxl9cutvoN+QpOlUoa8KLCAi9G0t+MRKUTIyVZ1b87yxxna+zjHZDCEYJTjmhwBE5a33TzSEFy4ZgyM9ZCeeAkJ41CD/gdGtrx5G+DKkw07B9+fTnfO196IbwF0nPOso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VEn+QVYl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/tfoYC7a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 11:50:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730548230;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYOKq/d7+Pg/dGOgPGdIS/54hQJHvZQ0joExJHtkD7Y=;
	b=VEn+QVYl/kV/5yjGjIJxsPhmHlylbUM3llZ+6gYvEJTTcFx+5XxluQGXByJBppJ9Wpbu9Z
	8ThsAngC2qfR+xZbc+2qyVyscnRY+E9ijXmIWXZrIPzTBLRQh/E3bMJsUMg0+F4vCz4Rnm
	XM7r68l2lcPne2qft75/dMBvSdOhlQCOgxDmjDUv/JKMIE3Tijkz6KYicaXHNOhqpN2F0O
	5OZLNYkpKnqy3x8KeP+Udv3q2hmVRRNqCflykKz518mfUyZJtPoHZWqpjyqKfQ0yuLRbzf
	N/RFm7Jmu4UVdAoFZEXbeqn+t5K2jUfH+QFj+QIKBTolvPRnRbLYRocKbrc4oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730548230;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYOKq/d7+Pg/dGOgPGdIS/54hQJHvZQ0joExJHtkD7Y=;
	b=/tfoYC7ap9OqxB4OLs/PH6LOLdKYLBWf70QpeM+zJmCcjLDHxXCC0qNknaeuY7RzhwttUQ
	aBn61qkoG2xlCtAA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] s390/vdso: Drop LBASE_VDSO
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-3-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-3-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054822964.3137.7503343391853382934.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     98333a84e3318a1dd08a3ec6def98abfb8215cdb
Gitweb:        https://git.kernel.org/tip/98333a84e3318a1dd08a3ec6def98abfb82=
15cdb
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 12:37:32 +01:00

s390/vdso: Drop LBASE_VDSO

This constant is always "0", providing no value and making the logic
harder to understand.
Also prepare for a consolidation of the vdso linkerscript logic by
aligning it with other architectures.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-3-b64f0842d51=
2@linutronix.de

---
 arch/s390/include/asm/vdso.h         | 3 ---
 arch/s390/kernel/vdso32/vdso32.lds.S | 2 +-
 arch/s390/kernel/vdso64/vdso64.lds.S | 2 +-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/vdso.h b/arch/s390/include/asm/vdso.h
index 91061f0..92c73e4 100644
--- a/arch/s390/include/asm/vdso.h
+++ b/arch/s390/include/asm/vdso.h
@@ -12,9 +12,6 @@ int vdso_getcpu_init(void);
=20
 #endif /* __ASSEMBLY__ */
=20
-/* Default link address for the vDSO */
-#define VDSO_LBASE	0
-
 #define __VVAR_PAGES	2
=20
 #define VDSO_VERSION_STRING	LINUX_2.6.29
diff --git a/arch/s390/kernel/vdso32/vdso32.lds.S b/arch/s390/kernel/vdso32/v=
dso32.lds.S
index 65b9513..c916c4f 100644
--- a/arch/s390/kernel/vdso32/vdso32.lds.S
+++ b/arch/s390/kernel/vdso32/vdso32.lds.S
@@ -16,7 +16,7 @@ SECTIONS
 #ifdef CONFIG_TIME_NS
 	PROVIDE(_timens_data =3D _vdso_data + PAGE_SIZE);
 #endif
-	. =3D VDSO_LBASE + SIZEOF_HEADERS;
+	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text
 	.gnu.hash	: { *(.gnu.hash) }
diff --git a/arch/s390/kernel/vdso64/vdso64.lds.S b/arch/s390/kernel/vdso64/v=
dso64.lds.S
index 753040a..ec42b7d 100644
--- a/arch/s390/kernel/vdso64/vdso64.lds.S
+++ b/arch/s390/kernel/vdso64/vdso64.lds.S
@@ -18,7 +18,7 @@ SECTIONS
 #ifdef CONFIG_TIME_NS
 	PROVIDE(_timens_data =3D _vdso_data + PAGE_SIZE);
 #endif
-	. =3D VDSO_LBASE + SIZEOF_HEADERS;
+	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text
 	.gnu.hash	: { *(.gnu.hash) }

