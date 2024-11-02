Return-Path: <linux-tip-commits+bounces-2739-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314FA9B9FB1
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 12:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5906B1C21371
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7DF1AC458;
	Sat,  2 Nov 2024 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qDDachor";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LJB2xdUg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8955189503;
	Sat,  2 Nov 2024 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548227; cv=none; b=Jc1kMwIzFzvokZNVnog4DlB/FjtE1QfekpPWL+ZnMLlzHWjaa0kgPt5fnDSZhrCB+8VhJsgJx7Q7BtKR+VrAtBsSv5/Zgje7ZgAJawEgotAwmA7Z961z32L0naN8/vA33fE07sdtqveYlE62iqbyeZa1duWoxaii8sqUQpPPGw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548227; c=relaxed/simple;
	bh=pUkX7h0Rz1fDXLBOoF0mPzCJuo9no1BGe2zJyQq5oX0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=beka1hE8TtOFJI4291MFIN/R0OBWioKZztyKylcmIBZK7HHDMqFnpXRH9a6dDYUOS9hvba9ceUDiDEz8w3wezzo03D7Yem5Vd2eq55vcJAIGSh0ETAnmodS+fURGFZ/b1sr24ukxa78Zz0q2S8Bbs6ESBd3Ubsfelw7rX2olguk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qDDachor; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LJB2xdUg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 11:50:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730548224;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=orOW9IA1jvRZfLj8mtM5k1NqLovf6ybDkTnBvfjuwwI=;
	b=qDDachorBnQa/b+857n6Vf9QgCVzQ76elk9EmUEiCErpB8h66uTm2b1nICUma9J8V6JCBK
	lEpth1MH+oEibtlqtnO++GiWBSjiDNiKCjLArTzw0l6fBHpHKoIj5k3GsuNoRIp+p82zaF
	26eqgLas3CJACVZPOjzW2mp3TnxC8KLblGP7p/w/G/6r9wYbstcSrnOWnQSZuPIjNVcuIH
	hPixUNcJphbIyrcsSMtnQAp49bp0GW9SxFOD14GZSOlaBXIPh4vNtnlocwG3HMnGtDRDWi
	4bhC9b2NW6Og7Buejy2joOOeUXceo/Hi3FYpfe3NcLt78lQvatB7Qlh38qotMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730548224;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=orOW9IA1jvRZfLj8mtM5k1NqLovf6ybDkTnBvfjuwwI=;
	b=LJB2xdUgeyLNK8qrsmn+jGR2nEcYi7XKzT57EXamXQQxNibOAoAR2vXSPFDUdRDp1demt+
	ykVxtt9dLc5hXGAg==
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
Message-ID: <173054822372.3137.11740237093914632953.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     dd937454d905fad9fcbeccd35ecfc8c3c096fe76
Gitweb:        https://git.kernel.org/tip/dd937454d905fad9fcbeccd35ecfc8c3c09=
6fe76
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:13 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 12:37:34 +01:00

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

