Return-Path: <linux-tip-commits+bounces-1587-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F3D926905
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Jul 2024 21:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A86282F78
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Jul 2024 19:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C3318FC94;
	Wed,  3 Jul 2024 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u44vlPbp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/KnHEBEE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3546184116;
	Wed,  3 Jul 2024 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720035382; cv=none; b=Xn1++Xl+iWy1HeV1+NCkPTADQHvhTjwGQu5Gz1Ob7enEvlxtQ1HyHjpFo7Y0Hieg++ZaLU1D9VzizIDshsjWqTYHnBaupoGZXKi5y7u/bHDzUu8USaulmgdr2BJpiGCLSeL8e7SGOf4Gt3fCLLQZraOLl8aDe6+uLUUHP1usbBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720035382; c=relaxed/simple;
	bh=uqHav4gpcovj2Pf0YyKkm346bxgofRI+CxWEXUJ/Mvg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JuRpc84qMU0b8JgA3XKsAguVpJ0hafspWyK+AOQQM7kXgD2U60Sh7rlpVlveleQKtqAF8g5g0Uvl/Msiv+NZccGG/aMdCNnDmsMlaPOCj0SHUBBueRE2YJAWv3W9unVR9eMX7QkdIDU9UM6wwB2AdcezDLRIfG5LglWJ9orpFVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u44vlPbp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/KnHEBEE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Jul 2024 19:36:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720035379;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vMQQgoyveyjH5yX/pnahnsjZ7vuvr0+eH6mDO4+CBkM=;
	b=u44vlPbpMcjRU+vk9hgU7nwNdpZXxdVfHFIuFU9cboO0ESzXcbxAj50QZSm150ztrpBskt
	peX7Mfurm7t8DYr+vccNW9+AN0aATd4DYO2kptSgnCe1W7zxOAC8lnHz5sGeMkjbuSx5DH
	6skuUncRIEt/L8zfJRuIxCfhW7VqHEp1fdr3D/z4O2Jnmi8qqAmORMrbeQLgvnW8CVKbj8
	O07T1AbcrloGGLbWyihgqNWim3STjok9zawbSF8ApZLK1aKHCrQAoGVzoOEJnwddL+UTcd
	fpnc7vInMhTZglHDyNGe4FmMBhVWm9ow4dBif/Rix9mxtK0HbNccVInTi9Prgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720035379;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vMQQgoyveyjH5yX/pnahnsjZ7vuvr0+eH6mDO4+CBkM=;
	b=/KnHEBEEaPBVCrUmCC+AdbJ8Y2+5PHuxAY0M3U/G4sV2sK2Q1UmJ1G4Wj5GDqTJ1/EvfLZ
	IX47JVE2YLzwNFCw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] x86/vdso: Remove unused include
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240701-vdso-cleanup-v1-5-36eb64e7ece2@linutronix.de>
References: <20240701-vdso-cleanup-v1-5-36eb64e7ece2@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172003537877.2215.17933618588743081260.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     2b83be20ae60308f5da31c696137a9561c44c24c
Gitweb:        https://git.kernel.org/tip/2b83be20ae60308f5da31c696137a9561c44c24c
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 01 Jul 2024 16:47:58 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Jul 2024 21:27:04 +02:00

x86/vdso: Remove unused include

Including hrtimer.h is not required and is probably a historical
leftover. Remove it.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Link: https://lore.kernel.org/r/20240701-vdso-cleanup-v1-5-36eb64e7ece2@linutronix.de

---
 arch/x86/include/asm/vdso/vsyscall.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso/vsyscall.h
index be199a9..9322628 100644
--- a/arch/x86/include/asm/vdso/vsyscall.h
+++ b/arch/x86/include/asm/vdso/vsyscall.h
@@ -4,7 +4,6 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/hrtimer.h>
 #include <linux/timekeeper_internal.h>
 #include <vdso/datapage.h>
 #include <asm/vgtod.h>

