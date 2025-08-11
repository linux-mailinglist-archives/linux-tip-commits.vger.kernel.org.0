Return-Path: <linux-tip-commits+bounces-6242-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F286B21312
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Aug 2025 19:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0AFB1A21653
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Aug 2025 17:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AD52D3A71;
	Mon, 11 Aug 2025 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q5ujRXs8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eXqtHxED"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666002C21E7;
	Mon, 11 Aug 2025 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933115; cv=none; b=kAOWCzNI9sN7L80jhXTcpHPthsBQj/39lSIHlMu2LK/p/tRsQm7wgwVNxEangKfdhhfMc1lhIRXffbmx9YjdBtYx2TYlMHJ60VK5uThQTmEKazBSFekhpOj27p9RPxy65Gd8vgOB/MN5AAaFyu5H1nvpTU0T7WN23aAJeJo81xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933115; c=relaxed/simple;
	bh=47KTT10WHKFiZxMxIMHfux8Gl1sdDOUG/ZJ4cJ9XvcI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aF0NyXttAJIrL3VUNO+W58+8tv0VJY1qHc53wXS5rfxW2A3Z9hRErK87+aRCHImn6/tvlP2+ZapFAV2IO60SmM8UNJo/Jw0IwDfGtLdWYh81XBmEAaoYQVQnHqVEkYs6if2yICJiRVHk+puHZK/5BqNvhTRgm4JqelZo5mJFcBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q5ujRXs8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eXqtHxED; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 11 Aug 2025 15:48:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754933111;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikOouoXkHEHMnRWF645nAnqb7byHThXc7UH59ZZJEzk=;
	b=q5ujRXs8uhBcDutEKGS/XAFEN+2p2F26V2xd6izrlg8b6/UIoGfWsAEMmVOliAGCITxQUT
	oAUhJckKMypuX659UUtdo+10WbR2+9DLXdO5m/0S6phmZdyit9mUkUqRrzi7+RDG2IfPEr
	toafYPya+tdnTtD8FvPc1ANq5lfIQlNUa8s6QVZMMJGZstiCPXbTfqiqAZ00LhzpK9oPXN
	if1JgYH/YC3Aeeg/74JHQZOC3X/Hk851o7ANZgfYbsWXCmfrMCkYX09X8MSXSpBAeqE8GN
	ZdCRyqeFY1JjwHLme/2Eq3k2FQsNz7jJLxTyFdGtFn4Hr8iTY1VCf60t06yJjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754933111;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikOouoXkHEHMnRWF645nAnqb7byHThXc7UH59ZZJEzk=;
	b=eXqtHxEDdgcpf5grE9fr+jJFwVqjjhyTJWNo0QqPlgfzMMTy2n/TBvq/rW+p4Ku86azSAj
	tdbRsG3nKS+ccDAA==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/bugs: Select best SRSO mitigation
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250721160310.1804203-1-david.kaplan@amd.com>
References: <20250721160310.1804203-1-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175492728627.1420.312317503925693968.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     4fa7d880aeb8cdbdaa4fb72be3e53ac1d6bcc088
Gitweb:        https://git.kernel.org/tip/4fa7d880aeb8cdbdaa4fb72be3e53ac1d6b=
cc088
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Mon, 21 Jul 2025 11:03:10 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 11 Aug 2025 17:32:36 +02:00

x86/bugs: Select best SRSO mitigation

The SRSO bug can theoretically be used to conduct user->user or guest->guest
attacks and requires a mitigation (namely IBPB instead of SBPB on context
switch) for these.  So mark SRSO as being applicable to the user->user and
guest->guest attack vectors.

Additionally, SRSO supports multiple mitigations which mitigate different
potential attack vectors.  Some CPUs are also immune to SRSO from
certain attack vectors (like user->kernel).

Use the specific attack vectors requiring mitigation to select the best
SRSO mitigation to avoid unnecessary performance hits.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250721160310.1804203-1-david.kaplan@amd.com
---
 Documentation/admin-guide/hw-vuln/attack_vector_controls.rst |  2 +-
 arch/x86/kernel/cpu/bugs.c                                   | 13 +++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst b/D=
ocumentation/admin-guide/hw-vuln/attack_vector_controls.rst
index b4de16f..6dd0800 100644
--- a/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
+++ b/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
@@ -214,7 +214,7 @@ Spectre_v1            X
 Spectre_v2            X                           X
 Spectre_v2_user                      X                           X          =
  *       (Note 1)
 SRBDS                 X              X            X              X
-SRSO                  X                           X
+SRSO                  X              X            X              X
 SSB                                                                         =
          (Note 4)
 TAA                   X              X            X              X          =
  *       (Note 2)
 TSA                   X              X            X              X
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b74bf93..2186a77 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -386,7 +386,6 @@ static bool __init should_mitigate_vuln(unsigned int bug)
=20
 	case X86_BUG_SPECTRE_V2:
 	case X86_BUG_RETBLEED:
-	case X86_BUG_SRSO:
 	case X86_BUG_L1TF:
 	case X86_BUG_ITS:
 		return cpu_attack_vector_mitigated(CPU_MITIGATE_USER_KERNEL) ||
@@ -3184,8 +3183,18 @@ static void __init srso_select_mitigation(void)
 	}
=20
 	if (srso_mitigation =3D=3D SRSO_MITIGATION_AUTO) {
-		if (should_mitigate_vuln(X86_BUG_SRSO)) {
+		/*
+		 * Use safe-RET if user->kernel or guest->host protection is
+		 * required.  Otherwise the 'microcode' mitigation is sufficient
+		 * to protect the user->user and guest->guest vectors.
+		 */
+		if (cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_HOST) ||
+		    (cpu_attack_vector_mitigated(CPU_MITIGATE_USER_KERNEL) &&
+		     !boot_cpu_has(X86_FEATURE_SRSO_USER_KERNEL_NO))) {
 			srso_mitigation =3D SRSO_MITIGATION_SAFE_RET;
+		} else if (cpu_attack_vector_mitigated(CPU_MITIGATE_USER_USER) ||
+			   cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_GUEST)) {
+			srso_mitigation =3D SRSO_MITIGATION_MICROCODE;
 		} else {
 			srso_mitigation =3D SRSO_MITIGATION_NONE;
 			return;

