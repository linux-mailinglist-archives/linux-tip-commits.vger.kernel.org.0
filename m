Return-Path: <linux-tip-commits+bounces-7832-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4E5D05D6D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 08 Jan 2026 20:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B77143084362
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Jan 2026 19:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F40428852B;
	Thu,  8 Jan 2026 19:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OR1sebU/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qkTAS6It"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4BD1B4223;
	Thu,  8 Jan 2026 19:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899920; cv=none; b=WR9ioDWSqMQyRos/8Bb5c/ThAH51kcWVnzeV5H72G6e17/5nSIVvVL8EAn95oSWHD2GTxb+f1bIPYxN9EstRpOGHYKicm8/b5lNxaXVJ+25UFT8I8hABdPY4BbAFdcCaVwgSvaCbRNYjG5GVjvKiJCJpiPVxltt/+jIXkX39VA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899920; c=relaxed/simple;
	bh=KUgMeRHr6ccW7EAM0tdEG+mdQqcdOHG4k6TJ3FOqvu4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Xl3XJSvOBw/eCz3Pk69MqSyebQ+SOhGqrWFU5ZzkcN/P9aAfLMC8WKOJ/uS+lCPHloWoeX1cVHV/PMV0kdoTzejqX/lHZpdNJChRBpqr+R1EerX5wMveWx8tcjC11ak2Vh9C7TKbd1qYEM8cgaNYfZd3FmAhRfmd12J4wZS3zvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OR1sebU/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qkTAS6It; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Jan 2026 19:18:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767899916;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T+kmZoBiMAlCjuvT7tA50b2Z/AquIYIz6os5f7mZpPg=;
	b=OR1sebU/iQMIjMQio8VglpunCxuM8eXPFRTw6ilkm36x2jYSyuqf7hRMJFh6lU4hAuzF96
	8VwZhMAwgzciLNRqqGFjbLmMDp6SoX80xB6qK0SawBKbCCGMX1VOP+J+J3ysuXx9GDr6BQ
	X+UbaIIML045T5TEQp//W/VaQeqY2SpmRCk5LSh3lnksQ9QrJmm5HgxVB1kfvHKsGGgsRd
	vB7N7D6HCLnPja9zvfNnz7PZGhj4biMrk4+JLFiuuxUvmBqaJVBTvIUZCQeKUYN7+WDh7F
	0mN6jw+yoBYun3QCI8M+a+aYESAt90nWQtb2Cy6olwdcb/OgFWsoLxdZA+Tqmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767899916;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T+kmZoBiMAlCjuvT7tA50b2Z/AquIYIz6os5f7mZpPg=;
	b=qkTAS6ItbLkXSsUXLxQs2S5nbEtMaJfl33siGnPJUUhw4CJ6pGJ0hsilp6y1+EiJVSPL2K
	X8qtQ748+aGQY2Ag==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternative: Patch a single alternative
 location only once
Cc: Juergen Gross <jgross@suse.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260105080452.5064-3-jgross@suse.com>
References: <20260105080452.5064-3-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176789991444.510.15916891740213652102.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     a4233c21e77375494223ade11da72523a0149d97
Gitweb:        https://git.kernel.org/tip/a4233c21e77375494223ade11da72523a01=
49d97
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 05 Jan 2026 09:04:52 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 07 Jan 2026 16:13:00 +01:00

x86/alternative: Patch a single alternative location only once

Instead of patching a single location potentially multiple times in case of
nested ALTERNATIVE()s, do the patching only after having evaluated all
alt_instr instances for that location.

This has multiple advantages:

- In case of replacing an indirect with a direct call using the
  ALT_FLAG_DIRECT_CALL flag, there is no longer the need to have that
  instance before any other instances at the same location (the
  original instruction is needed for finding the target of the direct
  call).
  This issue has been hit when trying to do paravirt patching similar
  to the following:
    ALTERNATIVE_2(PARAVIRT_CALL,    // indirect call
                  instr, feature,   // native instruction
                  ALT_CALL_INSTR, X86_FEATURE_XENPV)  // Xen function
  In case "feature" was true, "instr" replaced the indirect call. Under
  Xen PV the patching to have a direct call failed, as the original
  indirect call was no longer there to find the call target.

- In case of nested ALTERNATIVE()s there is no intermediate replacement
  visible. This avoids any problems in case e.g. an interrupt is
  happening between the single instances and the patched location is
  used during handling the interrupt.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20260105080452.5064-3-jgross@suse.com
---
 arch/x86/kernel/alternative.c | 49 ++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 6e3eec0..693b59b 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -593,39 +593,38 @@ struct patch_site {
 	u8 len;
 };
=20
-static void __init_or_module analyze_patch_site(struct patch_site *ps,
-						struct alt_instr *start,
-						struct alt_instr *end)
+static struct alt_instr * __init_or_module analyze_patch_site(struct patch_s=
ite *ps,
+							     struct alt_instr *start,
+							     struct alt_instr *end)
 {
-	struct alt_instr *r;
+	struct alt_instr *alt =3D start;
=20
 	ps->instr =3D instr_va(start);
-	ps->len =3D start->instrlen;
=20
 	/*
 	 * In case of nested ALTERNATIVE()s the outer alternative might add
 	 * more padding. To ensure consistent patching find the max padding for
 	 * all alt_instr entries for this site (nested alternatives result in
 	 * consecutive entries).
+	 * Find the last alt_instr eligible for patching at the site.
 	 */
-	for (r =3D start+1; r < end && instr_va(r) =3D=3D ps->instr; r++) {
-		ps->len =3D max(ps->len, r->instrlen);
-		start->instrlen =3D r->instrlen =3D ps->len;
+	for (; alt < end && instr_va(alt) =3D=3D ps->instr; alt++) {
+		ps->len =3D max(ps->len, alt->instrlen);
+
+		BUG_ON(alt->cpuid >=3D (NCAPINTS + NBUGINTS) * 32);
+		/*
+		 * Patch if either:
+		 * - feature is present
+		 * - feature not present but ALT_FLAG_NOT is set to mean,
+		 *   patch if feature is *NOT* present.
+		 */
+		if (!boot_cpu_has(alt->cpuid) !=3D !(alt->flags & ALT_FLAG_NOT))
+			ps->alt =3D alt;
 	}
=20
 	BUG_ON(ps->len > sizeof(ps->buff));
-	BUG_ON(start->cpuid >=3D (NCAPINTS + NBUGINTS) * 32);
=20
-	/*
-	 * Patch if either:
-	 * - feature is present
-	 * - feature not present but ALT_FLAG_NOT is set to mean,
-	 *   patch if feature is *NOT* present.
-	 */
-	if (!boot_cpu_has(start->cpuid) =3D=3D !(start->flags & ALT_FLAG_NOT))
-		ps->alt =3D NULL;
-	else
-		ps->alt =3D start;
+	return alt;
 }
=20
 static void __init_or_module prep_patch_site(struct patch_site *ps)
@@ -704,10 +703,14 @@ void __init_or_module noinline apply_alternatives(struc=
t alt_instr *start,
 	 * So be careful if you want to change the scan order to any other
 	 * order.
 	 */
-	for (a =3D start; a < end; a++) {
-		struct patch_site ps;
-
-		analyze_patch_site(&ps, a, end);
+	a =3D start;
+	while (a < end) {
+		struct patch_site ps =3D {
+			.alt =3D NULL,
+			.len =3D 0
+		};
+
+		a =3D analyze_patch_site(&ps, a, end);
 		prep_patch_site(&ps);
 		patch_site(&ps);
 	}

