Return-Path: <linux-tip-commits+bounces-6823-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DC8BE08E8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Oct 2025 21:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 003A35062A0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Oct 2025 19:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1542FE05A;
	Wed, 15 Oct 2025 19:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HeMcYhWp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mx3opPMl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C421DB13A;
	Wed, 15 Oct 2025 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760558101; cv=none; b=A8q+FCXeYj13nob4RYyuheU+U4ha14NR2tXM2fVwuOynY88GhkOBdvy7aOmAeYI+DzfSUPQTfpTb9dPSbE0sA8+Gqo0vQwrMDMnSllxoJbnD+GOsn4bLDbFrcEJh69KZCE6i0Hm6khtYmJV7mGNJ7aBx7NyUePVPswH2Cy6qCYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760558101; c=relaxed/simple;
	bh=VNPqcrlLsUfyayWVK9JAUMrRoqyHcPylLKS5IiJz0HQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QARC8+CalYLWbwwmSDtKv6WkXlyRLunPgXcv2w805F/6cDa9XvRBPGdQJmTIEqxhBj/zKHxRs4Te3q9RZa0Ep1NAdBT5e2icRW8aNOUaWMFknBZAOk0CXEyCzFbl+4+XSlw03iWaDzbJVlexfUTH9aKAz5VhjuokXfLb++hwbPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HeMcYhWp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mx3opPMl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Oct 2025 19:54:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760558097;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cmYkG6tJpnRfUjvD88sq/h0E6tCqvF1OTKGkOFYcjYs=;
	b=HeMcYhWpfrDbk9gRC8mQY7eJTn6Y8iklhljLuVRhB/K3fAjuuf/THMxNbvZPbJrzedO8zx
	plnJxHttPOWR/fdZuUnmDV5epQ4nRVnK1mxBvcHN2sdVcpTfDOXEEif/RTRWR6IEcSAuhQ
	qc40Qh99MfGQTs3Or1x+ormEj6w3ciCIAKQuhHi7WmClOCg0PXnNnsDTHdfgi6JAP8MwpK
	a4J9UY0mdz6mMwyFv+ZsN0hA3WLHDxfdr+9Pi3Z1dQCDnLuyOBZiv6sTL3zBVBb1W1A1F3
	oNLSwEnWxp+n0fzE9TE7PI/oju+1+vz2C7kh3VcqDFdwOHNLadvLuNxtRYZ14w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760558097;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cmYkG6tJpnRfUjvD88sq/h0E6tCqvF1OTKGkOFYcjYs=;
	b=mx3opPMlFZRAxAaufg3QV4AVkHGHLtYIOfiVBnU3eMclcGsIvMXAUVXOEVszEZe+hfEIx4
	4lycNcXj6sFUGuDQ==
From: "tip-bot2 for Rong Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/CPU/AMD: Prevent reset reasons from being
 retained across reboot
Cc: Rong Zhang <i@rong.moe>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Yazen Ghannam <yazen.ghannam@amd.com>,  <stable@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251010165959.49737-1-i@rong.moe>
References: <20251010165959.49737-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176055809535.709179.9375426508386127359.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e6416c2dfe23c9a6fec881fda22ebb9ae486cfc5
Gitweb:        https://git.kernel.org/tip/e6416c2dfe23c9a6fec881fda22ebb9ae48=
6cfc5
Author:        Rong Zhang <i@rong.moe>
AuthorDate:    Sat, 11 Oct 2025 00:59:58 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 15 Oct 2025 21:38:06 +02:00

x86/CPU/AMD: Prevent reset reasons from being retained across reboot

The S5_RESET_STATUS register is parsed on boot and printed to kmsg.
However, this could sometimes be misleading and lead to users wasting a
lot of time on meaningless debugging for two reasons:

* Some bits are never cleared by hardware. It's the software's
responsibility to clear them as per the Processor Programming Reference
(see [1]).

* Some rare hardware-initiated platform resets do not update the
register at all.

In both cases, a previous reboot could leave its trace in the register,
resulting in users seeing unrelated reboot reasons while debugging random
reboots afterward.

Write the read value back to the register in order to clear all reason bits
since they are write-1-to-clear while the others must be preserved.

  [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537#attach_303991

  [ bp: Massage commit message. ]

Fixes: ab8131028710 ("x86/CPU/AMD: Print the reason for the last reset")
Signed-off-by: Rong Zhang <i@rong.moe>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/all/20250913144245.23237-1-i@rong.moe/
---
 arch/x86/kernel/cpu/amd.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 5398db4..ccaa51c 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1355,11 +1355,23 @@ static __init int print_s5_reset_status_mmio(void)
 		return 0;
=20
 	value =3D ioread32(addr);
-	iounmap(addr);
=20
 	/* Value with "all bits set" is an error response and should be ignored. */
-	if (value =3D=3D U32_MAX)
+	if (value =3D=3D U32_MAX) {
+		iounmap(addr);
 		return 0;
+	}
+
+	/*
+	 * Clear all reason bits so they won't be retained if the next reset
+	 * does not update the register. Besides, some bits are never cleared by
+	 * hardware so it's software's responsibility to clear them.
+	 *
+	 * Writing the value back effectively clears all reason bits as they are
+	 * write-1-to-clear.
+	 */
+	iowrite32(value, addr);
+	iounmap(addr);
=20
 	for (i =3D 0; i < ARRAY_SIZE(s5_reset_reason_txt); i++) {
 		if (!(value & BIT(i)))

