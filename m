Return-Path: <linux-tip-commits+bounces-4317-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D19A67C85
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 20:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58768178877
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 19:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F0C1DDC2D;
	Tue, 18 Mar 2025 19:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jYVAL6YY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KfSvS74i"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF941531E1;
	Tue, 18 Mar 2025 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324536; cv=none; b=AykzTq3DyLZHodRWFLJEgGdmt5MzKNz/U/qjP9SBueS5JF2i94oS5Ng7yvePAsM4DmkTEjRWQ9NHgx6x2iD65qqWwYdicu8XwzKSsC1VDG2/WUVpclVB5EKYPdqJZwh/j3Hus4ZSlDknDrWS3A4yQcP+I3QXD1IdZ11dJOlbwYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324536; c=relaxed/simple;
	bh=RyWg6GZs0HG2H7ets4XXpl2bZzpVCBzMcD2/5l9R9rI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IJKYTCF9rJbcen/j+JqgRCpwgoKnLjBSbf8OpwES938Vc1TwTwfyi1eBruRqGUOsWC5kTB08QuO2wpX6bL3doRXmjt/KUVcAu1+ic2ps5QmtAhE5INyAlphvoRBuoouC29TXOaGPL996CDZQcEukFfgGOSjwH+/BFqR5MN69rUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jYVAL6YY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KfSvS74i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Mar 2025 18:54:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742324069;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KS+GnC5EU0IrAwhTdlBCk6x+4ASqVIeBDSKo3ThWbF4=;
	b=jYVAL6YYK+2PJlMsvwV5hWwZYnwahLEZUs5KoR31AM8rx9iHyNawkGKoN0pbxp2Q3ehsqR
	LPcEaPvSu7jcRkJ0X+b6qNBFSc5watluNTbOAWs2MhGKAfZflruPUv9way1qslzQBdybk4
	7QK6nr2ejLWmxH0dPIARDpHOBCIPn5OttYuMNXQN5VdRdYpgwH0UmmsVFsHoN/HD1J/t73
	9hxKNMfzM3CT6aQLYf3xo0R+jv9W7iaZRqSuLON+KmxOEJtjfhyJkH1WYRHjY6T+Hg5cCV
	0VV5AuxBWp0MuJqu5nPkHrdvRLYWYpy0c0If2nT9OlOOtrUhbBXPYdqVqxjWJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742324069;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KS+GnC5EU0IrAwhTdlBCk6x+4ASqVIeBDSKo3ThWbF4=;
	b=KfSvS74iizZa9PguypxD8vxVEosz0AhEd0H/wkPMizSNgodurCBze50Pc21giLrQyH+ZVF
	ZfH6J5C70C9d65Aw==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/smpboot: Fix INIT delay assignment for extended
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
Message-ID: <174232406840.14745.2671058347475165801.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     17b1dd60e367795b0b4f44c9a477185f8444e8b9
Gitweb:        https://git.kernel.org/tip/17b1dd60e367795b0b4f44c9a477185f8444e8b9
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Wed, 19 Feb 2025 18:41:28 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Mar 2025 19:33:46 +01:00

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
index 7dccc44..b68216f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -655,9 +655,9 @@ static void __init smp_set_init_udelay(void)
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

