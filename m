Return-Path: <linux-tip-commits+bounces-6077-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC00B02149
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 18:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F991CC268D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 16:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E422EF649;
	Fri, 11 Jul 2025 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e11JO4vp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="auyxh/Np"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FAD1FBEB9;
	Fri, 11 Jul 2025 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250174; cv=none; b=ijG1n1nivJossV0OVWtzHzC2CjVtyN45KEcRqfrDex0qrFUlu6UALN8sE5Nlj4HQVNFZXH2lXVxWEd6ljXPL4EvNIzru0p+vgmx4sQHuF6zU1oCfgOYzURCoNW6Pi+SAGN3XLG94Ixmz1CHZY/ZcFX7/fOJFmy1ws4Fg9WXPEjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250174; c=relaxed/simple;
	bh=6LL7ihOYyf1sAtanNhFmCE+F+/VdnBQv4lh5TPlFRIE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OwEK6tQU6Q4APDtHUTXMobPH9XnHt0ITCDIYktANxT7qWw0mpaFcG8yQFK/Vb4HUYnwpy1P4BoOXZl3agI7KYhixEEpx3AsIk76g/LxAye3l5CxtX440em7HAke0WkcQKrgDevqurAp8O4T7tGcCpdRYxBuoDugc6Y/I77bWFnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e11JO4vp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=auyxh/Np; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 16:09:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752250171;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pY/VLB0b2eMcE8gmfPuV83WMxGBX37y+8whfwGp5H9Q=;
	b=e11JO4vp947TTC5jo/41k1U1gMC+eGY5Ybz9GkArmO2dgQbC0ZP3kq3ui4emxK1qoqGssT
	97ZnwGQbHNg4MP9neiKgzSue1lw0Yv65Rp4aiFCuAnNl8ovWmzxS5T1ZXQCLic1ZoB0SBg
	8EtGk2Ta/2gZkzcBEXtDE9vjTHu/NTyPf8FJ3J3C8niC9A9S/Wl/nXShlKd96QFws7yybc
	l/V6Kk6Dq8eykgwBZ/ifqSZNMJl6mHYJ7ky1HBBl7bb9CKdfFCeN8s+8Ps7xyMO44q2Fd5
	frpobbBj3v4d3CSWeXEJ8NYQGV9x2o6EihmZrYuZDCZoiQ6jmRhId4KogL3jmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752250171;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pY/VLB0b2eMcE8gmfPuV83WMxGBX37y+8whfwGp5H9Q=;
	b=auyxh/NpgnzNz8IO8JFNF5Fm4aSpZyE4puhyQesq9GIaECkcjN4awYhYH3bE/7telwNfxu
	VVXjvyqWm8Im7wDQ==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/pti: Add attack vector controls for PTI
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250707183316.1349127-20-david.kaplan@amd.com>
References: <20250707183316.1349127-20-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175225017013.406.8386575672342160778.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     02c7d5b8e0d123185817f533ed12622ed1c695e5
Gitweb:        https://git.kernel.org/tip/02c7d5b8e0d123185817f533ed12622ed1c695e5
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Mon, 07 Jul 2025 13:33:14 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 11 Jul 2025 17:56:41 +02:00

x86/pti: Add attack vector controls for PTI

Disable PTI mitigation if user->kernel attack vector mitigations are
disabled.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250707183316.1349127-20-david.kaplan@amd.com
---
 arch/x86/mm/pti.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 1902998..6dba18f 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -38,6 +38,7 @@
 #include <asm/desc.h>
 #include <asm/sections.h>
 #include <asm/set_memory.h>
+#include <asm/bugs.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt)     "Kernel/User page tables isolation: " fmt
@@ -84,7 +85,8 @@ void __init pti_check_boottime_disable(void)
 		return;
 	}
 
-	if (cpu_mitigations_off())
+	if (pti_mode == PTI_AUTO &&
+	    !cpu_attack_vector_mitigated(CPU_MITIGATE_USER_KERNEL))
 		pti_mode = PTI_FORCE_OFF;
 	if (pti_mode == PTI_FORCE_OFF) {
 		pti_print_if_insecure("disabled on command line.");

