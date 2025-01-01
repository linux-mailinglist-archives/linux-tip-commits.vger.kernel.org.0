Return-Path: <linux-tip-commits+bounces-3165-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 566E99FF3FA
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Jan 2025 13:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6597618825E9
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Jan 2025 12:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723291E25F6;
	Wed,  1 Jan 2025 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gncM7qt3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yQScJmSa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E991E2031;
	Wed,  1 Jan 2025 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735733660; cv=none; b=kIt764rq3vMEk7tu4FaOHLvENqsdC1VO93xDeaLJFugc+N68p4uwhAH/5YsdLwVVpd5mpsf5OyQZNLunZNNKkZs+z5EkjCLuvvv/7CUUM4lKehirVkltIMHiBeoJO4NEhvVO7Dlnhme/ptzVbE7vo2KxSImBIdyz2USjN5/NIlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735733660; c=relaxed/simple;
	bh=CthoFmoG1TwtJICElC6/2vHjVwFl/axEgxkqstW0T1E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FlbjDqDWa2l5/3f8dUBqBweE3khPoi+G5LyGXehBddK5j8FqZYqI5wMLqvoMq6WsLpQ5F0TAj+Tja1csDKtsJbCijqQBwQfFYfPqB8vUW2M480+aeDBrHeOk/xzy4R4h1BGNKyb69puI0T74nW/rPnhV3ZqfBqOaXHd0vktG8oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gncM7qt3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yQScJmSa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 01 Jan 2025 12:14:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735733657;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LC3mZDpMNKygqt3YR58mG56lfYEwQoQ+CxEwY+HwSng=;
	b=gncM7qt3PnWlpRIoQYcF6G2f5KTjPFaM4iosmf+A1035AxxVoq1YyfmejJGE2ildXaW6c5
	8FDP56E8LOx887FFeYiuH/THBXJhND/vDylHUjzDIJF0H1AI+22B0u6889z3iLwlXm8CNN
	8HHPuTPQoBhvs5ywHfFafMR047NtdgFYbijiCVOP8FlzyMf5SaaSicYUrhhsrtMYH/Fygz
	3wf5Nsd8bOw3QGPwYpTlguMwcesr8J05pl6gPIatcQPImcW+wSRW1bU0U4PwXb8PnkdC3H
	a9SMaIkbKtn+rJ2sEu8LT6eCBBMay2kyfBonyu1gnncz8ldyyfPQRHB5nUgqqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735733657;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LC3mZDpMNKygqt3YR58mG56lfYEwQoQ+CxEwY+HwSng=;
	b=yQScJmSaSawlTBP7S5cvJIe3KaVUk18fTVy56je3j2SlWTmRTRh3AiHr4myu0idomBaLfs
	o47tLrufJyxKA9AQ==
From: "tip-bot2 for Nikolay Borisov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Return bool from
 find_blobs_in_containers()
Cc: Nikolay Borisov <nik.borisov@suse.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241018155151.702350-2-nik.borisov@suse.com>
References: <20241018155151.702350-2-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173573365662.399.17709390253297372778.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     a85c08aaa665b5436d325f6d7138732a0e1315ce
Gitweb:        https://git.kernel.org/tip/a85c08aaa665b5436d325f6d7138732a0e1315ce
Author:        Nikolay Borisov <nik.borisov@suse.com>
AuthorDate:    Fri, 18 Oct 2024 18:51:49 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 31 Dec 2024 14:03:30 +01:00

x86/microcode/AMD: Return bool from find_blobs_in_containers()

Instead of open-coding the check for size/data move it inside the
function and make it return a boolean indicating whether data was found
or not.

No functional changes.

  [ bp: Write @ret in find_blobs_in_containers() only on success. ]

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241018155151.702350-2-nik.borisov@suse.com
---
 arch/x86/kernel/cpu/microcode/amd.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index fb5d0c6..d395665 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -569,14 +569,19 @@ static bool get_builtin_microcode(struct cpio_data *cp)
 	return false;
 }
 
-static void __init find_blobs_in_containers(struct cpio_data *ret)
+static bool __init find_blobs_in_containers(struct cpio_data *ret)
 {
 	struct cpio_data cp;
+	bool found;
 
 	if (!get_builtin_microcode(&cp))
 		cp = find_microcode_in_initrd(ucode_path);
 
-	*ret = cp;
+	found = cp.data && cp.size;
+	if (found)
+		*ret = cp;
+
+	return found;
 }
 
 void __init load_ucode_amd_bsp(struct early_load_data *ed, unsigned int cpuid_1_eax)
@@ -591,8 +596,7 @@ void __init load_ucode_amd_bsp(struct early_load_data *ed, unsigned int cpuid_1_
 	/* Needed in load_microcode_amd() */
 	ucode_cpu_info[0].cpu_sig.sig = cpuid_1_eax;
 
-	find_blobs_in_containers(&cp);
-	if (!(cp.data && cp.size))
+	if (!find_blobs_in_containers(&cp))
 		return;
 
 	if (early_apply_microcode(ed->old_rev, cp.data, cp.size))
@@ -612,8 +616,7 @@ static int __init save_microcode_in_initrd(void)
 	if (dis_ucode_ldr || c->x86_vendor != X86_VENDOR_AMD || c->x86 < 0x10)
 		return 0;
 
-	find_blobs_in_containers(&cp);
-	if (!(cp.data && cp.size))
+	if (!find_blobs_in_containers(&cp))
 		return -EINVAL;
 
 	scan_containers(cp.data, cp.size, &desc);

