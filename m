Return-Path: <linux-tip-commits+bounces-6573-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AFDB5585A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Sep 2025 23:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E5D5C3876
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Sep 2025 21:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFE6258ED8;
	Fri, 12 Sep 2025 21:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NyYJlYEJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JnYdc1Yw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA4C22256B;
	Fri, 12 Sep 2025 21:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757712491; cv=none; b=Zec+9F22IVNK1nAXjHZN85fJWYUhBpOZNf1O0xaNRnrIUl+zQpZnaX2i3GXkORyNhacKuasobr9tvRHdCj2yxVWEQwq3V7aEqyxFh639vrLsPbiZeSWg/rhvLiu8BPMYVU+6qvxRINpQ+xO0oWQeG2uQKnsg2QnJLGGGS4kIkM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757712491; c=relaxed/simple;
	bh=TTj6dfagJTTxOZ8Obkut6OCT+NQf55eXbUy/iqVCCMM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EpDRUoPtaTQYLmNbycst8YDyKgrSYr0eJ1Cd2v179JJUlR3MDKHc9Y9BTfuJaKZvIFFc2b5pTwQPgNDvxwiE/CiBpPYfQXj0YNgwd5L82MYaAfyX+/vpgbBEgaaX0gk77WRAeRx5yL+XMpAH81TAV/AGn+gJ4dPZSneiJg4a7rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NyYJlYEJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JnYdc1Yw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Sep 2025 21:28:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757712487;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lqZA14XhjLiiI7wbmqfuhoy7Q5lPMcxq1kqxYv+Y7ZE=;
	b=NyYJlYEJ4EBSaPFe40vgW2/bWVOmPbGWaMmXeuaRP7zMEyDQs7d1sbwqPMKoWy3eLJSJaQ
	0mAbM+x+qLRMg6sqJA2NjpU1r+bvlW52zuA+S5+SV6TNWEL/g0glIjCpoETZn/d1qYFu4E
	CnsBmizXGyjYzbPzC4bkyfJWQgJj37mfZxiiGotABlckjlEUVYBJhhMsN8woYX7R/R5zsX
	/vBDLggiWRT15CPWKVfdLuIp0XdFxGYE18CC7KbVE23b0CcXFgTHsXtwdWhSoJRQXl3Crm
	vUAbreGuA/E+tutBZGs/64Q8SDT0z3gYY78Aq0YdKUeC4SvRyXH26qORKLi/+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757712487;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lqZA14XhjLiiI7wbmqfuhoy7Q5lPMcxq1kqxYv+Y7ZE=;
	b=JnYdc1YwZUtU6UeqARyuQ8PbrQQxP9kUlXlEKgdre32vXO4noUo4sXEuRfzx+4bFoYrtnP
	9pMjMog91VwsQ8Bg==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add attack vector controls for VMSCAPE
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250912152428.2761154-1-david.kaplan@amd.com>
References: <20250912152428.2761154-1-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175771248649.709179.5091056873593838180.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     5799d5d8a6c877f03ad5b5a640977053be45059a
Gitweb:        https://git.kernel.org/tip/5799d5d8a6c877f03ad5b5a640977053be4=
5059a
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Fri, 12 Sep 2025 10:24:28 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 12 Sep 2025 23:19:29 +02:00

x86/bugs: Add attack vector controls for VMSCAPE

Use attack vector controls to select whether VMSCAPE requires mitigation,
similar to other bugs.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 Documentation/admin-guide/hw-vuln/attack_vector_controls.rst |  1 +-
 arch/x86/kernel/cpu/bugs.c                                   | 14 +++++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst b/D=
ocumentation/admin-guide/hw-vuln/attack_vector_controls.rst
index 5964901..d0bdbd8 100644
--- a/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
+++ b/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
@@ -218,6 +218,7 @@ SRSO                  X              X            X      =
        X
 SSB                                  X
 TAA                   X              X            X              X          =
  *       (Note 2)
 TSA                   X              X            X              X
+VMSCAPE                                           X
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D
=20
 Notes:
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 36dcfc5..e817bba 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -434,6 +434,9 @@ static bool __init should_mitigate_vuln(unsigned int bug)
 	case X86_BUG_SPEC_STORE_BYPASS:
 		return cpu_attack_vector_mitigated(CPU_MITIGATE_USER_USER);
=20
+	case X86_BUG_VMSCAPE:
+		return cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_HOST);
+
 	default:
 		WARN(1, "Unknown bug %x\n", bug);
 		return false;
@@ -3304,15 +3307,18 @@ early_param("vmscape", vmscape_parse_cmdline);
=20
 static void __init vmscape_select_mitigation(void)
 {
-	if (cpu_mitigations_off() ||
-	    !boot_cpu_has_bug(X86_BUG_VMSCAPE) ||
+	if (!boot_cpu_has_bug(X86_BUG_VMSCAPE) ||
 	    !boot_cpu_has(X86_FEATURE_IBPB)) {
 		vmscape_mitigation =3D VMSCAPE_MITIGATION_NONE;
 		return;
 	}
=20
-	if (vmscape_mitigation =3D=3D VMSCAPE_MITIGATION_AUTO)
-		vmscape_mitigation =3D VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER;
+	if (vmscape_mitigation =3D=3D VMSCAPE_MITIGATION_AUTO) {
+		if (should_mitigate_vuln(X86_BUG_VMSCAPE))
+			vmscape_mitigation =3D VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER;
+		else
+			vmscape_mitigation =3D VMSCAPE_MITIGATION_NONE;
+	}
 }
=20
 static void __init vmscape_update_mitigation(void)

