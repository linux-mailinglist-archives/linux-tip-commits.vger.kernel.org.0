Return-Path: <linux-tip-commits+bounces-2711-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957349B9EA6
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59BCF281EFE
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 10:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37563155741;
	Sat,  2 Nov 2024 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w+jAheZM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p0j3Hyug"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A03C189B85;
	Sat,  2 Nov 2024 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542220; cv=none; b=Eso7s5ivZ30Saxan8NrbpjosZ62cMRmIA/9RzxMwL4uw2+zSCcX6/eCEhwZ47aJamZKbgLQsHMIKBSkd5poSsqK98lFBKfXZIt8outJG7/mr11IxiMsH0wNrKaxRwlJRICDyN+NOm29fSmfbWAv/5by4q1H5gM5an8GFl6pKjgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542220; c=relaxed/simple;
	bh=qjZ1SSTX/KUFy5wRt0m+ldTKLEVu7You5wp8yBb07Hk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qe0fTFboGdwpgcVkYPxRI/IXswBw0a16O1uNKcqpPOjepuBMkgIg2wDR78gpIvvWXI1f9R7dLT/XoryGqnrmyH4E3Y1ATQC75f73JO+x+CCcKj6545XdvyKfHe1W22pI1cuy9b9Kr7xfUQ6tQgutU/nr2baFiNdb3sx2IaTCuTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w+jAheZM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p0j3Hyug; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 10:10:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730542214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dq19qkLv753wnb/oil92s5l5TdDt8LxbHCrYpxcDRXs=;
	b=w+jAheZMWipbiHqsbRjvR2nNtgeDW3bL5r09FBmeUaxFgeeINE9ZAqanzjrb8ILrEL/0GD
	Dx2PVj/4qPUq3nK7Ea6rBQbgXJ4/gSifxdU3ropYHUbGRHm71MyKpyQVglFd/a4JxT2uLn
	w4CddBsGWlGusUXfHOlHutlD3RRs1ahFBdiuVqcEFNSHR/NrxQpfQ9up5S/d2xV+K5YzaI
	Hi1zwR6UWItwi5G29h79/uPKtuAlngsPldthmgRFYc8AuHubQe9WRnvQGIgAcWdA0wgtmP
	iuJ9iSSnmocPtkoXpjHe25cE3Ie1NLxqKnkhO3Z2NKxnyCgT8bAp7LlVB88BGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730542214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dq19qkLv753wnb/oil92s5l5TdDt8LxbHCrYpxcDRXs=;
	b=p0j3HyugokaAbur4NYm4GVAmtd/zjerMjru81tKhLIRIzBXUovsJa5wadsaApX2FQxVoho
	hMn8THtb57Jby0BA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] x86/vdso: Use __arch_get_vdso_data() to access vdso data
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-11-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-11-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054221396.3137.4619361866278118877.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     44e2e2c6152708394948009fab2986cf2712311f
Gitweb:        https://git.kernel.org/tip/44e2e2c6152708394948009fab2986cf271=
2311f
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:13 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 11:05:14 +01:00

x86/vdso: Use __arch_get_vdso_data() to access vdso data

The implementation details of the vdso_data access will change.
Prepare for that by using the existing helper function.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-11-b64f0842d5=
12@linutronix.de

---
 arch/x86/include/asm/vdso/getrandom.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/vdso/getrandom.h b/arch/x86/include/asm/vds=
o/getrandom.h
index ff5334a..ecdcdbc 100644
--- a/arch/x86/include/asm/vdso/getrandom.h
+++ b/arch/x86/include/asm/vdso/getrandom.h
@@ -32,8 +32,8 @@ static __always_inline ssize_t getrandom_syscall(void *buff=
er, size_t len, unsig
=20
 static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(=
void)
 {
-	if (IS_ENABLED(CONFIG_TIME_NS) && __vdso_data->clock_mode =3D=3D VDSO_CLOCK=
MODE_TIMENS)
-		return (void *)&__vdso_rng_data + ((void *)&__timens_vdso_data - (void *)&=
__vdso_data);
+	if (IS_ENABLED(CONFIG_TIME_NS) && __arch_get_vdso_data()->clock_mode =3D=3D=
 VDSO_CLOCKMODE_TIMENS)
+		return (void *)&__vdso_rng_data + ((void *)&__timens_vdso_data - (void *)_=
_arch_get_vdso_data());
 	return &__vdso_rng_data;
 }
=20

