Return-Path: <linux-tip-commits+bounces-2701-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F9A9B9E96
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC24281E69
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 10:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C82217B400;
	Sat,  2 Nov 2024 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="duMBdsXq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DTSDYbQb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4217E172798;
	Sat,  2 Nov 2024 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542217; cv=none; b=Wgg+G3nvd2stRxa3SpwRydP+LBGry8r2z6fefu29vmwrFcGrptm2L5bn9E2aiRsNCIIT0Gnv8QfuchuqnxyBUZRtOxr9Jm58V45I7bmKNDxtiBjRUUl1Y8nSenARs8ZWva1UFeFwIqil7TnDIh2a1VMIdul9kbEnKJGlcomHfj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542217; c=relaxed/simple;
	bh=/gsblzor+Ttzp61NiUEWT6XQVqciAxEAHsomqR42cZk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uRq5ofSmr5r6orw5gqBFFDQV7Y6VGQgWeuxiY8PZAtXGyiLnf2UgkdSHf1UXyGpyRh4gOVkq09BjXB6DUExNOzp41bzpgvQfhpyMU7WZ/wsmsHzgr5I57aZIA2nKL0Yb/MJbybzh7d35SVsGv1R7M9PiWuQCMrZZPSOxuAlWh70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=duMBdsXq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DTSDYbQb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 10:10:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730542207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HHyrkKCOqBa0Qj32wZF3BdODpbyL4L+K/+gn39X107w=;
	b=duMBdsXqML2SADs+FklZbYx8/XPOtz2PJY9Ez71CagXGF49ywgPdduVTuWQGlYW5us5Hbv
	kB+oQnwOV+O9ZVOZ6qRlGC0wtLbFRWByoBHPWkzWeJpXKpa1pQY2pYLSgD7ozX/xtL8sbi
	i0O1MpIS1RkwnJ0weOWLpwd+6qmsfVbbVQB9H9SWDGwLG7ow+RsgafX1nGte0nn4w6+NiF
	eoOUBtzlut3egd/krc7CN5SlH50t3QIE20QXKQ61EZ4RbLP3ajwrg6ArfD4XURFbUcAK7S
	mJwRdZXGcb81YG7HcGjzqLvtH9t6da2Mc0OhB/8SWfHMH26K5q0z6QEm6sMcOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730542207;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HHyrkKCOqBa0Qj32wZF3BdODpbyL4L+K/+gn39X107w=;
	b=DTSDYbQbleeoc7ikRD/QUgzRY4dA3JQPua3NMS6C3HVwInpRLF1J9DLh6+wglwaitkO7th
	8l54+oCefRi2jpAw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] powerpc/vdso: Remove offset comment from 32bit
 vdso_arch_data
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-21-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-21-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054220693.3137.16647050045675461253.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     c14fd488891ae14efb05743a958d131c2493cf60
Gitweb:        https://git.kernel.org/tip/c14fd488891ae14efb05743a958d131c249=
3cf60
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:23 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 11:05:15 +01:00

powerpc/vdso: Remove offset comment from 32bit vdso_arch_data

This offset was copy-pasted from the systemcfg structure.
It has no meaning for the 32bit VDSO.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-21-b64f0842d5=
12@linutronix.de

---
 arch/powerpc/include/asm/vdso_datapage.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/=
asm/vdso_datapage.h
index 248dee1..3d5862d 100644
--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -92,7 +92,7 @@ struct vdso_arch_data {
  * And here is the simpler 32 bits version
  */
 struct vdso_arch_data {
-	__u64 tb_ticks_per_sec;		/* Timebase tics / sec		0x38 */
+	__u64 tb_ticks_per_sec;		/* Timebase tics / sec */
 	__u32 syscall_map[SYSCALL_MAP_SIZE]; /* Map of syscalls */
 	__u32 compat_syscall_map[0];	/* No compat syscalls on PPC32 */
 	struct vdso_data data[CS_BASES];

