Return-Path: <linux-tip-commits+bounces-2439-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9D899F221
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7401F231A3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2AC1F76AF;
	Tue, 15 Oct 2024 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YEnRTYvv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nX2T6rr7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396261F6674;
	Tue, 15 Oct 2024 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007882; cv=none; b=QP6bBl91vMgsmA4ftLfC0Al2oYjH+ptvP//d7wUyToUMKSvBItZtyjH/tWgoElTFop16nTWztHu+t2tcMKwiCxY6ALQTRA3u8FgJBznQ+FKiaZiNK45sNmhjvkjewn9tSA3mBs4v0ubgciijtc2n9BANrgs3TNT17mmgmCmA/W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007882; c=relaxed/simple;
	bh=abcSKxTJAQOYaW6BaChZh1/JicQo5g2c1PqICNvx8nk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QLFfgrNq0w2X2uNpiNeJXFPSGm0YfoZOgrangVGYBu4UvS+uLVq7Xu+m1AaZm1tr9X42yl9+5ITlqKQXzU9IPfwXAVcf4lFYhRibVkUt6BKwgsX1YegXqyXvjJqavUMrJkq8Wm8fCYl4MtIY7TsExDtd2/eCu1zLi0bmDDYdUdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YEnRTYvv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nX2T6rr7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:57:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729007879;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7CDSqM6k0EqEPZbCfCaqhmNzBmh6FJCWAl+qqKJHc4=;
	b=YEnRTYvv6u+97KQoHxdeGEnNxMNSfCEakgqlfT+/2gYBJO5vmMrLr7blCbZUpedYm5xY7v
	U+XQiz1mzH7vdzSh8G3vAnzVn2d2wgsTWhUiwW66Fjqu3e/gP4uNjqCQF1SHIDehEgvTXo
	ujMOK8Oa1AVF9aasm7L7PA2vMke80IlG2PZF8nedb/ynNKclGYgbs5X5FOShFotMwjJMcC
	27V5wSveMTy63UBAc9Eu+wheMFXdugpiumxEf2gvWyNK1L1oKelnX1LtnD3igwaribZ1Q0
	9zSmcPS93uezrLFN/3ixzf7/faQozghNLFksQQmrrBjiKc16NwAxnBCa9TnTGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729007879;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7CDSqM6k0EqEPZbCfCaqhmNzBmh6FJCWAl+qqKJHc4=;
	b=nX2T6rr71/6W2IoQLcGERLHPysODgcihWUuDOkBlf1gVl1ZLMdlK+QvxrXmrmTEcnko7yF
	E7mpB7HxRuvvhFCQ==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] powerpc/vdso: Remove timekeeper includes
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20241010-vdso-generic-arch_update_vsyscall-v1-4-7fe5a3ea4382@linutronix.de>
References:
 <20241010-vdso-generic-arch_update_vsyscall-v1-4-7fe5a3ea4382@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900787872.1442.15672077919777559206.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     d93948d3ce591b90a43f922b73876e3511eec796
Gitweb:        https://git.kernel.org/tip/d93948d3ce591b90a43f922b73876e3511e=
ec796
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 17:44:47 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:50:29 +02:00

powerpc/vdso: Remove timekeeper includes

Since the generic VDSO clock mode storage is used, this header file is
unused and can be removed.

This avoids including a non-VDSO header while building the VDSO,
which can lead to compilation errors.

Also drop the comment which is out of date and in the wrong place.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-arch_update_vsyscall-=
v1-4-7fe5a3ea4382@linutronix.de

---
 arch/powerpc/include/asm/vdso/vsyscall.h | 4 ----
 arch/powerpc/kernel/time.c               | 1 -
 2 files changed, 5 deletions(-)

diff --git a/arch/powerpc/include/asm/vdso/vsyscall.h b/arch/powerpc/include/=
asm/vdso/vsyscall.h
index 92f480d..48560a1 100644
--- a/arch/powerpc/include/asm/vdso/vsyscall.h
+++ b/arch/powerpc/include/asm/vdso/vsyscall.h
@@ -4,12 +4,8 @@
=20
 #ifndef __ASSEMBLY__
=20
-#include <linux/timekeeper_internal.h>
 #include <asm/vdso_datapage.h>
=20
-/*
- * Update the vDSO data page to keep in sync with kernel timekeeping.
- */
 static __always_inline
 struct vdso_data *__arch_get_k_vdso_data(void)
 {
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 0ff9f03..4a95654 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -75,7 +75,6 @@
 /* powerpc clocksource/clockevent code */
=20
 #include <linux/clockchips.h>
-#include <linux/timekeeper_internal.h>
=20
 static u64 timebase_read(struct clocksource *);
 static struct clocksource clocksource_timebase =3D {

