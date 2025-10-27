Return-Path: <linux-tip-commits+bounces-7000-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE50DC0E353
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 14:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D35CE4E1CBA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 13:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927642FFF82;
	Mon, 27 Oct 2025 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xs3/lL0L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WLHnlkM4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B556F303CBB;
	Mon, 27 Oct 2025 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573112; cv=none; b=tNRUoxLZoQhkpVZ1yGbllnFhBaw3WERFx67+aajq9AhIsxbDuR1Z8o1J/3PuKDL54FbzDFHeADG7mPaxovPAj4FPy9XmL/BT1ru5eEnVCsipVlug5iZCkveN6g9gltx4tRmeISkiad68/ihUfzHJ1xsNQaPNZOk8oPB1TFVi8yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573112; c=relaxed/simple;
	bh=dKXFxi9uY0k5yVjlqeQwn8clNgwSrBI6UnyGSznsrY0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=bdraSq7Q+vt9mdUA+vAWPJxjokZKmUtIf9UGK6W89qmLWN5dCQz6TM49vkgL1c2u4aiILgjHf2vSdRhRw1xmNKtrHTnAfZ24Yu4fU1roRhFed1TIG0t2g5l6rs327WW2lLbsy5PhEAhNBGt0Lc9L8yyHU2RfWZwftswF223htlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xs3/lL0L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WLHnlkM4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 13:51:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761573108;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8nJasAAcTeVqTX51l8EAYWv8mQMJQmZQuHANfuv3jYc=;
	b=Xs3/lL0L+ftJ2w1x0I8ppL4ntMBLEPKnLkwFo7vEAq34DYIhH+Kz2F2KGnuRt2ObDZtxpa
	Usi6pWxtmR7gMMsvwtbHLNGm0OAL4i77gBU9LyNBujXWSImN3orcdB3cnLq97M0AA4f17B
	eLihCiy1064wSACfh29+HwKzzSN4JiTqGJyTAAcANaLVKPCN9pDRFWyKO0wTiP8wlJF21i
	41RNQddBTJEBSt7mXV9qPmKFe1Af9Uw5u+Nwr2rqDTIh45uX9mZ0RSW/jCQDkCmWHCl/Ko
	EMITegGGjrpB8CW6SP/ZDnjfaKnYb2REBVcO+S9589iJ2CyQRfPJHyNYl4MtJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761573108;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8nJasAAcTeVqTX51l8EAYWv8mQMJQmZQuHANfuv3jYc=;
	b=WLHnlkM4BobWwIwfCdWEeKkDrirbRGSMMkvDQ1jc8yEd6eJl/gkDfT+5cS6XVePYW1oTmd
	l2y6KMw7ee5uDBAg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/microcode/AMD: Limit Entrysign signature
 checking to known generations
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176157310666.2601451.1829123270158335667.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     9e954398cebcc72779798dc1bae03b746ee1ef98
Gitweb:        https://git.kernel.org/tip/9e954398cebcc72779798dc1bae03b746ee=
1ef98
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 23 Oct 2025 14:46:29 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 27 Oct 2025 14:43:15 +01:00

x86/microcode/AMD: Limit Entrysign signature checking to known generations

Limit Entrysign sha256 signature checking to CPUs in the range Zen1-Zen5.

X86_BUG cannot be used here because the loading on the BSP happens way
too early, before the cpufeatures machinery has been set up.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/all/20251023124629.5385-1-bp@kernel.org/
---
 arch/x86/kernel/cpu/microcode/amd.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microc=
ode/amd.c
index 28ed8c0..2a573fa 100644
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
+	if (fam =3D=3D 0x17)
+		return true;
+
+	if (fam =3D=3D 0x19) {
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

