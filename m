Return-Path: <linux-tip-commits+bounces-2700-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CA69B9E97
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00DFFB222AD
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 10:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02977179972;
	Sat,  2 Nov 2024 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IcFLAloi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7NVh/tM3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44720172BA8;
	Sat,  2 Nov 2024 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542216; cv=none; b=CQHsE+smGrjbynScIeChX+9DEzo454V5Gfs44D+jJASC0G6fVzs/gRblukVgVZn1GK+Il3RiRZEB2bNPKGqoOCyPV4JlHnUiyDRl2DYoYSJ1TP5dZTA189dGdcPNeqauCEvYlfwQ8XjDRLikN515SFDcP0p0/IpB8uf1H0CFNlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542216; c=relaxed/simple;
	bh=ZC/AS9kF5DjKEfA/t7ZHTVc/Qoa2sKVYQ/KMtORNtDE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rY6r1duiqwo+L6aDJHaANYEWxggr0jgNF7BwVALc+tB4V2/3u4YVFHPaYzJf3m4Guw4E6RDfqozBMSPMABmRcwbxDuwyvqCz9QEhSNuthYMme6RZaS9tEgKuX/j5Qd5HDQBignkYlpRz7pmfwULaaC44geFFmRrVlgRggKNdrfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IcFLAloi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7NVh/tM3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 10:10:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730542206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGLjGSf/tTT1pCJsPUiSHWTtPXXJ6Q30w3Lot+JgsV4=;
	b=IcFLAloiehBovNizVnRcK1Z8OXyXAmhoG+kHUhemD9Qjq7my4glp4X+yfFmIgV2SmaDsqW
	0P7qt3baJIGJu/LGVZjmeKTG37b2Rk8+77r8xyIE4JTRnUa+HBNx4qklyUruRuXoXQGfPc
	EydUq6xSP1SlQeMr7jaN05jHAswXTb3iP7YKKutBsZoDXOINqEdm2G03hixaP9fM6JUY2j
	IGpzz2mxv0cZS1CKeZAr9JhikMgqGdMqXPALwsvXEZaBZ2V6pKLVLfV4vRBVQzzer3+IY5
	MeloCz9v9nZkG8l+bvDPPOO7DFCF5fJhkfnlhTALF1qdlkAaCL5JspYFXNTPUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730542206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGLjGSf/tTT1pCJsPUiSHWTtPXXJ6Q30w3Lot+JgsV4=;
	b=7NVh/tM3Jyz4k5qjCa74DPYTqVYzCeuvE4LliOBvV7a+m2EAK+0C3LikLHUphrZbYHXiF0
	Q2yM5iPlVI6/NxDA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] powerpc/pseries/lparcfg: Fix printing of
 system_active_processors
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-23-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-23-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054220567.3137.299739927491770942.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     f78d2227833f2a430cd806877c47e125ba2ae8db
Gitweb:        https://git.kernel.org/tip/f78d2227833f2a430cd806877c47e125ba2=
ae8db
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:25 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 11:05:15 +01:00

powerpc/pseries/lparcfg: Fix printing of system_active_processors

When printing the information "system_active_processors", the variable
partition_potential_processors is used instead of
partition_active_processors. The wrong value is displayed.

Use partition_active_processors instead.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-23-b64f0842d5=
12@linutronix.de

---
 arch/powerpc/platforms/pseries/lparcfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platform=
s/pseries/lparcfg.c
index 62da20f..acc640f 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -553,7 +553,7 @@ static int pseries_lparcfg_data(struct seq_file *m, void =
*v)
 	} else {		/* non SPLPAR case */
=20
 		seq_printf(m, "system_active_processors=3D%d\n",
-			   partition_potential_processors);
+			   partition_active_processors);
=20
 		seq_printf(m, "system_potential_processors=3D%d\n",
 			   partition_potential_processors);

