Return-Path: <linux-tip-commits+bounces-7027-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B97C0F64A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 17:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164B03AC405
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 16:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6241C31353E;
	Mon, 27 Oct 2025 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hWOm3s/p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DZvBofbd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B817C2C3242;
	Mon, 27 Oct 2025 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582704; cv=none; b=nhGTC0fv2NEeCGRG+yqHcaL+q7IwLI1nCe+D1oKV1M9FJjsi5zkugBrLqu5CaaAO8hH5TVDWl4wfsk5tZsxSpz3E2AL98GMliFj8sNfX/o7/N3SkAMzoII7zfAB0rOAiu4VoBuxWjRXbHCz0MSD5prQjmXYZWJnhgS5YQ3+NVw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582704; c=relaxed/simple;
	bh=UErrFuj6ytgAMTjdGWk12FeZlPomKBeuBtGu+NEN8QE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EReiYFgGKWJG6gTSCs+Jnnbh45k7TfXgzexfjZsGPnuoVX6T3sYF6P6p4UINOvuVTQdoT9S0hpzFLWWfLYpPYkX40hkgdpp5FEfdWc4rZnwI1SrYstKDhPeP2CukxJuUJ5lucPtT+2GDutMXJS15trTFJrP51lnjZGv7W9H8kFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hWOm3s/p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DZvBofbd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 16:31:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n7iz6wsi08YjwTmOPs+NclMtmKa1EjkQAcuy+5M2SCE=;
	b=hWOm3s/pjUh4wW3cVfiz4GRG0gq03phBltnfe7XUZ0GqY61Lqocn3fMN9o0CsUpbyt0Kpz
	mqS0yg1La3NFKUAxRwJnURePm7YuRLRpCL/uNY3Uq5I0qRIn2njPDjI3CB0MUZ9mU0yqQe
	LLLQ5nx3cG57lbDQ5oDIYyPN7f+zayelyEqyWivtUH6gm0ZH7vx2Ov+3qBx25XETNCZSD8
	ygDJFp8VKZKVTtQVy/Ha035EU8cYXTS8/C+xFXQpKn1VDGjjQQkLA0/dyEhb+7YV+7m2Rz
	Anbx1p6bUOUgaDRSWPiP58au2FLJj1kS4TWrpdtEt2V5MCkPgXJCgd2b0pGZXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n7iz6wsi08YjwTmOPs+NclMtmKa1EjkQAcuy+5M2SCE=;
	b=DZvBofbdRoWr3xhd1hC8DIadzg20LqPEhU0TH8sefmNMij1JZt+nTR3oPXLZmg+W1Tzl3Y
	vQLtaK2JaLvIaDBA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/microcode/AMD: Limit Entrysign signature
 checking to known generations
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251023124629.5385-1-bp@kernel.org>
References: <20251023124629.5385-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176158269992.2601451.1416800166481248088.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     8a9fb5129e8e64d24543ebc70de941a2d77a9e77
Gitweb:        https://git.kernel.org/tip/8a9fb5129e8e64d24543ebc70de941a2d77=
a9e77
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 23 Oct 2025 14:46:29 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 27 Oct 2025 17:07:17 +01:00

x86/microcode/AMD: Limit Entrysign signature checking to known generations

Limit Entrysign sha256 signature checking to CPUs in the range Zen1-Zen5.

X86_BUG cannot be used here because the loading on the BSP happens way
too early, before the cpufeatures machinery has been set up.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/all/20251023124629.5385-1-bp@kernel.org
---
 arch/x86/kernel/cpu/microcode/amd.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microc=
ode/amd.c
index 28ed8c0..b7c797d 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -233,13 +233,31 @@ static bool need_sha_check(u32 cur_rev)
 	return true;
 }
=20
+static bool cpu_has_entrysign(void)
+{
+	unsigned int fam   =3D x86_family(bsp_cpuid_1_eax);
+	unsigned int model =3D x86_model(bsp_cpuid_1_eax);
+
+	if (fam =3D=3D 0x17 || fam =3D=3D 0x19)
+		return true;
+
+	if (fam =3D=3D 0x1a) {
+		if (model <=3D 0x2f ||
+		    (0x40 <=3D model && model <=3D 0x4f) ||
+		    (0x60 <=3D model && model <=3D 0x6f))
+			return true;
+	}
+
+	return false;
+}
+
 static bool verify_sha256_digest(u32 patch_id, u32 cur_rev, const u8 *data, =
unsigned int len)
 {
 	struct patch_digest *pd =3D NULL;
 	u8 digest[SHA256_DIGEST_SIZE];
 	int i;
=20
-	if (x86_family(bsp_cpuid_1_eax) < 0x17)
+	if (!cpu_has_entrysign())
 		return true;
=20
 	if (!need_sha_check(cur_rev))

