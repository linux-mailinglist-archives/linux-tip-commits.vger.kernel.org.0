Return-Path: <linux-tip-commits+bounces-4346-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DDAA68AAF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3459D46007E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B7E2580CE;
	Wed, 19 Mar 2025 11:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1tYJhHje";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/QFnUvm5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB7725525D;
	Wed, 19 Mar 2025 11:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382224; cv=none; b=Gl6d1YqpWwWZKzfFs0K4uSktAlV8MEtq7MdHkGUjJeAPyxEOoHeq0rXPJoHeClAk1yK9E85GpoUQ3ZCGt34u+fjwTMuqztyUoKsj7gn6QDX//b44WtGJcpkpws/1F3Yc4u+GZ1mHmllnKILBYcKcRMw0EnSGmD0USyqsz3JM6IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382224; c=relaxed/simple;
	bh=LYXBrsjI+ayklBs6J6PdkBWkkECaFSPilQ4CauslOIQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=B3Lrz1AX331N2rQm5dN7mTapArqqwBWwKSQmTbvrDrgyE8qk+l1rFJeNHmdFmVKWNhcz8ajq8MOwrBNOGAcVVg5GFHMY7aSh+uERAPiigEeKv7rIp1gsyKanIvyB/7fELpHNjjWSsoDLc3cs2hjEBOvclrNTVTktLgMrNfiVfQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1tYJhHje; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/QFnUvm5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382219;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0ELpMFZxPTVjGiKEuwFLcLIVh4IfJDWdCTgKN1FrLQ=;
	b=1tYJhHje4QpOXS0nmpttF1PjI3aV6DyWBFH593GH+uv1H/t/lcao2ef20Lklra5U3pJF7L
	MwqFPbXXDIzxC3zTEXdHs+lQf3OYkuuHtUzX1kPgob+zUKIRtzfm6H4gyr/jE1j9ADm2w/
	6hOLJhMvv4WeCQ5+z2yGpqYd3We2j0LlfcKjRSPWy/P/34Ck+Cq6zUCWkjYn2er1i7Kgbg
	RTqZ/3PLuoi9KNqDNu+HEaSOBvza3cyNEcCe35pnmZYGs+/4qdHcK8m4AEoSd24Sjcudpc
	SzNI2fX7CwrA88J0b90mF5Hz+s9GbHJMkB7OW2fBWBFaHl+qtgbpTtDEO1LGcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382219;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0ELpMFZxPTVjGiKEuwFLcLIVh4IfJDWdCTgKN1FrLQ=;
	b=/QFnUvm5GLUP/3/e44bWAyEZfSdeK4O89dVKrfZaQnavzM7IXQT88A1rDh8uAp9vr6pnHa
	tJbhuF47KfOfECDw==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/smpboot: Fix INIT delay assignment for extended
 Intel Families
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250219184133.816753-11-sohil.mehta@intel.com>
References: <20250219184133.816753-11-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238221892.14745.2711535962153025870.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     7a2ad752746bfb13e89a83984ecc52a48bae4969
Gitweb:        https://git.kernel.org/tip/7a2ad752746bfb13e89a83984ecc52a48bae4969
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Wed, 19 Feb 2025 18:41:28 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:19:50 +01:00

x86/smpboot: Fix INIT delay assignment for extended Intel Families

Some old crusty CPUs need an extra delay that slows down booting. See
the comment above 'init_udelay' for details. Newer CPUs don't need the
delay.

Right now, for Intel, Family 6 and only Family 6 skips the delay. That
leaves out both the Family 15 (Pentium 4s) and brand new Family 18/19
models.

The omission of Family 15 (Pentium 4s) seems like an oversight and 18/19
do not need the delay.

Skip the delay on all Intel processors Family 6 and beyond.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250219184133.816753-11-sohil.mehta@intel.com
---
 arch/x86/kernel/smpboot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 5e586f5..d6cf1e2 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -656,9 +656,9 @@ static void __init smp_set_init_udelay(void)
 		return;
 
 	/* if modern processor, use no delay */
-	if (((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) && (boot_cpu_data.x86 == 6)) ||
-	    ((boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) && (boot_cpu_data.x86 >= 0x18)) ||
-	    ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) && (boot_cpu_data.x86 >= 0xF))) {
+	if ((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL && boot_cpu_data.x86_vfm >= INTEL_PENTIUM_PRO) ||
+	    (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON && boot_cpu_data.x86 >= 0x18) ||
+	    (boot_cpu_data.x86_vendor == X86_VENDOR_AMD   && boot_cpu_data.x86 >= 0xF)) {
 		init_udelay = 0;
 		return;
 	}

