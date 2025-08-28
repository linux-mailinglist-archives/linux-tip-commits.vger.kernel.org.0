Return-Path: <linux-tip-commits+bounces-6393-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6286B39F2E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 28 Aug 2025 15:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C73168174C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 28 Aug 2025 13:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF2F312830;
	Thu, 28 Aug 2025 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h/KGBpEP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YESxak5F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C383128AD;
	Thu, 28 Aug 2025 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388378; cv=none; b=C+G0jL20WWcqfHRH4cmJb3fERzkqkySG/ELf0liDOcNEiPprM7jSjPMTSgbi9nYAKU9IQ7rofmETCt9qcCfOtGrRhvQ9hykvh9Nk02a+Db0I7BM+id7ArYx7faGHyjIpiAyjVE0KImv2DtPuAFgqmYTgfvO1Fwy5hULbJZKlQcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388378; c=relaxed/simple;
	bh=2wi8a1VsacLfSvZ8HFl5JZkcA2GgD7vFgG3ulSBHRNo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Bvv6c1Z+VAlY4W8LQViFqr57bM+KrpOWjO+lFC+d+UirsjkIvO/RRJecG97wSICZJ4ut6LAsRqmTzr9QLPYb5Y8z5mGNDUH+3t3+Cdg5eYDPHrDyeev+t37eEi5LdxpbfPoQyZhCW9oc7xnNitukyKZxeRVUdsj3veiRzCyD778=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h/KGBpEP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YESxak5F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 28 Aug 2025 13:39:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756388374;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hgRDWenIWUKeFFR8DrGAevmEavRDjsrM3h/4ecsWL6Q=;
	b=h/KGBpEPB2tTr69DSv9pdU/5vOP0x0t64vB3mQD2ZCb0P46CbCOYZBbPE5DgVq+N3EQo7S
	6eIp3Xi0YpH5kKXpeT5DN9u509BQNPWki46ZOqecV8VFhamvnu9+SQVGiZZO81Wm9XN/EW
	D3Ms38llZn9ANv2eL647EKvlzenuDLF+oHXtXryVREAef58VyT+oaZXc39T/vocmrnLQWs
	fxi8ca75Jzh+CYvSnGXAH43Wl6OgD8Vu4wUs4yYBQJDzBLSypCr8ppyvInXpGJ4RPZGe8r
	ri3OfAkPW01mYA81fMKxrluaa4OrWhjGExGrfEGBUJC4E+VpM8I4d7Mg64UeiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756388374;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hgRDWenIWUKeFFR8DrGAevmEavRDjsrM3h/4ecsWL6Q=;
	b=YESxak5FMekzIKFz9vjC7aryNp7XeMcwk0TPBaXdn2vWmfjw6UxbXvJFl3LM0ynHoc1k5L
	F8O+A0rrmxLG0JDg==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/bugs: Add attack vector controls for SSB
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250819192200.2003074-5-david.kaplan@amd.com>
References: <20250819192200.2003074-5-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175638836960.1920.12208793699420420560.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     8b3641dfb6f902407495c63b9b64482b32319b66
Gitweb:        https://git.kernel.org/tip/8b3641dfb6f902407495c63b9b64482b323=
19b66
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Tue, 19 Aug 2025 14:21:59 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 27 Aug 2025 18:17:12 +02:00

x86/bugs: Add attack vector controls for SSB

Attack vector controls for SSB were missed in the initial attack vector serie=
s.
The default mitigation for SSB requires user-space opt-in so it is only
relevant for user->user attacks.  Check with attack vector controls when
the command is auto - i.e., no explicit user selection has been done.

Fixes: 2d31d2874663 ("x86/bugs: Define attack vectors relevant for each bug")
Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250819192200.2003074-5-david.kaplan@amd.com
---
 Documentation/admin-guide/hw-vuln/attack_vector_controls.rst |  5 +----
 arch/x86/kernel/cpu/bugs.c                                   |  9 +++++++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst b/D=
ocumentation/admin-guide/hw-vuln/attack_vector_controls.rst
index 6dd0800..5964901 100644
--- a/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
+++ b/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
@@ -215,7 +215,7 @@ Spectre_v2            X                           X
 Spectre_v2_user                      X                           X          =
  *       (Note 1)
 SRBDS                 X              X            X              X
 SRSO                  X              X            X              X
-SSB                                                                         =
          (Note 4)
+SSB                                  X
 TAA                   X              X            X              X          =
  *       (Note 2)
 TSA                   X              X            X              X
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D
@@ -229,9 +229,6 @@ Notes:
    3 --  Disables SMT if cross-thread mitigations are fully enabled, the CPU=
 is
    vulnerable, and STIBP is not supported
=20
-   4 --  Speculative store bypass is always enabled by default (no kernel
-   mitigation applied) unless overridden with spec_store_bypass_disable opti=
on
-
 When an attack-vector is disabled, all mitigations for the vulnerabilities
 listed in the above table are disabled, unless mitigation is required for a
 different enabled attack-vector or a mitigation is explicitly selected via a
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 49ef1b8..af838b8 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -416,6 +416,10 @@ static bool __init should_mitigate_vuln(unsigned int bug)
 		       cpu_attack_vector_mitigated(CPU_MITIGATE_USER_USER) ||
 		       cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_GUEST) ||
 		       (smt_mitigations !=3D SMT_MITIGATIONS_OFF);
+
+	case X86_BUG_SPEC_STORE_BYPASS:
+		return cpu_attack_vector_mitigated(CPU_MITIGATE_USER_USER);
+
 	default:
 		WARN(1, "Unknown bug %x\n", bug);
 		return false;
@@ -2710,6 +2714,11 @@ static void __init ssb_select_mitigation(void)
 		ssb_mode =3D SPEC_STORE_BYPASS_DISABLE;
 		break;
 	case SPEC_STORE_BYPASS_CMD_AUTO:
+		if (should_mitigate_vuln(X86_BUG_SPEC_STORE_BYPASS))
+			ssb_mode =3D SPEC_STORE_BYPASS_PRCTL;
+		else
+			ssb_mode =3D SPEC_STORE_BYPASS_NONE;
+		break;
 	case SPEC_STORE_BYPASS_CMD_PRCTL:
 		ssb_mode =3D SPEC_STORE_BYPASS_PRCTL;
 		break;

