Return-Path: <linux-tip-commits+bounces-2434-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA8699F217
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C55F5B2079A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943861DD0D9;
	Tue, 15 Oct 2024 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DxdERTF6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cQAGyM3T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF641CB9EB;
	Tue, 15 Oct 2024 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007879; cv=none; b=rZ9Vm9SHZIU1xd5WR4KlaCg+9XlUncTzsM5UkNjweRobclGvs6CRR3d0dtE07Y93ZxoczFj6yET3aGPAPIWA21TMCzQFtJwYAUdakIM2eCDUteNLGjGZpWnxl6MUeL072RL1/MDoZ1+sQZJ2dyhjpFSK18k8341ws6oi7Dk22Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007879; c=relaxed/simple;
	bh=CTjxBv36ucQNmHNWTHSbRH6smp7AllgxG5H5+BywLXE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FZRuTK10WHNbowaCxw0ux8ay/ny7JSVhM8xZCeivdvghqiKlpfubzwtfGYGoHdtjx8Zwajzmlyh0a4pWTdWF0jVnp9Cd7ouGhER1I7K7DBIz/1bIprSuctprXVJI6iXiKXbd75byuTWiF3h69SXHg54cI0JfrAl6PxJn36Z54/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DxdERTF6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cQAGyM3T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:57:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729007876;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WkdkKJubb843TnOnVoxBH520L24SLlk+tQkelebZlUs=;
	b=DxdERTF69KZFrQc8EnZUI1jLOJcZzgUpjgZLHU7cC4ZpgaoQsjkZ1bR+QyiAzWBY5IydNv
	qdmXG3KPkTGAjBB6ucCJAJE6mVAAkVDDqc1VMVcv6bEH4nYZcrwcNsjxM2Ctpj1GYvIgIk
	IqBR1uf2vzirzVjhLMj+oHGpnOwcNMyp+HvBczW8107VwLrBIwOwRI0fHxAkdVHccLe3Tu
	jCzfxqJsX3eQ+nmr03LDQBYgeO83Bzvqvctn23jeWtrpJf0e1euGnvdbQduazfBRmSRfGR
	/6P0Yaw9kZKypUO1b54QrmVjtwmz4XYOs9mXNun0t3JL992+IBexrU59T52r6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729007876;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WkdkKJubb843TnOnVoxBH520L24SLlk+tQkelebZlUs=;
	b=cQAGyM3Tr3pq0vo0g50VSv0Vv9rDr32p/DwgO6alqfxxaVZHyxS+6h/wkM9BJSo6ZC2bAY
	we+3XtgYGDFTgHAQ==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] MIPS: vdso: Remove timekeeper includes
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20241010-vdso-generic-arch_update_vsyscall-v1-9-7fe5a3ea4382@linutronix.de>
References:
 <20241010-vdso-generic-arch_update_vsyscall-v1-9-7fe5a3ea4382@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900787559.1442.13120419839191821023.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     c0fba50a1e672629588c28ed70f01d516c1e1b27
Gitweb:        https://git.kernel.org/tip/c0fba50a1e672629588c28ed70f01d516c1=
e1b27
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 17:44:52 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:50:29 +02:00

MIPS: vdso: Remove timekeeper includes

Since the generic VDSO clock mode storage is used, this header file is
unused and can be removed.

This avoids including a non-VDSO header while building the VDSO,
which can lead to compilation errors.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-arch_update_vsyscall-=
v1-9-7fe5a3ea4382@linutronix.de

---
 arch/mips/include/asm/vdso/vsyscall.h | 1 -
 arch/mips/kernel/vdso.c               | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/mips/include/asm/vdso/vsyscall.h b/arch/mips/include/asm/vd=
so/vsyscall.h
index 47168aa..a458287 100644
--- a/arch/mips/include/asm/vdso/vsyscall.h
+++ b/arch/mips/include/asm/vdso/vsyscall.h
@@ -4,7 +4,6 @@
=20
 #ifndef __ASSEMBLY__
=20
-#include <linux/timekeeper_internal.h>
 #include <vdso/datapage.h>
=20
 extern struct vdso_data *vdso_data;
diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index dda36fa..4c8e3c0 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -14,7 +14,6 @@
 #include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/timekeeper_internal.h>
=20
 #include <asm/abi.h>
 #include <asm/mips-cps.h>

