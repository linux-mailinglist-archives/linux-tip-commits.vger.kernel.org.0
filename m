Return-Path: <linux-tip-commits+bounces-2436-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B48F099F21B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C69C1F23439
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89DD1F4FA7;
	Tue, 15 Oct 2024 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vp8aaHG8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p8Nshr/f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295E216F8E9;
	Tue, 15 Oct 2024 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007880; cv=none; b=DaCwd+Hd/y1VBg7M5FLPZiS8LmIFoK87MJusY7XfFTYdaSmmaiZpbvbbBrArAqzQnuVHWrem+ALWmmNY+mqLuOdyIAqtFroaeJl69xgvE/Zo+oQ2WO7fYA/QK7W2oeNh+HVryaVmkdeu4i8cFxxyf1F8T6rz5H0CwMDJByuU9J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007880; c=relaxed/simple;
	bh=ISZpZjDSTDPQm3I5gvis2YzdRlN+mfzscUAErJYaUjI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Qhs/pFDAnioTMYVlHEVE9zSq7pXRO3bSH5Wemec/OV3p1BAjWgW9H7SmuXkX+Zw1oq8i7YpcIbNAM/s22NRdV3w/jvsC36bBuUuaSxdGDgR3GV4tgwBZBe1FZs93t5zk7ym+S7ucsxVedj5Hz2Q5VIeNFEA44OvqJ4//zAF04HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vp8aaHG8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p8Nshr/f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:57:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729007877;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7rYby/YaHctJrz4KzXnfC+grCuwOfFmXq3NNmpEK9I=;
	b=vp8aaHG8BDaQC1866KxnJa4e/NSGGlsdXXEoxTvsE3U/ypa+Hu5Yt6cot/9F5jC97d/2+I
	TsvHmLKXM/oElGqnVuKKBltpRhxLt3J+nIo1PmR15URbCjg5ZiMGrZgE9FxP0RVGfAEADa
	BQAK1Fhb/uoO5LqyC4AZq0Dy9RhULGWjZ0LP3yU2LPJwddttsDVej/u7kGUdw9D13T0RUS
	lo145DVZOyYYyFrT2sRkX5UF9lj8GuMTNb7P2WN1+5ahmr5SRotox8XRdd+fIs0zyTzsFA
	w4r1HyW/wynG5hV24QOn9nT4Q9/QM3gcme+nfYy4K1MqXcrXFAUDxM1pWAG27Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729007877;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7rYby/YaHctJrz4KzXnfC+grCuwOfFmXq3NNmpEK9I=;
	b=p8Nshr/fEw3nSQJvfKSWcaBVpYXzTjUMaNJzu5for/GHIb0xSBPtRxaGK1qsCfU9jItuNs
	WEXCTdWQIoH/ZxCg==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] x86/vdso: Remove timekeeper include
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20241010-vdso-generic-arch_update_vsyscall-v1-7-7fe5a3ea4382@linutronix.de>
References:
 <20241010-vdso-generic-arch_update_vsyscall-v1-7-7fe5a3ea4382@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900787686.1442.802914379065068079.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     9025e3a6ecfcd9c9036778aa833211026c5ccf8b
Gitweb:        https://git.kernel.org/tip/9025e3a6ecfcd9c9036778aa833211026c5=
ccf8b
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 17:44:50 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:50:29 +02:00

x86/vdso: Remove timekeeper include

Since the generic VDSO clock mode storage is used, this header file is
unused and can be removed.

This avoids including a non-VDSO header while building the VDSO,
which can lead to compilation errors.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-arch_update_vsyscall-=
v1-7-7fe5a3ea4382@linutronix.de

---
 arch/x86/include/asm/vdso/vsyscall.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso=
/vsyscall.h
index 67fedf1..a1f916b 100644
--- a/arch/x86/include/asm/vdso/vsyscall.h
+++ b/arch/x86/include/asm/vdso/vsyscall.h
@@ -4,7 +4,6 @@
=20
 #ifndef __ASSEMBLY__
=20
-#include <linux/timekeeper_internal.h>
 #include <vdso/datapage.h>
 #include <asm/vgtod.h>
 #include <asm/vvar.h>

